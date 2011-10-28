From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH] define the way new representation types are encoded
 in the pack
Date: Thu, 27 Oct 2011 23:12:29 -0700
Message-ID: <7vwrbptzjm.fsf@alter.siamese.dyndns.org>
References: <7v62j9veh3.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Nicolas Pitre <nico@fluxnic.net>,
	"Shawn O. Pearce" <spearce@spearce.org>, Jeff King <peff@peff.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 28 08:12:39 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RJfgC-0001ub-Qw
	for gcvg-git-2@lo.gmane.org; Fri, 28 Oct 2011 08:12:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755208Ab1J1GMc convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 28 Oct 2011 02:12:32 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:57242 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754918Ab1J1GMc convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 28 Oct 2011 02:12:32 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 94C5F30BC;
	Fri, 28 Oct 2011 02:12:31 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=LyJ/9qBFEjJb
	sHkauEgpy5Mkfos=; b=UN2JUa4Yfu6Ovg537QrXUxC5htxnN27HfwuE60bH1KZR
	re9TWgnOj7l7N3hVgFPdavkNEf53yRVKDZj7OP0ByEtEMRosiaYygr7YMNQBhltI
	ZkB3utL6+ZLh7/itjPRJC0biwOXEBCYWzi5xuKSb5NbIiJyd5ASNcgeMQpTXm0c=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=AU8YYv
	OakO10IP3p+YLCXMOHj2pWhIv5uEt68a+VfezNMuIMM+I7WK1g8MK960ave/yr9m
	WwYjtsJ9iWPGXR4PatxseJamgDnDP95DFkEwxK4WGQVFZ53q0l+qNpGOOhDH+KSu
	owHruQumbGX35mdXm7+FwWSM9V51Quy7XLTg4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8CB0230BB;
	Fri, 28 Oct 2011 02:12:31 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B37A330B8; Fri, 28 Oct 2011
 02:12:30 -0400 (EDT)
In-Reply-To: <7v62j9veh3.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Thu, 27 Oct 2011 23:04:40 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: D179BD9C-012B-11E1-84F0-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184341>

Junio C Hamano <gitster@pobox.com> writes:

> I haven't started using type=3D8 and upwards for anything yet, but be=
cause
> we have only one "future expansion" value left, I want us to be extre=
mely
> careful in order to avoid painting us into a corner that we cannot ge=
t out
> of, so I am sending this out early for a preliminary review.
>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>  cache.h     |    3 ++-
>  sha1_file.c |   36 ++++++++++++++++++++++++++++++++----
>  2 files changed, 34 insertions(+), 5 deletions(-)
>
> diff --git a/cache.h b/cache.h
> index 2e6ad36..b02139b 100644
> --- a/cache.h
> +++ b/cache.h
> @@ -380,9 +380,10 @@ enum object_type {
>  	OBJ_TREE =3D 2,
>  	OBJ_BLOB =3D 3,
>  	OBJ_TAG =3D 4,
> -	/* 5 for future expansion */
> +	OBJ_EXT =3D 5, /* 5 for future expansion */
>  	OBJ_OFS_DELTA =3D 6,
>  	OBJ_REF_DELTA =3D 7,
> +	OBJ_CAT_TREE =3D 8,
>  	OBJ_ANY,
>  	OBJ_MAX
>  };

As people may be able to guess from the name, CAT_TREE is envisioned to
encode a large data (primarily of type "blob") by recording the object
name of a tree object and probably the total length, and would represen=
t
the concatenation of all blobs contained in the tree object when the tr=
ee
is traversed in some fixed order (e.g. Avery's "bup split"). I am guess=
ing
that the payload for CAT_TREE representation type will be:

 - 20-byte object name for the top-level tree object;

 - type of the basic object (commit, tree, blob, or tag) it represents,
   even though it is unlikely that we would want to record such a large
   commit or tag that needs CAT_TREE representation;

 - the total length of the basic object it represents, even though it i=
s
   redundant (you could traverse and sum the sizes of blobs contained i=
n
   the tree object), it would help sha1_object_info() and friends. This
   will be the "some size" I mentioned in the previous message for this
   representation type.

We would probably add loose object representation for CAT_TREE, which m=
ay
look like:

    "cattree" <size of this cat-tree in decimal> NUL
    <basic object type> <size of the basic object> NUL
    <object name of the top-level tree>

and would need to teach unpack_sha1_file() about it. One caveat is that
we would want to keep the "contents name the object" invariant, so even=
 if
a large blob is expressed as a CAT_TREE, its object name must still be
what we would get by hashing '"blob" <size> NUL <payload>'.

A loose object file in "cattree" representation will not hash to the va=
lue
a na=C3=AFve implementation would expect, and fsck_sha1() needs to be a=
ware of
it. I haven't thought things through in this area.

=46urther work would involve (no way exhaustive, of course):

 - Teach fsck and connectivity tools that objects that are reachable fr=
om
   any object (even a blob) that is represented as a CAT_TREE are neede=
d
   and reachable by that object;

 - Teach pack-objects that anything that is represented as a CAT_TREE d=
oes
   not need to be deltified (the objects used as its representation wou=
ld
   go through the usual deltification rules);

 - Teach unpack-objects to expand CAT_TREE representation into a "cattr=
ee"
   loose object.

 - Perhaps teach the attributes mechanism to lie to anybody who asks th=
at
   any object in CAT_TREE representation is a binary file to trigger th=
e
   "we do not unnecessarily look at binary" logic in "git diff" machine=
ry.

 - Teach fast-import to write out CAT_TREE representation. This is
   probably the quickest and least-impact way to exploit existing suppo=
rt
   for large files in index_fd().

 - Update grep.c::grep_buffer() to take not <buf,size> but git_istream,
   and rewrite builtin/grep.c::grep_sha1() to use streaming interface.
=20
