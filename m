From: Ben Willard <benwillard@gmail.com>
Subject: [PATCH 2/2] blame: Fix corner case when a directory becomes a file
Date: Tue, 2 Jun 2009 15:29:17 -0400
Message-ID: <4a257d91.0407560a.04d2.ffffe775@mx.google.com>
References: <cover.1243969358.git.benwillard@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 02 21:29:32 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MBZfw-0007JF-2T
	for gcvg-git-2@gmane.org; Tue, 02 Jun 2009 21:29:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751652AbZFBT3Y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Jun 2009 15:29:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751110AbZFBT3X
	(ORCPT <rfc822;git-outgoing>); Tue, 2 Jun 2009 15:29:23 -0400
Received: from fg-out-1718.google.com ([72.14.220.159]:28298 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750776AbZFBT3W (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Jun 2009 15:29:22 -0400
Received: by fg-out-1718.google.com with SMTP id d23so920035fga.17
        for <git@vger.kernel.org>; Tue, 02 Jun 2009 12:29:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=btHl+WriVbq+B36CLRwjA6cQ5B1aTrc6IXKoBjjWYT8=;
        b=FxRjDKzRBXyKFCF5L3b6xAJAkcFWorBBvvdrl0689OL8BWszj8hIS3ucvVhxagEod+
         jycpBVtv/bL/sybYTMCtpN3IdhdgyUtJ/kzckJugl+ba1Nr/sKlNCGXTBprbK7OiZE7s
         nEVcMF918Cq5iqMcS1FNi9s+4rROmilwnR3WY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=SoKtbaYlQB2652W7YitY3gS6dL4CiYj3U9SChmIoiTktxHR6+lZ+dxaz1v2HtwUbKw
         JnI5dI9D3Ifu4qjoIny+Qw5HdRyOHtdpPlY4fKfG3gn7SywmBuMcbJPjWxc2Cfz/0PDu
         XMoIrTfVcLDw2g8uU2HnuuWSN6XdlcuaasUdc=
Received: by 10.86.4.7 with SMTP id 7mr175505fgd.46.1243970963213;
        Tue, 02 Jun 2009 12:29:23 -0700 (PDT)
Received: from ben-laptop (rn--cgr-1-1-a38.uwaterloo.ca [129.97.253.234])
        by mx.google.com with ESMTPS id 4sm14635305fgg.18.2009.06.02.12.29.20
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 02 Jun 2009 12:29:21 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <cover.1243969358.git.benwillard@gmail.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120537>

find_origin() assumes that there will be only one listing in
diff_queued_diff, but this is not the case when a directory becomes a
file in a single commit.  So, don't fail in this case.

Signed-off-by: Ben Willard <benwillard@gmail.com>
---
 builtin-blame.c  |   12 ++++++++----
 t/t8006-blame.sh |    2 +-
 2 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/builtin-blame.c b/builtin-blame.c
index cf74a92..3e217af 100644
--- a/builtin-blame.c
+++ b/builtin-blame.c
@@ -363,16 +363,14 @@ static struct origin *find_origin(struct scoreboard *sb,
 	diffcore_std(&diff_opts);
 
 	/* It is either one entry that says "modified", or "created",
-	 * or nothing.
+	 * or nothing, or two entries (a "deleted" and an "add").
 	 */
 	if (!diff_queued_diff.nr) {
 		/* The path is the same as parent */
 		porigin = get_origin(sb, parent, origin->path);
 		hashcpy(porigin->blob_sha1, origin->blob_sha1);
 	}
-	else if (diff_queued_diff.nr != 1)
-		die("internal error in blame::find_origin");
-	else {
+	else if (diff_queued_diff.nr == 1) {
 		struct diff_filepair *p = diff_queued_diff.queue[0];
 		switch (p->status) {
 		default:
@@ -388,6 +386,12 @@ static struct origin *find_origin(struct scoreboard *sb,
 			break;
 		}
 	}
+	else if (diff_queued_diff.nr == 2) {
+		/* Both added and removed, (ie. directory became a file) */
+	}
+	else {
+		die("internal error in blame::find_origin");
+	}
 	diff_flush(&diff_opts);
 	diff_tree_release_paths(&diff_opts);
 	if (porigin) {
diff --git a/t/t8006-blame.sh b/t/t8006-blame.sh
index 7c271f0..17f38ff 100755
--- a/t/t8006-blame.sh
+++ b/t/t8006-blame.sh
@@ -14,7 +14,7 @@ test_expect_success 'setup' '
 	git commit -m "Add dir as a file"
 '
 
-test_expect_failure 'blame runs on dir' '
+test_expect_success 'blame runs on dir' '
 	git blame dir
 '
 
-- 
1.6.3.1.279.gd4bf4
