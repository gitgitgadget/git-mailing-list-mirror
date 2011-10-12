From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Re* [PATCH v3 19/22] resolve_ref(): emit warnings for
 improperly-formatted references
Date: Tue, 11 Oct 2011 21:41:39 -0700
Message-ID: <7v39eyddoc.fsf@alter.siamese.dyndns.org>
References: <1316121043-29367-1-git-send-email-mhagger@alum.mit.edu>
 <1316121043-29367-20-git-send-email-mhagger@alum.mit.edu>
 <20111011161652.GA15629@sigill.intra.peff.net>
 <7vr52jfm8i.fsf@alter.siamese.dyndns.org>
 <7vmxd7flkw.fsf@alter.siamese.dyndns.org>
 <7v39ezffq5.fsf_-_@alter.siamese.dyndns.org>
 <20111011230749.GA29785@sigill.intra.peff.net>
 <7vehyjcckp.fsf@alter.siamese.dyndns.org>
 <20111012021128.GA32149@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michael Haggerty <mhagger@alum.mit.edu>, git@vger.kernel.org,
	cmn@elego.de, A Large Angry SCM <gitzilla@gmail.com>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Sverre Rabbelier <srabbelier@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Oct 12 06:41:57 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RDqdf-0005Vl-Mt
	for gcvg-git-2@lo.gmane.org; Wed, 12 Oct 2011 06:41:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751980Ab1JLEln (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Oct 2011 00:41:43 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:49523 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751798Ab1JLEln (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Oct 2011 00:41:43 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DA1A42B37;
	Wed, 12 Oct 2011 00:41:41 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=84plSdK1fvAxJYKpDWH6WlJ8uy0=; b=Ea9YOe9hP1U6+F8DhQcb
	Z6bXn3aoPXGr4J0WYtn+rL8GYjCOrCwArL7usOu74lEc/mz1vYPdzEfVJZHkVvwK
	gUxIV/zlUk38ZmBcO8nWKKIzKwxg1YEbgzyumxSsID4ESOUxWgOAGw4w3SZJ7sO7
	CpSznHxtzCWM+vtV7ElVYJ8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=Cfcn1c4/fJfasNYv1hHgq3Ei8EkpqA3kY9tl3QvAvqVH44
	6WoWd6ctTa1twlEZLarCgIyu9HRAkGV5h+vVEAXXcERrsnmywozgHr5c6WdsfItR
	0YhXKGAr0krf4MGd2wOY/+abdhLOboBISiUQQe81FuBvnoMCRwYP5jnVAO3/Q=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D06BC2B36;
	Wed, 12 Oct 2011 00:41:41 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 5CAED2B34; Wed, 12 Oct 2011
 00:41:41 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 7AD0572C-F48C-11E0-A541-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183352>

Jeff King <peff@peff.net> writes:

> At any rate, I think the changes should be all or nothing. If the
> warning goes away, fine. But if the warning stays, and dwim_ref is going
> to have special rules for looking in the top-level $GIT_DIR, then things
> like shorten_unambiguous_ref need to respect those rules, or we've just
> created a new bug.

Whether we remove the warning or not, I think it would be an improvement
not to look at random files directly underneath $GIT_DIR/. I am not sure
how we can be confident that we caught everything, though.

In other words, is shorten-unambiguous-refs the last one that needs
fixing? How would we know for certain?

Also I tend to think Michael's "only warn in refs/" is probably not the
right solution. When a caller asks to resolve_ref(MERGE_HEAD), one of
these things can be true:

 - A file $GIT_DIR/MERGE_HEAD does not exist; this is not inherently an
   error unless we were supposed to be in the middle of a conflicted
   merge.

 - A file $GIT_DIR/MERGE_HEAD exists, and records a correct 40-hexadecimal
   get_sha1_hex() can grok. This is perfectly normal.

 - A file $GIT_DIR/MERGE_HEAD exists, but get_sha1_hex() does not grok
   it. Michael warns against this twice, and I think it is a wrong thing
   to pass this unnoticed.

Once we tighten all the "too loose accesses to $GIT_DIR/$random_filename",
we might even want to have an option to cause the caller to die() in the
error case, and the logic is the same for refs under $GIT_DIR/refs/, not
just the ref-like-things directly under $GIT_DIR.

A regular ref, can also appear in $GIT_DIR/packed-refs, but a corruption
of an entry in the file will be caught when the file is read and outside
the scope of this discussion, I think.
