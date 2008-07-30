From: Steve Haslam <shaslam@lastminute.com>
Subject: Re: [PATCH] Glean libexec path from argv[0] for git-upload-pack and
    git-receive-pack.
Date: Wed, 30 Jul 2008 17:15:18 +0100
Message-ID: <48909396.3080500@lastminute.com>
References: <1217417238-26731-1-git-send-email-shaslam@lastminute.com> <alpine.LSU.1.00.0807301650060.3486@wbgn129.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Johannes Sixt <johannes.sixt@telecom.at>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Jul 30 18:16:34 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KOELo-0001B1-VO
	for gcvg-git-2@gmane.org; Wed, 30 Jul 2008 18:16:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751826AbYG3QPc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Jul 2008 12:15:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752011AbYG3QPc
	(ORCPT <rfc822;git-outgoing>); Wed, 30 Jul 2008 12:15:32 -0400
Received: from sglonmg02-out.sabre.com ([151.193.120.24]:36901 "EHLO
	sglonmg02-out.sabre.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751550AbYG3QPc (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Jul 2008 12:15:32 -0400
X-ExtLoop1: From 10.136.85.54
X-IronPort-AV: E=Sophos;i="4.31,279,1215385200"; 
   d="scan'208";a="1125111817"
Received: from unknown (HELO sglonbh01.Global.ad.sabre.com) ([10.136.85.54])
  by sglonmg02-out.sabre.com with ESMTP; 30 Jul 2008 17:15:18 +0100
Received: from sglonms02.Global.ad.sabre.com ([10.136.85.20]) by sglonbh01.Global.ad.sabre.com with Microsoft SMTPSVC(6.0.3790.1830);
	 Wed, 30 Jul 2008 17:15:18 +0100
Received: from [10.104.41.28] ([10.104.41.28]) by sglonms02.Global.ad.sabre.com with Microsoft SMTPSVC(6.0.3790.1830);
	 Wed, 30 Jul 2008 17:15:18 +0100
User-Agent: Mozilla-Thunderbird 2.0.0.16 (X11/20080724)
In-Reply-To: <alpine.LSU.1.00.0807301650060.3486@wbgn129.biozentrum.uni-wuerzburg.de>
X-OriginalArrivalTime: 30 Jul 2008 16:15:18.0208 (UTC) FILETIME=[7531EC00:01C8F25F]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90814>

[sorry, was intended to cc Johannes Sixt when I mailed the patch to the 
list... not doing well with the recipient etiquette]

[and then Icedove decided it was going to send mail as HTML. This is so embarassing.]

Johannes Schindelin wrote:
>> diff --git a/upload-pack.c b/upload-pack.c
>> index c911e70..086eff6 100644
>> --- a/upload-pack.c
>> +++ b/upload-pack.c
>> @@ -616,6 +616,9 @@ int main(int argc, char **argv)
>>  	int i;
>>  	int strict = 0;
>>  
>> +	if (argv[0] && *argv[0])
>> +		git_extract_argv0_path(argv[0]);
>> +
>>     
>
> This is ugly.  The called function should already do it itself.
>   

Fair enough.

> Further, why not go the full nine yards and avoid the calculation 
> altogether, until it is necessary?  Then the change to add 
> lookup_program_in_path() would be nice and non-intrusive.

git.c will always need to do the calculation, to determine which command 
it is being invoked as, so is there much value in delaying until necessary?

If the code in git.c is left alone, then it needs to be eventually 
duplicated in upload-pack.c and receive-pack.c, or in exec_cmd.c. [I 
botched when sending out the patch originally and only sent it to 
Johannes and not the list, so it's my fault that the history of how this 
has evolved is unclear I'm afraid]

> IOW why not leave the function name as-is, and just enhance system_path() 
> to have a static variable "initialized", which does the whole calculation? 
> I.e. move the calculation from git.c to exec_cmd.c, but at the same time 
> do it only when needed.

Hmm, system_path and setup_path both use argv0_path; git.c would need to 
call an additional function in exec_cmd.c to get the "leafname" result 
of the calculation, though.

> And your change to set argv0_path from receive-pack and upload-pack would 
> be a second patch.

OK.

> And then the patch to add support to "glean" (did not know that word) the 
> path from the PATH (lookup_program_in_path()) could come as a third patch.

I think that once git-upload-pack.c et al get the argv[0] path over to 
setup_path() then there's nothing more to do; setup_path() already uses 
argv0_path in its list of paths to try. I'm confused to the reference to 
PATH, though: we're avoiding the PATH environment variable completely.

SRH
