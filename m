From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/WIP 05/11] symbolize return values of
 tree_entry_interesting()
Date: Thu, 27 Oct 2011 11:36:48 -0700
Message-ID: <7vbot2z3gf.fsf@alter.siamese.dyndns.org>
References: <1319438176-7304-1-git-send-email-pclouds@gmail.com>
 <1319438176-7304-6-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu Oct 27 20:36:56 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RJUox-0003c7-UO
	for gcvg-git-2@lo.gmane.org; Thu, 27 Oct 2011 20:36:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754614Ab1J0Sgv convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 27 Oct 2011 14:36:51 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:45660 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754221Ab1J0Sgu convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 27 Oct 2011 14:36:50 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4CF0A5F89;
	Thu, 27 Oct 2011 14:36:50 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=uDuz+gdptvf5
	PfsbLsHLupuNr14=; b=ADdtO8IICePjSm9rvzC0nwDciXpH0a6GbBLulajfafuQ
	NuUjob7HgyEoMABwzbohdJZA6CWnkcHnIBwzTeSKq3RJs9489OBXr+6EC+Jy8xBj
	mivTbfaLzHYDCPwK8jVGFh72ErK+QJ0AI1GikXpRFVhOplRfdodmV6yCQiPaIlY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=m3ouMQ
	ukHsLJmCdq46G7E52zAX8yW+hEkrohNzz0tLcj3ts5IG2UgtkZzww02pB04QdhF0
	rTNo84aVyGsC/IL1URvZinhswV2HfBev0equtykiIQ61re4pjhsJ87WTt1L4tMvZ
	ns+VFO6shqkhr2ShicCHr0Q16hGcT79znOl7o=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 438605F88;
	Thu, 27 Oct 2011 14:36:50 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id BBF745F87; Thu, 27 Oct 2011
 14:36:49 -0400 (EDT)
In-Reply-To: <1319438176-7304-6-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Mon, 24 Oct
 2011 17:36:10 +1100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: A1EBBCA8-00CA-11E1-84B4-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184314>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> This helps extending the value later on for "interesting, but cannot
> decide if the entry truely matches yet" (ie. prefix matches)
>
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>

Good change; it is a basic code hygiene to avoid magic constants anyway=
=2E

> diff --git a/tree-diff.c b/tree-diff.c
> index 6782484..25cc981 100644
> --- a/tree-diff.c
> +++ b/tree-diff.c
> @@ -114,12 +114,13 @@ static void show_entry(struct diff_options *opt=
, const char *prefix,
>  }
> =20
>  static void skip_uninteresting(struct tree_desc *t, struct strbuf *b=
ase,
> -			       struct diff_options *opt, int *match)
> +			       struct diff_options *opt,
> +			       enum interesting *match)
>  {
>  	while (t->size) {
>  		*match =3D tree_entry_interesting(&t->entry, base, 0, &opt->pathsp=
ec);
>  		if (*match) {
> -			if (*match < 0)
> +			if (*match =3D=3D all_entries_not_interesting)
>  				t->size =3D 0;
>  			break;
>  		}

The caller of this function needs to be updated as well.

But I have to wonder why this skip_uninteresting() does not peek the
original value of *match and skip, which is the loop structure the othe=
r
caller of tree_entry_interesting() in this file has.

diff --git a/tree-diff.c b/tree-diff.c
index 25cc981..de4ba28 100644
--- a/tree-diff.c
+++ b/tree-diff.c
@@ -133,7 +133,7 @@ int diff_tree(struct tree_desc *t1, struct tree_des=
c *t2,
 {
 	struct strbuf base;
 	int baselen =3D strlen(base_str);
-	int t1_match =3D 0, t2_match =3D 0;
+	enum interesting t1_match, t2_match;
=20
 	/* Enable recursion indefinitely */
 	opt->pathspec.recursive =3D DIFF_OPT_TST(opt, RECURSIVE);
@@ -142,6 +142,9 @@ int diff_tree(struct tree_desc *t1, struct tree_des=
c *t2,
 	strbuf_init(&base, PATH_MAX);
 	strbuf_add(&base, base_str, baselen);
=20
+	/* Initialize to something other than all_entries_not_interesting */
+	t1_match =3D t2_match =3D entry_not_interesting;
+
 	for (;;) {
 		if (diff_can_quit_early(opt))
 			break;
