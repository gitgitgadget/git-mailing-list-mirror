From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH jn/svn-fe] vcs-svn: Allow change nodes for root of tree (/)
Date: Mon, 6 Dec 2010 16:19:32 -0600
Message-ID: <20101206221931.GA13401@burratino>
References: <20101118050023.GA14861@burratino>
 <20101120004525.GA17445@burratino>
 <20101120005334.GL17445@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	David Barr <david.barr@cordelta.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Dec 06 23:19:54 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PPjPW-0000uE-7o
	for gcvg-git-2@lo.gmane.org; Mon, 06 Dec 2010 23:19:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753839Ab0LFWTt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Dec 2010 17:19:49 -0500
Received: from mail-wy0-f174.google.com ([74.125.82.174]:60907 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753617Ab0LFWTs (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Dec 2010 17:19:48 -0500
Received: by wyb28 with SMTP id 28so12543753wyb.19
        for <git@vger.kernel.org>; Mon, 06 Dec 2010 14:19:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=t2t1kamBrdXNNTrJTQY/yxrW4u4EvvMXsbkDnTph6Po=;
        b=VORiwyeHjCvOIgM1OyH/rxwrzbpvPsaxqp8oGN9IDAojco+Xjr6iYz1VlXKsVnpcfd
         y2sLPLlPCEayd1lrCO6Pa6yVDMZY7XJHD5v8gsNmkQRE6o4EgoC13jkor//DIpQYTvta
         vTjNW7BQJRe+WQqxDAP9XgIrHQgQvJk7Z+mfM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=ibpysek58hoW4k1oQ6hannYfVRzNc7XqFm+r00g7s3B6FCefV6MKIGDp2m0F/jKBLm
         cINl7Tmta4DUQcOGPf6gT6EtzNoBWnGkOSyvgalc2LdHpP5wbsvKRFSWhm+TY8katJlA
         +eW2gB2NCqgcwhl7gLJUkVUKMl4n70sUFVegI=
Received: by 10.227.148.19 with SMTP id n19mr6424032wbv.175.1291673986791;
        Mon, 06 Dec 2010 14:19:46 -0800 (PST)
Received: from burratino ([68.255.109.73])
        by mx.google.com with ESMTPS id h29sm3781435wbc.15.2010.12.06.14.19.43
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 06 Dec 2010 14:19:45 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20101120005334.GL17445@burratino>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163033>

It is not uncommon for a svn repository to include change records for
properties at the top level of the tracked tree:

	Node-path: 
	Node-kind: dir
	Node-action: change
	Prop-delta: true
	Prop-content-length: 43
	Content-length: 43

	K 10
	svn:ignore
	V 11
	build-area

	PROPS-END

Unfortunately a recent svn-fe change (vcs-svn: More dump format sanity
checks, 2010-11-19) causes such nodes to be rejected with the error
message

	fatal: invalid dump: path to be modified is missing

The repo_tree module does not keep a dirent for the root of the tree.
Add a block to the dump parser to take care of this case.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 t/t9010-svn-fe.sh |   73 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 vcs-svn/svndump.c |    5 +++-
 2 files changed, 77 insertions(+), 1 deletions(-)

diff --git a/t/t9010-svn-fe.sh b/t/t9010-svn-fe.sh
index 7dc0670..04ce97d 100755
--- a/t/t9010-svn-fe.sh
+++ b/t/t9010-svn-fe.sh
@@ -580,6 +580,79 @@ test_expect_success 'property deltas supported' '
 	test_cmp expect actual
 '
 
+test_expect_success 'properties on /' '
+	reinit_git &&
+	cat <<-\EOF >expect &&
+	OBJID
+	OBJID
+	:000000 100644 OBJID OBJID A	greeting
+	EOF
+	sed -e "s/X$//" <<-\EOF >changeroot.dump &&
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
+	Text-content-length: 0
+	Prop-content-length: 10
+	Content-length: 10
+
+	PROPS-END
+
+	Revision-number: 2
+	Prop-content-length: 10
+	Content-length: 10
+
+	PROPS-END
+
+	Node-path: X
+	Node-kind: dir
+	Node-action: change
+	Prop-delta: true
+	Prop-content-length: 43
+	Content-length: 43
+
+	K 10
+	svn:ignore
+	V 11
+	build-area
+
+	PROPS-END
+	EOF
+	echo Revision-number: 2 &&
+	echo Prop-content-length: $(wc -c <revprops) &&
+	echo Content-length: $(wc -c <revprops) &&
+	echo &&
+	cat revprops &&
+	echo &&
+	cat <<-\EOF
+	Node-path: script.sh
+	Node-kind: file
+	Node-action: change
+	Prop-delta: true
+	Prop-content-length: 30
+	Content-length: 30
+
+	D 14
+	svn:executable
+	PROPS-END
+	EOF
+	test-svn-fe changeroot.dump >stream &&
+	git fast-import <stream &&
+	{
+		git rev-list HEAD |
+		git diff-tree --root --always --stdin |
+		sed "s/$_x40/OBJID/g"
+	} >actual &&
+	test_cmp expect actual
+'
+
 test_expect_success 'deltas for typechange' '
 	reinit_git &&
 	cat >expect <<-\EOF &&
diff --git a/vcs-svn/svndump.c b/vcs-svn/svndump.c
index d2a5347..6543b51 100644
--- a/vcs-svn/svndump.c
+++ b/vcs-svn/svndump.c
@@ -203,7 +203,10 @@ static void handle_node(void)
 	}
 	if (mark && type == REPO_MODE_DIR)
 		die("invalid dump: directories cannot have text attached");
-	if (node_ctx.action == NODEACT_CHANGE) {
+	if (node_ctx.action == NODEACT_CHANGE && !~*node_ctx.dst) {
+		if (type != REPO_MODE_DIR)
+			die("invalid dump: root of tree is not a regular file");
+	} else if (node_ctx.action == NODEACT_CHANGE) {
 		uint32_t mode = repo_modify_path(node_ctx.dst, 0, mark);
 		if (!mode)
 			die("invalid dump: path to be modified is missing");
-- 
1.7.2.4
