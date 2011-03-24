From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] Reimplement read_tree_recursive() using
 tree_entry_interesting()
Date: Thu, 24 Mar 2011 12:55:48 -0700
Message-ID: <7vlj048f97.fsf@alter.siamese.dyndns.org>
References: <AANLkTinYB=ZUTe29Y9ibLVL5z3KhiYmnCpCGcHx=18RJ@mail.gmail.com>
 <1300977675-6243-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Michael J Gruber <git@drmicha.warpmail.net>
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 24 20:56:11 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q2qdd-0002NG-NO
	for gcvg-git-2@lo.gmane.org; Thu, 24 Mar 2011 20:56:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934003Ab1CXT4C convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 24 Mar 2011 15:56:02 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:62927 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933832Ab1CXT4A convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 24 Mar 2011 15:56:00 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 18AA441F6;
	Thu, 24 Mar 2011 15:57:41 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=cIBN0VjzflR2
	Fk7CK/sVfvSu+R4=; b=bXPbdUc06IKMDDPaMSvK2aIzf1ZSd46ZORmL58gR+X4y
	N5K8VBEtO4oRsc2hff0QlemUpOIYDx1tupI+199Z0uiEMqRo7Bwu4sypio4dlsw3
	NZ2o5CTsJXPlJMvFfe2hTAlWDU3TfM+6fXusjDjGu9QGM5DGEol1bxV4uCOF0VA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=roaPmG
	zlB9DXmZX/k8dBh7KvnkMNLJvbfi0fe7Yu5+ePRWln/7wueipMZWMqwlvg9VawSq
	u6jL3jkZl9fYU++/kQDiZHR49B0esf72CrA09GnLIr8QFdXe14adPZIhT0gqFQ52
	zDOF7/Rhjp7O8MEtAhakpmhl+qe62g+yhbZcY=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id DB11B41F5;
	Thu, 24 Mar 2011 15:57:36 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 977D741F4; Thu, 24 Mar 2011
 15:57:32 -0400 (EDT)
In-Reply-To: <1300977675-6243-1-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Thu, 24 Mar
 2011 21:41:14 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: F754DA32-5650-11E0-9792-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169939>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> +static int read_tree_1(struct tree *tree, struct strbuf *base,
> +		       int stage, struct pathspec *pathspecs,
> +		       read_tree_fn_t fn, void *context)

Micronit: call the variable pathspec, not pathspecs.

An instance of the structure contains a specification to limit the set =
of
paths to operate on as a set of pathspec elements, and this single set =
is
collectively called a "struct pathspec"; you are not passing an array t=
hat
has one or more pathspecs in it here (i.e. pathspecs[2] in this functio=
n
does not make sense).

It looks like the result is easier to follow, perhaps mostly thanks to =
the
(re)use of strbuf instead of allocating a new path when going deeper.

> @@ -108,10 +60,22 @@ int read_tree_recursive(struct tree *tree,
>  	init_tree_desc(&desc, tree->buffer, tree->size);
> =20
>  	while (tree_entry(&desc, &entry)) {
> -		if (!match_tree_entry(base, baselen, entry.path, entry.mode, match=
))
> +		if (all_interesting)
> +			retval =3D all_interesting > 0;
> +		else {
> +			retval =3D tree_entry_interesting(&entry, base, 0, pathspecs);
> +			if (retval =3D=3D 2)
> +				all_interesting =3D 1;
> +			else if (retval =3D=3D -1) {
> +				all_interesting =3D -1;
> +				retval =3D 0;
> +			}
> +		}
> +		if (!retval)
>  			continue;

This "if all-interesting then avoid calling into an expensive matcher"
logic looks familiar but is not something that came from the parts dele=
ted
by this patch.  Where did I see it? Is that something we can share in a
common helper function? Is such a sharing worth pursuing, considering t=
hat
the above is a reasonably trivial logic in a tight loop?

"That's how the return value of tree-entry-interesting is designed to b=
e
used, and it is unsurprising that all the callers will fall into that
pattern" is a perfectly acceptable answer, I guess.

Thanks.
