Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91C2D1B26E
	for <git@vger.kernel.org>; Fri, 20 Oct 2023 16:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="iGnvhrgU"
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B8C818F
	for <git@vger.kernel.org>; Fri, 20 Oct 2023 09:41:09 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id D052131854;
	Fri, 20 Oct 2023 12:41:08 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=nrwaL6CvbW7w40Bt8aq62B72c2RXU5lwkbl7zZ
	k4WXI=; b=iGnvhrgUnqyH2RLBIXEEBJpohVVc9Sy9tJyN+gq806eu+waFh+haeh
	tyDv40sB5/xrsS9WJR9Mb1QdENWk6kB5syzKejoF/os8pwMT+XYIgDHiePPchlhv
	1D2lXn/z9H/SH6WZaLjqL+TTFXF8gmSGE72WmSaVzzUuS9I3Aqzvs=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id C921431853;
	Fri, 20 Oct 2023 12:41:08 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.153.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 540BE31852;
	Fri, 20 Oct 2023 12:41:05 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org,  ps@pks.im
Subject: Re: [PATCH v3 3/3] rev-list: add commit object support in
 `--missing` option
In-Reply-To: <xmqqttqmtcc2.fsf@gitster.g> (Junio C. Hamano's message of "Thu,
	19 Oct 2023 16:35:41 -0700")
References: <20231016103830.56486-1-karthik.188@gmail.com>
	<20231019121024.194317-1-karthik.188@gmail.com>
	<20231019121024.194317-4-karthik.188@gmail.com>
	<xmqq4jimuv26.fsf@gitster.g> <xmqqttqmtcc2.fsf@gitster.g>
Date: Fri, 20 Oct 2023 09:41:03 -0700
Message-ID: <xmqq1qdptffk.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 766342D6-6F67-11EE-B5BC-F515D2CDFF5E-77302942!pb-smtp20.pobox.com

Junio C Hamano <gitster@pobox.com> writes:

> Rather, I was wondering if we need to use object flags to mark these
> objects, or can do what we want to do without using any object flags
> at all.  For the purpose of reporting "missing" objects, wouldn't it
> be sufficient to walk the object graph and report our findings as we
> go?  To avoid reporting the same object twice, as we reasonably can
> expect that the missing objects are minority (compared to the total
> number of objects), perhaps the codepath that makes such a report
> can use a hashmap of object_ids or something, for example.

Digging from the bottom,

 * builtin/rev-list.c:show_commit() gets "struct rev_list_info *"
   that has "struct rev_info *" [*].

 * list-objects.c:do_traverse() calls revision.c:get_revision() to
   obtain commits, some of which may be missing ones, and things
   behind get_revision() are responsible for marking the commit as
   missing.  It has "struct traversal_context *", among whose
   members is the "revs" member that is the "struct rev_info *".

 * revision.c:get_revision() and machinery behind it ultimately
   discovers a missing commit in the revision.c:process_parents()
   that loops over the parents commit_list.  It of course has access
   to "struct rev_info *".

So, presumably, if we add a new member to "struct rev_info" that
optionally [*] points at an oidset that records the object names of
missing objects we discovered so far (i.e., the set of missing
objects), the location we set the MISSING bit of a commit can
instead add the object name of the commit to the set.  And we can
export a function that takes "struct rev_info *" and "struct object
*" (or "struct object_id *") to check for membership in the "set of
missing objects", which would be used where we checked the MISSING
bit of a commit.

I do not know the performance implications of going this route, but
if we do not find a suitable vacant bit, we do not have to use any
object flags bit to do this, if we go this route, I would think.  I
may be missing some details that breaks the above outline, though.


[Footnotes]

 * A potential #leftoverbits tangent.

   Why is "rev_list_info" structure declared in <bisect.h>?  I
   suspect that this is a fallout from recent header file shuffling,
   but given who uses it (among which is rev-list:show_commit() that
   has very little to do with bisection and uses the information in
   rev_list_info when doing its normal non-bisect things), it does
   not make much sense.

 * When .do_not_die_on_missing_objects is false, it can and should
   be left NULL, but presumably we use the "do not die" bit even
   when we are not necessarily collecting the missing objects?  So
   the new member cannot replace the "do not die" bit completely.
