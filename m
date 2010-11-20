From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 10/15] vcs-svn: Reject path nodes without Node-action
Date: Fri, 19 Nov 2010 18:52:59 -0600
Message-ID: <20101120005259.GK17445@burratino>
References: <20101118050023.GA14861@burratino>
 <20101120004525.GA17445@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	David Barr <david.barr@cordelta.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Nov 20 01:53:54 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PJbiD-0002va-PY
	for gcvg-git-2@lo.gmane.org; Sat, 20 Nov 2010 01:53:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755865Ab0KTAxt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Nov 2010 19:53:49 -0500
Received: from mail-yx0-f174.google.com ([209.85.213.174]:44409 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755760Ab0KTAxs (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Nov 2010 19:53:48 -0500
Received: by yxf34 with SMTP id 34so3101558yxf.19
        for <git@vger.kernel.org>; Fri, 19 Nov 2010 16:53:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=W5RagaK4kNgsNJjJ/UDHm3i3AbtEbWRVVcnjQkYxpIc=;
        b=cbyhq0bQ4eIxpjE4bo5dk8xfQ6C2IekcjIGr8I85sFsop5qoVbs3tTwAHGKDOlbB4T
         c1t5y7fR1wzb5vNOTV7b8fWNDZUlRQKzRIM0Wuj4EfRiHo+08mwn87tIccPCdVERvwPH
         c4nfb6J9EWE1tFcSNILEJ380l4gFstf7KHcdQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=Xl5qEkhKmah5pGHVDJ1a4i+5GawL7bYhGilMs9E/8kPXweMq0NN6nKZusWUix45+uP
         pY/d45/TdA4j3PcfHoSc9fQoL1YtPg0Pc2ltGKAtG/PxgZ8y5eEkpDPnr8mNvZ5vtYbY
         TpFnCgflYCtChkho+7Bynmj95D2mnI9ZSeYHM=
Received: by 10.150.157.13 with SMTP id f13mr4576038ybe.441.1290214427271;
        Fri, 19 Nov 2010 16:53:47 -0800 (PST)
Received: from burratino (adsl-68-255-106-176.dsl.chcgil.ameritech.net [68.255.106.176])
        by mx.google.com with ESMTPS id r18sm1471861yba.3.2010.11.19.16.53.45
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 19 Nov 2010 16:53:46 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20101120004525.GA17445@burratino>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161810>

It would be better to flag such errors and let the import proceed
anyway, but for now it is simpler not to worry about recovery
from such weird cases.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 t/t9010-svn-fe.sh |   20 ++++++++++++++++++++
 vcs-svn/svndump.c |    7 +++++--
 2 files changed, 25 insertions(+), 2 deletions(-)

diff --git a/t/t9010-svn-fe.sh b/t/t9010-svn-fe.sh
index 729e73d..cb9a236 100755
--- a/t/t9010-svn-fe.sh
+++ b/t/t9010-svn-fe.sh
@@ -252,6 +252,26 @@ test_expect_success 'directory with files' '
 	test_cmp hi directory/file2
 '
 
+test_expect_success 'node without action' '
+	cat >inaction.dump <<-\EOF &&
+	SVN-fs-dump-format-version: 3
+
+	Revision-number: 1
+	Prop-content-length: 10
+	Content-length: 10
+
+	PROPS-END
+
+	Node-path: directory
+	Node-kind: dir
+	Prop-content-length: 10
+	Content-length: 10
+
+	PROPS-END
+	EOF
+	test_must_fail test-svn-fe inaction.dump
+'
+
 test_expect_failure 'change file mode but keep old content' '
 	reinit_git &&
 	cat >expect <<-\EOF &&
diff --git a/vcs-svn/svndump.c b/vcs-svn/svndump.c
index 4fdfcbb..78c2de0 100644
--- a/vcs-svn/svndump.c
+++ b/vcs-svn/svndump.c
@@ -174,7 +174,8 @@ static void handle_node(void)
 
 	if (node_ctx.srcRev) {
 		repo_copy(node_ctx.srcRev, node_ctx.src, node_ctx.dst);
-		node_ctx.action = NODEACT_CHANGE;
+		if (node_ctx.action == NODEACT_ADD)
+			  node_ctx.action = NODEACT_CHANGE;
 	}
 
 	if (mark && type == REPO_MODE_DIR)
@@ -182,8 +183,10 @@ static void handle_node(void)
 
 	if (node_ctx.action == NODEACT_CHANGE)
 		node_ctx.type = repo_modify_path(node_ctx.dst, 0, mark);
-	else	/* Node-action: add */
+	else if (node_ctx.action == NODEACT_ADD)
 		repo_add(node_ctx.dst, type, mark);
+	else
+		die("invalid dump: Node-path block lacks Node-action");
 
 	if (have_props) {
 		const uint32_t old_mode = node_ctx.type;
-- 
1.7.2.3
