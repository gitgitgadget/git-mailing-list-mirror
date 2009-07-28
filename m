From: Geoffrey Irving <irving@naml.us>
Subject: [PATCH] git fast-export: add --no-data option
Date: Mon, 27 Jul 2009 22:20:22 -0400
Message-ID: <7f9d599f0907271920y58709842v1316758aa2a23e20@mail.gmail.com>
References: <7f9d599f0907250645s6e6f9b81w3cf20f07eff088eb@mail.gmail.com> 
	<7vfxcku13i.fsf@alter.siamese.dyndns.org> <alpine.DEB.1.00.0907251942390.8306@pacific.mpi-cbg.de> 
	<7f9d599f0907270548k15c51a01j1fedba20c66b66f6@mail.gmail.com> 
	<alpine.DEB.1.00.0907272042450.6883@intel-tinevez-2-302>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Jul 28 04:28:56 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MVcQn-0006J7-5P
	for gcvg-git-2@gmane.org; Tue, 28 Jul 2009 04:28:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752120AbZG1C2i (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 27 Jul 2009 22:28:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752099AbZG1C2h
	(ORCPT <rfc822;git-outgoing>); Mon, 27 Jul 2009 22:28:37 -0400
Received: from qw-out-2122.google.com ([74.125.92.26]:47663 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751795AbZG1C2g (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Jul 2009 22:28:36 -0400
Received: by qw-out-2122.google.com with SMTP id 8so1885932qwh.37
        for <git@vger.kernel.org>; Mon, 27 Jul 2009 19:28:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:sender:received:in-reply-to
         :references:from:date:x-google-sender-auth:message-id:subject:to:cc
         :content-type:content-transfer-encoding;
        bh=Ddhc5y8VJlo6HjVKG8uR4tOsfQ8tP4OyWqwZ5w2qMYo=;
        b=m2ywKMe0tZIWDANSRHcMHBPIdan/MwZYNAy5fefcQ7BL/62UHUFf15l7swXm/GS6LA
         sCAZLGz281KlwartSyyem6/5SjPysNauAPDnPgKTA28jto5V6Rse1PWHtvJoj3SpMB9O
         ShXKYKkkKTnso1at+C7YHZfK+xZlU2IoFkUao=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:from:date
         :x-google-sender-auth:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        b=AXYwig7/zt/NBmhLiYLU39d3JEwEspfC9B3IqCU5k2fChQprQ3Oj+Whz57Z225A1aO
         ZTgphbJhL/hiz9v+t2FSVfY06uWmRkdpvrtV8qBCD3DiR3aU3+/Fj7uC9+FYb8wSEx2L
         js0pWPuYwsEzvWUELCylhDa81RG3vApXSl5cA=
Received: by 10.220.76.73 with SMTP id b9mr4282505vck.85.1248747642506; Mon, 
	27 Jul 2009 19:20:42 -0700 (PDT)
In-Reply-To: <alpine.DEB.1.00.0907272042450.6883@intel-tinevez-2-302>
X-Google-Sender-Auth: f650792a4edf1e82
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124207>

When using git fast-export and git fast-import to rewrite the history
of a repository with large binary files, almost all of the time is
spent dealing with blobs.  This is extremely inefficient if all we want
to do is rewrite the commits and tree structure.  --no-data skips the
output of blobs and writes SHA-1s instead of marks, which provides a
massive speedup.

Signed-off-by: Geoffrey Irving <irving@naml.us>
---

Here's my modified patch on top of Johannes' fix to parse-options.  On github:

    http://github.com/girving/git/commit/98549f6809a4dc22d088f3c2ee1f798e858cce3e
    http://github.com/girving/git/commit/00a7c591b9a1fc6880ad5f88d118bb1d6ea86878

 Documentation/git-fast-export.txt |    7 +++++++
 builtin-fast-export.c             |    9 ++++++++-
 2 files changed, 15 insertions(+), 1 deletions(-)

diff --git a/Documentation/git-fast-export.txt
b/Documentation/git-fast-export.txt
index 0c9eb56..47a96dd 100644
--- a/Documentation/git-fast-export.txt
+++ b/Documentation/git-fast-export.txt
@@ -71,6 +71,13 @@ marks the same across runs.
 	allow that.  So fake a tagger to be able to fast-import the
 	output.

+--no-data::
+	Skip output of blob objects and instead refer to blobs via
+	their original SHA-1 hash.  This is useful when rewriting the
+	directory structure or history of a repository without
+	touching the contents of individual files.  Note that the
+	resulting stream can only be used by a repository which
+	already contains the necessary objects.

 EXAMPLES
 --------
diff --git a/builtin-fast-export.c b/builtin-fast-export.c
index 9a8a6fc..a0f0284 100644
--- a/builtin-fast-export.c
+++ b/builtin-fast-export.c
@@ -25,6 +25,7 @@ static const char *fast_export_usage[] = {
 static int progress;
 static enum { VERBATIM, WARN, STRIP, ABORT } signed_tag_mode = ABORT;
 static int fake_missing_tagger;
+static int no_data;

 static int parse_opt_signed_tag_mode(const struct option *opt,
 				     const char *arg, int unset)
@@ -101,6 +102,9 @@ static void handle_object(const unsigned char *sha1)
 	char *buf;
 	struct object *object;

+	if (no_data)
+		return;
+
 	if (is_null_sha1(sha1))
 		return;

@@ -158,7 +162,7 @@ static void show_filemodify(struct diff_queue_struct *q,
 			 * Links refer to objects in another repositories;
 			 * output the SHA-1 verbatim.
 			 */
-			if (S_ISGITLINK(spec->mode))
+			if (no_data || S_ISGITLINK(spec->mode))
 				printf("M %06o %s %s\n", spec->mode,
 				       sha1_to_hex(spec->sha1), spec->path);
 			else {
@@ -504,6 +508,9 @@ int cmd_fast_export(int argc, const char **argv,
const char *prefix)
 			     "Import marks from this file"),
 		OPT_BOOLEAN(0, "fake-missing-tagger", &fake_missing_tagger,
 			     "Fake a tagger when tags lack one"),
+		{ OPTION_NEGBIT, 0, "data", &no_data, NULL,
+			"Skip output of blob data",
+			PARSE_OPT_NOARG | PARSE_OPT_NEGHELP, NULL, 1 },
 		OPT_END()
 	};

-- 
1.6.3.1
