Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="wHYELfPH"
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A96781BC3
	for <git@vger.kernel.org>; Fri,  8 Dec 2023 09:13:23 -0800 (PST)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id C47781C7EBE;
	Fri,  8 Dec 2023 12:13:20 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=pOGUv2P50oVxTXC1w9vTzQ5AYuMtTQiYkAaO+s
	+LBuU=; b=wHYELfPHONv08697XNPiKSRO9J+ZvLhXxForPVQMzTIxbZxcNt0aQZ
	p2cOG3E8+hTCDzKwSoIEnEZqyMfLYT9W8MLE/ypb/vP6CKUCJ32AikyCmf3Gl1jp
	sH6kvcBNxXCUIaS7MAZI20CFh2QqyNcmDXWDB2FhQkNlkQn5aD58A=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id BB0101C7EBC;
	Fri,  8 Dec 2023 12:13:20 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.103.223])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 2B8241C7EBB;
	Fri,  8 Dec 2023 12:13:20 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Eric Sunshine <sunshine@sunshineco.com>
Cc: Willem Verstraeten <willem.verstraeten@gmail.com>,
  phillip.wood@dunelm.org.uk,  git@vger.kernel.org,  Jeff King
 <peff@peff.net>
Subject: Re: [PATCH 2/2] checkout: forbid "-B <branch>" from touching a
 branch used elsewhere
In-Reply-To: <CAPig+cSGF+vQrnD0f99cbdpQOOC7X6ULa9tFe+FwVrG0SF4PGg@mail.gmail.com>
	(Eric Sunshine's message of "Mon, 4 Dec 2023 16:06:50 -0500")
References: <CAGX9RpFMCVLQV7RbK2u9AabusvkZD+RZNv_UD=R00cSUrjutBg@mail.gmail.com>
	<xmqqjzq9cl70.fsf@gitster.g> <xmqqv89tau3r.fsf@gitster.g>
	<xmqqpm01au0w.fsf_-_@gitster.g>
	<bf848477-b4dd-49d3-8e4b-de0fc3948570@gmail.com>
	<xmqqwmu42ccb.fsf@gitster.g>
	<b3532261-3cf4-4666-9cbd-4ce668cd2e49@gmail.com>
	<CAGX9RpH0RJfBADQwJ=c7PCHU955vOqd0Wdc7Yi7XUuAQQW_FNQ@mail.gmail.com>
	<CAPig+cSGF+vQrnD0f99cbdpQOOC7X6ULa9tFe+FwVrG0SF4PGg@mail.gmail.com>
Date: Sat, 09 Dec 2023 02:13:18 +0900
Message-ID: <xmqqsf4c39e9.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 15E1BD1E-95ED-11EE-BBC6-78DCEB2EC81B-77302942!pb-smtp1.pobox.com

Eric Sunshine <sunshine@sunshineco.com> writes:

>    Needs review and documentation updates.
>
> I'm not sure if the "Needs review" comment is still applicable since
> the patch did get some review comments, however, the mentioned
> documentation update is probably still needed for this series to
> graduate.

Thanks.  I think "-B" being defined as "branch -f <branch>" followed
by "checkout <branch>" makes it technically unnecessary to add any
new documentation (because "checkout <branch>" will refuse, so it
naturally follows that "checkout -B <branch>" should), but giving
the failure mode a bit more explicit mention would be more helpful
to readers.

Here is to illustrate what I have in mind.  The mention of the
"transactional" was already in the documentation for the "checkout"
back when switch was described at d787d311 (checkout: split part of
it to new command 'switch', 2019-03-29), but somehow was left out in
the documentation of the "switch".  While it is not incorrect to say
that it is a convenient short-cut, it is more important to say what
happens when one of them fails, so I am tempted to port that
description over to the "switch" command, and give the "used elsewhere"
as a sample failure mode.

The test has been also enhanced to check the "transactional" nature.

 Documentation/git-checkout.txt |  4 +++-
 Documentation/git-switch.txt   |  9 +++++++--
 t/t2400-worktree-add.sh        | 18 ++++++++++++++++--
 3 files changed, 26 insertions(+), 5 deletions(-)

diff --git c/Documentation/git-checkout.txt w/Documentation/git-checkout.txt
index 240c54639e..55a50b5b23 100644
--- c/Documentation/git-checkout.txt
+++ w/Documentation/git-checkout.txt
@@ -63,7 +63,9 @@ $ git checkout <branch>
 ------------
 +
 that is to say, the branch is not reset/created unless "git checkout" is
-successful.
+successful (e.g., when the branch is in use in another worktree, not
+just the current branch stays the same, but the branch is not reset to
+the start-point, either).
 
 'git checkout' --detach [<branch>]::
 'git checkout' [--detach] <commit>::
diff --git c/Documentation/git-switch.txt w/Documentation/git-switch.txt
index c60fc9c138..6137421ede 100644
--- c/Documentation/git-switch.txt
+++ w/Documentation/git-switch.txt
@@ -59,13 +59,18 @@ out at most one of `A` and `B`, in which case it defaults to `HEAD`.
 -c <new-branch>::
 --create <new-branch>::
 	Create a new branch named `<new-branch>` starting at
-	`<start-point>` before switching to the branch. This is a
-	convenient shortcut for:
+	`<start-point>` before switching to the branch. This is the
+	transactional equivalent of
 +
 ------------
 $ git branch <new-branch>
 $ git switch <new-branch>
 ------------
++
+that is to say, the branch is not reset/created unless "git switch" is
+successful (e.g., when the branch is in use in another worktree, not
+just the current branch stays the same, but the branch is not reset to
+the start-point, either).
 
 -C <new-branch>::
 --force-create <new-branch>::
diff --git c/t/t2400-worktree-add.sh w/t/t2400-worktree-add.sh
index bbcb2d3419..5d5064e63d 100755
--- c/t/t2400-worktree-add.sh
+++ w/t/t2400-worktree-add.sh
@@ -129,8 +129,22 @@ test_expect_success 'die the same branch is already checked out' '
 test_expect_success 'refuse to reset a branch in use elsewhere' '
 	(
 		cd here &&
-		test_must_fail git checkout -B newmain 2>actual &&
-		grep "already used by worktree at" actual
+
+		# we know we are on detached HEAD but just in case ...
+		git checkout --detach HEAD &&
+		git rev-parse --verify HEAD >old.head &&
+
+		git rev-parse --verify refs/heads/newmain >old.branch &&
+		test_must_fail git checkout -B newmain 2>error &&
+		git rev-parse --verify refs/heads/newmain >new.branch &&
+		git rev-parse --verify HEAD >new.head &&
+
+		grep "already used by worktree at" error &&
+		test_cmp old.branch new.branch &&
+		test_cmp old.head new.head &&
+
+		# and we must be still on the same detached HEAD state
+		test_must_fail git symbolic-ref HEAD
 	)
 '
 
