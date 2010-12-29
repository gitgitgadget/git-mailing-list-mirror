From: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
Subject: Re: [PATCH 18/31] rebase: extract merge code to new source file
Date: Wed, 29 Dec 2010 23:24:53 +0100 (CET)
Message-ID: <alpine.DEB.1.10.1012292315070.7175@debian>
References: <1293528648-21873-1-git-send-email-martin.von.zweigbergk@gmail.com> <1293528648-21873-19-git-send-email-martin.von.zweigbergk@gmail.com> <201012292231.33333.j6t@kdbg.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>,
	git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Christian Couder <chriscool@tuxfamily.org>
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Thu Dec 30 05:24:17 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PYA3k-0007c9-3X
	for gcvg-git-2@lo.gmane.org; Thu, 30 Dec 2010 05:24:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751363Ab0L3EYF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Dec 2010 23:24:05 -0500
Received: from mail-qy0-f174.google.com ([209.85.216.174]:54193 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750939Ab0L3EYE (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Dec 2010 23:24:04 -0500
Received: by qyj19 with SMTP id 19so12825065qyj.19
        for <git@vger.kernel.org>; Wed, 29 Dec 2010 20:24:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:x-x-sender:to:cc
         :subject:in-reply-to:message-id:references:user-agent:mime-version
         :content-type;
        bh=sgnSSk6CPcqsfunoRWA5dqfyV2joPD93PYVq8JyUAE4=;
        b=XM0/tfXLpjtMOwURloKa6la9vXLbliKSIal5wdDylv2Yid86CUwAZj7aCqOB6NqS6y
         kSfiI9KZzSbFNVbj2iXjbnWCbgisdJrbOHo2r4ZQWsGfcAEL/8W3H05rIXqRPCS5ybe/
         kYlNO+deaIjXizRr8T/dareHHMUU8o7MDPdPQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:x-x-sender:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version:content-type;
        b=sR2nm0ArO2S1IPaS3nS7wJab/EcDdhqEYCNzMTrZSxK/paCCE1Xh1rFr0DTH61XTyF
         webk9yNMduqkc5q9wSAQSyCUYzlXGn2j/10Fxd7v5QANQlPiS5eYhu0iQGP616Rl0XoV
         an7D6ClDqPwn9gXTqkD3e/L89NRwy0fAtI3Mg=
Received: by 10.224.61.11 with SMTP id r11mr14713067qah.230.1293683042837;
        Wed, 29 Dec 2010 20:24:02 -0800 (PST)
Received: from [192.168.1.103] (modemcable151.183-178-173.mc.videotron.ca [173.178.183.151])
        by mx.google.com with ESMTPS id t7sm7807618qcs.40.2010.12.29.20.24.00
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 29 Dec 2010 20:24:01 -0800 (PST)
X-X-Sender: martin@debian
In-Reply-To: <201012292231.33333.j6t@kdbg.org>
User-Agent: Alpine 1.10 (DEB 962 2008-03-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164347>

On Wed, 29 Dec 2010, Johannes Sixt wrote:

> On Dienstag, 28. Dezember 2010, Martin von Zweigbergk wrote:
> > -run_interactive_rebase () {
> > +run_specific_rebase () {
> >  	if [ "$interactive_rebase" = implied ]; then
> >  		GIT_EDITOR=:
> >  		export GIT_EDITOR
> >  	fi
> >  	export onto autosquash strategy strategy_opts verbose rebase_root \
> > -	force_rebase action preserve_merges upstream switch_to head_name
> > -	exec git-rebase--interactive
> > +	force_rebase action preserve_merges upstream switch_to head_name \
> > +	state_dir orig_head onto_name GIT_QUIET revisions RESOLVEMSG \
> > +	allow_rerere_autoupdate
> > +	export -f move_to_original_branch
> 
> Is export -f portable?

It seems like it isn't. What is a good way to check?
 
> > +	test "$type" != am && exec git-rebase--$type
> 
> I'd prefer to dispatch to the final rebase type using
> 
> 	. git-rebase--$type
> 
> This way, you can avoid to export the huge list of helper variables and the 
> function. (And it might be faster by a millisecond - or a few dozens on 
> Windows.)

Makes a lot of sense. Will change. Why didn't I do that from the
beginning?


Thanks,
Martin
