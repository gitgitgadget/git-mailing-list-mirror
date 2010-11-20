From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 11/15] vcs-svn: More dump format sanity checks
Date: Fri, 19 Nov 2010 18:53:34 -0600
Message-ID: <20101120005334.GL17445@burratino>
References: <20101118050023.GA14861@burratino>
 <20101120004525.GA17445@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	David Barr <david.barr@cordelta.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Nov 20 01:54:28 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PJbil-0003Am-Lz
	for gcvg-git-2@lo.gmane.org; Sat, 20 Nov 2010 01:54:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755942Ab0KTAyX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Nov 2010 19:54:23 -0500
Received: from mail-gx0-f174.google.com ([209.85.161.174]:42961 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755795Ab0KTAyW (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Nov 2010 19:54:22 -0500
Received: by gxk23 with SMTP id 23so3103331gxk.19
        for <git@vger.kernel.org>; Fri, 19 Nov 2010 16:54:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=FmuNspmmY6ukei34NMIF5/W0JilnAIXjriLeQuTI7TE=;
        b=qIShy+t6xyJDjq39Wme5y2PUx1rS7WD0BpKwzTTw+CLk6DbB1W6lHuZ1NzGa7dEcsO
         RNvkJU8YPcKHpRCtxQ/pBUMBcJB64xi29Ya6q5skPrWi0wXE4r73QL/rhip92iiR0KLJ
         YQvtnujMk/dEi04qTSOKaeVBuMIt5OTkWM7U0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=hVPH7fnFLC+yrwHkdGmCet1YTDrnNUB1WcDcYxF1vwhn167IolK3ySqfw1I6k0boOh
         uqKiuDbOuCKHzaUedW0TmxHdXivhcbgFKRfnpDQp9hZ226+ubxabO8tLlwde3JPHWZSE
         9eKRUSDEYk6Ui6uG0J52ESoY3SE93BaZvadlM=
Received: by 10.150.144.19 with SMTP id r19mr4634104ybd.141.1290214462268;
        Fri, 19 Nov 2010 16:54:22 -0800 (PST)
Received: from burratino (adsl-68-255-106-176.dsl.chcgil.ameritech.net [68.255.106.176])
        by mx.google.com with ESMTPS id q5sm193349ybe.18.2010.11.19.16.54.20
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 19 Nov 2010 16:54:21 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20101120004525.GA17445@burratino>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161811>

Node-action: change is not appropriate when switching between file and
directory or adding a new file.  Current svn-fe silently accepts such
nodes and the resulting tree has missing files in the "changed when
meant to add" case.

Node-action: add requires some content (text or directory); there is
no such thing as an "intent to add" node in svn dumps.  Current svn-fe
accepts such contentless adds but produces an invalid fast-import
stream that refers to nonexistent mark :0 in response.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 t/t9010-svn-fe.sh |   21 +++++++++++++++++++++
 vcs-svn/svndump.c |   18 ++++++++++++++----
 2 files changed, 35 insertions(+), 4 deletions(-)

diff --git a/t/t9010-svn-fe.sh b/t/t9010-svn-fe.sh
index cb9a236..f1e8799 100755
--- a/t/t9010-svn-fe.sh
+++ b/t/t9010-svn-fe.sh
@@ -272,6 +272,27 @@ test_expect_success 'node without action' '
 	test_must_fail test-svn-fe inaction.dump
 '
 
+test_expect_success 'action: add node without text' '
+	cat >textless.dump <<-\EOF &&
+	SVN-fs-dump-format-version: 3
+
+	Revision-number: 1
+	Prop-content-length: 10
+	Content-length: 10
+
+	PROPS-END
+
+	Node-path: textless
+	Node-kind: file
+	Node-action: add
+	Prop-content-length: 10
+	Content-length: 10
+
+	PROPS-END
+	EOF
+	test_must_fail test-svn-fe textless.dump
+'
+
 test_expect_failure 'change file mode but keep old content' '
 	reinit_git &&
 	cat >expect <<-\EOF &&
diff --git a/vcs-svn/svndump.c b/vcs-svn/svndump.c
index 78c2de0..62bb148 100644
--- a/vcs-svn/svndump.c
+++ b/vcs-svn/svndump.c
@@ -181,12 +181,22 @@ static void handle_node(void)
 	if (mark && type == REPO_MODE_DIR)
 		die("invalid dump: directories cannot have text attached");
 
-	if (node_ctx.action == NODEACT_CHANGE)
-		node_ctx.type = repo_modify_path(node_ctx.dst, 0, mark);
-	else if (node_ctx.action == NODEACT_ADD)
+	if (node_ctx.action == NODEACT_CHANGE) {
+		uint32_t mode = repo_modify_path(node_ctx.dst, 0, mark);
+		if (!mode)
+			die("invalid dump: path to be modified is missing");
+		if (mode == REPO_MODE_DIR && type != REPO_MODE_DIR)
+			die("invalid dump: cannot modify a directory into a file");
+		if (mode != REPO_MODE_DIR && type == REPO_MODE_DIR)
+			die("invalid dump: cannot modify a file into a directory");
+		node_ctx.type = mode;
+	} else if (node_ctx.action == NODEACT_ADD) {
+		if (!mark && type != REPO_MODE_DIR)
+			die("invalid dump: adds node without text");
 		repo_add(node_ctx.dst, type, mark);
-	else
+	} else {
 		die("invalid dump: Node-path block lacks Node-action");
+	}
 
 	if (have_props) {
 		const uint32_t old_mode = node_ctx.type;
-- 
1.7.2.3
