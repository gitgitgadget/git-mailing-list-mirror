Return-Path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6327620179
	for <e@80x24.org>; Mon, 20 Jun 2016 10:59:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932373AbcFTK7q (ORCPT <rfc822;e@80x24.org>);
	Mon, 20 Jun 2016 06:59:46 -0400
Received: from mout.gmx.net ([212.227.15.15]:50857 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754576AbcFTK7g (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Jun 2016 06:59:36 -0400
Received: from virtualbox ([37.24.143.194]) by mail.gmx.com (mrgmx001) with
 ESMTPSA (Nemesis) id 0MGS9o-1bAbLm1ugi-00DInO; Mon, 20 Jun 2016 12:59:22
 +0200
Date:	Mon, 20 Jun 2016 12:56:01 +0200 (CEST)
From:	Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:	git@vger.kernel.org
cc:	Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v2 7/7] format-patch: use stdout directly
In-Reply-To: <cover.1466420060.git.johannes.schindelin@gmx.de>
Message-ID: <d486373d9eb2bd248a80b6be7061b56db2f148aa.1466420060.git.johannes.schindelin@gmx.de>
References: <cover.1466244194.git.johannes.schindelin@gmx.de> <cover.1466420060.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:xurxrVmPPM3rdS9uklUxQr8tRACYtFm+f+7qtAYXRM50V6lnAOv
 rhf8cV6kGHQAT7kUuHRinfaIhXddQEE6LtgfUFv2no/41To+YvRwv85jdWB8JZMSqxhlTjE
 ogmubu1ozI3wz4oggSy5fyw6BS7ubYnU7xtriW6OY6EN4ZMGJy/4Yqw9gixpLny91Tz3nB2
 Velc96CqKaSy0r70O8wQw==
X-UI-Out-Filterresults:	notjunk:1;V01:K0:hlOxHWQLp7k=:YjUZAHRcL30m/UYXGSPFX1
 DR6HPXO8+yrwCk2scfDy9VKUe8/jP3wFv1d3hJKaN2qzUrYHhhbXUCJT6dsJ8OE9Uc8hwKO4O
 9swXm0pLw945OYOGPLDyG9HoQBvO5yNUEhVMljxfthnm5Hrc+656WuYjVCTYFP4nJ6rAsqRKJ
 Wfrqa/o40/J1IlhPdYmVptChvt9vZxsW2B2BtQpO0wPxZ5MNa9iqXUwyyiBaeDdoVi0P579pM
 FMjrNaC43u6PmA5hasBOeoYMrrSDfA/Q1tuIVxw6EIosiUEn3tQmlliHZs2DQ+dudo3Ir4nsc
 LSR6zY7a6CaUkOsz9OrQdUHhfstmo2G0JsPAgduqeoIHSwPgG6GDtxl46hbmbpxZ0FAKX3gpI
 haeFjzJCe0VgqTRxAq72jLlYvzlQBaNZtNxvUqeGHHDn2/2DQdwNGqNkkMCaAj6jv4UnrlJPC
 jHHCW1Ra72hiwqYWGhxmJXktQCNbdlYfYDwojSdqOHnliJGSnc9JOmDPcfWb6/1lOGe1m7kdp
 qvAX776M8ucIKoiOEWnlkAE1tL226umxsieFWfiS8roHJM9WLED7haksGJzZ416vXnZt+tXer
 P5I0fdK/pnR1xxZyi1II17ZsFC2x02BUfYwvI/XXNvhGLKcghFg3hSpiM1DNZAeVcUmB0NBON
 044xxp0FILOgIc9xVweJrslZnZm+Fh43/I1IMTQUMOYIeTEcEuNi3vIEJmMXvEQ0cbD7Fvt1w
 p05FpIRJqA3S+hWM773KE1xoGPL57W39mR7MD5AmlhfKcgO9LRqTEojJAuKLRMrjFnXXk+JxR
 kX7bgRo
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
index db034a8..5a889d5 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -796,7 +796,6 @@ static int git_format_config(const char *var, const char *value, void *cb)
 	return git_log_config(var, value, cb);
 }
 
-static FILE *realstdout = NULL;
 static const char *output_directory = NULL;
 static int outdir_offset;
 
@@ -822,7 +821,7 @@ static int open_next_file(struct commit *commit, const char *subject,
 		fmt_output_subject(&filename, subject, rev);
 
 	if (!quiet)
-		fprintf(realstdout, "%s\n", filename.buf + outdir_offset);
+		printf("%s\n", filename.buf + outdir_offset);
 
 	if ((rev->diffopt.file = fopen(filename.buf, "w")) == NULL)
 		return error(_("Cannot open patch file %s"), filename.buf);
@@ -1629,9 +1628,6 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 		get_patch_ids(&rev, &ids);
 	}
 
-	if (!use_stdout)
-		realstdout = xfdopen(xdup(1), "w");
-
 	if (prepare_revision_walk(&rev))
 		die(_("revision walk setup failed"));
 	rev.boundary = 1;
-- 
2.9.0.119.g370c5a9
