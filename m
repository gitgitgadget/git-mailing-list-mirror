From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 15/15] vcs-svn: Implement Prop-delta handling
Date: Fri, 19 Nov 2010 18:57:46 -0600
Message-ID: <20101120005746.GP17445@burratino>
References: <20101118050023.GA14861@burratino>
 <20101120004525.GA17445@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	David Barr <david.barr@cordelta.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Nov 20 01:58:41 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PJbmq-0004tN-JL
	for gcvg-git-2@lo.gmane.org; Sat, 20 Nov 2010 01:58:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755808Ab0KTA6f (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Nov 2010 19:58:35 -0500
Received: from mail-gw0-f46.google.com ([74.125.83.46]:57015 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755280Ab0KTA6e (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Nov 2010 19:58:34 -0500
Received: by gwb20 with SMTP id 20so369416gwb.19
        for <git@vger.kernel.org>; Fri, 19 Nov 2010 16:58:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=6zQMwdwQXByFUqIIllImA2pJX89pkJ6yBz1sFChcfsE=;
        b=ENl2JOms1i3WlIYaT5GufznrdoJWPN6pR4OUMaQQnvcjd2FVomsMAXfeyXDYrnFWzw
         bQCGAEglnLmK9coMVu7JAPrDreCVsmKjH/BodSMYJXdbe9nVGi8G8cmXGJcLzhn2Ec8W
         oij/lf7WT+5n/gXY1VTNAjlIEnSzsizDbI+54=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=vWdVWfP9m/NHBV2+FaCqgSyiVhBJNWfJbzZBpcEu4oIXYQf4H+4/3wfjLUW0OlocKn
         Dmc4sek6du5gPOusE5HH7Q+Zhs6CrMwq+AfySmc3N5FthNs2ODlVCuKq7gDuFaC4loYl
         DZ68E0o+t/+3r+ZXNwfUClSamVGZFf0wAHBuE=
Received: by 10.151.9.8 with SMTP id m8mr4626679ybi.213.1290214714280;
        Fri, 19 Nov 2010 16:58:34 -0800 (PST)
Received: from burratino (adsl-68-255-106-176.dsl.chcgil.ameritech.net [68.255.106.176])
        by mx.google.com with ESMTPS id f4sm33750yhc.3.2010.11.19.16.58.32
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 19 Nov 2010 16:58:33 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20101120004525.GA17445@burratino>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161815>

From: David Barr <david.barr@cordelta.com>

The rules for what file is used as delta source for each file are not
documented in dump-load-format.txt.  Luckily, the Apache Software
Foundation repository has rich enough examples to figure out most of
the rules:

Node-action: replace implies the empty property set and empty text as
preimage for deltas.  Otherwise, if a copyfrom source is given, that
node is the preimage for deltas.  Lastly, if none of the above applies
and the node path exists in the current revision, then that version
forms the basis.

[jn: refactored, with tests]

Signed-off-by: David Barr <david.barr@cordelta.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
That's the end of this chapter.  Thanks for reading.

In the next chapter, the line_buffer lib will gain the ability to read
from multiple files (based on some patches seen on the list before)
and use this ability to manage the cat-blob-fd and some temporary
files for applying deltas.

Reading from the cat-blob-fd with stdio functions carries a great risk
of deadlock, so we need to find a way to do this without fdopen()
(some routines for doing this are already written and usable, but they
haven't been made into a nice library yet).

 t/t9010-svn-fe.sh |  102 +++++++++++++++++++++++++++++++++++++++++++++++++++-
 vcs-svn/svndump.c |   54 +++++++++++++++++++++++-----
 2 files changed, 144 insertions(+), 12 deletions(-)

diff --git a/t/t9010-svn-fe.sh b/t/t9010-svn-fe.sh
index f1e8799..7dc0670 100755
--- a/t/t9010-svn-fe.sh
+++ b/t/t9010-svn-fe.sh
@@ -514,7 +514,12 @@ test_expect_success 'deltas not supported' '
 	test_must_fail test-svn-fe delta.dump
 '
 
-test_expect_success 'property deltas not supported' '
+test_expect_success 'property deltas supported' '
+	reinit_git &&
+	cat >expect <<-\EOF &&
+	OBJID
+	:100755 100644 OBJID OBJID M	script.sh
+	EOF
 	{
 		properties \
 			svn:author author@example.com \
@@ -565,7 +570,100 @@ test_expect_success 'property deltas not supported' '
 		PROPS-END
 		EOF
 	} >propdelta.dump &&
-	test_must_fail test-svn-fe propdelta.dump
+	test-svn-fe propdelta.dump >stream &&
+	git fast-import <stream &&
+	{
+		git rev-list HEAD |
+		git diff-tree --stdin |
+		sed "s/$_x40/OBJID/g"
+	} >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'deltas for typechange' '
+	reinit_git &&
+	cat >expect <<-\EOF &&
+	OBJID
+	:120000 100644 OBJID OBJID T	test-file
+	OBJID
+	:100755 120000 OBJID OBJID T	test-file
+	OBJID
+	:000000 100755 OBJID OBJID A	test-file
+	EOF
+	cat >deleteprop.dump <<-\EOF &&
+	SVN-fs-dump-format-version: 3
+
+	Revision-number: 1
+	Prop-content-length: 10
+	Content-length: 10
+
+	PROPS-END
+
+	Node-path: test-file
+	Node-kind: file
+	Node-action: add
+	Prop-delta: true
+	Prop-content-length: 35
+	Text-content-length: 17
+	Content-length: 52
+
+	K 14
+	svn:executable
+	V 0
+
+	PROPS-END
+	link testing 123
+
+	Revision-number: 2
+	Prop-content-length: 10
+	Content-length: 10
+
+	PROPS-END
+
+	Node-path: test-file
+	Node-kind: file
+	Node-action: change
+	Prop-delta: true
+	Prop-content-length: 53
+	Text-content-length: 17
+	Content-length: 70
+
+	K 11
+	svn:special
+	V 1
+	*
+	D 14
+	svn:executable
+	PROPS-END
+	link testing 231
+
+	Revision-number: 3
+	Prop-content-length: 10
+	Content-length: 10
+
+	PROPS-END
+
+	Node-path: test-file
+	Node-kind: file
+	Node-action: change
+	Prop-delta: true
+	Prop-content-length: 27
+	Text-content-length: 17
+	Content-length: 44
+
+	D 11
+	svn:special
+	PROPS-END
+	link testing 321
+	EOF
+	test-svn-fe deleteprop.dump >stream &&
+	git fast-import <stream &&
+	{
+		git rev-list HEAD |
+		git diff-tree --root --stdin |
+		sed "s/$_x40/OBJID/g"
+	} >actual &&
+	test_cmp expect actual
 '
 
 test_expect_success 't9135/svn.dump' '
diff --git a/vcs-svn/svndump.c b/vcs-svn/svndump.c
index c3e1e32..8a224ac 100644
--- a/vcs-svn/svndump.c
+++ b/vcs-svn/svndump.c
@@ -115,20 +115,35 @@ static void init_keys(void)
 	keys.prop_delta = pool_intern("Prop-delta");
 }
 
-static void handle_property(uint32_t key, const char *val, uint32_t len)
+static void handle_property(uint32_t key, const char *val, uint32_t len,
+				uint32_t *type_set)
 {
 	if (key == keys.svn_log) {
+		if (!val)
+			die("invalid dump: unsets svn:log");
 		/* Value length excludes terminating nul. */
 		rev_ctx.log = log_copy(len + 1, val);
 	} else if (key == keys.svn_author) {
 		rev_ctx.author = pool_intern(val);
 	} else if (key == keys.svn_date) {
+		if (!val)
+			die("invalid dump: unsets svn:date");
 		if (parse_date_basic(val, &rev_ctx.timestamp, NULL))
-			fprintf(stderr, "Invalid timestamp: %s\n", val);
-	} else if (key == keys.svn_executable) {
-		node_ctx.type = REPO_MODE_EXE;
-	} else if (key == keys.svn_special) {
-		node_ctx.type = REPO_MODE_LNK;
+			warning("invalid timestamp: %s", val);
+	} else if (key == keys.svn_executable || key == keys.svn_special) {
+		if (*type_set) {
+			if (!val)
+				return;
+			die("invalid dump: sets type twice");
+		}
+		if (!val) {
+			node_ctx.type = REPO_MODE_BLB;
+			return;
+		}
+		*type_set = 1;
+		node_ctx.type = key == keys.svn_executable ?
+				REPO_MODE_EXE :
+				REPO_MODE_LNK;
 	}
 }
 
@@ -136,6 +151,19 @@ static void read_props(void)
 {
 	uint32_t key = ~0;
 	const char *t;
+	/*
+	 * NEEDSWORK: to support simple mode changes like
+	 *	K 11
+	 *	svn:special
+	 *	V 1
+	 *	*
+	 *	D 14
+	 *	svn:executable
+	 * we keep track of whether a mode has been set and reset to
+	 * plain file only if not.  We should be keeping track of the
+	 * symlink and executable bits separately instead.
+	 */
+	uint32_t type_set = 0;
 	while ((t = buffer_read_line()) && strcmp(t, "PROPS-END")) {
 		uint32_t len;
 		const char *val;
@@ -151,8 +179,13 @@ static void read_props(void)
 		case 'K':
 			key = pool_intern(val);
 			continue;
+		case 'D':
+			key = pool_intern(val);
+			val = NULL;
+			len = 0;
+			/* fall through */
 		case 'V':
-			handle_property(key, val, len);
+			handle_property(key, val, len, &type_set);
 			key = ~0;
 			continue;
 		default:
@@ -167,8 +200,8 @@ static void handle_node(void)
 	const uint32_t type = node_ctx.type;
 	const int have_props = node_ctx.propLength != LENGTH_UNKNOWN;
 
-	if (node_ctx.text_delta || node_ctx.prop_delta)
-		die("text and property deltas not supported");
+	if (node_ctx.text_delta)
+		die("text deltas not supported");
 	if (node_ctx.textLength != LENGTH_UNKNOWN)
 		mark = next_blob_mark();
 	if (node_ctx.action == NODEACT_DELETE) {
@@ -206,7 +239,8 @@ static void handle_node(void)
 	}
 	if (have_props) {
 		const uint32_t old_mode = node_ctx.type;
-		node_ctx.type = type;
+		if (!node_ctx.prop_delta)
+			node_ctx.type = type;
 		if (node_ctx.propLength)
 			read_props();
 		if (node_ctx.type != old_mode)
-- 
1.7.2.3
