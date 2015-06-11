From: Augie Fackler <augie@google.com>
Subject: [PATCH] fetch-pack: optionally save packs to disk
Date: Thu, 11 Jun 2015 13:44:36 -0400
Message-ID: <1434044676-2942-1-git-send-email-augie@google.com>
Cc: Augie Fackler <augie@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 11 19:45:00 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z36XC-0004Mn-Ux
	for gcvg-git-2@plane.gmane.org; Thu, 11 Jun 2015 19:44:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933515AbbFKRoq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Jun 2015 13:44:46 -0400
Received: from mail-ig0-f173.google.com ([209.85.213.173]:38867 "EHLO
	mail-ig0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754658AbbFKRom (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Jun 2015 13:44:42 -0400
Received: by igblz2 with SMTP id lz2so9911134igb.1
        for <git@vger.kernel.org>; Thu, 11 Jun 2015 10:44:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=HaWoMP+z8ZdpLe5KmlMemJxRdyj1LG+PyF0BBkEezCw=;
        b=gp0MWxrdeW/7n51iPSNr/pyfCmZB4QMmPloDls332/jdAt00whEc2+QKW3oCGp6td9
         Ngir7HNAp8K/MnjOg8oGdCLykX9feBcC+Er/3HvGgxJt06AlxoNbDA9m3c2k1iD/t79o
         NRl9MrYOKUfEFLfiRJC3VY/MvPq8+9YYxmrE8lUryPj6egYEb79Jj47Mp2a6g3Xmw+8L
         /5mHGP5eyyuvSY6bUQSEOsEPjSQ7jOceSEZQ9ZfmyvcjbJykMuJcrJ80JpIo2tobAUDE
         hbEelH2Bv4OhunQ2FkZ+Ca9esKtEKQffF1vIu3JWWZ4BMJZHDpbscV4+GDfrOsHTvvXm
         wbcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=HaWoMP+z8ZdpLe5KmlMemJxRdyj1LG+PyF0BBkEezCw=;
        b=JWJO9mXPrcNeff3Ef+3WYr3RTUoW6AoEQ7PT/Mpnv4EmHWysEdarjKbvq3YKLevSiK
         nm9GKS3VqJAjX0Cnk3zeaztEiGcYavLmg4phsUAExW8Xv3BK9SDXgQTdlcGbfb67HsBl
         K8V0H0OIIEJ8c2AXCZwgL3CzLLh8/qIKwL61H+XbBvkZSFTgtUjYCmSQEsgqht9iFzHg
         s7T976EoYx6ggDmX6WwI3X+HLz6gT4m8nQWhX9hCh05Id2AGmZDLW0W7PiaTvLd0U3pK
         5pei1zOYLNCmXN2ojvw8721829mruzk+eo+qH472uCe7Epjz0ggcCrL3n4FnddLxlSWf
         a26w==
X-Gm-Message-State: ALoCoQmnjsnmhuTQmAvsLxHrgqMubuVwBk5G0X5VkYx29LvagQt1AmX4X2n8LXB8SVqcljnPNX2a
X-Received: by 10.42.48.9 with SMTP id q9mr9044879icf.21.1434044681435;
        Thu, 11 Jun 2015 10:44:41 -0700 (PDT)
Received: from arthedain.pit.corp.google.com ([172.29.6.88])
        by mx.google.com with ESMTPSA id x4sm796698iod.26.2015.06.11.10.44.40
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 11 Jun 2015 10:44:40 -0700 (PDT)
X-Mailer: git-send-email 2.4.3.369.gda395ba.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271444>

When developing server software, it's often helpful to save a
potentially-bogus pack for later analysis. This makes that trivial,
instead of painful. This is made a little complicated by the fact that
in some cases (like cloning from smart-http, but not from a local repo)
the fetch code reads the pack header before sending the pack to
index-pack (which then gets a --pack_header flag). The included tests
cover both of these cases.

To use the new feature, set GIT_SAVE_FETCHED_PACK_TO to a file path and
git-fetch will do the rest. The resulting pack can be examined with
git-index-pack or similar tools (although if it's corrupt, custom tools
can be especially helpful.)
---
 fetch-pack.c                | 44 ++++++++++++++++++++++++++++++++++++++++----
 t/t5551-http-fetch-smart.sh | 12 ++++++++++++
 t/t5601-clone.sh            |  9 +++++++++
 3 files changed, 61 insertions(+), 4 deletions(-)

diff --git a/fetch-pack.c b/fetch-pack.c
index a912935..fe6ba58 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -684,7 +684,7 @@ static int get_pack(struct fetch_pack_args *args,
 	const char *argv[22];
 	char keep_arg[256];
 	char hdr_arg[256];
-	const char **av, *cmd_name;
+	const char **av, *cmd_name, *savepath;
 	int do_keep = args->keep_pack;
 	struct child_process cmd = CHILD_PROCESS_INIT;
 	int ret;
@@ -708,9 +708,8 @@ static int get_pack(struct fetch_pack_args *args,
 	cmd.argv = argv;
 	av = argv;
 	*hdr_arg = 0;
+	struct pack_header header;
 	if (!args->keep_pack && unpack_limit) {
-		struct pack_header header;
-
 		if (read_pack_header(demux.out, &header))
 			die("protocol error: bad pack header");
 		snprintf(hdr_arg, sizeof(hdr_arg),
@@ -762,7 +761,44 @@ static int get_pack(struct fetch_pack_args *args,
 		*av++ = "--strict";
 	*av++ = NULL;
 
-	cmd.in = demux.out;
+	savepath = getenv("GIT_SAVE_FETCHED_PACK_TO");
+	if (savepath) {
+		struct child_process cmd2 = CHILD_PROCESS_INIT;
+		const char *argv2[22];
+		int pipefds[2];
+		int e;
+		const char **av2;
+		cmd2.argv = argv2;
+		av2 = argv2;
+		*av2++ = "tee";
+		if (*hdr_arg) {
+			/* hdr_arg being nonempty means we already read the
+			 * pack header from demux, so we need to drop a pack
+			 * header in place for tee to append to, otherwise
+			 * we'll end up with a broken pack on disk.
+			 */
+			int fp;
+			struct sha1file *s;
+			fp = open(savepath, O_CREAT | O_TRUNC | O_WRONLY, 0666);
+			s = sha1fd_throughput(fp, savepath, NULL);
+			sha1write(s, &header, sizeof(header));
+			sha1flush(s);
+			close(fp);
+			/* -a is supported by both GNU and BSD tee */
+			*av2++ = "-a";
+		}
+		*av2++ = savepath;
+		*av2++ = NULL;
+		cmd2.in = demux.out;
+		e = pipe(pipefds);
+		if (e != 0)
+			die("couldn't make pipe to save pack");
+		cmd2.out = pipefds[1];
+		cmd.in = pipefds[0];
+		if (start_command(&cmd2))
+			die("couldn't start tee to save a pack");
+	} else
+		cmd.in = demux.out;
 	cmd.git_cmd = 1;
 	if (start_command(&cmd))
 		die("fetch-pack: unable to fork off %s", cmd_name);
diff --git a/t/t5551-http-fetch-smart.sh b/t/t5551-http-fetch-smart.sh
index 58207d8..bf4640d 100755
--- a/t/t5551-http-fetch-smart.sh
+++ b/t/t5551-http-fetch-smart.sh
@@ -82,11 +82,23 @@ test_expect_success 'fetch changes via http' '
 	test_cmp file clone/file
 '
 
+test_expect_success 'fetch changes via http and save pack' '
+	echo content >>file &&
+	git commit -a -m two &&
+	git push public &&
+	GIT_SAVE_FETCHED_PACK_TO=saved.pack &&
+	export GIT_SAVE_FETCHED_PACK_TO &&
+	(cd clone && git pull) &&
+	git index-pack clone/saved.pack
+'
+
 cat >exp <<EOF
 GET  /smart/repo.git/info/refs?service=git-upload-pack HTTP/1.1 200
 POST /smart/repo.git/git-upload-pack HTTP/1.1 200
 GET  /smart/repo.git/info/refs?service=git-upload-pack HTTP/1.1 200
 POST /smart/repo.git/git-upload-pack HTTP/1.1 200
+GET  /smart/repo.git/info/refs?service=git-upload-pack HTTP/1.1 200
+POST /smart/repo.git/git-upload-pack HTTP/1.1 200
 EOF
 test_expect_success 'used upload-pack service' '
 	sed -e "
diff --git a/t/t5601-clone.sh b/t/t5601-clone.sh
index bfdaf75..73f9e1c 100755
--- a/t/t5601-clone.sh
+++ b/t/t5601-clone.sh
@@ -40,6 +40,15 @@ test_expect_success C_LOCALE_OUTPUT 'output from clone' '
 	test $(grep Clon output | wc -l) = 1
 '
 
+test_expect_success 'clone allows saving a pack' '
+	rm -fr dst saved.pack &&
+	GIT_SAVE_FETCHED_PACK_TO=saved.pack &&
+	export GIT_SAVE_FETCHED_PACK_TO &&
+	git clone -n "file://$(pwd)/src" dst >output 2>&1 &&
+	test -e saved.pack &&
+	git index-pack saved.pack
+'
+
 test_expect_success 'clone does not keep pack' '
 
 	rm -fr dst &&
-- 
2.4.3.369.gda395ba.dirty
