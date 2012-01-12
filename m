From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] tree_entry_interesting: make recursive mode default
Date: Wed, 11 Jan 2012 21:04:59 -0800
Message-ID: <7v1ur54ikk.fsf@alter.siamese.dyndns.org>
References: <20120111063104.GA3153@burratino>
 <1326341371-16628-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>,
	Linus Torvalds <torvalds@linux-foundation.org>
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jan 12 06:05:40 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RlCr5-0004CS-Gh
	for gcvg-git-2@lo.gmane.org; Thu, 12 Jan 2012 06:05:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750927Ab2ALFFG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 12 Jan 2012 00:05:06 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:44572 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750718Ab2ALFFF convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 12 Jan 2012 00:05:05 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7DB9A677C;
	Thu, 12 Jan 2012 00:05:03 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=R2VWcnuuUFsV
	uMssY5d7qdG+V0w=; b=KVZT4uzGEYwGZt6B4uBtBQQWZzMm5ZHkk3Zdty2GGRXF
	bZU1nivn0BOgXsjEkAZtA7bPwR0Huu5fOsT3v7PtqkFIPjHaM6KONe5ya3jZnJvs
	Lgmhc+2Z1/2mV3irWNiXJm5j7S/z3mPo12NJcCRbJN35pDyOYsmdoH6j80lRo1o=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=xqmWRP
	DLOcu28rA4I8SZb7O8Fi+nvfgoqsoXFNtHMO4i/PbxHvrEkN80f/bIuBdQQa6IEO
	K9lsdWJrHX3mZNF1gMdU+d34eK4qIw/1n1w1/cXus9FVStKKubppG2b4V1CVrFB2
	q4AhhnNd7SSm3dlozRwN3rJdXJH8YtsrElOdQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7460B677A;
	Thu, 12 Jan 2012 00:05:03 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 5A5A36779; Thu, 12 Jan 2012
 00:05:01 -0500 (EST)
In-Reply-To: <1326341371-16628-1-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Thu, 12 Jan
 2012 11:09:31 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: FB42B620-3CDA-11E1-A76E-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188429>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> There is a bit of history behind this. Some time ago, t_e_i() only
> supported prefix matching. diff-tree supported recursive and
> non-recursive mode but it did not make any difference to prefix
> matching.
>
> Later on, t_e_i() gained limited recursion support to unify a similar
> matching code used by git-grep. It introduced two new fields in struc=
t
> pathspec: max_depth and recursive. "recursive" field functions as a
> feature switch so that this feature is off by default.
>
> Some time after that, t_e_i() further gained wildcard support. With
> wildcard matching, recursive and non-recursive diff-tree
> mattered. "recursive" field was reused to distinguish recursion in
> diff-tree.
>
> This choice has a side effect that by default wildcard matching is in
> non-recursive mode, which is not true. All current call sites except
> "diff-tree without -r" (grep, traverse_commit_list, tree-walk and
> general tree diff) prefer recursive mode.
>
> This patch decouples the use of recursive field. The max_depth featur=
e
> switch is now controlled by max_depth_valid field. diff-tree recursio=
n
> is controlled by nonrecursive_diff_tree, which makes it recursive by
> default.

Thanks, but I am curious about two (and a half) things.

 - The "max_depth" option has perfectly good and natural "invalid"
   sentinel values (i.e. 0 or negative). Why do we need a separate
   bitfield?

 - Special casing the non-recursive mode of diff-tree is perfectly
   acceptable, but nonrecursive_diff_tree does not sound like a very go=
od
   name for it for two reasons. Perhaps there may be other users that w=
ant
   the "surface only" behaviour, so having "diff_tree" in the name limi=
ts
   its future (re)use. Also an option that is named negatively inevitab=
ly
   invites "if (!opt->non_whatever)" double negative. Can we come up wi=
th
   a better name, perhaps "onelevel_only" or something?

 - Shouldn't "onelevel_only" be the same as limiting to a single depth
   with "max_depth"?
