Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F8BC18641
	for <git@vger.kernel.org>; Sun, 12 Nov 2023 23:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="kEy0TW+C"
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0083ABE
	for <git@vger.kernel.org>; Sun, 12 Nov 2023 15:09:59 -0800 (PST)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 83FDB1B75AE;
	Sun, 12 Nov 2023 18:09:56 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=uPwA9iEVx1V7BPfDseasbzwmXt4vUA2rcMKzoO
	e+9Bk=; b=kEy0TW+Co7cljlVBtth1rZDKbBPN801MTKvyOM3EuOfF+3xFVP3lFu
	QWwC3Ui1QxffKXfQbNVu2kHxcDQAFqx3zi7S4ZMUSYrCQWJSZ36/eS5TriOPVly+
	/mkmxzpg1f3mVuZGn8UFtKtse1cuE9q/A+Foe/gewtqdo1wkpmRYo=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 6B3351B75AD;
	Sun, 12 Nov 2023 18:09:56 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.67.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id BB5161B75AC;
	Sun, 12 Nov 2023 18:09:54 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Elijah Newren <newren@gmail.com>
Cc: Philip Oakley <philipoakley@iee.email>,  Jeremy Pridmore
 <jpridmore@rdt.co.uk>,  "git@vger.kernel.org" <git@vger.kernel.org>,  Paul
 Baumgartner <pbaumgartner@rdt.co.uk>
Subject: Re: Git Rename Detection Bug
In-Reply-To: <CABPp-BEtva2WTGQG3Qs4EbZLK_RJC9vuA-2OYxkTPExgowwvqQ@mail.gmail.com>
	(Elijah Newren's message of "Sat, 11 Nov 2023 07:13:28 -0800")
References: <LO6P265MB6736043BE8FB607DB671D21EFAAAA@LO6P265MB6736.GBRP265.PROD.OUTLOOK.COM>
	<CABPp-BHYaxa7QoXabM=7hW-93hQLK-=KayGtDHtWxxdAnJCcJw@mail.gmail.com>
	<LO6P265MB6736F5F9E8368A9DE95D294FFAA9A@LO6P265MB6736.GBRP265.PROD.OUTLOOK.COM>
	<CABPp-BHEX+SyophEfgRqDbNdrAS3=bptt_cKzHLBSutnBAxexw@mail.gmail.com>
	<9baca4af-a570-4b7a-a1ee-de91b809e79c@iee.email>
	<CABPp-BEtva2WTGQG3Qs4EbZLK_RJC9vuA-2OYxkTPExgowwvqQ@mail.gmail.com>
Date: Mon, 13 Nov 2023 08:09:53 +0900
Message-ID: <xmqqzfzimuv2.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 97E78EF2-81B0-11EE-BC7B-78DCEB2EC81B-77302942!pb-smtp1.pobox.com

Elijah Newren <newren@gmail.com> writes:

>> Could I suggest that we are missing a piece of terminology, to wit,
>> BLOBSAME. It's a compatriot to TREESAME, as used in `git log` for
>> history simplification (based on a tree's pathspec, most commonly a
>> commit's top level path).
>
> We could add it, but I'm not sure how it helps.  We already had 'exact
> rename' which seems to fit the bill as well, and 'blob' is something
> someone new to Git is unlikely to know.

Also, as Philip said, TREESAME is a concept foreign to rename
detection codepath.  It is a property of a commit (not a tree) and
tells us if it has the same tree object as its relevant parents (in
which case it can be simplified away if it is a merge).  I do not
mind rename codepath using a jargon (or two) to express "in trees A
and B, this subtree of A records the same tree object as a subtree
of B at a different path (i.e., the contents of these two subtrees
at different paths are the same)" but the word used to express that
should not be TREESAME to avoid confusion.  And the other word to
express "this path in tree A records a blob object that is identical
to this other path in tree B" should not be BLOBSAME, as the word
strongly hints it is somehow related to TREESAME.

Thanks.

