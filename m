From: Paul Gortmaker <paul.gortmaker@windriver.com>
Subject: Re: [PATCH] gitweb: filter escapes from longer commit titles that
 break firefox
Date: Mon, 20 Apr 2009 09:29:15 -0400
Message-ID: <49EC78AB.6020009@windriver.com>
References: <1239985473-666-1-git-send-email-paul.gortmaker@windriver.com> <m3r5znpt5g.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 20 15:31:42 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LvtaX-0001Zi-MP
	for gcvg-git-2@gmane.org; Mon, 20 Apr 2009 15:31:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755335AbZDTN3g (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Apr 2009 09:29:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755324AbZDTN3g
	(ORCPT <rfc822;git-outgoing>); Mon, 20 Apr 2009 09:29:36 -0400
Received: from mail.windriver.com ([147.11.1.11]:63504 "EHLO mail.wrs.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754964AbZDTN3g (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Apr 2009 09:29:36 -0400
Received: from ALA-MAIL03.corp.ad.wrs.com (ala-mail03 [147.11.57.144])
	by mail.wrs.com (8.13.6/8.13.6) with ESMTP id n3KDTXYT007418;
	Mon, 20 Apr 2009 06:29:33 -0700 (PDT)
Received: from ala-mail06.corp.ad.wrs.com ([147.11.57.147]) by ALA-MAIL03.corp.ad.wrs.com with Microsoft SMTPSVC(6.0.3790.1830);
	 Mon, 20 Apr 2009 06:29:33 -0700
Received: from [128.224.146.65] ([128.224.146.65]) by ala-mail06.corp.ad.wrs.com with Microsoft SMTPSVC(6.0.3790.1830);
	 Mon, 20 Apr 2009 06:29:32 -0700
User-Agent: Thunderbird 2.0.0.21 (X11/20090409)
In-Reply-To: <m3r5znpt5g.fsf@localhost.localdomain>
X-OriginalArrivalTime: 20 Apr 2009 13:29:32.0866 (UTC) FILETIME=[0A5D2A20:01C9C1BC]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116982>

Jakub Narebski wrote:
> Paul Gortmaker <paul.gortmaker@windriver.com> writes:
>
>   
>> If there is a commit that ends in ^X and is longer in length than
>> what will fit in title_short, then it doesn't get fed through
>> esc_html() and so the ^X will appear as-is in the page source.
>>
>> When Firefox comes across this, it will fail to display the page,
>> and only display a couple lines of error messages that read like:
>>
>>    XML Parsing Error: not well-formed
>>    Location: http://git ....
>>
>> Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
>>     
>
> This is an issue for when project doesn't follow sanity (control
> characters in commit message) nor commit message conventions of git
> (limiting length of first line of commit message to 60-70 characters).
>   

I agree - the situation should be that it doesn't happen, but it can 
happen (and it did
happen) that a novice, or a simple mistake ends up with such a commit. 

> But I do not think that the solution presented here is good solution
> for this problem.  chop_and_escape_str is meant as _output_ filter,
> because it generates (can generate) fragment of HTML.  It is not a
> good solution to use it for shortening in intermediate representation
> of %co{'title'}.
>
> And I think that issue might be a bug elsewhere in gitweb if we have
> text output which is not passed through esc_html... or bug in CGI.pm
> if the error is in not escaping of -title _attribute_ (attribute
> escaping has slightly different rules than escaping HTML, and should
> be done automatically by CGI.pm).
>
>
> So thanks for noticing the issue, but NAK on the solution.
>   

Fair enough -- I wasn't familiar with the code in there, and there 
wasn't really any indication that it was for output only.  I can easily 
believe that there is a better place for it -- I just didn't see where 
any global esc_html filtering was taking place...

Paul.

>   
>> ---
>>  gitweb/gitweb.perl |    2 +-
>>  1 files changed, 1 insertions(+), 1 deletions(-)
>>
>> diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
>> index 33ef190..e686e82 100755
>> --- a/gitweb/gitweb.perl
>> +++ b/gitweb/gitweb.perl
>> @@ -2470,7 +2470,7 @@ sub parse_commit_text {
>>  	foreach my $title (@commit_lines) {
>>  		$title =~ s/^    //;
>>  		if ($title ne "") {
>> -			$co{'title'} = chop_str($title, 80, 5);
>> +			$co{'title'} = chop_and_escape_str($title, 80, 5);
>>  			# remove leading stuff of merges to make the interesting part visible
>>  			if (length($title) > 50) {
>>  				$title =~ s/^Automatic //;
>> -- 
>> 1.6.2.3
>>
>>     
>
>   
