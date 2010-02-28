From: Bert Wesarg <bert.wesarg@googlemail.com>
Subject: [PATCH 2/3] make union merge an xdl merge favor
Date: Sun, 28 Feb 2010 20:56:20 +0100
Message-ID: <17999fdb3ff374156acb7fc670426265fa27b94b.1267385538.git.bert.wesarg@googlemail.com>
References: <972adf380be481b5e8d031481586e9c34da2cbb7.1267385538.git.bert.wesarg@googlemail.com>
Cc: Bert Wesarg <bert.wesarg@googlemail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Feb 28 20:56:51 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NlpFy-0003MC-Ay
	for gcvg-git-2@lo.gmane.org; Sun, 28 Feb 2010 20:56:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031942Ab0B1T4o (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 28 Feb 2010 14:56:44 -0500
Received: from mail-fx0-f219.google.com ([209.85.220.219]:36989 "EHLO
	mail-fx0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1031931Ab0B1T4n (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 28 Feb 2010 14:56:43 -0500
Received: by fxm19 with SMTP id 19so120810fxm.21
        for <git@vger.kernel.org>; Sun, 28 Feb 2010 11:56:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:in-reply-to:references;
        bh=/4YtRkR5QiSyPA+tMhK5+yKrCTZjh+bPrgdASpnAwJ8=;
        b=frKMWlwb0qUcQ0CPJFlWvlI7JC/yCdhUTmQBvapv99e4EZasBsdN8v60d6pBZW9cem
         rnl7tpLKlXLzG5dK19zPP95K51hmY9eO6ktR/uIsInkFDpuw30nrbX/CPnY4BfUxpLZW
         9O78CDACM/yNL9TeYXOtUsLMGRXpcbq3qWgB0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=x2K22XeplUeeO0ptG4IbDgKDvyn0F5YD/ihCF3Hb/K24c64l/NYyZ29xSepepdIgON
         ve/NtuOzSbf+kkTi+7jF6+7CqEG5HoL111ZSHve8E/KXPGIr52XmmuFawwuSwbPNOhCz
         +uvLws4X1mpdNTQSZ9D6WrgddN6YmKpmjIb2s=
Received: by 10.103.79.36 with SMTP id g36mr2815567mul.60.1267386990124;
        Sun, 28 Feb 2010 11:56:30 -0800 (PST)
Received: from localhost (p5B0F7A0D.dip.t-dialin.net [91.15.122.13])
        by mx.google.com with ESMTPS id j9sm13741627mue.17.2010.02.28.11.56.24
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 28 Feb 2010 11:56:27 -0800 (PST)
X-Mailer: git-send-email 1.7.0.584.g2da2b
In-Reply-To: <972adf380be481b5e8d031481586e9c34da2cbb7.1267385538.git.bert.wesarg@googlemail.com>
In-Reply-To: <972adf380be481b5e8d031481586e9c34da2cbb7.1267385538.git.bert.wesarg@googlemail.com>
References: <972adf380be481b5e8d031481586e9c34da2cbb7.1267385538.git.bert.wesarg@googlemail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141263>

The current union merge driver is implemented as an post process.  But the
xdl_merge code is quite capable to produce the result by itself.  Therefore
move to it there and teach git-merge-file a new --union option.

Signed-off-by: Bert Wesarg <bert.wesarg@googlemail.com>
---
 Documentation/git-merge-file.txt |    2 +-
 builtin-merge-file.c             |    2 +
 ll-merge.c                       |   43 ++++---------------------------------
 xdiff/xdiff.h                    |    1 +
 xdiff/xmerge.c                   |   20 +++++++++++------
 5 files changed, 22 insertions(+), 46 deletions(-)

diff --git a/Documentation/git-merge-file.txt b/Documentation/git-merge-file.txt
index a5b9c1f..11dff6f 100644
--- a/Documentation/git-merge-file.txt
+++ b/Documentation/git-merge-file.txt
@@ -10,7 +10,7 @@ SYNOPSIS
 --------
 [verse]
 'git merge-file' [-L <current-name> [-L <base-name> [-L <other-name>]]]
-	[--ours|--theirs] [-p|--stdout] [-q|--quiet] [--marker-size=<n>]
+	[--ours|--theirs|--union] [-p|--stdout] [-q|--quiet] [--marker-size=<n>]
 	<current-file> <base-file> <other-file>
 
 
diff --git a/builtin-merge-file.c b/builtin-merge-file.c
index 57d757c..f69dad6 100644
--- a/builtin-merge-file.c
+++ b/builtin-merge-file.c
@@ -39,6 +39,8 @@ int cmd_merge_file(int argc, const char **argv, const char *prefix)
 			    XDL_MERGE_FAVOR_OURS),
 		OPT_SET_INT(0, "theirs", &favor, "for conflicts, use their version",
 			    XDL_MERGE_FAVOR_THEIRS),
+		OPT_SET_INT(0, "union", &xmp.favor, "for conflicts, use a union version",
+			    XDL_MERGE_FAVOR_UNION),
 		OPT_INTEGER(0, "marker-size", &xmp.marker_size, "for conflicts, use this marker size"),
 		OPT__QUIET(&quiet),
 		OPT_CALLBACK('L', NULL, names, "name",
diff --git a/ll-merge.c b/ll-merge.c
index 4c7f11b..a4b2f4c 100644
--- a/ll-merge.c
+++ b/ll-merge.c
@@ -98,44 +98,11 @@ static int ll_union_merge(const struct ll_merge_driver *drv_unused,
 			  mmfile_t *src2, const char *name2,
 			  int flag, int marker_size)
 {
-	char *src, *dst;
-	long size;
-	int status, saved_style;
-
-	/* We have to force the RCS "merge" style */
-	saved_style = git_xmerge_style;
-	git_xmerge_style = 0;
-	status = ll_xdl_merge(drv_unused, result, path_unused,
-			      orig, src1, NULL, src2, NULL,
-			      flag, marker_size);
-	git_xmerge_style = saved_style;
-	if (status <= 0)
-		return status;
-	size = result->size;
-	src = dst = result->ptr;
-	while (size) {
-		char ch;
-		if ((marker_size < size) &&
-		    (*src == '<' || *src == '=' || *src == '>')) {
-			int i;
-			ch = *src;
-			for (i = 0; i < marker_size; i++)
-				if (src[i] != ch)
-					goto not_a_marker;
-			if (src[marker_size] != '\n')
-				goto not_a_marker;
-			src += marker_size + 1;
-			size -= marker_size + 1;
-			continue;
-		}
-	not_a_marker:
-		do {
-			ch = *src++;
-			*dst++ = ch;
-			size--;
-		} while (ch != '\n' && size);
-	}
-	result->size = dst - result->ptr;
+	/* Use union favor */
+	flag = (flag & 1) | (XDL_MERGE_FAVOR_UNION << 1);
+	return ll_xdl_merge(drv_unused, result, path_unused,
+			    orig, src1, NULL, src2, NULL,
+			    flag, marker_size);
 	return 0;
 }
 
diff --git a/xdiff/xdiff.h b/xdiff/xdiff.h
index 3f6229e..22614d5 100644
--- a/xdiff/xdiff.h
+++ b/xdiff/xdiff.h
@@ -61,6 +61,7 @@ extern "C" {
 /* merge favor modes */
 #define XDL_MERGE_FAVOR_OURS 1
 #define XDL_MERGE_FAVOR_THEIRS 2
+#define XDL_MERGE_FAVOR_UNION 3
 #define XDL_MERGE_FAVOR(flags) (((flags)>>4) & 3)
 #define XDL_MERGE_FLAGS(level, style, favor) ((level)|(style)|((favor)<<4))
 
diff --git a/xdiff/xmerge.c b/xdiff/xmerge.c
index 8cbe45e..c901ecb 100644
--- a/xdiff/xmerge.c
+++ b/xdiff/xmerge.c
@@ -28,6 +28,7 @@ typedef struct s_xdmerge {
 	 * 0 = conflict,
 	 * 1 = no conflict, take first,
 	 * 2 = no conflict, take second.
+	 * 3 = no conflict, take both.
 	 */
 	int mode;
 	/*
@@ -230,14 +231,19 @@ static int xdl_fill_merge_buffer(xdfenv_t *xe1, const char *name1,
 			size = fill_conflict_hunk(xe1, name1, xe2, name2,
 						  size, i, style, m, dest,
 						  marker_size);
-		else if (m->mode == 1)
-			size += xdl_recs_copy(xe1, i, m->i1 + m->chg1 - i, 0,
+		else if (m->mode & 3) {
+			/* Before conflicting part */
+			size += xdl_recs_copy(xe1, i, m->i1 - i, 0,
 					      dest ? dest + size : NULL);
-		else if (m->mode == 2)
-			size += xdl_recs_copy(xe2, m->i2 - m->i1 + i,
-					      m->i1 + m->chg2 - i, 0,
-					      dest ? dest + size : NULL);
-		else
+			/* Postimage from side #1 */
+			if (m->mode & 1)
+				size += xdl_recs_copy(xe1, m->i1, m->chg1, 1,
+						      dest ? dest + size : NULL);
+			/* Postimage from side #2 */
+			if (m->mode & 2)
+				size += xdl_recs_copy(xe2, m->i2, m->chg2, 1,
+						      dest ? dest + size : NULL);
+		} else
 			continue;
 		i = m->i1 + m->chg1;
 	}
-- 
1.7.0.584.g2da2b
