From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 03/15] vcs-svn: Eliminate node_ctx.mark global
Date: Fri, 19 Nov 2010 18:46:54 -0600
Message-ID: <20101120004654.GD17445@burratino>
References: <20101118050023.GA14861@burratino>
 <20101120004525.GA17445@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	David Barr <david.barr@cordelta.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Nov 20 01:47:50 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PJbcL-000059-1Y
	for gcvg-git-2@lo.gmane.org; Sat, 20 Nov 2010 01:47:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755030Ab0KTAro (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Nov 2010 19:47:44 -0500
Received: from mail-gw0-f46.google.com ([74.125.83.46]:41888 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753763Ab0KTArn (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Nov 2010 19:47:43 -0500
Received: by gwb20 with SMTP id 20so366315gwb.19
        for <git@vger.kernel.org>; Fri, 19 Nov 2010 16:47:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=iM3Dixb5eahzjYPeG4yt6pJnYSZckpt/v1uZjZu/w1w=;
        b=b3MOQZJuBtgr3jOMzEeIrWVfCZs8NuKU4A+aRD59UFsxBK9vsSmVYgzf9vbL+Jd2gP
         A2TPEDA7tzS1sjK1wl9p/cNnnBAQ1lvhFXcsHPPURT9uIgOac3vSx1dftSQ22BtODRuo
         YRWLkzaXa7AMEQOcPVfMcasYTGKkphyoiSDrI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=WemEiEUa2JcKZ9eiYsuq9bVUdg+xXgOVZfCtQ0SbVtUaLfFv/Y3PcRR453HqaSH2Vm
         iBtsXUEbuoPxQ8jXm2YXtGED3udzh1Tjt9PXat+n3QPFANuLbPFMKAHfe5LQNEYNeFsu
         64guPEeK/dVcglxPqyNoQeTMMJsSzbYhrYuq4=
Received: by 10.151.13.9 with SMTP id q9mr1010406ybi.423.1290214062028;
        Fri, 19 Nov 2010 16:47:42 -0800 (PST)
Received: from burratino (adsl-68-255-106-176.dsl.chcgil.sbcglobal.net [68.255.106.176])
        by mx.google.com with ESMTPS id v9sm192081ybe.9.2010.11.19.16.47.40
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 19 Nov 2010 16:47:41 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20101120004525.GA17445@burratino>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161803>

The mark variable is only used in handle_node().  Its life is
very short and simple: first, a new mark number is allocated if
this node has text attached, then that mark is recorded in the
in-core tree being built up, and lastly the mark is communicated
to fast-import in the stream along with the associated text.

A new reader may worry about interaction with other code, especially
since mark is not initialized to zero in handle_node() itself.
Disperse such worries by making it local.  No functional change
intended.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 vcs-svn/svndump.c |   23 +++++++++++------------
 1 files changed, 11 insertions(+), 12 deletions(-)

diff --git a/vcs-svn/svndump.c b/vcs-svn/svndump.c
index 65bd335..1fb7f82 100644
--- a/vcs-svn/svndump.c
+++ b/vcs-svn/svndump.c
@@ -40,7 +40,7 @@ static char* log_copy(uint32_t length, char *log)
 }
 
 static struct {
-	uint32_t action, propLength, textLength, srcRev, mark, type;
+	uint32_t action, propLength, textLength, srcRev, type;
 	uint32_t src[REPO_MAX_PATH_DEPTH], dst[REPO_MAX_PATH_DEPTH];
 	uint32_t text_delta, prop_delta;
 } node_ctx;
@@ -73,7 +73,6 @@ static void reset_node_ctx(char *fname)
 	node_ctx.src[0] = ~0;
 	node_ctx.srcRev = 0;
 	pool_tok_seq(REPO_MAX_PATH_DEPTH, node_ctx.dst, "/", fname);
-	node_ctx.mark = 0;
 	node_ctx.text_delta = 0;
 	node_ctx.prop_delta = 0;
 }
@@ -151,7 +150,7 @@ static void read_props(void)
 
 static void handle_node(void)
 {
-	uint32_t old_mode = 0;
+	uint32_t old_mode = 0, mark = 0;
 
 	if (node_ctx.text_delta || node_ctx.prop_delta)
 		die("text and property deltas not supported");
@@ -164,7 +163,7 @@ static void handle_node(void)
 
 	if (node_ctx.textLength != LENGTH_UNKNOWN &&
 	    node_ctx.type != REPO_MODE_DIR)
-		node_ctx.mark = next_blob_mark();
+		mark = next_blob_mark();
 
 	if (node_ctx.action == NODEACT_DELETE) {
 		repo_delete(node_ctx.dst);
@@ -172,26 +171,26 @@ static void handle_node(void)
 			   node_ctx.action == NODEACT_REPLACE) {
 		if (node_ctx.action == NODEACT_REPLACE &&
 		    node_ctx.type == REPO_MODE_DIR)
-			repo_replace(node_ctx.dst, node_ctx.mark);
+			repo_replace(node_ctx.dst, mark);
 		else if (node_ctx.propLength != LENGTH_UNKNOWN)
-			repo_modify(node_ctx.dst, node_ctx.type, node_ctx.mark);
+			repo_modify(node_ctx.dst, node_ctx.type, mark);
 		else if (node_ctx.textLength != LENGTH_UNKNOWN)
-			old_mode = repo_replace(node_ctx.dst, node_ctx.mark);
+			old_mode = repo_replace(node_ctx.dst, mark);
 	} else if (node_ctx.action == NODEACT_ADD) {
 		if (node_ctx.srcRev && node_ctx.propLength != LENGTH_UNKNOWN)
-			repo_modify(node_ctx.dst, node_ctx.type, node_ctx.mark);
+			repo_modify(node_ctx.dst, node_ctx.type, mark);
 		else if (node_ctx.srcRev && node_ctx.textLength != LENGTH_UNKNOWN)
-			old_mode = repo_replace(node_ctx.dst, node_ctx.mark);
+			old_mode = repo_replace(node_ctx.dst, mark);
 		else if ((node_ctx.type == REPO_MODE_DIR && !node_ctx.srcRev) ||
 			 node_ctx.textLength != LENGTH_UNKNOWN)
-			repo_add(node_ctx.dst, node_ctx.type, node_ctx.mark);
+			repo_add(node_ctx.dst, node_ctx.type, mark);
 	}
 
 	if (node_ctx.propLength == LENGTH_UNKNOWN && old_mode)
 		node_ctx.type = old_mode;
 
-	if (node_ctx.mark)
-		fast_export_blob(node_ctx.type, node_ctx.mark, node_ctx.textLength);
+	if (mark)
+		fast_export_blob(node_ctx.type, mark, node_ctx.textLength);
 	else if (node_ctx.textLength != LENGTH_UNKNOWN)
 		buffer_skip_bytes(node_ctx.textLength);
 }
-- 
1.7.2.3
