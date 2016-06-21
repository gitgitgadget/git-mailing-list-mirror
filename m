Return-Path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AD3611F744
	for <e@80x24.org>; Tue, 21 Jun 2016 10:40:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751537AbcFUKj2 (ORCPT <rfc822;e@80x24.org>);
	Tue, 21 Jun 2016 06:39:28 -0400
Received: from mout.gmx.net ([212.227.15.18]:51497 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751380AbcFUKgE (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Jun 2016 06:36:04 -0400
Received: from virtualbox ([37.24.143.194]) by mail.gmx.com (mrgmx001) with
 ESMTPSA (Nemesis) id 0M8eAd-1bblvh36eZ-00w9z2; Tue, 21 Jun 2016 12:35:26
 +0200
Date:	Tue, 21 Jun 2016 12:35:26 +0200 (CEST)
From:	Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:	git@vger.kernel.org
cc:	Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v3 9/9] format-patch: use stdout directly
In-Reply-To: <cover.1466505222.git.johannes.schindelin@gmx.de>
Message-ID: <2b9fb9fcc8aa1159e4386b99940185019cba3e4a.1466505223.git.johannes.schindelin@gmx.de>
References: <cover.1466420060.git.johannes.schindelin@gmx.de> <cover.1466505222.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:EtrENOaiUlfzf5scTKH19AhE5Mqb+XsaFnxH2nREZWtNP9Qbqze
 P4r9f2bN4Kd7em9+MG+p3q8dRpD40SzcuRpP2C20VXeuYGEdMue3qA0htSihcYpL4rXHzX/
 Y7QuWwjJjyEaUP7/UbEZ2t9JCvPkOxM69VMwssfsy11HN5PhdZWvelgyyEPF5VlgxJBiGi9
 zulS7c0S85/T335afIi/w==
X-UI-Out-Filterresults:	notjunk:1;V01:K0:BBaMlqx3rAc=:jW1ABT8PeMFRsBqGDFViGa
 CNNjKc3vG7Ic84FUg2mmimSFEb/0F/6VfTiXOUa7wHUrbI3Z/njoF8F4K+xJB8jjmv/1vPrZ6
 jRpX2AVRFVGYiPjHccTKAt3sr+z3zniBEjmrOR6tY2z1eGEW3AIKL4crhwpV84eVFp48b74rt
 6jfzo6HmiXDBadFqNaRyS66vIx7UszbJ6si8iNM9XzNkAHfYhS2iKavEtg587sGec9iI280Oq
 +iPJpOxQbRExgzDx2rAYal+n3DkjXFAQ33MBZPB3PAm4qlqAqNZyAtzJxA7uN5O8tebzUSG3i
 lBdt1eqrsrQzDDm3dx712mCk/wBtVACvxaP97kQHd7lsWZKE0aIdS3pkfo8nYyP42zOgN6kdG
 lMSrpudD0Xh3vKcpYWh4Ke2ubUGPdi7oXU7jwLEJr0QlmlDAJwCYDdVd/XGZAQhuinzt9Feyd
 Xt643JaB/e/eir1Z7sauf1rHpbvzzYyb5Kun15T9nLqIPODm82bp2TfzQKFUyiqnUa9Xs9xY1
 Dy43PuQXCjN+l4Qq/2u6TJUqEU1+uBM+oQe0j5RYyC4zgyq5lpEeFPLikAdv7jg4Gfsiygdmc
 gSeV/n8lfYE31+zsMkQlvGkuzeCPgi6rwk7hccFQISpyHb3309yJh1mBf7ExdGozEHTXdIpAN
 hcmLQVbjTsXQUBH4PxDkpFF+7dLYrNRcMrH+cJTqB63sQrrd/rjaQmrwToZUbin/kqP9qIVu1
 I2RTbJiGle5zCXcRZZr/MZzByA77DBB8rHPwrqF6rKsQY9TXKkboSwMMbkLaBaa0i0iPy18dv
 tLclSgQ
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
index 8dcf205..2bfcc43 100644
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
2.9.0.118.g0e1a633
