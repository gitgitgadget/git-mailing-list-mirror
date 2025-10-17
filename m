Received: from mail.avm.de (mail.avm.de [212.42.244.94])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBF5A770FE
	for <git@vger.kernel.org>; Fri, 17 Oct 2025 09:47:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.42.244.94
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760694468; cv=none; b=MgQa7U4s5o4BfK73H+hbjBh4hwvNXWpgZIDeoSa43biL/C1xCZ7UHDozCeH8UCK4D/RIskawM2r/809cKEXgOhsdZgkYW8tOLIGzsNhG55si7fFsxywhpvDAx6ygfopNouoj2kugbhuLENZMvWyBu8tLM2Izkbi0Yezr7nMTeJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760694468; c=relaxed/simple;
	bh=Bhcr7nX/LU3zTAOyBv/e3zdjnnGa2Y86wkw0/+09CNA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mKanWZ+3CFH8W5sksHlUSZKFUF9lTeJF36MZv5bt2/z3niNJfb7qUHtN9tUWzxSkOTui8rD9BMtBiVrZCgC1Az7ItiKex+2wyGNlHJ6WcFDEywyqMiPRiDYWeeqiBTKbs6qgDKUyHag7Sn7e0OFyDAPDcm98mx9fL/rr02Aus8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=avm.de; spf=pass smtp.mailfrom=avm.de; arc=none smtp.client-ip=212.42.244.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=avm.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=avm.de
Received: from [212.42.244.71] (helo=mail.avm.de)
	by mail.avm.de with ESMTP (eXpurgate 4.53.4)
	(envelope-from <phahn-oss@avm.de>)
	id 68f210b8-5261-7f0000032729-7f000001818a-1
	for <git@vger.kernel.org>; Fri, 17 Oct 2025 11:47:36 +0200
Received: from mail-auth.avm.de (dovecot-mx-01.avm.de [212.42.244.71])
	by mail.avm.de (Postfix) with ESMTPS
	for <git@vger.kernel.org>; Fri, 17 Oct 2025 11:47:36 +0200 (CEST)
From: Philipp Hahn <phahn-oss@avm.de>
To: git@vger.kernel.org
Cc: Philipp Hahn <phahn-oss@avm.de>
Subject: BUG: commit-graph + objects/alternate -> SIGSEGV
Date: Fri, 17 Oct 2025 11:47:11 +0200
Message-ID: <20251017094717.626300-1-phahn-oss@avm.de>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-purgate-ID: 149429::1760694456-176A9FD0-E45861BB/0/0
X-purgate-type: clean
X-purgate-size: 4690
X-purgate-Ad: Categorized by eleven eXpurgate (R) https://www.eleven.de
X-purgate: This mail is considered clean (visit https://www.eleven.de for further information)
X-purgate: clean

Thank you for filling out a Git bug report!
Please answer the following questions to help us understand your issue.

What did you do before the bug happened? (Steps to reproduce your issue)

	git config --global fetch.writeCommitGraph true

	SOME_REPO='git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git'
	git clone "$SOME_REPO" 1st
	git clone --reference base/.git/objects/ "$SOME_REPO" 2nd

	sleep 14d  # lots of changes upstream happen

	cat  1st/.git/objects/info/commit-graphs/commit-graph-chain
	git -C 1st fetch origin
	cat  1st/.git/objects/info/commit-graphs/commit-graph-chain

	cat  2nd/.git/objects/info/commit-graphs/commit-graph-chain
	git -C 2nd fetch origin
	cat  2nd/.git/objects/info/commit-graphs/commit-graph-chain

What did you expect to happen? (Expected behavior)

	should work

What happened instead? (Actual behavior)

	`git fetch` crashes with a SIGSEGV respective complains about "missing commit-graphs":
	> Warnung: konnte nicht alle Commit-Graph-Dateien finden

	(gdb) bt
	#0  __memcpy_avx_unaligned_erms () at ../sysdeps/x86_64/multiarch/memmove-vec-unaligned-erms.S:342
	#1  0x000063f176070f97 in hashwrite (f=0x63f1ad38c3b0, buf=0x0, count=20) at ./csum-file.c:126
	#2  0x000063f17604b43d in write_graph_chunk_data (f=0x63f1ad38c3b0, data=0x63f1ad7e7f20) at ./commit-graph.c:1240
	#3  0x000063f176235dc2 in write_chunkfile (cf=0x63f1ad38c070, data=0x63f1ad7e7f20) at ./chunk-format.c:85
	#4  0x000063f17604df55 in write_commit_graph_file (ctx=0x63f1ad7e7f20) at ./commit-graph.c:2132
	#5  0x000063f17604f9eb in write_commit_graph (odb=0x63f1ad05d130, pack_indexes=0x0, commits=0x7ffd0f657160, flags=(COMMIT_GRAPH_WRITE_PROGRESS | COMMIT_GRAPH_WRITE_SPLIT), opts=0x0)
	    at ./commit-graph.c:2630
	#6  0x000063f17604d0d3 in write_commit_graph_reachable (odb=0x63f1ad05d130, flags=(COMMIT_GRAPH_WRITE_PROGRESS | COMMIT_GRAPH_WRITE_SPLIT), opts=0x0) at ./commit-graph.c:1874
	#7  0x000063f175f58cdd in cmd_fetch (argc=1, argv=0x7ffd0f658638, prefix=0x0) at builtin/fetch.c:2471
	#8  0x000063f175efadda in run_builtin (p=0x63f176349b98 <commands+984>, argc=4, argv=0x7ffd0f658630) at ./git.c:469
	#9  0x000063f175efb240 in handle_builtin (argc=4, argv=0x7ffd0f658630) at ./git.c:723
	#10 0x000063f175efb4c2 in run_argv (argcp=0x7ffd0f65847c, argv=0x7ffd0f658470) at ./git.c:787
	#11 0x000063f175efba9e in cmd_main (argc=4, argv=0x7ffd0f658630) at ./git.c:922
	#12 0x000063f176007a64 in main (argc=5, argv=0x7ffd0f658628) at ./common-main.c:62
	(gdb) up
	#2  0x000063f17604b43d in write_graph_chunk_data (f=0x63f1ad38c3b0, data=0x63f1ad7e7f20) at ./commit-graph.c:1240
	1240			hashwrite(f, tree->hash, the_hash_algo->rawsz);
	(gdb) p tree
	$7 = (struct object_id *) 0x0
	(gdb) l
	1235	
	1236			if (repo_parse_commit_no_graph(ctx->r, *list))
	1237				die(_("unable to parse commit %s"),
	1238					oid_to_hex(&(*list)->object.oid));
	1239			tree = get_commit_tree_oid(*list);
	1240			hashwrite(f, tree->hash, the_hash_algo->rawsz);
	1241	
	1242			parent = (*list)->parents;
	1243	
	1244			if (!parent)

What's different between what you expected and what actually happened?

	`git` should not crash but detect, that the referenced commit-graphs from the
	alternate repository are no longer there, ignore them and build a new complete
	graph on its own.

Anything else you want to add:

	May `git` should detect, that "alternate repositories" don't work well with
	"commit graphs" and should warn about that.

	Or recomment to disabble `fetch.writeCommitGraph` in repositories, which are used as alternates.

	2nd/.git/objects/info/commit-graphs/:
		commit-graph-chain
		graph-eaf006965bd96cbfaea3127fe6faded17e337d81.graph

	2nd/.git/objects/info/commit-graphs/commit-graph-chain:
		947ca043c9d5c054195bff874e37bfed738607b3
		087b52e4f21a976a00a96d80fc10329066c87267
		c28bc2ddb938daffda137d8847dff685dc361ebf
		eaf006965bd96cbfaea3127fe6faded17e337d81

	1st/.git/objects/info/commit-graphs/:
		commit-graph-chain
		graph-00ab433b37dfb9c3a3b2930a68b55005c39fdd1a.graph
		graph-7c2471bbb8d6980cbe716b8ffdc0a171c8d12ea9.graph
		graph-947ca043c9d5c054195bff874e37bfed738607b3.graph

Please review the rest of the bug report below.
You can delete any lines you don't wish to share.


[System Info]
git version:
git version 2.43.0
cpu: x86_64
no commit associated with this build
sizeof-long: 8
sizeof-size_t: 8
shell-path: /bin/sh
uname: Linux 6.8.0-85-generic #85-Ubuntu SMP PREEMPT_DYNAMIC Thu Sep 18 15:26:59 UTC 2025 x86_64
compiler info: gnuc: 12.2
libc info: glibc: 2.39
$SHELL (typically, interactive shell): /bin/bash


[Enabled Hooks]
