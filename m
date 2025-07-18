Received: from mout.web.de (mout.web.de [212.227.15.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C06F420E71D
	for <git@vger.kernel.org>; Fri, 18 Jul 2025 09:09:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752829756; cv=none; b=HPYDvy4s5Oqwf0A1GOj9V07jRKzeDGNAclCNJhAkTOiTEQBnBPsXo3COyYnwElBiVafTdOxBgw/x9dErwwidfkIPieZUyg6sZSHdW4QkCXB1n8w1TAPe92KZ/jsRFoTolGh8B2mJCOWdLh2mJapUw/twlZ/1kVIe5V0WD+bqkH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752829756; c=relaxed/simple;
	bh=bQY/N3xyy9wMUieaRaSuUExa6rjYVW14aSe8zUwi6sQ=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=badIk4IO0OVVgQj7+frsvi5I1dLeiqczmvLQyud5J46Xl17t5Jtjh8qvvUqXLOFXDpCkeo8bZ1Zqf4XY7D9mvO3JfYoY1NSTiWivs1V9Vck2Z4YsRprtBMpJwj68AcYZ8wTE2ylUNf4kFzMPL3uTGxtyecif66liGlYVwSjQU78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=Vf4WCobw; arc=none smtp.client-ip=212.227.15.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="Vf4WCobw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1752829745; x=1753434545; i=l.s.r@web.de;
	bh=1rjAUYAgLf11C7Xz4pnPYOAuh51j1F9c8wnL7xj9ydc=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:From:To:
	 Cc:References:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=Vf4WCobw2AToxv9DtR4Pwuup+TjDXNbwo66ghABMFP1ZAUj/9HMvh9VFi1y+2ZSC
	 s/RkFDj34Q3EepQoDwmz/gpS4YR91N/9mB+ULb4Npap6hFYBYvLNk9CnmU8bsMsSU
	 WnxSkiDDWyodxZKsRUkHMERQtNCoTvRABLPhwJob6Hy5PTBHuGlzyaAPORyJwmwnE
	 v889dSzN2saB76NOLH6gVo26u0K9VucwBzI05sXvJOvDOV6d2fNcsiBkMqQUVcgHA
	 YwIH3n5PX8xm1NG71yFJTyMFACtsk9e2l5gUBMh1vLxB2Hi6vvzbeZRHxmPPJrh3y
	 IsvFKBI2SWFKx/UnUw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.2.31] ([79.203.28.103]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1Mxpmc-1uoS6x0rvy-013Ox6; Fri, 18
 Jul 2025 11:09:05 +0200
Message-ID: <8ff40c56-368a-4347-aeae-2aca2cb6a5b2@web.de>
Date: Fri, 18 Jul 2025 11:09:04 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH v2 0/3] commit: convert pop_most_recent_commit() to prio_queue
From: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
To: Git List <git@vger.kernel.org>
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
 Justin Tobler <jltobler@gmail.com>
References: <bc079b3c-a472-4f5d-95ca-390f9de25196@web.de>
Content-Language: en-US
In-Reply-To: <bc079b3c-a472-4f5d-95ca-390f9de25196@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:syCUyD2O4ScP1shPGelpSZEt5RDS5uDk73AkjoxA91d1J/nfB1D
 NHZaWLnPZKK+nRigI+HmRwAjC3K5OIjV4fzoU1089PidzTk3xMN7UNKVl6ed7AOvbxfTx0H
 vk9fuAvVjt2tn3mMaUjbZ1a7tk1mFzW6oebzpXovqDL0IVxRohxKkrey7es6OrDEJ/au9gY
 qbajg4F+xi5wzBdTAju0Q==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:N06Ywcgcjdo=;m4x8CQZ3yJ2gHTMvfonyz4/OzUe
 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
 NFWmoNcTArMhnpaBkO3XXhkxGo

Use prio_queue to improve worst-case performance at the cost of slightly
worse best-case performance.  Then add and use prio_queue_replace() to
recover that loss.

Changes since v2:
- Mention that a prio_queue improves performance for merge-heavy
  histories in the commit message.
- Add the new perf script to Meson build file.
- Mention which kind of history we are aiming for and show its shape in
  a comment in the perf script.
- Remove unnecessary quotes and use single quotes for the perf test
  code.
- Rename the variable delete_pending to get_pending to align it with
  the concrete function prio_queue_get() instead of referring to the
  abstract concept of deletion, to improve readability.

  commit: convert pop_most_recent_commit() to prio_queue
  prio-queue: add prio_queue_replace()
  commit: use prio_queue_replace() in pop_most_recent_commit()

 commit.c                          | 14 ++++--
 commit.h                          |  8 ++--
 fetch-pack.c                      | 13 +++---
 object-name.c                     | 10 ++---
 prio-queue.c                      | 45 ++++++++++++++------
 prio-queue.h                      |  8 ++++
 t/meson.build                     |  1 +
 t/perf/p1501-rev-parse-oneline.sh | 71 +++++++++++++++++++++++++++++++
 t/unit-tests/u-prio-queue.c       | 23 ++++++++++
 walker.c                          | 11 +++--
 10 files changed, 170 insertions(+), 34 deletions(-)
 create mode 100755 t/perf/p1501-rev-parse-oneline.sh

Range-diff against v1:
1:  d9c0d13801 ! 1:  5bff885d0f commit: convert pop_most_recent_commit() t=
o prio_queue
    @@ Metadata
      ## Commit message ##
         commit: convert pop_most_recent_commit() to prio_queue
    =20
    -    pop_most_recent_commit() calls commit_list_insert_by_date(), whic=
h and
    -    is itself called in a loop, which can lead to quadratic complexit=
y.
    -    Replace the commit_list with a prio_queue to ensure logarithmic w=
orst
    -    case complexity and convert all three users.
    +    pop_most_recent_commit() calls commit_list_insert_by_date() for p=
arent
    +    commits, which is itself called in a loop.  This can lead to quad=
ratic
    +    complexity if there are many merges.  Replace the commit_list wit=
h a
    +    prio_queue to ensure logarithmic worst case complexity and conver=
t all
    +    three users.
    =20
         Add a performance test that exercises one of them using a patholo=
gical
         history that consists of 50% merges and 50% root commits to demon=
strate
    @@ object-name.c: static enum get_oid_result get_oid_with_context_1(st=
ruct reposito
     =20
      			free_commit_list(list);
    =20
    + ## t/meson.build ##
    +@@ t/meson.build: benchmarks =3D [
    +   'perf/p1450-fsck.sh',
    +   'perf/p1451-fsck-skip-list.sh',
    +   'perf/p1500-graph-walks.sh',
    ++  'perf/p1501-rev-parse-oneline.sh',
    +   'perf/p2000-sparse-operations.sh',
    +   'perf/p3400-rebase.sh',
    +   'perf/p3404-rebase-interactive.sh',
    +
      ## t/perf/p1501-rev-parse-oneline.sh (new) ##
     @@
     +#!/bin/sh
    @@ t/perf/p1501-rev-parse-oneline.sh (new)
     +
     +test_perf_fresh_repo
     +
    ++#
    ++# Creates lots of merges to make history traversal costly.  In
    ++# particular it creates 2^($max_level-1)-1 2-way merges on top of
    ++# 2^($max_level-1) root commits.  E.g., the commit history looks lik=
e
    ++# this for a $max_level of 3:
    ++#
    ++#     _1_
    ++#    /   \
    ++#   2     3
    ++#  / \   / \
    ++# 4   5 6   7
    ++#
    ++# The numbers are the fast-import marks, which also are the commit
    ++# messages.  1 is the HEAD commit and a merge, 2 and 3 are also merg=
es,
    ++# 4-7 are the root commits.
    ++#
     +build_history () {
     +	local max_level=3D"$1" &&
     +	local level=3D"${2:-1}" &&
    @@ t/perf/p1501-rev-parse-oneline.sh (new)
     +	sed -n -e "s/^.* //p" -e "q" <commits >needle
     +'
     +
    -+test_perf "rev-parse ':/$(cat needle)'" "
    -+	git rev-parse ':/$(cat needle)' >actual
    -+"
    ++test_perf "rev-parse :/$(cat needle)" '
    ++	git rev-parse :/$(cat needle) >actual
    ++'
     +
     +test_expect_success 'verify result' '
     +	test_cmp expect actual
2:  a4011d850c =3D 2:  a2e57ca443 prio-queue: add prio_queue_replace()
3:  dc535e8b64 ! 3:  1cbea38524 commit: use prio_queue_replace() in pop_mo=
st_recent_commit()
    @@ commit.c: void commit_list_sort_by_date(struct commit_list **list)
      {
     -	struct commit *ret =3D prio_queue_get(queue);
     +	struct commit *ret =3D prio_queue_peek(queue);
    -+	int delete_pending =3D 1;
    ++	int get_pending =3D 1;
      	struct commit_list *parents =3D ret->parents;
     =20
      	while (parents) {
    @@ commit.c: void commit_list_sort_by_date(struct commit_list **list)
      		if (!repo_parse_commit(the_repository, commit) && !(commit->object=
.flags & mark)) {
      			commit->object.flags |=3D mark;
     -			prio_queue_put(queue, commit);
    -+			if (delete_pending)
    ++			if (get_pending)
     +				prio_queue_replace(queue, commit);
     +			else
     +				prio_queue_put(queue, commit);
    -+			delete_pending =3D 0;
    ++			get_pending =3D 0;
      		}
      		parents =3D parents->next;
      	}
    -+	if (delete_pending)
    ++	if (get_pending)
     +		prio_queue_get(queue);
      	return ret;
      }
=2D-=20
2.50.1
