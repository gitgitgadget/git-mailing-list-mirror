From: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
Subject: Re: [PATCH 05/31] rebase: improve detection of rebase in progress
Date: Tue, 28 Dec 2010 21:35:34 +0100 (CET)
Message-ID: <alpine.DEB.1.10.1012282104320.29381@debian>
References: <1293528648-21873-1-git-send-email-martin.von.zweigbergk@gmail.com> <1293528648-21873-6-git-send-email-martin.von.zweigbergk@gmail.com> <7vaajpv6lh.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>,
	git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Christian Couder <chriscool@tuxfamily.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Dec 29 03:34:54 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PXlsJ-0001t5-Tz
	for gcvg-git-2@lo.gmane.org; Wed, 29 Dec 2010 03:34:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751707Ab0L2Ceq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Dec 2010 21:34:46 -0500
Received: from mail-qy0-f174.google.com ([209.85.216.174]:47751 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751535Ab0L2Ceq (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Dec 2010 21:34:46 -0500
Received: by qyj19 with SMTP id 19so11749213qyj.19
        for <git@vger.kernel.org>; Tue, 28 Dec 2010 18:34:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:x-x-sender:to:cc
         :subject:in-reply-to:message-id:references:user-agent:mime-version
         :content-type;
        bh=j9bDyapdCQg1YUEzbXhNUjKcz0xcPmUrA39VBg9xyc8=;
        b=voikezHtkcBjsb/Ami501BVjNHiV3INUB/xV52lJgOLMBCw0RL5xtEv7WKNIC4XVPG
         ce6qB4iffhNGglJ3VtVeWGWVB0rvi65S/fz5o8pkI1Tlnt48jRO+ufXPtNeEmAWeZrbe
         lB80BVCnmyDdVxHZueKtN5Ndiuj+M1iAmwfPw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:x-x-sender:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version:content-type;
        b=jGLi/f2WS1lAQ4et53+XW41sCmwlOJamcVCEaWAHYYDnrbUlIvziddsc51TUg1XFgi
         arzAAPcfrhTNg/3TGPcxTtmjIB9W8zMfD7h36cdm6aVAPCB7S0MGrIJV2pcrI5tOWOA4
         HUiMgwIf1fOapTqkLcr2qD0kxLAgX9R39pwDY=
Received: by 10.229.249.17 with SMTP id mi17mr12674265qcb.123.1293590085265;
        Tue, 28 Dec 2010 18:34:45 -0800 (PST)
Received: from [192.168.1.105] (modemcable151.183-178-173.mc.videotron.ca [173.178.183.151])
        by mx.google.com with ESMTPS id y17sm8093253qci.21.2010.12.28.18.34.43
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 28 Dec 2010 18:34:44 -0800 (PST)
X-X-Sender: martin@debian
In-Reply-To: <7vaajpv6lh.fsf@alter.siamese.dyndns.org>
User-Agent: Alpine 1.10 (DEB 962 2008-03-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164301>


On Tue, 28 Dec 2010, Junio C Hamano wrote:

> Martin von Zweigbergk <martin.von.zweigbergk@gmail.com> writes:
> 
> > Currently, the existence of rebase-merge/ is tested with 'test -d',
> > while the existence of rebase-apply/ is tested by creating the
> > directory and then deleting it again. Any good reason for this?
> 
> I don't recall how the merge side reached the current shape of the code,
> but I think the rebase-apply one was that we wanted to make sure not only
> we don't have a directory but also we actually _can_ create one.  If
> somebody had a bad permission set, "test -d" wouldn't help us much.  We
> would fail later and error diagnosis codepath should do the right thing
> anyway, so it is not a correctness issue, but is more about attempting to
> notice an error early rather than late.

Yeah, I was wondering if that might have been the reason. Why would
anyone set such permissions on .git (keep in mind that I am no
Linux/Unix expert)?

I saw that the code was introduced [1] when the directory was called
.dotest and I believe this directory was created at the top level
(i.e. a sibling to .git). Could it be that it was reasonable for the
user to set such permissions back then (on the top level dir), but not
any longer (on the .git dir)?


Either way, if it is good to have the that check for rebase-apply/,
wouldn't it be good to have for rebase-merge/ as well?

/Martin


[1] 7f4bd5d (rebase: one safety net, one bugfix and one optimization.,
2005-11-28)
