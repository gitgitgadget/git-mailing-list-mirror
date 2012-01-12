From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [BUG] multi-commit cherry-pick messes up the order of commits
Date: Thu, 12 Jan 2012 22:44:18 +0530
Message-ID: <1326388458-5785-1-git-send-email-artagnon@gmail.com>
References: <CALkWK0=Mv_tzNw-hN_9fAr+vABappndEK5iSWQHDk8Yk6Z-stw@mail.gmail.com>
Cc: =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>,
	Christian Couder <christian.couder@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Jan 12 18:16:25 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RlOGG-0008EH-MU
	for gcvg-git-2@lo.gmane.org; Thu, 12 Jan 2012 18:16:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754496Ab2ALRQU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Jan 2012 12:16:20 -0500
Received: from mail-iy0-f174.google.com ([209.85.210.174]:64431 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754297Ab2ALRQU (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Jan 2012 12:16:20 -0500
Received: by iabz25 with SMTP id z25so2992784iab.19
        for <git@vger.kernel.org>; Thu, 12 Jan 2012 09:16:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=Q0Y29j736J/a9vUt+FAeGh2XuzaIrDL/zS/HNK7qgTY=;
        b=G+09H34w17isCOq6LaFbtL7gmF/VPuOeY6LkfFQrV2Qf4fKv0TMYUrW+0yib+epopN
         5MFAc6bqSMZpG6AXf0cDLRxL+AqfpDikNwMUFxcL8sN65AWt9fbJtUBzeczsSxzyIwwo
         1hKUqtpmgpKBqKBSxZ8dtzwdlrw0MNUqGcHYI=
Received: by 10.50.219.234 with SMTP id pr10mr4894930igc.27.1326388579572;
        Thu, 12 Jan 2012 09:16:19 -0800 (PST)
Received: from localhost.localdomain ([203.110.240.205])
        by mx.google.com with ESMTPS id r5sm9692458igl.3.2012.01.12.09.16.15
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 12 Jan 2012 09:16:18 -0800 (PST)
X-Mailer: git-send-email 1.7.8.2
In-Reply-To: <CALkWK0=Mv_tzNw-hN_9fAr+vABappndEK5iSWQHDk8Yk6Z-stw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188458>

Ramkumar Ramachandra wrote:
> My current worktree (WIP):
> [...]

Classic whitespace breakage.  How many times am I going to fall for
the same joke?

diff --git a/builtin/revert.c b/builtin/revert.c
index 0d8020c..47da41b 100644
--- a/builtin/revert.c
+++ b/builtin/revert.c
@@ -228,6 +228,7 @@ static void parse_args(int argc, const char **argv, struct replay_opts *opts)
 		opts->revs = xmalloc(sizeof(*opts->revs));
 		init_revisions(opts->revs, NULL);
 		opts->revs->no_walk = 1;
+		opts->revs->literal_order = 1;
 		if (argc < 2)
 			usage_with_options(usage_str, options);
 		argc = setup_revisions(argc, argv, opts->revs, NULL);
diff --git a/revision.c b/revision.c
index 064e351..301ef58 100644
--- a/revision.c
+++ b/revision.c
@@ -2054,7 +2054,10 @@ int prepare_revision_walk(struct rev_info *revs)
 		if (commit) {
 			if (!(commit->object.flags & SEEN)) {
 				commit->object.flags |= SEEN;
-				commit_list_insert_by_date(commit, &revs->commits);
+				if (revs->literal_order)
+					commit_list_insert(commit, &revs->commits);
+				else
+					commit_list_insert_by_date(commit, &revs->commits);
 			}
 		}
 		e++;
diff --git a/revision.h b/revision.h
index b8e9223..65c3dc3 100644
--- a/revision.h
+++ b/revision.h
@@ -67,6 +67,7 @@ struct rev_info {
 			remove_empty_trees:1,
 			simplify_history:1,
 			lifo:1,
+			literal_order:1,
 			topo_order:1,
 			simplify_merges:1,
 			simplify_by_decoration:1,
