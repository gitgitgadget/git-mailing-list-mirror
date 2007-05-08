From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH/RFC] diff: Make numstat machine friendly also for renames
Date: Tue, 8 May 2007 03:45:25 +0200
Message-ID: <200705080345.26817.jnareb@gmail.com>
References: <11785850223782-git-send-email-jnareb@gmail.com> <7vzm4g5ddu.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Tue May 08 03:42:14 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HlEiT-0003uT-Ke
	for gcvg-git@gmane.org; Tue, 08 May 2007 03:42:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934585AbXEHBlW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 7 May 2007 21:41:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934594AbXEHBlW
	(ORCPT <rfc822;git-outgoing>); Mon, 7 May 2007 21:41:22 -0400
Received: from py-out-1112.google.com ([64.233.166.183]:37386 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934585AbXEHBlU (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 May 2007 21:41:20 -0400
Received: by py-out-1112.google.com with SMTP id a29so1353773pyi
        for <git@vger.kernel.org>; Mon, 07 May 2007 18:41:19 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=C/97GBJN9uEVSEXQBRZsPGSNQUdOXQY603N8kNWoBXpymN18ouVW8J5qdxYgqHknY6aSiAfYPEcBdtJtb/l6VTDFVoiD4FLaifgCaccT76X83cxJOlOhm4lJSOAskz6NuH1/4iHVxdNlkBaGOdDqTb7aEXyb0teAeCTlN8AAud4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=qMLCE37EAFFBMJ6nVhAr10UmjCou83UosJMr2ft/+cyBhQqEMFVFW/YRViF9RAakuSjRklwM3N+CmcelyYTKFgwsVCZEWLRm6iNcHFt1p5dTbe8fD6saOKloeFnom9HI9V97XBfCBX3LwyH7ofP56kEHQI+3XQAjhb7BNv6zyk0=
Received: by 10.65.206.7 with SMTP id i7mr11151181qbq.1178588479769;
        Mon, 07 May 2007 18:41:19 -0700 (PDT)
Received: from host-89-229-25-173.torun.mm.pl ( [89.229.25.173])
        by mx.google.com with ESMTP id d12sm5030307qbc.2007.05.07.18.40.57;
        Mon, 07 May 2007 18:40:58 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <7vzm4g5ddu.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46506>

Junio C Hamano wrote:
> Jakub Narebski <jnareb@gmail.com> writes:
> 
>> Instead of saving human readable rename information in the 'name'
>> field when diffstat info is generated, do it when writing --stat
>> output. Change --numstat output to be machine friendly.
>>
>> This makes result of git-diff --numstat more suitable for machines
>> also when renames are involved, by using format similar to the one for
>> renames in the raw diff format, instead of the format more suited for
>> humans.
>>
>> The numstat format for rename is now
>>
>>   added deleted TAB path for "src" TAB path for "dst" LF
>>
>> or if -z option is used
>>
>>   added deleted TAB path for "src" NUL NUL path for "dst" NUL
> 
> Why two NULs?

That was the only way I could think of to separate pre-image name
from posi-image name for renames. Note that file name might look like
(part of) diffstat line, and there is no 'status' field in the
numstat to mark rename (as there is in "git diff-tree --raw" output).

But it doesn't mean that this is the only way, that is why it is RFC.
Well that and the fact that this patch increases slightly memory
footprint.

> There are already a handful in-tree users of --numstat, and also
> a few tests scripts.  I think you would need to adjust them.

Right, I forgot to run "make test" to check which tests scripts
would need adjusting.

But result of "git grep -e -M --and -e --numstat -- t/" is empty,
so I don't think that any script test --numstat with rename detection.

>> The goal of this change is to make it possible to generate HTML
>> diffstat against first parent for merge commits in gitweb. The current
>> notation for renames, which looks for example like below:
>>
>>   t/{t6030-bisect-run.sh => t6030-bisect-porcelain.sh}
> 
> I do not have much objection against teaching --numstat to show
> the preimage pathnames.  I do not disagree with "the goal" of
> showing "git diff --stat -M $commit^1 $commit" even for merge
> commit.
> 
> But I do not see the connection between the two.  Why aren't you
> parsing --summary?

Did you mean --stat here? Because

  --summary::
        Output a condensed summary of extended header information
        such as creations, renames and mode changes.

I'd like to have diffstat for merge, similar to what "git pull <repo>"
does when doing true merge, not what "git commit" does.

And --stat is meant for human consumption, not for machine consumption.
File name may contain " => " inside. And there is no way to differentiate
between " => " in file name, and " => " separating "src" path name from
"dst" path name.

> Have you actually _tested_ your patch?

Compiled, but forgot to run "make test". But I have checked that it passes
"make test", which probably mean that we don't have enough coverage ;-)

>> @@ -949,11 +955,19 @@ static void show_numstat(struct diffstat_t* data,
>>  			printf("-\t-\t");
>>  		else
>>  			printf("%d\t%d\t", file->added, file->deleted);
>> -		if (options->line_termination && !file->is_renamed &&
>> +		if (options->line_termination &&
>>  		    quote_c_style(file->name, NULL, NULL, 0))
>>  			quote_c_style(file->name, NULL, stdout, 0);
>>  		else
>>  			fputs(file->name, stdout);
>> +		if (file->is_renamed) {
>> +			printf("%s", options->line_termination ? "\t" : "\0\0");
> 
> I know you marked it as RFC; but it is impolite to request
> comments from other people on a patch that does not do what you
> intended to do, without marking "this is untested".  It would
> waste people's time.

It passes "make test". I should perhaps mark more strongly that some
of _ideas_ are untested...

-- 
Jakub Narebski
Poland
