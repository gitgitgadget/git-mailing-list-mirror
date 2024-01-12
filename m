Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E364C15AFA
	for <git@vger.kernel.org>; Fri, 12 Jan 2024 21:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="A1VLBq40"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 2B895284AF;
	Fri, 12 Jan 2024 16:14:11 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=uLQsXY3csecM
	DyYD7haSgRk0ir73b91IGUmV98FeVtQ=; b=A1VLBq40UvEPp0ydM2t882yfzJY2
	DU9RoB2QD+Z9OjCYQNgc+AS21nY3rsMrtydlnbTSyWkLou87nRKdr/D1HAS+X3dw
	stFD/qiiccyf1Zp0LMTD7a2cPqIVQmqxiNW9U7Mk9mZLcJoemMnLea1nMWjmj71v
	7wqeBN/fFtFp63c=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 240E4284AE;
	Fri, 12 Jan 2024 16:14:11 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.200.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 177FD284AD;
	Fri, 12 Jan 2024 16:14:07 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Michael Lohmann <mi.al.lohmann@gmail.com>
Cc: phillip.wood123@gmail.com,  git@vger.kernel.org,
  phillip.wood@dunelm.org.uk
Subject: Re: [RFC PATCH] `log --merge` also for rebase/cherry pick/revert
In-Reply-To: <20240112150346.73735-1-mi.al.lohmann@gmail.com> (Michael
	Lohmann's message of "Fri, 12 Jan 2024 16:03:46 +0100")
References: <47a4418b-68bf-4850-ba8b-1a5264f923e4@gmail.com>
	<20240112150346.73735-1-mi.al.lohmann@gmail.com>
Date: Fri, 12 Jan 2024 13:14:05 -0800
Message-ID: <xmqqil3y9rvm.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID:
 855FAA80-B18F-11EE-A681-F515D2CDFF5E-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable

Michael Lohmann <mi.al.lohmann@gmail.com> writes:

> Almost, but not quite: "git log =E2=80=94merge" only shows the commits =
touching the
> conflict, so it would be equivalent to (I think):
>
>    git log HEAD CHERRY_PICK_HEAD ^$(git merge-base HEAD CHERRY_PICK_HEA=
D) -- $(git diff --name-only --diff-filter=3DU --relative)
>
> (or replace CHERRY_PICK with one of the other actions)

It can certainly _reduce_ the noise, but I am not sure if it works
over the right history segment.  Let me think aloud a bit.

Let's imagine that in a history forked long time ago,

 O----O----O----O----X HEAD
  \
   Z---Z---Z---Z---A---B CHERRY_PICK_HEAD

where all commits modified the same path in question that you saw
conflicts in when your "git cherry-pick B" stopped.

I do not know what to think about the changes to that path by the
commits denoted by 'O', but the changes done to the path by commits
denoted by 'Z' should have absolutely no relevance, as the whole
point of cherry-picking B relative to A is because we do not care
about what Zs did, no?  For that matter, given that how we structure
the 3-way merge for such a cherry-pick to "move from X the same way
as you would move from A to B", how you got to X (i.e. Os) should
not matter, either.

On the other hand, such a conflict may arise from the fact that Os
and Zs made changes differently to cause the contents of the path at
X and A differ significantly.  So, OK, I can buy your argument that
what Os and Zs to the conflicted path did can be interesting when
understanding the conflict during such a cherry-pick.

>> Indeed there HEAD and CHERRY_PICK_HEAD may not share a common ancestor=
.
>
> True - but same for MERGE_HEAD ("git merge --allow-unrelated-histories"=
). I

But that is very different, isn't it?  Merging two unrelated
histories is like merging two histories where the common ancestor
had an empty tree, i.e.

      o---o---o---X HEAD
     /
   (v) an imaginary ancestor with an empty tree
     \
      o---o---o---O MERGE_HEAD

so it is a reasonable degenerated behaviour to consider what all
commits on both sides did to the paths in question.
