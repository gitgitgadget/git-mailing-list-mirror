Return-Path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 55D342018B
	for <e@80x24.org>; Wed, 22 Jun 2016 15:03:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752786AbcFVPCy (ORCPT <rfc822;e@80x24.org>);
	Wed, 22 Jun 2016 11:02:54 -0400
Received: from mout.gmx.net ([212.227.15.18]:50056 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751973AbcFVPCJ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Jun 2016 11:02:09 -0400
Received: from virtualbox ([37.24.143.194]) by mail.gmx.com (mrgmx003) with
 ESMTPSA (Nemesis) id 0MAyVY-1b80QC42HU-009xSq; Wed, 22 Jun 2016 17:02:05
 +0200
Date:	Wed, 22 Jun 2016 17:02:04 +0200 (CEST)
From:	Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:	git@vger.kernel.org
cc:	Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v4 08/10] format-patch: use stdout directly
In-Reply-To: <cover.1466607667.git.johannes.schindelin@gmx.de>
Message-ID: <35a00cad311766d2bc64dada92e14c163e5a5806.1466607667.git.johannes.schindelin@gmx.de>
References: <cover.1466505222.git.johannes.schindelin@gmx.de> <cover.1466607667.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:ZHKadIQe9cabkbKvcKu/BfS5ZrGgkf921kFBneIkqszrbM5869w
 M1uFPdHgeFZ5YnXP9ju4HCuShJ0nVZE/OI+YHpCk1A0C91rZMABNvrMnPRRRbbSlKhTukU1
 bDk4xBDj7+eHOyRxds8Oj2z4J2mTtqsFQvYTWtI/GF0536PBZRPi9Y7pGNkr4TTqYtNSccS
 a3i9ukWtTFxcsQ5f9VXQg==
X-UI-Out-Filterresults:	notjunk:1;V01:K0:Lzh0AFt6hIk=:GDJJSLDlhtRAbwdrVXkLt0
 u1u4anNZ4MFe4Nk7KDEzxfUomqMef4A7uPiX079MVkjWxpzx9oA9yaR8/5TlgdZLKweOAZxB6
 9I60Y5M4ZMaZqlhkZjGnlkiXLBspCq7vwV4lv6velh7m6a6lATbWfS7GQiUUSFfxPAA904CLk
 J457vSELSAkltWXoju/rlQP5NgL8IxgqqW8UF/xfWlY4XqweDXzWPn1yG95IUqyxcQuzILHQS
 9xJiqTrIKQ28mPlsHB6ldiIstfpXkHCI1Vo6TQpqIYIawU9x+2AwQRVhAXMikVvdj8JaOhQrY
 RbzJCrKAn6SY0xVphUgF8W2CUkGbSDr+CDBF4pfERYH9tHhoSGIxW7lwLx2pF2ooQhk2uddDk
 W+ep/PxZzBugHv0X1o6B2MDbZalcAmhC4NMalMhaFWRgu09wDCDLFwzZZG6sGNkQX6O4otAj5
 Q40qn5FceNiiJLFMxtWZ4t0nPmeIIv0QBqd119Js43yzn+n8JTHxvUrQglMTMEfT2B8piwC0e
 5dVQlpjSYEk540OiVEudEJVPCwWfygtxPAkesSBLFq+s7pTHCqu1Rz/YnZ+XAt8Dr1uf/z7KY
 /MfiicemWWOi32c+gb14qJ4qyNe/ocGhQkcGb6mPpiY0LUajpjGERwUHDl/ovmJ9xpUIxKmsJ
 plWtnnoH2N2jFy86fSjXYZl3xXCP5xniFDo7DR4rvIFBCFZnsMzEhNUgyUM7Rxv1z/C6P7ONw
 9V/udPdU2BD+4Iemsl0isHjuuXvTc5RzHRI0PJXHQeU8z2iPuHYhS1B+F9ZTwHpW5bPwqNUDT
 VZF8GpG
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Earlier, we freopen()ed stdout in order to write patches to files.
That forced us to duplicate stdout (naming it "realstdout") because we
*still* wanted to be able to report the file names.

As we do not abuse stdout that way anymore, we no longer need to
duplicate stdout, either.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 builtin/log.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/builtin/log.c b/builtin/log.c
index 869c23b..2a42216 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -805,7 +805,6 @@ static int git_format_config(const char *var, const char *value, void *cb)
 	return git_log_config(var, value, cb);
 }
 
-static FILE *realstdout = NULL;
 static const char *output_directory = NULL;
 static int outdir_offset;
 
@@ -831,7 +830,7 @@ static int open_next_file(struct commit *commit, const char *subject,
 		fmt_output_subject(&filename, subject, rev);
 
 	if (!quiet)
-		fprintf(realstdout, "%s\n", filename.buf + outdir_offset);
+		printf("%s\n", filename.buf + outdir_offset);
 
 	if ((rev->diffopt.file = fopen(filename.buf, "w")) == NULL)
 		return error(_("Cannot open patch file %s"), filename.buf);
@@ -1639,9 +1638,6 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 		get_patch_ids(&rev, &ids);
 	}
 
-	if (!use_stdout)
-		realstdout = xfdopen(xdup(1), "w");
-
 	if (prepare_revision_walk(&rev))
 		die(_("revision walk setup failed"));
 	rev.boundary = 1;
-- 
2.9.0.118.g0e1a633


