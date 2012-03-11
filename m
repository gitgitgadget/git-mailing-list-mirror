From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] apply: reallocate the postimage buffer when needed
Date: Sun, 11 Mar 2012 11:43:52 -0700
Message-ID: <7v8vj7x9jr.fsf@alter.siamese.dyndns.org>
References: <1331475857-15169-1-git-send-email-cmn@elego.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
To: Carlos =?utf-8?Q?Mart=C3=ADn?= Nieto <cmn@elego.de>
X-From: git-owner@vger.kernel.org Sun Mar 11 19:44:27 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S6nkp-000475-5v
	for gcvg-git-2@plane.gmane.org; Sun, 11 Mar 2012 19:44:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753868Ab2CKSn4 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 11 Mar 2012 14:43:56 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:47405 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753865Ab2CKSnz convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 11 Mar 2012 14:43:55 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 715137FCE;
	Sun, 11 Mar 2012 14:43:54 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=rc9ZQei1rOfp
	WGBwbe/hJxZ5BPY=; b=v8hkQNsDP/Zv9BIFpk8y5mPWBQrUUXF9VjcCw4EIFprs
	5egshik7pt67WiMq/odlwYqlFshS+GgcZGDI3mj1Yk7FvibIza7eXkVbhzJnj4ZX
	BY1PkrOmbXoMQuu78p6vrKvENuSqphe/E0XYoOGGqcxJzgG15vDmVKxZgg/Vk+k=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=BqBnMV
	TW25z16qwJoJjEKDjFZGTJ07JfFgqgwWD6wD93ZNytxvkiEITyJEiCd2MuB9PqFS
	Wiie2c77lnWXPVKv4QaOYVNE2VMqmiz4n51Q0GFYZ9BPJambbgv4Ej48UlvEWNk0
	cx/XBb3n/xTtEKqQwMxzP7mXRsHqaVM/w8zT4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 687097FCD;
	Sun, 11 Mar 2012 14:43:54 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id F083C7FCC; Sun, 11 Mar 2012
 14:43:53 -0400 (EDT)
In-Reply-To: <1331475857-15169-1-git-send-email-cmn@elego.de> ("Carlos
 =?utf-8?Q?Mart=C3=ADn?= Nieto"'s message of "Sun, 11 Mar 2012 15:24:17
 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 26F3FCE0-6BAA-11E1-9331-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192821>

Carlos Mart=C3=ADn Nieto <cmn@elego.de> writes:

> Blame says Junio and Giuseppe were the last ones to touch this part o=
f
> the code, so there you go.

Whatever you do in your fix, this comment block needs to be updated:

	/*
	 * Adjust the common context lines in postimage. This can be
	 * done in-place when we are just doing whitespace fixing,
	 * which does not make the string grow, but needs a new buffer
	 * when ignoring whitespace causes the update, since in this case
	 * we could have e.g. tabs converted to multiple spaces.
	 * We trust the caller to tell us if the update can be done
	 * in place (postlen=3D=3D0) or not.
	 */

The second sentence used to be true for a long time (if you indented
your line with too many spaces, we removed them and replaced with
fewer number of tabs; if you had spaces before a tab, we removed
them; if you added unnecessary whitespaces at the end, we removed
them), but ceased to be so when Python style "indent must be spaces"
was added.

So I think this either always needs to re-allocate, or the caller
has to tell it by other means than "!postlen" the need for
reallocation.

I wasn't involved in the "apply while ignoring whitespace
differences", so Giuseppe may be able to notice other mode of
beakages in this and fuzzy_matchlines() function.  The commit to be
stared at is 86c91f9 (git apply: option to ignore whitespace
differences, 2009-08-04).

Thanks.
