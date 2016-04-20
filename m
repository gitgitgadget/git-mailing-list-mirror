From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 03/12] worktree.c: make find_shared_symref() return struct worktree *
Date: Wed, 20 Apr 2016 10:05:06 -0700
Message-ID: <xmqqlh48w6rh.fsf@gitster.mtv.corp.google.com>
References: <1460897965-486-1-git-send-email-pclouds@gmail.com>
	<1461158693-21289-1-git-send-email-pclouds@gmail.com>
	<1461158693-21289-4-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, rethab.ch@gmail.com, rappazzo@gmail.com
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 20 19:05:17 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1asvYy-0008CD-RQ
	for gcvg-git-2@plane.gmane.org; Wed, 20 Apr 2016 19:05:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751525AbcDTRFK convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 20 Apr 2016 13:05:10 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:50592 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751029AbcDTRFJ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 20 Apr 2016 13:05:09 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 0EA4912E71;
	Wed, 20 Apr 2016 13:05:08 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=V9MyCzJay2Ff
	w/byTadHvH5TTDo=; b=SZjHSaWkppCDzII7GjBvhOciB/sEyEuCJcujQ/sGkLyp
	2veS7Ad2wbc4Hqy1/+zVprugnxuWPu8IRz9aRYw4fO0vGBymqD/7NOZrOWqxziY4
	veBz8TkXSZnc3+YLTHjY6rJat9Z11DHAYK0PnUef83YiTAOgVYH4u+vN1lCqTPQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=BeByG6
	o69Gld8LCIlxBruEx7S7o0dAtVvZ548+Uu9J9I39VnnI8iiyo6lldHjBrAOW0AAj
	OJzapwMuDAYOvygY3RJkow+j+Ih50hiPM7V7mtOYUu/lT6MSihJO9T6/DTMPLRPL
	338i0JwnfpFc+XANOAbbmFL+Gcv2qVUZKrEOw=
Received: from pb-smtp1. (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 0389E12E70;
	Wed, 20 Apr 2016 13:05:08 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 39E8B12E6F;
	Wed, 20 Apr 2016 13:05:07 -0400 (EDT)
In-Reply-To: <1461158693-21289-4-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Wed, 20
 Apr 2016 20:24:44 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 0860FA70-071A-11E6-9806-9A9645017442-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292045>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> This gives the caller more information and they can answer things lik=
e,
> "is it the main worktree" or "is it the current worktree". The latter
> question is needed for the "checkout a rebase branch" case later.

That makes good sense.

> diff --git a/worktree.h b/worktree.h
> index 3198c8d..d71d7ec 100644
> --- a/worktree.h
> +++ b/worktree.h
> @@ -36,9 +36,10 @@ extern void free_worktrees(struct worktree **);
>  /*
>   * Check if a per-worktree symref points to a ref in the main worktr=
ee
>   * or any linked worktree, and return the path to the exising worktr=
ee
> - * if it is.  Returns NULL if there is no existing ref.  The caller =
is
> - * responsible for freeing the returned path.
> + * if it is. Returns NULL if there is no existing ref. The result
> + * may be destroyed by the next call.
>   */

To return and keep alive one worktree[] instance (i.e. "existing"),
the code holds onto the entire return value from get_worktrees(), if
I am not misreading it.  Typically you would have only a handful of
worktrees so this may not be an issue, though.
