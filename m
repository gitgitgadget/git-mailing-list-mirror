From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] fetch: better alignment in ref summary
Date: Sun, 22 May 2016 17:58:12 -0700
Message-ID: <xmqqfut9bnff.fsf@gitster.mtv.corp.google.com>
References: <20160522112019.26516-1-pclouds@gmail.com>
	<20160522112019.26516-2-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 23 02:58:24 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b4eCK-000682-H3
	for gcvg-git-2@plane.gmane.org; Mon, 23 May 2016 02:58:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752720AbcEWA6Q convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 22 May 2016 20:58:16 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:53428 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752706AbcEWA6Q convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 22 May 2016 20:58:16 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 96E3C1CD3E;
	Sun, 22 May 2016 20:58:14 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=bIDfTWwtxs/T
	gII3gdLYvP3+JgU=; b=r6UiUX84ncmk+VrfLwmufTnR4Tre8odWxfmlNG9mME0t
	siM72/JNaG7vnN0WBMs+CqIFYyzgvGoUtvoeYlo6R2TAITjBhZGS5kstyZoOTNvM
	M4AA13UnSh6hkN5VRUCaVWCbJwfkZnzACLf4IYlCRqpOBAfI133QXX6M6Bz9wto=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=KHilbe
	LG7PdbJ9/nQGt9Ghz5HCl9/zZKZ2fOwE2gqttpDoxsYnlV/zJHwUqurViOcG9EEX
	/3JplDwBxMXxrRi0NCGJ4KfvLJGpA5OmWBEel95SKrR6WrsnnRcj45gHYsPRIgNL
	fudhMEEOcvhXfD6tHNaZb8DZI+qR6J6Lcj85A=
Received: from pb-smtp1. (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 8F1821CD3D;
	Sun, 22 May 2016 20:58:14 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 131E31CD3B;
	Sun, 22 May 2016 20:58:14 -0400 (EDT)
In-Reply-To: <20160522112019.26516-2-pclouds@gmail.com> (=?utf-8?B?Ik5n?=
 =?utf-8?B?dXnhu4VuIFRow6FpIE5n4buNYw==?=
	Duy"'s message of "Sun, 22 May 2016 18:20:18 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 6D78C908-2081-11E6-80C6-9A9645017442-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295295>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> Currently fetch hard-codes the "remote" column to be 10. For repos
> with long branch names, the output could look ugly like this
>
> From github.com:pclouds/git
>  * [new branch]      2nd-index  -> pclouds/2nd-index
>  * [new branch]      3nd-index  -> pclouds/3nd-index
>  * [new branch]      file-watcher -> pclouds/file-watcher
>  ...

So, we have to show "an object taken from their name is copied to
our name", and somebody designed the format to report it to use
"their-name -> our-name", and decided that a certain number of
columns is sufficient for "their-name" part and that attempting to
align "->" sign is a good idea..

That was long before a few best practices were established.  We
encourage people to use longer and more descriptive branch names, so
"their-name" is a lot longer than 10 columns, which contradicts the
first one of two old assumptions.  And we want to keep the second
old assumption alive.

Progressively pushing "->" to the right like you did might be a
cheap way to do so, but shouldn't we be also taking advantage of
another best practice that has been established since we started
reporting this "their-name came to our-name", namely, very often,
our-name is a short and fixed prefix plus their-name?

That is, I wonder if the above can become something like:

> From github.com:pclouds/git
>  * [new branch]      { -> pclouds/}2nd-index
>  * [new branch]      { -> pclouds/}3nd-index
>  * [new branch]      { -> pclouds/}file-watcher
>  ...

The above example borrows the idea used in diffstat label for
renaming patch and I think you can design a better notataion, but a
big point is that you can shorten the whole thing by not repeating
the common part twice.  The arrow aligns merely as a side effect of
the shortening, taking advantage of the fact that most people fetch
with "$their_prefix/*:$our_prefix/*" renaming refspec.
