From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCH] t5801: properly test the test shell
Date: Fri, 26 Apr 2013 11:55:17 +0200
Message-ID: <517A4F05.5030609@drmicha.warpmail.net>
References: <ff7ccf22012f069ceca054d90aa0f72666cc11c2.1366884583.git.git@drmicha.warpmail.net> <7vppxi60pj.fsf@alter.siamese.dyndns.org> <7vfvye4jrc.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Felipe Contreras <felipe.contreras@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Apr 26 11:55:22 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UVfN8-00065l-06
	for gcvg-git-2@plane.gmane.org; Fri, 26 Apr 2013 11:55:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932567Ab3DZJzL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Apr 2013 05:55:11 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:44448 "EHLO
	out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932563Ab3DZJzK (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 26 Apr 2013 05:55:10 -0400
Received: from compute2.internal (compute2.nyi.mail.srv.osa [10.202.2.42])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id C127720B70;
	Fri, 26 Apr 2013 05:55:09 -0400 (EDT)
Received: from frontend1.nyi.mail.srv.osa ([10.202.2.160])
  by compute2.internal (MEProxy); Fri, 26 Apr 2013 05:55:09 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=message-id:date:from:mime-version:to:cc
	:subject:references:in-reply-to:content-type
	:content-transfer-encoding; s=smtpout; bh=Lu4QiXA3cXzzf9vgB3oCm2
	WHa04=; b=JyHki9L8ZIUjrDL8WKXDGQiUKAkQBWMvEBZpHcJo6kvfNvRwe+8GzF
	ZumTiln3YFhwLiAKIiqOdjMbocvV+U8Ud6TNnbNuYS7fr6s+rmpX4pGeddb0/+fr
	CTGHavThtguCytAHG81cNC0zoqgBw9Pkq8Z47rB07w7RB0zEMtYDQ=
X-Sasl-enc: 2Qy5RE1tYuh4Xoff3F5+rg5xXKOHNKGSkek/VTUbjvk4 1366970109
Received: from localhost.localdomain (unknown [130.75.46.56])
	by mail.messagingengine.com (Postfix) with ESMTPA id 26FECC80005;
	Fri, 26 Apr 2013 05:55:09 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130402 Thunderbird/17.0.5
In-Reply-To: <7vfvye4jrc.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222524>

Junio C Hamano venit, vidit, dixit 25.04.2013 19:12:
> Junio C Hamano <gitster@pobox.com> writes:
> 
>> Michael J Gruber <git@drmicha.warpmail.net> writes:
>>
>>> fc407f9 (Add new simplified git-remote-testgit, 2012-11-28) introduced a
>>> test which was meant to skip the test unless the test shell is bash.
>>> Unfortunately, it tests for the availability of bash only.
>>
>> True.
>>
>>> But users can
>>> opt to use a different shell (using SHELL_PATH) for the tests even though
>>> bash is available.
>>>
>>> At least for dash,
>>> 21610d8 (transport-helper: clarify pushing without refspecs, 2013-04-17)
>>> is the commit which actually introduces a test (pushing without refspec)
>>> which fails to fail even though it is supposed to. It uses the
>>> construct:
>>>
>>> VAR=value function arguments
>>
>> The right fix for that is to fix that line, so that the test itself
>> can run under any sane POSIX shell, isn't it?  The test in turn may
>> need to run git-remote-testgit, which, without J6t's updates, only
>> is usable under bash, but to make sure the test will choke on
>> absence of bash, the existing check should be sufficient, no?
> 
> Curiously enough, there were a few instances of the correct "set and
> export environment explicitly during the life of subshell" construct
> already in the script.  I found only this one as problematic.
> 
> Does it fix your issue without your change?
> 
> It is a separate issue to port git-remote-testgit to POSIX (J6t
> already has a two part draft), move it to git-remote-testgit.sh, and
> get its shebang line preprocessed like all other shell scripts.  I
> think it is worth doing.
> 
> Takers?
> 
>  t/t5801-remote-helpers.sh | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/t/t5801-remote-helpers.sh b/t/t5801-remote-helpers.sh
> index 4dcf744..c956abd 100755
> --- a/t/t5801-remote-helpers.sh
> +++ b/t/t5801-remote-helpers.sh
> @@ -118,7 +118,9 @@ test_expect_success 'pushing without refspecs' '
>  	(cd local2 &&
>  	echo content >>file &&
>  	git commit -a -m ten &&
> -	GIT_REMOTE_TESTGIT_REFSPEC="" test_must_fail git push 2>../error) &&
> +	GIT_REMOTE_TESTGIT_REFSPEC="" &&
> +	export GIT_REMOTE_TESTGIT_REFSPEC &&
> +	test_must_fail git push 2>../error) &&
>  	grep "remote-helper doesn.t support push; refspec needed" error
>  '
>  
> 

Perfect, I just failed to notice that the subshell would make the export
local to that test.

Thanks!

Michael
