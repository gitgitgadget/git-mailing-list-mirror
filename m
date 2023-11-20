Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="0ENEQ0st"
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03B64F4
	for <git@vger.kernel.org>; Mon, 20 Nov 2023 08:13:48 -0800 (PST)
Received: by mail-qt1-x829.google.com with SMTP id d75a77b69052e-41cd6e1d4fbso26843451cf.1
        for <git@vger.kernel.org>; Mon, 20 Nov 2023 08:13:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1700496827; x=1701101627; darn=vger.kernel.org;
        h=content-transfer-encoding:content-disposition:mime-version
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9omhVwKFwxCvO20wWwnGT/ajOw6HxdjEwTowjYHsGP0=;
        b=0ENEQ0stBgs/CQHPO+p9anytxrRku19KE7+cVy+9gPEclz8dAZ/xpf9+rvEVIZgFSB
         PHER+8wPwLyCQLiwp6kaHESXqbKCjkGsiZbr2Tcc7d0RwER/IyYMSk78Lvfme/q3Ele3
         7pp4tT+vHxBfnLLZ6jinrtAsjC9v8xQQhkojt1EFJMS0MH2wocX0OPHh2I6JscTqXnmy
         MSPZ3+HF6+JZWaaS7tUV7mDsl4MN7rDXNQ0YZwVOI16BGujAlttIZsKso1gPwxKavXWa
         LKj/IhNTCEZdgE3wt20modPA62kcUt8KuA8HIY/q/eW/sAqiD2YKc0MvA4u7pun9TljS
         cNjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700496827; x=1701101627;
        h=content-transfer-encoding:content-disposition:mime-version
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9omhVwKFwxCvO20wWwnGT/ajOw6HxdjEwTowjYHsGP0=;
        b=nzUVi70EASDpNuOxgt3iJTYGvIiXGtmOlznuSeKuf9v4faPfBpX20THavjoFL2xRbU
         RiUMJh+P5/MPZa9t6jc+TK8Uxy41WV9Mxu85E40n2qLsHMASz8rPukbWoxT10a0Tifzx
         27RaUYQI9iJw6ZITC+9TaWtp0sjfKyvJF84h47LhPPO6v+3XmMl/bSVOlGMvTrp12pWu
         wEOAaJ8lNXE6TSVmaR5eU0tqpgNmHq92qdTyDye8uq83gJ36R9ZXhp84+feSS9dl2Jl5
         I/OTJ8CyyyxRtOKdQidDyROPckuZ67g6V8RMOykhy7KzLbSG8pV+uR/aJa6ciQNNjrNz
         GHyg==
X-Gm-Message-State: AOJu0Yx5w/dtybo7RH0B2zWbjvk6aat/7tC3dtAVFO/O5X6FEFDRZuUr
	dLhw5PDJpT4vNLoJofuugBzXkNYRVwxAzeydZcRp7g==
X-Google-Smtp-Source: AGHT+IHNRBOmprOMEYXybbf2Mae4PQpiTPs/eZUeHXdjDB3NGTojSOC9TEabxftsEHhdiZaRQfc9fg==
X-Received: by 2002:a05:6214:1ccd:b0:66d:61c3:8ca4 with SMTP id g13-20020a0562141ccd00b0066d61c38ca4mr7674237qvd.15.1700496826807;
        Mon, 20 Nov 2023 08:13:46 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id e15-20020ad4442f000000b0066d12d1351fsm2974487qvt.143.2023.11.20.08.13.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Nov 2023 08:13:46 -0800 (PST)
Date: Mon, 20 Nov 2023 11:13:45 -0500
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Patrick Steinhardt <ps@pks.im>,
	Junio C Hamano <gitster@pobox.com>,
	Carlos =?utf-8?B?QW5kcsOpcyBSYW3DrXJleiBDYXRhw7Fv?= <antaigroupltda@gmail.com>
Subject: [PATCH] object-name: reject too-deep recursive ancestor queries
Message-ID: <57c0b30ddfe7c0ae78069682ff8454791e54469f.1700496801.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

When trying to resolve a revision query like "HEAD~~~~~", our call
pattern looks something like:

  - object-name.c::get_oid_with_context()
  - object-name.c::get_oid_1()
  - object-name.c::get_nth_ancestor()
  - object-name.c::get_oid_1()
  - ...

With `get_nth_ancestor()` and `get_oid_1()` mutually recurring, popping
one '~' off of the revision query for each round of the recursion.

Since this recursive behavior is unbounded, having too many "~"'s
contained in a revision query will cause us to blow the stack.
Generating a message like this when compiled under SANITIZE=address:

    $ valgrind git rev-parse "HEAD$(perl -e "print \"~\" x 1000000000000")"
    ==597453== Memcheck, a memory error detector
    ==597453== Copyright (C) 2002-2022, and GNU GPL'd, by Julian Seward et al.
    ==597453== Using Valgrind-3.19.0 and LibVEX; rerun with -h for copyright info
    ==597453== Command: /home/ttaylorr/local/bin/git.compile diff HEAD~~~~~~~~~~~~[...]
    ==597453==
    AddressSanitizer:DEADLYSIGNAL
    =================================================================
    ==597453==ERROR: AddressSanitizer: stack-overflow on address 0x7fffdd838ff8 (pc 0x7f2726082748 bp 0x7fffdd839110 sp 0x7fffdd839000 T0)
        #0 0x7f2726082748 in __asan::GetTLSFakeStack() ../../../../src/libsanitizer/asan/asan_fake_stack.cpp:176
        #1 0x7f2726082748 in GetFakeStackFast ../../../../src/libsanitizer/asan/asan_fake_stack.cpp:193
        #2 0x7f27260833de in OnMalloc ../../../../src/libsanitizer/asan/asan_fake_stack.cpp:207
        #3 0x7f27260833de in __asan_stack_malloc_1 ../../../../src/libsanitizer/asan/asan_fake_stack.cpp:256
        #4 0x563f9077d9d8 in get_nth_ancestor /home/ttaylorr/src/git/object-name.c:1087
        #5 0x563f9077e957 in get_oid_1 /home/ttaylorr/src/git/object-name.c:1295
        #6 0x563f9077da64 in get_nth_ancestor /home/ttaylorr/src/git/object-name.c:1092
        #7 0x563f9077e957 in get_oid_1 /home/ttaylorr/src/git/object-name.c:1295
        #8 0x563f9077da64 in get_nth_ancestor /home/ttaylorr/src/git/object-name.c:1092
        [...]
        #247 0x563f9077e957 in get_oid_1 /home/ttaylorr/src/git/object-name.c:1295
        #248 0x563f9077da64 in get_nth_ancestor /home/ttaylorr/src/git/object-name.c:1092

    SUMMARY: AddressSanitizer: stack-overflow ../../../../src/libsanitizer/asan/asan_fake_stack.cpp:176 in __asan::GetTLSFakeStack()
    ==597453==ABORTING

(Note that the actual stack is much deeper. GDB reports that the bottom
of the stack looks something like the following):

    #54866 0x0000555555c6d3bf in get_oid_with_context_1 (repo=0x5555563849a0 <the_repo>, name=0x7fffffff4be5 "HEAD", '~' <repeats 196 times>..., flags=128, prefix=0x0, oid=0x7ffff5713d40, oc=0x7ffff5713d90) at object-name.c:1947
    #54867 0x0000555555c6e2fa in get_oid_with_context (repo=0x5555563849a0 <the_repo>, str=0x7fffffff4be5 "HEAD", '~' <repeats 196 times>..., flags=128, oid=0x7ffff5713d40, oc=0x7ffff5713d90) at object-name.c:2096
    #54868 0x0000555555d8eed8 in handle_revision_arg_1 (arg_=0x7fffffff4be5 "HEAD", '~' <repeats 196 times>..., revs=0x7ffff5b000d0, flags=0, revarg_opt=0) at revision.c:2174
    #54869 0x0000555555d8f1a9 in handle_revision_arg (arg=0x7fffffff4be5 "HEAD", '~' <repeats 196 times>..., revs=0x7ffff5b000d0, flags=0, revarg_opt=0) at revision.c:2189
    #54870 0x0000555555d97ca9 in setup_revisions (argc=2, argv=0x7fffffff4970, revs=0x7ffff5b000d0, opt=0x0) at revision.c:2932
    #54871 0x00005555557d6a63 in cmd_diff (argc=2, argv=0x7fffffff4970, prefix=0x0) at builtin/diff.c:502
    #54872 0x00005555557367bf in run_builtin (p=0x5555561c4c30 <commands+816>, argc=2, argv=0x7fffffff4970) at git.c:469
    #54873 0x000055555573716b in handle_builtin (argc=2, argv=0x7fffffff4970) at git.c:723
    #54874 0x000055555573785a in run_argv (argcp=0x7ffff56028b0, argv=0x7ffff56028e0) at git.c:787
    #54875 0x0000555555738626 in cmd_main (argc=2, argv=0x7fffffff4970) at git.c:922
    #54876 0x00005555559d3fdd in main (argc=3, argv=0x7fffffff4968) at common-main.c:62

Fortunately, we can impose a limit on the maximum recursion depth we're
willing to accept when resolving queries like the above without
significantly impeding users. This patch sets the limit at 4096, though
we could probably increase that limit depending on the size of each
frame.

The limit introduced here is large enough that any reasonable query
should still run to completion, but small enough that if the frame size
were to significantly increase, our protection would still be effective.

The change here is straightforward: each call to get_nth_ancestor()
increases a counter, and then decrements that counter before returning.

The diff is a little noisy since there are a handful of return paths
from `get_nth_ancestor()`, all of which need to decrement the depth
variable.

Since this is a local-only exploit, a user would have to be tricked into
running such a query by an adversary. Even if they were successfully
tricked into running the malicious query, the blast radius is limited to
a local stack overflow, which does not have meaningful paths to remote
code execution, arbitrary memory reads, or any more grave security
concerns.

Reported-by: Carlos Andrés Ramírez Cataño <antaigroupltda@gmail.com>
Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 object-name.c                  | 26 ++++++++++++++++++++------
 t/t1506-rev-parse-diagnosis.sh |  5 +++++
 2 files changed, 25 insertions(+), 6 deletions(-)

diff --git a/object-name.c b/object-name.c
index 0bfa29dbbf..675e0a759e 100644
--- a/object-name.c
+++ b/object-name.c
@@ -1080,6 +1080,9 @@ static enum get_oid_result get_parent(struct repository *r,
 	return MISSING_OBJECT;
 }
 
+static int get_nth_ancestor_max_depth = 4096;
+static int get_nth_ancestor_curr_depth;
+
 static enum get_oid_result get_nth_ancestor(struct repository *r,
 					    const char *name, int len,
 					    struct object_id *result,
@@ -1089,20 +1092,31 @@ static enum get_oid_result get_nth_ancestor(struct repository *r,
 	struct commit *commit;
 	int ret;
 
+	if (++get_nth_ancestor_curr_depth > get_nth_ancestor_max_depth)
+		 return error(_("exceeded maximum ancestor depth"));
+
 	ret = get_oid_1(r, name, len, &oid, GET_OID_COMMITTISH);
 	if (ret)
-		return ret;
+		goto done;
 	commit = lookup_commit_reference(r, &oid);
-	if (!commit)
-		return MISSING_OBJECT;
+	if (!commit) {
+		ret = MISSING_OBJECT;
+		goto done;
+	}
 
 	while (generation--) {
-		if (repo_parse_commit(r, commit) || !commit->parents)
-			return MISSING_OBJECT;
+		if (repo_parse_commit(r, commit) || !commit->parents) {
+			ret = MISSING_OBJECT;
+			goto done;
+		}
 		commit = commit->parents->item;
 	}
 	oidcpy(result, &commit->object.oid);
-	return FOUND;
+
+	ret = FOUND;
+done:
+	get_nth_ancestor_curr_depth--;
+	return ret;
 }
 
 struct object *repo_peel_to_type(struct repository *r, const char *name, int namelen,
diff --git a/t/t1506-rev-parse-diagnosis.sh b/t/t1506-rev-parse-diagnosis.sh
index ef40511d89..b3b9f6c8c5 100755
--- a/t/t1506-rev-parse-diagnosis.sh
+++ b/t/t1506-rev-parse-diagnosis.sh
@@ -244,6 +244,11 @@ test_expect_success 'reject Nth ancestor if N is too high' '
 	test_must_fail git rev-parse HEAD~100000000000000000000000000000000
 '
 
+test_expect_success 'reject too-deep recursive ancestor queries' '
+	test_must_fail git rev-parse "HEAD$(perl -e "print \"~\" x 4097")" 2>err &&
+	grep "error: exceeded maximum ancestor depth" err
+'
+
 test_expect_success 'pathspecs with wildcards are not ambiguous' '
 	echo "*.c" >expect &&
 	git rev-parse "*.c" >actual &&

base-commit: cfb8a6e9a93adbe81efca66e6110c9b4d2e57169
-- 
2.43.0.rc2.19.geadd45bf00
