Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5706B2905
	for <git@vger.kernel.org>; Tue, 30 Jul 2024 01:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722302268; cv=none; b=WA/A0OZ2AQOodyD0x8inzqdLFd7V3EfwecwdHHJKqWdbVzfeEOqQl8nny+lo9lZlZ4Ow3ng0ZLzSAPX8N1KFoqZmtALcuYqqlBTNwC//j7ry4R6xdmNpfNvnB0/dcR3Pc6owrztULTbZGrDTQgirrthssPMEYljI7qSAiGJcGBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722302268; c=relaxed/simple;
	bh=LQAkUChSVKoCzkTQubKZXndMmfvo9nsM/ux96t1NE2A=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MIU++ZR1/NbeAxavVAnNuBF9lSaP1CAsSRU2EGcYZ3+tF+FMxesK3C8AHuAOCQMlydHCtb6+I9fOtSK59aojWcIYlO1FChv/cbCA77HgmUOTZdwlj+hIvcEzHq1SbQLbfotWC7nnHNfEzU4woGWK3IyQX+TjsGU4yoy3U0i1qYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=Sg6TyB6D; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="Sg6TyB6D"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 2C2B427F4E;
	Mon, 29 Jul 2024 21:17:40 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references:mime-version
	:content-transfer-encoding; s=sasl; bh=LQAkUChSVKoCzkTQubKZXndMm
	fvo9nsM/ux96t1NE2A=; b=Sg6TyB6D6Xu4XniD+k9m4FyjEONygzYVJzCkWLocz
	yJA3pXaWSx32jZh4i8+BLb7E/ObEJ0H16Kw51i1/DhLIh3Yyqe/pHtGwmqV94HqD
	Iz+h+BJLlz6e1Ih7I6lCa1BWDUkm87ewLcNsx4Irp157HAhZo3v5tQ4C73g4Vmnr
	1s=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 231FA27F4D;
	Mon, 29 Jul 2024 21:17:40 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.139.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 829B827F4C;
	Mon, 29 Jul 2024 21:17:39 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: [PATCH v2 0/5] Tighten patch header parsing in patch-id
Date: Mon, 29 Jul 2024 18:17:33 -0700
Message-ID: <20240730011738.4032377-1-gitster@pobox.com>
X-Mailer: git-send-email 2.46.0-71-g1aa693ace8
In-Reply-To: <20240621231826.3280338-1-gitster@pobox.com>
References: <20240621231826.3280338-1-gitster@pobox.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Pobox-Relay-ID:
 8345152C-4E11-11EF-9726-BAC1940A682E-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable

    Updates from v1

     - changed flag bits used internally from CPP macro to enum and
       added a bit of comments.

The patch-id command loops over a series of patches, picking up the
origin commit object name (which is on the "patch header" line) and
then computing the patch identifier out of the "patch" (series of
"diff") that follows the "patch header".

The parser is structured in a bit "strange" way.  It repeatedly
calls a single helper function get_one_patchid() that returns when a
patch header is recognised, or skips until the "patch" part begins
and then computes the "patch id" over the "patch" part, until it
sees a patch header.  The caller knows that it gets just the "patch
header" for the first patch with its first call, and the second call
is about computing the patch id for the first patch, whose
originating commit was obtained from the first call, etc.

During the second and subsequent call (i.e. after finding a patch
header which caused the get_one_patchid() to return, calling the
helper again, expecting it to skip the commit log and find the patch
for which we are asked to compute the patch id), we shouldn't look
for the patch header at all.  Otherwise, a line that looks like a
patch header in the log message can easily be mistaken to be the
beginning of a new patch header, as if the current message did not
have any patch text.

This 5-patch series is organized as follows:

 - patch 1 is about setting the baseline.  We need to recognise the
   patch header produced by format-patch, log, and diff-tree --stdin.

 - patch 2 to patch 4 are bit of code restructuring without changing
   the behaviour.

 - patch 5 stops looking for a patch header when we shouldn't, and
   adds tests.


Junio C Hamano (5):
  t4204: patch-id supports various input format
  patch-id: call flush_current_id() only when needed
  patch-id: make get_one_patchid() more extensible
  patch-id: rewrite code that detects the beginning of a patch
  patch-id: tighten code to detect the patch header

 builtin/patch-id.c  | 93 +++++++++++++++++++++++++++++++++++----------
 t/t4204-patch-id.sh | 40 +++++++++++++++++++
 2 files changed, 112 insertions(+), 21 deletions(-)

Range-diff against v1:
1:  c1ff38c0b8 =3D 1:  e68a30f6c9 t4204: patch-id supports various input =
format
2:  a201f344a6 =3D 2:  3afc63b210 patch-id: call flush_current_id() only =
when needed
3:  237f8910ca ! 3:  22dd5e7a5b patch-id: make get_one_patchid() more ext=
ensible
    @@ builtin/patch-id.c: static int scan_hunk_header(const char *p, int=
 *p_before, in
      	return 1;
      }
     =20
    -+#define GOPID_STABLE   01
    -+#define GOPID_VERBATIM 02
    ++/*
    ++ * flag bits to control get_one_patchid()'s behaviour.
    ++ */
    ++enum {
    ++	GOPID_STABLE =3D (1<<0),		/* --stable */
    ++	GOPID_VERBATIM =3D (1<<1),	/* --verbatim */
    ++};
     +
      static int get_one_patchid(struct object_id *next_oid, struct objec=
t_id *result,
     -			   struct strbuf *line_buf, int stable, int verbatim)
4:  d6d068c9dc =3D 4:  0cca1ed513 patch-id: rewrite code that detects the=
 beginning of a patch
5:  51af73722c ! 5:  ef422df7c1 patch-id: tighten code to detect the patc=
h header
    @@ Commit message
      ## builtin/patch-id.c ##
     @@ builtin/patch-id.c: static int scan_hunk_header(const char *p, in=
t *p_before, int *p_after)
     =20
    - #define GOPID_STABLE   01
    - #define GOPID_VERBATIM 02
    -+#define GOPID_FIND_HEADER 04
    + /*
    +  * flag bits to control get_one_patchid()'s behaviour.
    ++ *
    ++ * STABLE/VERBATIM are given from the command line option as
    ++ * --stable/--verbatim.  FIND_HEADER conveys the internal state
    ++ * maintained by the caller to allow the function to avoid mistakin=
g
    ++ * lines of log message before seeing the "diff" part as the beginn=
ing
    ++ * of the next patch.
    +  */
    + enum {
    + 	GOPID_STABLE =3D (1<<0),		/* --stable */
    + 	GOPID_VERBATIM =3D (1<<1),	/* --verbatim */
    ++	GOPID_FIND_HEADER =3D (1<<2),	/* stop at the beginning of patch me=
ssage */
    + };
     =20
      static int get_one_patchid(struct object_id *next_oid, struct objec=
t_id *result,
    - 			   struct strbuf *line_buf, unsigned flags)
    +@@ builtin/patch-id.c: static int get_one_patchid(struct object_id *=
next_oid, struct object_id *result,
      {
      	int stable =3D flags & GOPID_STABLE;
      	int verbatim =3D flags & GOPID_VERBATIM;
--=20
2.46.0-69-gd0749fd195

