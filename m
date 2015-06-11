From: Augie Fackler <augie@google.com>
Subject: [PATCH v2] fetch-pack: optionally save packs to disk
Date: Thu, 11 Jun 2015 14:59:28 -0400
Message-ID: <1434049168-10613-1-git-send-email-augie@google.com>
References: <CAGZ79kaS4utvDbXOo7emmSUH6M-8LY-oA65Ss3PLDkFModkbSg@mail.gmail.com>
Cc: Stefan Beller <sbeller@google.com>,
	Junio C Hamano <gitster@pobox.com>,
	Augie Fackler <augie@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 11 20:59:56 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z37hf-0006J0-8O
	for gcvg-git-2@plane.gmane.org; Thu, 11 Jun 2015 20:59:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753817AbbFKS7o (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Jun 2015 14:59:44 -0400
Received: from mail-ig0-f181.google.com ([209.85.213.181]:35081 "EHLO
	mail-ig0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752266AbbFKS7n (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Jun 2015 14:59:43 -0400
Received: by igbzc4 with SMTP id zc4so61220356igb.0
        for <git@vger.kernel.org>; Thu, 11 Jun 2015 11:59:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=7JuS5ONFphPWZGNHZp0Y/EaTgmNEqvQMLL1+/epJr/s=;
        b=fGjjSQVs3u+zOpnFI/rBAFf+f8Dn+IAPb90QAjCN6rYzSR/palj4sHP7Q+56qyiHu6
         hQ/r40fy4x4hIIeXXDNQpbLwjm5qlV8R+dcu6tzvOLsevVzR3kS0Y2/wMWstbKfna2j3
         Zto2A3aqJ7Bl499mnxeidR49J2yJkWRAXt2vAY7BceuY0685udUN3aqlWS0mOx2aNJXU
         ar2+KyrnR3xCSj7hXMLW8OT97RaIfg2B23ZWgQx+QcFkIo7ZndQ386G2T1sllZRjBWJu
         NyPNvb5Me2fq9ynHoJNfbja2xPlS9JKjxrP8p6dafEtV4x1BGouhBnCmCK0N9w1BqKTL
         Spdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=7JuS5ONFphPWZGNHZp0Y/EaTgmNEqvQMLL1+/epJr/s=;
        b=TJgbwqtSBkPN+qtOJyFCwrIUQDTcziYZsexQe0D1cjzE4onjjGEi1aomBQEMEpK8ar
         cyePnEuFjSII1xtLFmu+Lh7IdNb/orjgyDPVryTTRywwZA4Z44tiGPA+hLfs6mIvSALB
         DUlQKpaR6ryzGJc8lGPzroDYTxuu+5h1ksjqzoVbraOFqkixfpkYPR2cFzRVA3oyvr71
         LH130qF7ZDKm/sGoH2CR4CmTPxu+5iuDMBXhhz+oXWfPLRtQ22KNOYBzCuHgr/nEZWtC
         PGj/mXjbdvr6XLMkd+L3niKXlhJeR7FLRzU/bS0dtDSep9N3gs7X1p9Z4Zh4MqiWi3zq
         5TVA==
X-Gm-Message-State: ALoCoQkuqam04dQYFGQrGSk+8da1HBR5rcm6u2M0KDHeCt2MKlwqT3sL/lU1+NrKKAfDesJt6KeK
X-Received: by 10.50.143.99 with SMTP id sd3mr14751218igb.23.1434049181971;
        Thu, 11 Jun 2015 11:59:41 -0700 (PDT)
Received: from arthedain.pit.corp.google.com ([172.29.6.88])
        by mx.google.com with ESMTPSA id d8sm1096802igl.19.2015.06.11.11.59.40
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 11 Jun 2015 11:59:40 -0700 (PDT)
X-Mailer: git-send-email 2.4.3.369.gda395ba.dirty
In-Reply-To: <CAGZ79kaS4utvDbXOo7emmSUH6M-8LY-oA65Ss3PLDkFModkbSg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271451>

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

Signed-off-by: Augie Fackler <augie@google.com>
---
 Documentation/git.txt       |  6 ++++++
 fetch-pack.c                | 44 ++++++++++++++++++++++++++++++++++++++++----
 t/t5551-http-fetch-smart.sh | 12 ++++++++++++
 t/t5601-clone.sh            |  9 +++++++++
 4 files changed, 67 insertions(+), 4 deletions(-)

diff --git a/Documentation/git.txt b/Documentation/git.txt
index 45b64a7..31bc3b5 100644
--- a/Documentation/git.txt
+++ b/Documentation/git.txt
@@ -1060,6 +1060,12 @@ GIT_ICASE_PATHSPECS::
 	an operation has touched every ref (e.g., because you are
 	cloning a repository to make a backup).
 
+`GIT_SAVE_FETCHED_PACK_TO`::
+	If set, save any fetched pack to the path in the
+	variable. This is mostly useful if you're writing a custom
+	server and are producing broken packs, as the saved pack won't
+	be cleaned up even if it's corrupt.
+
 
 Discussion[[Discussion]]
 ------------------------
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
