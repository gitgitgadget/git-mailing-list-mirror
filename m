From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: generation numbers
Date: Thu, 7 Jul 2011 22:10:12 +0200
Message-ID: <201107072210.13254.jnareb@gmail.com>
References: <1307819051-25748-1-git-send-email-avarab@gmail.com> <7viprfhu4w.fsf@alter.siamese.dyndns.org> <20110707190828.GC12044@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, Ted Ts'o <tytso@mit.edu>,
	Jonathan Nieder <jrnieder@gmail.com>,
	=?utf-8?q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
	<avarab@gmail.com>, Clemens Buchacher <drizzd@aon.at>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Jul 07 22:10:34 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qeuu7-00084f-Hr
	for gcvg-git-2@lo.gmane.org; Thu, 07 Jul 2011 22:10:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752745Ab1GGUKZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Jul 2011 16:10:25 -0400
Received: from mail-fx0-f52.google.com ([209.85.161.52]:48828 "EHLO
	mail-fx0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752743Ab1GGUKY (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Jul 2011 16:10:24 -0400
Received: by fxd18 with SMTP id 18so1385944fxd.11
        for <git@vger.kernel.org>; Thu, 07 Jul 2011 13:10:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-disposition:content-type
         :content-transfer-encoding:message-id;
        bh=5MNv2eJklbWOuXCo7gR7yeKe397RWW4khXbToQiTxAs=;
        b=gbStRmBjF6YeEkwPD1O6oJMHVnoydz3YGsF74fJ8QgGcSuv1MZ4d1/EBUE+BnzxCwZ
         xoVfZyG8pT6oUXsYGjSvLuLxZn5cMtBmikk3o+dXnUiSFq/PWAB465+Y7deVGs/PGGhm
         TPM4v/ccZVG4jUKKSFCBQQ4FZpAGQszvQ1dgE=
Received: by 10.223.91.156 with SMTP id n28mr1792098fam.102.1310069423597;
        Thu, 07 Jul 2011 13:10:23 -0700 (PDT)
Received: from [192.168.1.15] (abwq132.neoplus.adsl.tpnet.pl [83.8.240.132])
        by mx.google.com with ESMTPS id g12sm2514960fai.32.2011.07.07.13.10.21
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 07 Jul 2011 13:10:22 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <20110707190828.GC12044@sigill.intra.peff.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176776>

On Thu, 7 Jul 2011, Jeff King wrote:
> On Wed, Jul 06, 2011 at 04:22:23PM -0700, Junio C Hamano wrote:
> 
> > As to the low level implementation detail I agree everything you said, but
> > I have been wondering how the generation number should intereact with
> > grafts and replaces. It certainly would be safest whenever you change
> > grafts (which should be a rare event anyway).
> 
> Ugh. I hadn't even considered grafting. Yeah, grafting or replacing
> could make the generation numbers totally wrong. And not just for the
> replaced commit, but for everything that builds on top. That's perhaps
> an argument against putting them into the commit header at all; once you
> graft, everything after will have bogus generation numbers.
> 
> So yeah, you would want to clear the cache any time you tweak
> replacements or grafts (which I think is what you were saying in your
> final sentence).
> 
> You could do a hybrid solution, in which you have generation numbers in
> the commit header, and an external cache. You need the cache anyway to
> support older commits without the header. And then you could use the
> built-in generation numbers when there's no grafting or replacing going
> on, and the cache otherwise. That keeps the common case (no grafts)
> faster.

Or we could enhance pack protocol (new capability) to send generation
notes cache as a separate stream perhaps.

Or make generation notes cache part of post-downloading work, after
(or while) generating pack index.

> Still, if we can get the external lookup to be faster than my initial
> notes attempt (which really should not be that hard), the performance
> difference may not end up that big, and it won't even be worth putting
> them into the header at all.

I wonder if we can reuse pack index code / format somewhat.

Or perhaps some kind of on-disk hash table; we need O(1) fast lookup,
and ability to update structure 'in place'.

-- 
Jakub Narebski
Poland
