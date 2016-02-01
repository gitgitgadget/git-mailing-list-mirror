From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC] GPG-Signed pushes & commits: differentiating between no signature and an unknown key
Date: Mon, 01 Feb 2016 14:49:09 -0800
Message-ID: <xmqqmvrkt5ay.fsf@gitster.mtv.corp.google.com>
References: <robbat2-20160201T220940-187080200Z@orbis-terrarum.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Git Mailing List <git@vger.kernel.org>
To: "Robin H. Johnson" <robbat2@gentoo.org>
X-From: git-owner@vger.kernel.org Mon Feb 01 23:49:39 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aQNHc-0007Pd-9A
	for gcvg-git-2@plane.gmane.org; Mon, 01 Feb 2016 23:49:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932467AbcBAWtO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Feb 2016 17:49:14 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:50039 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932401AbcBAWtM (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Feb 2016 17:49:12 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 03D2941959;
	Mon,  1 Feb 2016 17:49:12 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=uns1iZ/XhMsr9Q/fKouYOQ+zGjU=; b=H2MOp/
	9YIxbJaB/atQGZGjMFPXqI87gpDMIlFcsS6ZUJG9Olszwr01HT79rEcQG1aupJ4D
	oNtpYWwbGmRZe/o6Ir2LsC7gGoEnfP4zkg41sY0TnHPUq9GGacxjXRGUGxd1gCaZ
	cNRY5NSCGUs/Pqt+vdF7ZPG0FLlOEk/maxQ0A=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ZoQCAJ3KhMMz/mYusUDIMd/+G3wx5xaf
	VqcQQX9OxjGWknPJ6YdJBETf2D6rGN3ORILigN+nN1i/8Jwkea9Z6fCnllmuLOaX
	uwYj9W/GlhdDgMWdM/vFg3EQ7oEt/3B9+c2h66tovgaXKx+jBAxc5CwsfElidB5O
	t0aIpvuakGk=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id EE42941957;
	Mon,  1 Feb 2016 17:49:11 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 5C5F241955;
	Mon,  1 Feb 2016 17:49:11 -0500 (EST)
In-Reply-To: <robbat2-20160201T220940-187080200Z@orbis-terrarum.net> (Robin
	H. Johnson's message of "Mon, 1 Feb 2016 22:22:31 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 029CC44C-C936-11E5-AE69-04C16BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285223>

"Robin H. Johnson" <robbat2@gentoo.org> writes:

> Format string %G? includes state 'N', which is described as "no
> signature".
>
> If you try to verify a commit or push for which you have no key (and you
> don't automatically fetch from the keyservers [1]), then the format
> string ALSO contains 'N', which is incorrect.
>
> It should be possible to differentiate between a commit/push with NO
> signature, and a commit/push signed with an unknown key.
>
> In the case of verifying signed pushes before accepting them, this is
> critical to providing a useful error message to the user. Presently, if
> %G? evaluates to 'N', then none of the GIT_PUSH_CERT* env vars are set.

Hrm, I think GIT_PUSH_CERT* environment variables are exported
whenever push_cert_sha1[] is not "0"{40}, and push_cert_sha1[] is
cleared only when write_sha1_file() fails.  The failure from calling
parse_signature(), verify_signed_buffer() and parse_gpg_output()
does not clear push_cert_sha1[], so I am not sure if we are reading
the same code.

Are you talking about something other than prepare_push_cert_sha1()?

> In the case of the signed push with the unknown key, they should remain
> set.

In any case, I think "should" is relative to the balance between
convenience and safety.  If you set up your receiving end to use a
keyring that holds trusted keys and nothing else, it makes it harder
to make mistakes in the script and accept something you shouldn't if
the validation script is fed "No, this is not good" if a push is
signed by unknown key, so showing "known to be bad" and "unsure if
it is good" the same way with 'N' is what "should" happen from that
point of view.

Of course, a set-up that fetches unknown keys lazily when they are
first encountered would need more work to do the verification
themselves, but as long as GIT_PUSH_CERT itself is exported that
should be possible (iow, we are trying to make simple way less error
prone, while allowing more advanced use possible, if harder).

If the blob object name is not exported depending on the validation
status, that certainly sounds like a bug, as that would make "more
advanced use" above impossible.  But I am not sure how that happens.
