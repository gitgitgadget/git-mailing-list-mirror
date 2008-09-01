From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH] fast-import: add ignore non-existent files option.
Date: Tue, 2 Sep 2008 01:30:08 +0300
Message-ID: <1220308173-20392-1-git-send-email-felipe.contreras@gmail.com>
References: <94a0d4530809011501n651c42c8xebb5cc39a93aac4c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 02 00:31:32 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KaHve-0007BY-Hs
	for gcvg-git-2@gmane.org; Tue, 02 Sep 2008 00:31:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751362AbYIAWaQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Sep 2008 18:30:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751314AbYIAWaQ
	(ORCPT <rfc822;git-outgoing>); Mon, 1 Sep 2008 18:30:16 -0400
Received: from fk-out-0910.google.com ([209.85.128.190]:62483 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751093AbYIAWaP (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Sep 2008 18:30:15 -0400
Received: by fk-out-0910.google.com with SMTP id 18so1561589fkq.5
        for <git@vger.kernel.org>; Mon, 01 Sep 2008 15:30:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:x-mailer:user-agent;
        bh=SD9O3g4ivjAF+LfSuGy25l/eVAd0RwBUrodifyKr92o=;
        b=Nm9hww155XySubGHfZbBDpvbQtpi2fie/eFkVFgI0vUnmhdOJEpxAU02XF1gJPICYa
         ZSCY3y/IeDn6CmZcUkrvTDXzpSS5uwksrrBuhr0BTAtFbTxeX5GVsRH6ZG1dxlUZWySN
         gFLpj68BgqGygXqi8Dk3OvoyzI1gU/2pqpf7Q=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:x-mailer:user-agent;
        b=w4jRHh53NnEwBBrRyXZZTy/G/VfEHj1pH2w1wj95k3KJEKOmFhUNU1d0KmxOSeXC8f
         +Jy0EAFjmJv2+lqOCa+g9FA9tbjJvlPZ8oh0dNTwLHBFDOzW514wR4+P++qpACezaquw
         lOHdqfZwto36VKGLYWDzpJSUQejQ6dumelN5M=
Received: by 10.180.216.16 with SMTP id o16mr5372031bkg.13.1220308212912;
        Mon, 01 Sep 2008 15:30:12 -0700 (PDT)
Received: from annwn.felipec.org ( [88.113.6.167])
        by mx.google.com with ESMTPS id g28sm6798407fkg.8.2008.09.01.15.30.11
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 01 Sep 2008 15:30:11 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <94a0d4530809011501n651c42c8xebb5cc39a93aac4c@mail.gmail.com>
X-Mailer: git-send-email 1.6.0.1
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94618>

This is useful for SCMs that don't have proper changesets in each
revision (monotone).

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 Documentation/git-fast-import.txt |    4 ++++
 fast-import.c                     |   14 ++++++++++++--
 2 files changed, 16 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-fast-import.txt b/Documentation/git-fast-import.txt
index c2f483a..42e10c1 100644
--- a/Documentation/git-fast-import.txt
+++ b/Documentation/git-fast-import.txt
@@ -95,6 +95,10 @@ OPTIONS
 	memory used by fast-import during this run.  Showing this output
 	is currently the default, but can be disabled with \--quiet.
 
+--tolerant::
+	Avoid fatal exceptions when actions are executed in non-existent
+	files.  For example removing a file that is not there.
+
 
 Performance
 -----------
diff --git a/fast-import.c b/fast-import.c
index 7089e6f..01be3fa 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -345,6 +345,7 @@ static struct recent_command *rc_free;
 static unsigned int cmd_save = 100;
 static uintmax_t next_mark;
 static struct strbuf new_data = STRBUF_INIT;
+static int tolerant;
 
 static void write_branch_report(FILE *rpt, struct branch *b)
 {
@@ -1993,8 +1994,15 @@ static void file_change_cr(struct branch *b, int rename)
 		tree_content_remove(&b->branch_tree, s, &leaf);
 	else
 		tree_content_get(&b->branch_tree, s, &leaf);
-	if (!leaf.versions[1].mode)
-		die("Path %s not in branch", s);
+	if (!leaf.versions[1].mode) {
+		if (tolerant) {
+			if (leaf.tree)
+				release_tree_content_recursive(leaf.tree);
+			warning("Path %s not in branch", s);
+			return;
+		} else
+			die("Path %s not in branch", s);
+	}
 	tree_content_set(&b->branch_tree, d,
 		leaf.versions[1].sha1,
 		leaf.versions[1].mode,
@@ -2447,6 +2455,8 @@ int main(int argc, const char **argv)
 			show_stats = 0;
 		else if (!strcmp(a, "--stats"))
 			show_stats = 1;
+		else if (!strcmp(a, "--tolerant"))
+			tolerant = 1;
 		else
 			die("unknown option %s", a);
 	}
-- 
1.6.0.1
