From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 02/15] vcs-svn: Eliminate node_ctx.srcRev global
Date: Fri, 19 Nov 2010 18:46:22 -0600
Message-ID: <20101120004622.GC17445@burratino>
References: <20101118050023.GA14861@burratino>
 <20101120004525.GA17445@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	David Barr <david.barr@cordelta.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Nov 20 01:47:18 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PJbbp-0008Hn-Ma
	for gcvg-git-2@lo.gmane.org; Sat, 20 Nov 2010 01:47:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755323Ab0KTArM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Nov 2010 19:47:12 -0500
Received: from mail-gy0-f174.google.com ([209.85.160.174]:37714 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753763Ab0KTArK (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Nov 2010 19:47:10 -0500
Received: by gyb11 with SMTP id 11so329014gyb.19
        for <git@vger.kernel.org>; Fri, 19 Nov 2010 16:47:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=NVCKutak0AGq8JEo9/5lggbnikaQtA5/fmlTRJA/Jic=;
        b=Zg6ZVRtn5ToCeUQ32JioElnXZaQpPuhCgWQAhvfYI5/nEHOK8Fir6D9Fr3DzRGn6ll
         FfcFrxFKVGsea5n0DrnZ7E1VuDjGNlil89uZO/eKFtYKaQrHrMlQpDXPkMPZ6w9GVB3p
         evTr9t0Ag28SLwya4wZ85GalCjpX+DmaIBOyI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=xfMjdczKrTN8gbg5wI/9eDBuUgoKGlIpYEz1gebM2ABH0ahx7EelQeEBIppF2i98eF
         acEl+3POGPcP+eNauZjyhHH4h0psFQwwilZQsO9wZcdgS126pZ0gP8+lt7M60OvMlOsQ
         ChFnQFbRuPtEZlOPtBTN7pPlZCuBzxKgmP420=
Received: by 10.150.92.7 with SMTP id p7mr4578347ybb.405.1290214029592;
        Fri, 19 Nov 2010 16:47:09 -0800 (PST)
Received: from burratino (adsl-68-255-106-176.dsl.chcgil.sbcglobal.net [68.255.106.176])
        by mx.google.com with ESMTPS id q18sm185612ybk.15.2010.11.19.16.47.07
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 19 Nov 2010 16:47:09 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20101120004525.GA17445@burratino>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161802>

The srcRev variable is only used in handle_node(); its purpose
is to hold the old mode for a path, to only be used if properties
are not being changed.  Narrow its scope to make its meaningful
lifetime more obvious.

No functional change intended.  Add some tests as a sanity-check
for the simplest case (no renames).

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 t/t9010-svn-fe.sh |  158 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 vcs-svn/svndump.c |   15 +++--
 2 files changed, 166 insertions(+), 7 deletions(-)

diff --git a/t/t9010-svn-fe.sh b/t/t9010-svn-fe.sh
index be5372a..729e73d 100755
--- a/t/t9010-svn-fe.sh
+++ b/t/t9010-svn-fe.sh
@@ -252,6 +252,164 @@ test_expect_success 'directory with files' '
 	test_cmp hi directory/file2
 '
 
+test_expect_failure 'change file mode but keep old content' '
+	reinit_git &&
+	cat >expect <<-\EOF &&
+	OBJID
+	:120000 100644 OBJID OBJID T	greeting
+	OBJID
+	:100644 120000 OBJID OBJID T	greeting
+	OBJID
+	:000000 100644 OBJID OBJID A	greeting
+	EOF
+	echo "link hello" >expect.blob &&
+	echo hello >hello &&
+	cat >filemode.dump <<-\EOF &&
+	SVN-fs-dump-format-version: 3
+
+	Revision-number: 1
+	Prop-content-length: 10
+	Content-length: 10
+
+	PROPS-END
+
+	Node-path: greeting
+	Node-kind: file
+	Node-action: add
+	Prop-content-length: 10
+	Text-content-length: 11
+	Content-length: 21
+
+	PROPS-END
+	link hello
+
+	Revision-number: 2
+	Prop-content-length: 10
+	Content-length: 10
+
+	PROPS-END
+
+	Node-path: greeting
+	Node-kind: file
+	Node-action: change
+	Prop-content-length: 33
+	Content-length: 33
+
+	K 11
+	svn:special
+	V 1
+	*
+	PROPS-END
+
+	Revision-number: 3
+	Prop-content-length: 10
+	Content-length: 10
+
+	PROPS-END
+
+	Node-path: greeting
+	Node-kind: file
+	Node-action: change
+	Prop-content-length: 10
+	Content-length: 10
+
+	PROPS-END
+	EOF
+	test-svn-fe filemode.dump >stream &&
+	git fast-import <stream &&
+	{
+		git rev-list HEAD |
+		git diff-tree --root --stdin |
+		sed "s/$_x40/OBJID/g"
+	} >actual &&
+	git show HEAD:greeting >actual.blob &&
+	git show HEAD^:greeting >actual.target &&
+	test_cmp expect actual &&
+	test_cmp expect.blob actual.blob &&
+	test_cmp hello actual.target
+'
+
+test_expect_success 'change file mode and reiterate content' '
+	reinit_git &&
+	cat >expect <<-\EOF &&
+	OBJID
+	:120000 100644 OBJID OBJID T	greeting
+	OBJID
+	:100644 120000 OBJID OBJID T	greeting
+	OBJID
+	:000000 100644 OBJID OBJID A	greeting
+	EOF
+	echo "link hello" >expect.blob &&
+	echo hello >hello &&
+	cat >filemode.dump <<-\EOF &&
+	SVN-fs-dump-format-version: 3
+
+	Revision-number: 1
+	Prop-content-length: 10
+	Content-length: 10
+
+	PROPS-END
+
+	Node-path: greeting
+	Node-kind: file
+	Node-action: add
+	Prop-content-length: 10
+	Text-content-length: 11
+	Content-length: 21
+
+	PROPS-END
+	link hello
+
+	Revision-number: 2
+	Prop-content-length: 10
+	Content-length: 10
+
+	PROPS-END
+
+	Node-path: greeting
+	Node-kind: file
+	Node-action: change
+	Prop-content-length: 33
+	Text-content-length: 11
+	Content-length: 44
+
+	K 11
+	svn:special
+	V 1
+	*
+	PROPS-END
+	link hello
+
+	Revision-number: 3
+	Prop-content-length: 10
+	Content-length: 10
+
+	PROPS-END
+
+	Node-path: greeting
+	Node-kind: file
+	Node-action: change
+	Prop-content-length: 10
+	Text-content-length: 11
+	Content-length: 21
+
+	PROPS-END
+	link hello
+	EOF
+	test-svn-fe filemode.dump >stream &&
+	git fast-import <stream &&
+	{
+		git rev-list HEAD |
+		git diff-tree --root --stdin |
+		sed "s/$_x40/OBJID/g"
+	} >actual &&
+	git show HEAD:greeting >actual.blob &&
+	git show HEAD^:greeting >actual.target &&
+	test_cmp expect actual &&
+	test_cmp expect.blob actual.blob &&
+	test_cmp hello actual.target
+'
+
 test_expect_success 'deltas not supported' '
 	{
 		# (old) h + (inline) ello + (old) \n
diff --git a/vcs-svn/svndump.c b/vcs-svn/svndump.c
index db11851..65bd335 100644
--- a/vcs-svn/svndump.c
+++ b/vcs-svn/svndump.c
@@ -40,7 +40,7 @@ static char* log_copy(uint32_t length, char *log)
 }
 
 static struct {
-	uint32_t action, propLength, textLength, srcRev, srcMode, mark, type;
+	uint32_t action, propLength, textLength, srcRev, mark, type;
 	uint32_t src[REPO_MAX_PATH_DEPTH], dst[REPO_MAX_PATH_DEPTH];
 	uint32_t text_delta, prop_delta;
 } node_ctx;
@@ -72,7 +72,6 @@ static void reset_node_ctx(char *fname)
 	node_ctx.textLength = LENGTH_UNKNOWN;
 	node_ctx.src[0] = ~0;
 	node_ctx.srcRev = 0;
-	node_ctx.srcMode = 0;
 	pool_tok_seq(REPO_MAX_PATH_DEPTH, node_ctx.dst, "/", fname);
 	node_ctx.mark = 0;
 	node_ctx.text_delta = 0;
@@ -152,6 +151,8 @@ static void read_props(void)
 
 static void handle_node(void)
 {
+	uint32_t old_mode = 0;
+
 	if (node_ctx.text_delta || node_ctx.prop_delta)
 		die("text and property deltas not supported");
 
@@ -159,7 +160,7 @@ static void handle_node(void)
 		read_props();
 
 	if (node_ctx.srcRev)
-		node_ctx.srcMode = repo_copy(node_ctx.srcRev, node_ctx.src, node_ctx.dst);
+		old_mode = repo_copy(node_ctx.srcRev, node_ctx.src, node_ctx.dst);
 
 	if (node_ctx.textLength != LENGTH_UNKNOWN &&
 	    node_ctx.type != REPO_MODE_DIR)
@@ -175,19 +176,19 @@ static void handle_node(void)
 		else if (node_ctx.propLength != LENGTH_UNKNOWN)
 			repo_modify(node_ctx.dst, node_ctx.type, node_ctx.mark);
 		else if (node_ctx.textLength != LENGTH_UNKNOWN)
-			node_ctx.srcMode = repo_replace(node_ctx.dst, node_ctx.mark);
+			old_mode = repo_replace(node_ctx.dst, node_ctx.mark);
 	} else if (node_ctx.action == NODEACT_ADD) {
 		if (node_ctx.srcRev && node_ctx.propLength != LENGTH_UNKNOWN)
 			repo_modify(node_ctx.dst, node_ctx.type, node_ctx.mark);
 		else if (node_ctx.srcRev && node_ctx.textLength != LENGTH_UNKNOWN)
-			node_ctx.srcMode = repo_replace(node_ctx.dst, node_ctx.mark);
+			old_mode = repo_replace(node_ctx.dst, node_ctx.mark);
 		else if ((node_ctx.type == REPO_MODE_DIR && !node_ctx.srcRev) ||
 			 node_ctx.textLength != LENGTH_UNKNOWN)
 			repo_add(node_ctx.dst, node_ctx.type, node_ctx.mark);
 	}
 
-	if (node_ctx.propLength == LENGTH_UNKNOWN && node_ctx.srcMode)
-		node_ctx.type = node_ctx.srcMode;
+	if (node_ctx.propLength == LENGTH_UNKNOWN && old_mode)
+		node_ctx.type = old_mode;
 
 	if (node_ctx.mark)
 		fast_export_blob(node_ctx.type, node_ctx.mark, node_ctx.textLength);
-- 
1.7.2.3
