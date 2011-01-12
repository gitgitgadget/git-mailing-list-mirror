From: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
Subject: Re: [PATCH 05/31] rebase: improve detection of rebase in progress
Date: Wed, 12 Jan 2011 05:20:54 -0500 (EST)
Message-ID: <alpine.DEB.1.10.1101120511330.856@debian>
References: <1293528648-21873-1-git-send-email-martin.von.zweigbergk@gmail.com> <1293528648-21873-6-git-send-email-martin.von.zweigbergk@gmail.com> <7vaajpv6lh.fsf@alter.siamese.dyndns.org> <alpine.DEB.1.10.1012282104320.29381@debian>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>,
	git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Christian Couder <chriscool@tuxfamily.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jan 12 11:21:07 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PcxpB-00054w-R2
	for gcvg-git-2@lo.gmane.org; Wed, 12 Jan 2011 11:21:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751901Ab1ALKVA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Jan 2011 05:21:00 -0500
Received: from mail-vw0-f46.google.com ([209.85.212.46]:57399 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751461Ab1ALKU7 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Jan 2011 05:20:59 -0500
Received: by vws16 with SMTP id 16so110008vws.19
        for <git@vger.kernel.org>; Wed, 12 Jan 2011 02:20:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:x-x-sender:to:cc:subject:in-reply-to
         :message-id:references:user-agent:mime-version:content-type;
        bh=krxlqo5XXrih0m0/XKN5vioM+LjUB6J5n0h1Wpt0Bh0=;
        b=rzcqDA7Y4Jn4/l7LD55TxTv4HF5Nms1g04ibicPIoCOJRMN7zfcv5QcW/pktfbcVLK
         NNovj306JASEcf6PBNW89G078nRqGoKyUyzK6mT4YOhv18HvclRZhzM9nHT7w894KMrS
         uBAqllqFVjOBn95iOHj6WAcrNiaMvAx3xJzGo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:x-x-sender:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version:content-type;
        b=N9yr8gRsCKx3/85UO52UBhRW6ncxzP7YExW+pkSay8WWk+PN+Z/XyLwEEdi/hRF7t3
         wkTG8S8KrOV7o7siSpll4RD8axXvCK9vzum9UyRSE2JDXVy7XVxScJBlQuJ9Fasb6A3I
         ypdVFMoH1EjaNkGsASDziIit8WnVVvDqgmx8I=
Received: by 10.220.199.77 with SMTP id er13mr240184vcb.44.1294827658190;
        Wed, 12 Jan 2011 02:20:58 -0800 (PST)
Received: from [192.168.1.101] (modemcable151.183-178-173.mc.videotron.ca [173.178.183.151])
        by mx.google.com with ESMTPS id p8sm833vcr.42.2011.01.12.02.20.56
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 12 Jan 2011 02:20:57 -0800 (PST)
X-X-Sender: martin@debian
In-Reply-To: <alpine.DEB.1.10.1012282104320.29381@debian>
User-Agent: Alpine 1.10 (DEB 962 2008-03-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165013>

On Tue, 28 Dec 2010, Martin von Zweigbergk wrote:

> 
> On Tue, 28 Dec 2010, Junio C Hamano wrote:
> 
> > Martin von Zweigbergk <martin.von.zweigbergk@gmail.com> writes:
> > 
> > > Currently, the existence of rebase-merge/ is tested with 'test -d',
> > > while the existence of rebase-apply/ is tested by creating the
> > > directory and then deleting it again. Any good reason for this?
> > 
> > I don't recall how the merge side reached the current shape of the code,
> > but I think the rebase-apply one was that we wanted to make sure not only
> > we don't have a directory but also we actually _can_ create one.  If
> > somebody had a bad permission set, "test -d" wouldn't help us much.  We
> > would fail later and error diagnosis codepath should do the right thing
> > anyway, so it is not a correctness issue, but is more about attempting to
> > notice an error early rather than late.
> 
> Yeah, I was wondering if that might have been the reason. Why would
> anyone set such permissions on .git (keep in mind that I am no
> Linux/Unix expert)?
> 
> I saw that the code was introduced [1] when the directory was called
> .dotest and I believe this directory was created at the top level
> (i.e. a sibling to .git). Could it be that it was reasonable for the
> user to set such permissions back then (on the top level dir), but not
> any longer (on the .git dir)?
> 
> 
> Either way, if it is good to have the that check for rebase-apply/,
> wouldn't it be good to have for rebase-merge/ as well?
> 
> /Martin
> 
> 
> [1] 7f4bd5d (rebase: one safety net, one bugfix and one optimization.,
> 2005-11-28)
> 

I'm working on a re-roll. Any input on this?
