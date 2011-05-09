From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v0 3/3] Bigfile: teach "git add" to send a large file
 straight to a pack
Date: Mon, 09 May 2011 09:14:09 -0700
Message-ID: <7vzkmvq2b2.fsf@alter.siamese.dyndns.org>
References: <1304844455-23570-1-git-send-email-gitster@pobox.com>
 <1304844455-23570-4-git-send-email-gitster@pobox.com>
 <BANLkTimo_D_s-=zjPAbStvETRh8d_Tpa_w@mail.gmail.com>
 <7v4o53rhkv.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Shawn Pearce <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Mon May 09 18:14:24 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QJT6F-0005E9-GS
	for gcvg-git-2@lo.gmane.org; Mon, 09 May 2011 18:14:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753008Ab1EIQOS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 May 2011 12:14:18 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:50323 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752873Ab1EIQOR (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 May 2011 12:14:17 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 3B4D4411B;
	Mon,  9 May 2011 12:16:21 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=tCy65nisRrV43OadDFWSSy39HBs=; b=wSE0BN
	BjNWnmPDPohfsSZ2Pmyu1HzgL8RgKIkrt63AjHprt4ZMtD4OyvrS/TFc6uP6BOr0
	VRjJpYmKh1hXUVaQaP1jKSPwW3GFvTK9I1GUB5XRNZ3/BHuvoiRuP0rlKSeFUO9R
	Z2oYhW8CPnndNUow4A9lpRkk4g9avNpyAvjwM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=QoyVw6cvg4dXLT8j5ZzaPJ8wgJiu29tH
	h3ovja9rlMn77XLdY8ioXGGOVy2l5g/wyE4ZY9AM1AUN7ltSq1EZXkMe2yg2FPhR
	B+zFSq0b+X1zYLs6ZeyrG2UdmJhxG/sqPEWWSEJr6Q9/uxPxbcQdoZbzYms0m2b3
	cQ9jBiL3Pj4=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 162934118;
	Mon,  9 May 2011 12:16:19 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 23909410F; Mon,  9 May 2011
 12:16:15 -0400 (EDT)
In-Reply-To: <7v4o53rhkv.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Mon, 09 May 2011 08:58:56 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: AC243C08-7A57-11E0-BB37-90BEB0B5FC3A-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173241>

Junio C Hamano <gitster@pobox.com> writes:

> I envisioned that the "API" I talked about in the NEEDSWORK you quoted
> would keep an open file descriptor to the "currently being built" packfile
> wrapped in a "struct packed_git", with an in-core index_data that is
> adjusted every time you add a straight-to-pack kind of object. Upon a
> "finalize" call, it would determines the final pack name, write the real
> pack .idx file out, and rename the "being built" packfile to the final
> name to make it available to the outside world.
>
> Within a single git process that approach would give access to the set of
> objects that are going straight to the pack.  When it needs to spawn a git
> subprocess, it however would need to finalize the pack to give access to
> the new object, just like when fast-import flushes when asked to expose
> the marks.
>
> After all, this topic is about handling large binary files that would not
> fit in core at once (we do not support them now at all). It may not too
> bad to say we stuff one object per packfile and immediately close the
> packfile (which is what the use of fast-import by the POC patch
> does).

A (tentatively final) side note.

The primary reason why I wanted to think about using a single packfile
that is kept open and add multiple objects to the pack was because we may
later want to use this kind of set-up for "initial import", regardless of
the size of the object being added.  But now I think about it I do not
think that use case matters a lot.  The resulting single pack would have
much worse object density, compared to the case where you add them
normally, initially creating loose object files and then repack/gc at
which time you are likely to have more than one rev to sanely deltify.

Using one pack per large object while creating is not too bad to begin
with.  If you had a large enough core to hold such a large binary file,
the current system would store it as a single loose object file, so it is
not like we are making things any worse.  In either form, these "single
object per a file" initial storage will find their more permanent home
upon the first repack/gc.
