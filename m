From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] cache-tree: invalidate i-t-a paths after writing trees
Date: Fri, 09 Nov 2012 03:57:47 -0800
Message-ID: <7vy5ibouo4.fsf@alter.siamese.dyndns.org>
References: <3E62F933-76CD-4578-8684-21444EAA454F@JonathonMah.com>
 <1352459040-14452-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Jonathon Mah <me@JonathonMah.com>
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Fri Nov 09 12:58:05 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TWnDo-0006UX-Pp
	for gcvg-git-2@plane.gmane.org; Fri, 09 Nov 2012 12:58:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752679Ab2KIL5v convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 9 Nov 2012 06:57:51 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:50076 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752399Ab2KIL5u convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 9 Nov 2012 06:57:50 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7585F8A8A;
	Fri,  9 Nov 2012 06:57:49 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=XEh4RTGQOXfL
	p868HeUZr5HdFrE=; b=WtSg7hMCnN0g24r/1jb3HPErykEFpIwlUxdBBzF4/8zr
	lYhopKbPQly5aw2dhJ8nuTx5MC7iuWahK8YM809oYrEI0wMOeDHyImpap46D2AK0
	txYkKfqqLyXLd4HG8tkNaeOPWKnBcL3Eq2yqhiUYLMZAK5bmaoQBX/w1FF4A2eM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=D2K5c9
	0A+g9L4yKt+kiNX/JfNqgxrGcNADOnTQUW6kbJ9eqMNm6ZuDUc75QjVGgRfDjWe2
	Bgf1AXZbThkJmqwQm85npwiUuaUAVacVWZrnte4Svqy3HVDjggwEGG3ksuVzJQVS
	u3NG8lnn58mSGD1e0p1hw/UCFZvY1FuxZfN6U=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 630528A89;
	Fri,  9 Nov 2012 06:57:49 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C6B368A88; Fri,  9 Nov 2012
 06:57:48 -0500 (EST)
In-Reply-To: <1352459040-14452-1-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Fri, 9 Nov
 2012 18:04:00 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: AE8EC0E4-2A64-11E2-9D54-54832E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209214>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> diff --git a/cache-tree.c b/cache-tree.c
> index 28ed657..30a8018 100644
> --- a/cache-tree.c
> +++ b/cache-tree.c
> @@ -381,6 +381,9 @@ int cache_tree_update(struct cache_tree *it,
>  	i =3D update_one(it, cache, entries, "", 0, flags);
>  	if (i < 0)
>  		return i;
> +	for (i =3D 0; i < entries; i++)
> +		if (cache[i]->ce_flags & CE_INTENT_TO_ADD)
> +			cache_tree_invalidate_path(it, cache[i]->name);
>  	return 0;
>  }

I notice there is another special case for CE_REMOVE but there is
nothing that adjusts the cache-tree for these entries in the current
codebase.

I suspect the original code before we (perhaps incorrectly) updated
the code not to error out upon I-T-A entries was fine only because
we do not attempt to fully populate the cache-tree during a merge in
the unpack-trees codepath, which will mark the index entries that
are to be removed with CE_REMOVE in the resulting index.

The solution implemented with this patch will break if we start
updating the cache tree after a successful merge in unpack-trees, I
suspect.

An alternative might be to add a "phoney" bit next to "used" in the
cache_tree structure, mark the cache tree as phoney when we skip an
entry marked as CE_REMOVE or CE_ITA, and make the postprocessing
loop this patch adds aware of that bit, instead of iterating over
the index entries; instead, it would recurse the resulting cache
tree and invalidate parts of the tree that have subtrees with the
"phoney" bit set, or something.
