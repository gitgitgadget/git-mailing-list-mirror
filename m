From: Kevin Ballard <kevin@sb.org>
Subject: Re: [PATCH] Don't try and percent-escape existing percent escapes in git-svn URIs
Date: Sun, 9 Mar 2008 08:29:09 -0400
Message-ID: <0FE6BDE6-961E-4671-B9EC-EFA25389DF54@sb.org>
References: <1205018447-18344-1-git-send-email-kevin@sb.org> <20080309091240.GA17484@mayonaise>
Mime-Version: 1.0 (Apple Message framework v919.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Sun Mar 09 13:30:19 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JYKfS-00052a-Rk
	for gcvg-git-2@gmane.org; Sun, 09 Mar 2008 13:30:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750799AbYCIM3N (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Mar 2008 08:29:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750750AbYCIM3N
	(ORCPT <rfc822;git-outgoing>); Sun, 9 Mar 2008 08:29:13 -0400
Received: from sd-green-bigip-145.dreamhost.com ([208.97.132.145]:37072 "EHLO
	randymail-a9.g.dreamhost.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1750739AbYCIM3M (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 9 Mar 2008 08:29:12 -0400
Received: from KBALLARD.RES.WPI.NET (KBALLARD.RES.WPI.NET [130.215.239.91])
	by randymail-a9.g.dreamhost.com (Postfix) with ESMTP id 4C991EF34F;
	Sun,  9 Mar 2008 05:29:11 -0700 (PDT)
In-Reply-To: <20080309091240.GA17484@mayonaise>
X-Mailer: Apple Mail (2.919.2)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76656>

On Mar 9, 2008, at 5:12 AM, Eric Wong wrote:

> Kevin Ballard <kevin@sb.org> wrote:
>> git-svn: project names are percent-escaped ever since f5530b.
>> Unfortunately this breaks the scenario where the user hands git-svn
>> an already-escaped URI. Fix the regexp to skip over what looks like
>> existing percent escapes, and test this scenario.
>
> What happens when something that _looks_ like a percent escape is
> actually a part of the URL and not really an escape?

Have you ever seen a URL like that? I haven't. However, what is fairly  
common is for URLs to contain spaces, and such URLs are always stored  
already-escaped.

The standard situation that triggers this issue is pulling a URL from  
`svn info`. Such a URL is already escaped, which means you can't feed  
it into `git svn clone` directly, you have to de-escape it first. This  
is a problem. Here's an example:

http://macromates.com/svn/Bundles/trunk/Bundles/Ruby%20on%20Rails.tmbundle

I tried cloning that and it failed, because it turned that into

http://macromates.com/svn/Bundles/trunk/Bundles/Ruby%2520on%2520Rails.tmbundle

However, my friend who was still on v1.5.3.7 cloned that no problem,  
since that was before the escaping code.

-Kevin

>
>> Signed-off-by: Kevin Ballard <kevin@sb.org>
>> ---
>> git-svn.perl                                  |    2 +-
>> t/t9120-git-svn-clone-with-percent-escapes.sh |   31 +++++++++++++++ 
>> ++++++++++
>> 2 files changed, 32 insertions(+), 1 deletions(-)
>> create mode 100755 t/t9120-git-svn-clone-with-percent-escapes.sh
>>
>> diff --git a/git-svn.perl b/git-svn.perl
>> index 9e2faf9..cec664f 100755
>> --- a/git-svn.perl
>> +++ b/git-svn.perl
>> @@ -3658,7 +3658,7 @@ sub escape_uri_only {
>> 	my ($uri) = @_;
>> 	my @tmp;
>> 	foreach (split m{/}, $uri) {
>> -		s/([^\w.-])/sprintf("%%%02X",ord($1))/eg;
>> +		s/([^\w.%-]|%(?![a-fA-F0-9]{2}))/sprintf("%%%02X",ord($1))/eg;
>> 		push @tmp, $_;
>> 	}
>> 	join('/', @tmp);
>> diff --git a/t/t9120-git-svn-clone-with-percent-escapes.sh b/t/ 
>> t9120-git-svn-clone-with-percent-escapes.sh
>> new file mode 100755
>> index 0000000..9a4eabe
>> --- /dev/null
>> +++ b/t/t9120-git-svn-clone-with-percent-escapes.sh
>> @@ -0,0 +1,31 @@
>> +#!/bin/sh
>> +#
>> +# Copyright (c) 2008 Kevin Ballard
>> +#
>> +
>> +test_description='git-svn clone with percent escapes'
>> +. ./lib-git-svn.sh
>> +
>> +test_expect_success 'setup svnrepo' "
>> +	mkdir project project/trunk project/branches project/tags &&
>> +	echo foo > project/trunk/foo &&
>> +	svn import -m '$test_description' project '$svnrepo/pr ject' &&
>> +	rm -rf project &&
>> +	start_httpd
>> +"
>> +
>> +if test "$SVN_HTTPD_PORT" = ""
>> +then
>> +	test_expect_failure 'test clone with percent escapes - needs  
>> SVN_HTTPD_PORT set' 'false'
>> +else
>> +	test_expect_success 'test clone with percent escapes' '
>> +		git svn clone "$svnrepo/pr%20ject" clone &&
>> +		cd clone &&
>> +			git rev-parse refs/remotes/git-svn &&
>> +		cd ..
>> +	'
>> +fi
>> +
>> +stop_httpd
>> +
>> +test_done
>> -- 
>> 1.5.4.3.487.g1eab2.dirty
>>
>
> -- 
> Eric Wong
>

-- 
Kevin Ballard
http://kevin.sb.org
kevin@sb.org
http://www.tildesoft.com


