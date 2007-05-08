From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH/RFC] diff: Make numstat machine friendly also for renames
Date: Tue, 8 May 2007 14:33:57 +0200
Message-ID: <200705081433.58931.jnareb@gmail.com>
References: <11785850223782-git-send-email-jnareb@gmail.com> <200705080345.26817.jnareb@gmail.com> <7vhcqo5b64.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Tue May 08 14:34:14 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HlOtQ-0002oI-UH
	for gcvg-git@gmane.org; Tue, 08 May 2007 14:34:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966723AbXEHMeI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 8 May 2007 08:34:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966735AbXEHMeI
	(ORCPT <rfc822;git-outgoing>); Tue, 8 May 2007 08:34:08 -0400
Received: from ug-out-1314.google.com ([66.249.92.174]:63299 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S966723AbXEHMeG (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 May 2007 08:34:06 -0400
Received: by ug-out-1314.google.com with SMTP id 44so111034uga
        for <git@vger.kernel.org>; Tue, 08 May 2007 05:34:05 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=B6nh5/4RtVnfzMpI4ReryrI6tFNVdfx5CBjbrWhDdqOUKoIM1SCDnho4MJDucxHZXbK2b4cgPJtk+diJ84yO9jOGu1j7jrepxJSTCAao+lYQCMcHtQSsgPd2Rrvs/f/ff2D9I9DvhPDY54+rmesJMc1S5id2aL4JLo5LcrnOb0U=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=dzT9HFf2oHeHIjgq8O1302Q55vNuLaZpCX2E4cU3mR1YsjgTAfryjSzhYcVihIKiqZr0kmVz3IEoeG2dnvH3zUefgQ8IMnoxjTyxJOXWMnebfE8rttTJKMSUv/GE1LHWt4/dq8KuWIhQRUVrE0U0u4hOEWQnmXg3QF4lKyqcG1Y=
Received: by 10.67.10.12 with SMTP id n12mr480658ugi.1178627645090;
        Tue, 08 May 2007 05:34:05 -0700 (PDT)
Received: from host-89-229-25-173.torun.mm.pl ( [89.229.25.173])
        by mx.google.com with ESMTP id 54sm779896ugp.2007.05.08.05.34.01;
        Tue, 08 May 2007 05:34:02 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <7vhcqo5b64.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46572>

Junio C Hamano <junkio@cox.net> wrote:
> Jakub Narebski <jnareb@gmail.com> writes:
> 
>>>> The numstat format for rename is now
>>>>
>>>>   added deleted TAB path for "src" TAB path for "dst" LF
>>>>
>>>> or if -z option is used
>>>>
>>>>   added deleted TAB path for "src" NUL NUL path for "dst" NUL
>>> 
>>> Why two NULs?
>>
>> That was the only way I could think of to separate pre-image name
>> from posi-image name for renames. Note that file name might look like
>> (part of) diffstat line, and there is no 'status' field in the
>> numstat to mark rename (as there is in "git diff-tree --raw" output).
> 
> The --stat format is for human consumption, and --numstat (be it
> with -z or without) is for machines, so I am not opposed to a
> format change that gives information that is already computed
> but currently is hard to parse.  If the format change breaks
> existing scripts, we might want to do --numstat-extended,
> though...
> 
> For example, I do not see a reason not to add "R98" in there.
> I.e.
> 
> 	added deleted status TAB "src" (TAB "dst"){0,1} LF
> 	added deleted status NUL "src" (NUL "dst"){0,1} NUL
> 
> where the dst path is present only when status says it is a
> rename/copy, just like the --raw format.

That is a good idea, but wouldn't it break existing scripts? Well,
break more than a bit hacky idea of using NUL NUL as separator between
pre-image name and post-image name.

This would change output in every case, while my proposal doesn't change
output for the case without renames. '-M' should also work correctly,
perhaps scripts using it getting wrong filename. It is '-z -M' that changes
most.

>> Did you mean --stat here?
> 
> No, I did mean --summary.  But that was foolish of me.  I forgot
> that it had the same { namepart => namepart } issue.

Ah. I somehow didn't get then that you meant for --numstat to have only
post-image names, and get pre-image names from rename information in
--summary. But as you have noticed it wouldn't help: rename information
is in the same for-humans format.

>>>> @@ -949,11 +955,19 @@ static void show_numstat(struct diffstat_t* data,
>>>>  			printf("-\t-\t");
>>>>  		else
>>>>  			printf("%d\t%d\t", file->added, file->deleted);
>>>> -		if (options->line_termination && !file->is_renamed &&
>>>> +		if (options->line_termination &&
>>>>  		    quote_c_style(file->name, NULL, NULL, 0))
>>>>  			quote_c_style(file->name, NULL, stdout, 0);
>>>>  		else
>>>>  			fputs(file->name, stdout);
>>>> +		if (file->is_renamed) {
>>>> +			printf("%s", options->line_termination ? "\t" : "\0\0");
>
> What I was hoping you to notice was that printf("%s", "\0\0")
> thing.  %s would not even notice that the const char[] literal
> is 2 bytes long.

Ooops. Shame on me. That is the result of trying to be too smart... 
and changing separator between pathnames for rename from NUL to NUL NUL.

-- 
Jakub Narebski
Poland
