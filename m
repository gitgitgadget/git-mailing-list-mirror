Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C28133E5
	for <git@vger.kernel.org>; Mon,  6 Nov 2023 23:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="lTGtZ0qs"
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C43DD8F
	for <git@vger.kernel.org>; Mon,  6 Nov 2023 15:38:54 -0800 (PST)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 7C8EF3BEFF;
	Mon,  6 Nov 2023 18:38:53 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=p/d/FpnXWHSR
	kVd3buQYq3Z6jYUeF/MVoPqgvGz7o94=; b=lTGtZ0qsMj7WgsfHgXkl4giXOqPq
	u+MtZUo5wZE9IEKvgtP6sigmIpjFk/S7zEkPwn8f7DdYhlSbjuO73wWWvErJTG/j
	PDuvB9VwLpCzW1CqUhXt2RL95raMLSHeKxIcIvTIOs7/4k5cqCfERz0Rinfp4jDD
	hlwPi4dLAz3rn/I=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 740A63BEFE;
	Mon,  6 Nov 2023 18:38:53 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.67.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id E8D7B3BEFC;
	Mon,  6 Nov 2023 18:38:49 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Santiago =?utf-8?Q?Garc=C3=ADa?= Pimentel <santiago@garciapimentel.com>
Cc: git@vger.kernel.org
Subject: Re: git refusing to merge branches when pulling using a refspec
In-Reply-To: <FC0625CD-D736-412C-A4C5-04F9F41FFEEA@garciapimentel.com>
	("Santiago =?utf-8?Q?Garc=C3=ADa?= Pimentel"'s message of "Mon, 6 Nov 2023
 18:36:45
	+0100")
References: <FC0625CD-D736-412C-A4C5-04F9F41FFEEA@garciapimentel.com>
Date: Tue, 07 Nov 2023 08:38:48 +0900
Message-ID: <xmqqbkc6cv07.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID:
 A3152B66-7CFD-11EE-977C-A19503B9AAD1-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable

Santiago Garc=C3=ADa Pimentel <santiago@garciapimentel.com> writes:

> Hello,
>
> I'm dealing with a small automation (CI) to synchronise some specific b=
ranches between two git repositories.
>
> I need to sync a branch with other using a user-given refspec. e.g.
>
> $ git pull origin "refs/heads/branchOrigin:refs/heads/branchDestination=
=E2=80=9D.
>
> (I=E2=80=99ll have a list of refspecs, but so far Im trying to make it =
work with one)
>
> When the branch can be fast-forwarded there is no problem, but I cannot=
 manage to make it work when it cant.
>
> I just. get the message "[rejected] branchOrigin -> branchDestination (=
non-fast forward)."
With the "pull" command above, you are doing two logically
independent things.  Do you really need to do both?

 * git pull "<remote>" "<src>:<dst>" first does a "git fetch" to
   locally update <dst> with the commit that is pointed at by <src>
   at the <remote> repository.

 * then, into the currently checked out HEAD, the <src> taken from
   <remote> is merged into.

If you do not need to update <dst> locally, don't give :<dst> part
on the command line.

If you do need to update <dst> locally and safely, then thank that
you got the [rejected] message.  Because the <src> was updated at
the <remote> side that is not based on what you have at <dst>
locally, you may be losint commits from your local <dst> if you let
the first stage of the "git pull" go through, and that is what the
failing command is about.

If you do need to update <dst> locally but you do not have anything
valuable on <dst> locally (in other words, <dst> is used only to
keep track of <src> at <remote>, and if <remote> rewinds the history
of their <src> and loses some commits, you want to lose these commits
the same way from your <dst>), then add "+" before the refspec, i.e.

    git pull "<remote>" "+<src>:<dst>"

