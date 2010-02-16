From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 3/4] Refactoring: move duplicated code from
 builtin-pack-objects.c and fast-import.c to object.c
Date: Tue, 16 Feb 2010 11:35:56 -0800
Message-ID: <7vhbphm0rn.fsf@alter.siamese.dyndns.org>
References: <1266276411-5796-1-git-send-email-michael.lukashov@gmail.com>
 <1266276411-5796-4-git-send-email-michael.lukashov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Michael Lukashov <michael.lukashov@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 16 20:36:18 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NhTDT-0001So-5j
	for gcvg-git-2@lo.gmane.org; Tue, 16 Feb 2010 20:36:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756138Ab0BPTgJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Feb 2010 14:36:09 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:35474 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754863Ab0BPTgF (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Feb 2010 14:36:05 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 098659AD1C;
	Tue, 16 Feb 2010 14:36:03 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=UnNJIeVGr0wQm7bd2RoL9LyeqqY=; b=hjcGVW
	ZC0xs80mk6fsw13VixaWLF2iT+0iIG+jxot0yiFKHtK3NLcJY23khI00yCq9oJBg
	o9DwFk2Fk7MYZUKDqQ1UL2MiE4E30TJV9ml7E7PLIh4PHBdiXEAhz85pFD4v6Lic
	MQJKWwYUIs4F20z8ujT1iYS8GJ/h80me8b4Zw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Ix9kdLJ4qo8RZy8yG26/jrL8s8B2Ip1F
	J076Z8+PR+oiT8cswN2aJRgIW/41SzgASvM26kXvX25IEAX3DKgnahYp4ysERqsc
	ExN2M6GrWyB5jdq6o4fvl+BZvBVW2TUKtTdOAGdYVTEq3A5xKuBLgqUakbyTlRer
	KkcUSzbEj9k=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id D3DC59AD1A;
	Tue, 16 Feb 2010 14:36:00 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 272F09AD0D; Tue, 16 Feb
 2010 14:35:57 -0500 (EST)
In-Reply-To: <1266276411-5796-4-git-send-email-michael.lukashov@gmail.com>
 (Michael Lukashov's message of "Mon\, 15 Feb 2010 23\:26\:49 +0000")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 833A547E-1B32-11DF-998C-6AF7ED7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140137>

Michael Lukashov <michael.lukashov@gmail.com> writes:

> The following functions are duplicated:
>
>   encode_header

what are the other duplicated ones ;-)?

> Signed-off-by: Michael Lukashov <michael.lukashov@gmail.com>
> ---

Two comments:

 - encode_header() was a perfectly good name for a static function in
   these two contexts, but when lifted into public namespace, it is not
   clear enough anymore.  It is not clear "header" in what context you are
   talking about.  At least it should be encode_in_pack_object_header();

 - Look at what are in object.[ch]; they are all about "object" layer,
   that sits one level higher in the abstraction on top of the raw object
   data layer (e.g. read_sha1_file() and friends).  This function belongs
   to a layer that is even lower level than the raw object data (i.e. one
   particular implementation of the raw object data representations among
   others).

   It looks very out of place.  I would say that cache.h and sha1_file.c
   would probably be a better place, if nobody else finds a better
   alternative.

Other than that, I agree with the patch, including its choice of types
involved.
