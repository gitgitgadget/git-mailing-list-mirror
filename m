From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/5] Prevent diff machinery from examining worktree
 outside sparse checkout
Date: Fri, 31 Jul 2009 09:34:00 -0700
Message-ID: <7vprbgstfr.fsf@alter.siamese.dyndns.org>
References: <1248850154-5469-1-git-send-email-pclouds@gmail.com>
 <1248850154-5469-2-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jul 31 18:34:18 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MWv3g-00052d-In
	for gcvg-git-2@gmane.org; Fri, 31 Jul 2009 18:34:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752276AbZGaQeJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 31 Jul 2009 12:34:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752088AbZGaQeI
	(ORCPT <rfc822;git-outgoing>); Fri, 31 Jul 2009 12:34:08 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:51611 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752063AbZGaQeH (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 31 Jul 2009 12:34:07 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 9421118E8A;
	Fri, 31 Jul 2009 12:34:05 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 28C9518E88; Fri, 31 Jul 2009
 12:34:01 -0400 (EDT)
In-Reply-To: <1248850154-5469-2-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuIFRow6FpIE5n4buNYw==?= Duy"'s message of "Wed\, 29 Jul
 2009 16\:49\:10 +1000")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: F69B674A-7DEF-11DE-80A0-AEF1826986A2-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124580>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> ---

Sign off?  Oh, this is an RFC... Ok...

> diff --git a/diff-lib.c b/diff-lib.c
> index b7813af..4094f18 100644
> --- a/diff-lib.c
> +++ b/diff-lib.c
> @@ -337,6 +337,8 @@ static void do_oneway_diff(struct unpack_trees_op=
tions *o,
>  	struct rev_info *revs =3D o->unpack_data;
>  	int match_missing, cached;
> =20
> +	/* if the entry is not checked out, don't examine work tree */
> +	cached =3D o->index_only || (idx && idx->ce_flags & CE_VALID);
>  	/*
>  	 * Backward compatibility wart - "diff-index -m" does
>  	 * not mean "do not ignore merges", but "match_missing".
> @@ -344,7 +346,6 @@ static void do_oneway_diff(struct unpack_trees_op=
tions *o,
>  	 * But with the revision flag parsing, that's found in
>  	 * "!revs->ignore_merges".
>  	 */
> -	cached =3D o->index_only;
>  	match_missing =3D !revs->ignore_merges;
> =20
>  	if (cached && idx && ce_stage(idx)) {

The big comment is about match_missing and not about cached, so the cod=
e
movement is good.  When we pass NULL idx to this function, it means tha=
t
the tree has it but the index doesn't, so it cannot possibly be marked =
as
"exists in the index but is not checked out".  So the hunk makes sense.

> diff --git a/diff.c b/diff.c
> index 91d6ea2..de1bd87 100644
> --- a/diff.c
> +++ b/diff.c
> @@ -1810,8 +1810,10 @@ static int reuse_worktree_file(const char *nam=
e, const unsigned char *sha1, int
> =20
>  	/*
>  	 * If ce matches the file in the work tree, we can reuse it.
> +	 * For sparse checkout case, ce_uptodate() may be true although
> +	 * the file may or may not exist in the work tree.
>  	 */
> -	if (ce_uptodate(ce) ||
> +	if ((ce_uptodate(ce) && !(ce->ce_flags & CE_VALID)) ||
>  	    (!lstat(name, &st) && !ce_match_stat(ce, &st, 0)))
>  		return 1;

Why is this hunk necessary?  A few lines above this we return 0 for any
CE_VALID cache entry.
