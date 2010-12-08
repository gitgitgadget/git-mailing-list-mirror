From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 4/4] describe: Delay looking up commits until
 searching for an inexact match
Date: Wed, 08 Dec 2010 14:50:37 -0800
Message-ID: <7v7hfjkhfm.fsf@alter.siamese.dyndns.org>
References: <alpine.DEB.2.02.1011171830050.14285@dr-wily.mit.edu>
 <20101203084348.GD18202@burratino>
 <alpine.DEB.2.02.1012060149550.23348@dr-wily.mit.edu>
 <20101206073214.GA3745@burratino>
 <alpine.DEB.2.02.1012061159500.23348@dr-wily.mit.edu>
 <7vfwu9qvew.fsf@alter.siamese.dyndns.org>
 <alpine.DEB.2.02.1012072204371.23348@dr-wily.mit.edu>
 <alpine.DEB.2.02.1012072341570.23348@dr-wily.mit.edu>
 <alpine.DEB.2.02.1012072344000.23348@dr-wily.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder@ira.uka.de>,
	Kirill Smelkov <kirr@mns.spb.ru>,
	Thomas Rast <trast@student.ethz.ch>
To: Anders Kaseorg <andersk@ksplice.com>
X-From: git-owner@vger.kernel.org Wed Dec 08 23:51:01 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PQSqi-0002Uq-VW
	for gcvg-git-2@lo.gmane.org; Wed, 08 Dec 2010 23:51:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756369Ab0LHWu4 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 8 Dec 2010 17:50:56 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:52468 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756251Ab0LHWuz convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 8 Dec 2010 17:50:55 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id A96FB2326;
	Wed,  8 Dec 2010 17:51:17 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type
	:content-transfer-encoding; s=sasl; bh=vnWIELhjhAvkqMJuNBt/gICjK
	7o=; b=FpA9o5x/YH0K1lTRwyWZRk+9ugZceVc15khY8o+UZSdtaNC+z0Y9/eRwd
	HnnMBq6mwVNQSKSPIdfSYLP88KMk3SP9xJaCchqLWfHkJDRchCLQNDUN3nJuv5Jq
	PAKEtRWETW5/o2katvOjCtuyLuMDl/pt+Nw0g+VzhyvwW/N7Rs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type
	:content-transfer-encoding; q=dns; s=sasl; b=WqfieBF407OMsM0U+uH
	RUXgsBteZqRSMy4wnwXSp4vJODfibFyPZy4Oxo6X+MVzZ5SB3JM3UGvn/LtMhdmM
	eAXyzCNf/SyEnSlLacCoCD7FYkjfBVmjOq67ZZtOSq9Ur50wFP7D/5bi1tf4chfj
	84Hak0uBSbxm65QwlsPHKqGg=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 49E12231E;
	Wed,  8 Dec 2010 17:51:11 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 3F9F92315; Wed,  8 Dec 2010
 17:51:02 -0500 (EST)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: A70BF528-031D-11E0-AC9F-C4BE9B774584-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163229>

Anders Kaseorg <andersk@ksplice.com> writes:

> Now that struct commit.util is not used until after we=E2=80=99ve che=
cked that
> the argument doesn=E2=80=99t exactly match a tag, we can wait until t=
hen to
> look up the commits for each tag.
>
> This avoids a lot of I/O on --exact-match queries in repositories wit=
h
> many tags.  For example, =E2=80=98git describe --exact-match HEAD=E2=80=
=99 becomes
> about 12 times faster on a cold cache (3.2s instead of 39s) in a
> linux-2.6 repository with 2000 packed tags.  That=E2=80=99s a huge wi=
n for the
> interactivity of the __git_ps1 shell prompt helper when on a detached
> HEAD.

You seem to have gone in a slightly different direction with this rerol=
l.
I am not sure if use of hash_table in this code would actually improve
anything (aside from the general readability and "reusing code from a g=
ood
infrastructure is a good thing" principle), though, no matter how many
tags you have in your repository.  In the code from the earlier round,
lookup_commit_reference_gently call in the fallback codepath to populat=
e
commit->util used the *obj_hash[] to quickly look up the commits with t=
he
same object name already.

> @@ -60,6 +61,15 @@ static inline struct commit_name *find_commit_name=
(const unsigned char *peeled)
>  	return n;
>  }
> =20
> +static int set_util(void *vn)
> +{
> +	struct commit_name *n =3D vn;
> +	struct commit *c =3D lookup_commit_reference_gently(n->peeled, 1);
> +	if (c)
> +		c->util =3D n;
> +	return 0;
> +}

I don't know how the above would work in the face of hash collisions.

This is a callback for for_each_hash(), which visits each populated ent=
ry
in the underlying hash table.  The semantics of the hash table hash.c
gives you is "here is a flat hash table.  We insert only to an empty
field, and otherwise we will tell you where your new element would have
hashed into, so that you can implement linear overflow or chained bucke=
ts
yourself on top of this", and you chose to implement bucket chaining in
add_to_known_names(), so don't you need to walk the chain here for comm=
its
that share the same first four bytes in their object names?
