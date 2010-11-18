From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 1/2] vcs-svn: Error out for v3 dumps
Date: Wed, 17 Nov 2010 23:02:48 -0600
Message-ID: <20101118050248.GB14861@burratino>
References: <20101118050023.GA14861@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	David Barr <david.barr@cordelta.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 18 06:03:39 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PIwen-0003P4-Q6
	for gcvg-git-2@lo.gmane.org; Thu, 18 Nov 2010 06:03:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751068Ab0KRFDc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Nov 2010 00:03:32 -0500
Received: from mail-gw0-f46.google.com ([74.125.83.46]:34829 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750854Ab0KRFDb (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Nov 2010 00:03:31 -0500
Received: by gwj17 with SMTP id 17so1627202gwj.19
        for <git@vger.kernel.org>; Wed, 17 Nov 2010 21:03:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=LgVI2r19pUI4C9o3ecJYM3SaFjf3PNYjz20EwmjyIRo=;
        b=Uoy4r3uDFFERlp7thUiKg0EEqx6wJd2tCmL25zC/IapBDHpGaXqdL2pKqXuHifuJGj
         v1titf45BCwOVlU91EiCh/cRK4Sknx/CUZNp/7HtBDAcXZx7Wn7VyA65bbxN0jvJjcT2
         j02pCjM62b0YxBtwwYWoOMRtkP28mSaZODWiM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=DQIp0jnJzoYT7VK3de1b4SKY5ZYKCHt4NWEzymd2xI1XfL041wnOubQ73Jt5aqFevZ
         e4ZpgzlHltOBDYBpkErmbyfp+rp4cpw9BLT873BDqZ2XNJ5iM9CRzwNouMlCrVbBL6/B
         ozFNroYrPzHIoY+ILzGfAt0gPtc2NZfgmII0g=
Received: by 10.151.156.2 with SMTP id i2mr349826ybo.371.1290056610286;
        Wed, 17 Nov 2010 21:03:30 -0800 (PST)
Received: from burratino ([68.255.106.176])
        by mx.google.com with ESMTPS id v9sm1290825ybe.21.2010.11.17.21.03.28
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 17 Nov 2010 21:03:29 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20101118050023.GA14861@burratino>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161648>

By ignoring the Text-Delta and Prop-Delta node fields, current svn-fe
happily mistakes deltas for full text and instead of cleanly erroring
out, it produces a valid but semantically bogus fast-import stream
when fed a dump file in the modern "svnadmin dump --deltas" format.

Dump file parsers are supposed to ignore header fields they don't
understand (to allow for backward-compatible extensions), but they are
also supposed to check the SVN-fs-dump-format-version header to
prevent misinterpretation of non backward-compatible extensions.
Do so.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 t/t9010-svn-fe.sh |   59 +++++++++++++++++++++++++++++++++-------------------
 vcs-svn/svndump.c |   13 +++++++++--
 2 files changed, 47 insertions(+), 25 deletions(-)

diff --git a/t/t9010-svn-fe.sh b/t/t9010-svn-fe.sh
index a713dfc..e9e46ea 100755
--- a/t/t9010-svn-fe.sh
+++ b/t/t9010-svn-fe.sh
@@ -4,29 +4,44 @@ test_description='check svn dumpfile importer'
 
 . ./lib-git-svn.sh
 
-test_dump() {
-	label=$1
-	dump=$2
-	test_expect_success "$dump" '
-		svnadmin create "$label-svn" &&
-		svnadmin load "$label-svn" < "$TEST_DIRECTORY/$dump" &&
-		svn_cmd export "file://$PWD/$label-svn" "$label-svnco" &&
-		git init "$label-git" &&
-		test-svn-fe "$TEST_DIRECTORY/$dump" >"$label.fe" &&
-		(
-			cd "$label-git" &&
-			git fast-import < ../"$label.fe"
-		) &&
-		(
-			cd "$label-svnco" &&
-			git init &&
-			git add . &&
-			git fetch "../$label-git" master &&
-			git diff --exit-code FETCH_HEAD
-		)
-	'
+reinit_git () {
+	rm -fr .git &&
+	git init
 }
 
-test_dump simple t9135/svn.dump
+>empty
+
+test_expect_success 'empty dump' '
+	reinit_git &&
+	echo "SVN-fs-dump-format-version: 2" >input &&
+	test-svn-fe input >stream &&
+	git fast-import <stream
+'
+
+test_expect_success 'v3 dumps not supported' '
+	reinit_git &&
+	echo "SVN-fs-dump-format-version: 3" >input &&
+	test_must_fail test-svn-fe input >stream &&
+	test_cmp empty stream
+'
+
+test_expect_success 't9135/svn.dump' '
+	svnadmin create simple-svn &&
+	svnadmin load simple-svn <"$TEST_DIRECTORY/t9135/svn.dump" &&
+	svn_cmd export "file://$PWD/simple-svn" simple-svnco &&
+	git init simple-git &&
+	test-svn-fe "$TEST_DIRECTORY/t9135/svn.dump" >simple.fe &&
+	(
+		cd simple-git &&
+		git fast-import <../simple.fe
+	) &&
+	(
+		cd simple-svnco &&
+		git init &&
+		git add . &&
+		git fetch ../simple-git master &&
+		git diff --exit-code FETCH_HEAD
+	)
+'
 
 test_done
diff --git a/vcs-svn/svndump.c b/vcs-svn/svndump.c
index 53d0215..fa580e6 100644
--- a/vcs-svn/svndump.c
+++ b/vcs-svn/svndump.c
@@ -51,14 +51,14 @@ static struct {
 } rev_ctx;
 
 static struct {
-	uint32_t uuid, url;
+	uint32_t version, uuid, url;
 } dump_ctx;
 
 static struct {
 	uint32_t svn_log, svn_author, svn_date, svn_executable, svn_special, uuid,
 		revision_number, node_path, node_kind, node_action,
 		node_copyfrom_path, node_copyfrom_rev, text_content_length,
-		prop_content_length, content_length;
+		prop_content_length, content_length, svn_fs_dump_format_version;
 } keys;
 
 static void reset_node_ctx(char *fname)
@@ -85,6 +85,7 @@ static void reset_rev_ctx(uint32_t revision)
 static void reset_dump_ctx(uint32_t url)
 {
 	dump_ctx.url = url;
+	dump_ctx.version = 1;
 	dump_ctx.uuid = ~0;
 }
 
@@ -105,6 +106,7 @@ static void init_keys(void)
 	keys.text_content_length = pool_intern("Text-content-length");
 	keys.prop_content_length = pool_intern("Prop-content-length");
 	keys.content_length = pool_intern("Content-length");
+	keys.svn_fs_dump_format_version = pool_intern("SVN-fs-dump-format-version");
 }
 
 static void read_props(void)
@@ -206,7 +208,12 @@ void svndump_read(const char *url)
 		*val++ = '\0';
 		key = pool_intern(t);
 
-		if (key == keys.uuid) {
+		if (key == keys.svn_fs_dump_format_version) {
+			dump_ctx.version = atoi(val);
+			if (dump_ctx.version > 2)
+				die("expected svn dump format version <= 2, found %d",
+				    dump_ctx.version);
+		} else if (key == keys.uuid) {
 			dump_ctx.uuid = pool_intern(val);
 		} else if (key == keys.revision_number) {
 			if (active_ctx == NODE_CTX)
-- 
1.7.2.3.551.g13682.dirty
