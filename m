From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Q: does index-pack work in place on windows?
Date: Thu, 03 Feb 2011 17:59:48 -0800
Message-ID: <7v1v3ozhij.fsf@alter.siamese.dyndns.org>
References: <7v39o6xk5q.fsf@alter.siamese.dyndns.org>
 <AANLkTi=m+kERSH7TJFjuRaUfA7FR03zwNn2PKFxrqiOp@mail.gmail.com>
 <alpine.LFD.2.00.1102030026430.12104@xanadu.home>
 <7vk4hhwpfb.fsf@alter.siamese.dyndns.org>
 <alpine.LFD.2.00.1102031958000.12104@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Erik Faye-Lund <kusmabite@gmail.com>, Johannes Sixt <j6t@kdbg.org>,
	git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>
To: Nicolas Pitre <nico@fluxnic.net>
X-From: git-owner@vger.kernel.org Fri Feb 04 03:00:11 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PlAy2-0007r0-Uh
	for gcvg-git-2@lo.gmane.org; Fri, 04 Feb 2011 03:00:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755054Ab1BDCAG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Feb 2011 21:00:06 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:45267 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751006Ab1BDCAE (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Feb 2011 21:00:04 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 3BF0540EF;
	Thu,  3 Feb 2011 21:00:57 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=H9PGi83ZDirLzq/cVNm6dGOmu5o=; b=LenDUu
	J0tTEFs3rMU913AWYzVFTsz2sLasXSonK0wLzOoEJX6T/Weh3DUJuhn7dV+MxShL
	57I/SPxLmn9Lbu/f/Lx28eYzrnLsY0/wOGZg+pPA+kSUKy+sDN0ZW8PGM6sIrZfp
	aJp0PoQRK+EUKuW9xdYCqzzZNooKGYxQyst/c=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=LOAaTZDp2wAtGWOafol4MNgidegQgsrs
	KBQaa4KKFtP8x67ZKCD7iaCITg/8+XfTyTmGhSm8dwKA1hutWEgxn2lkQLQgOhrT
	kmZmO+WleIrwqkXq5dz3IS/Y2FBjO010zolTfG9KHcdFwmx/1K6vuzJcBrAyBKOU
	Faw7M342ruE=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id DDEAA40EE;
	Thu,  3 Feb 2011 21:00:51 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 0DB5C40EA; Thu,  3 Feb 2011
 21:00:44 -0500 (EST)
In-Reply-To: <alpine.LFD.2.00.1102031958000.12104@xanadu.home> (Nicolas
 Pitre's message of "Thu\, 03 Feb 2011 20\:14\:34 -0500 \(EST\)")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 97F54794-3002-11E0-BFD0-F13235C70CBC-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166018>

Nicolas Pitre <nico@fluxnic.net> writes:

> On Wed, 2 Feb 2011, Junio C Hamano wrote:
>
>> I am trying to see if an index-pack with slight modification would be a
>> good replacement for verify-pack.
> ...
> index-pack _could_ be a replacement for verify-pack.  It certainly can 
> validate a pack since it is its purpose, possibly faster than 
> verify-pack.  You'd still have to compare the existing pack index 
> against the one index-pack creates without overwriting that original 
> index, taking into accound index version differences, etc.

We already know index-pack is a lot faster when you have a lot of deep
deltas, as it works from a base to its immediate delta children while
pinning that base, as opposed to verify-pack that verifies each and every
object in the pack in the index order, inflating and then applying
potentially long delta chains repeatedly---the only thing that could be
helping it right now is the in-core delta base cache.

> However index-pack won't tell you what is broken in the pack when 
> corruptions are to be found.

Yes, but at that point, you are pretty much lost anyway, as the only thing
you can do to salvage salvageable parts of the broken pack, if you still
trust its associated .idx file, is to walk the table of contents and ask
for each individual object; knowing where the .pack or .idx is broken with
the current verify-pack does not help you very much.
