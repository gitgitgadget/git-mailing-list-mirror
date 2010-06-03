From: Simo Melenius <simo.melenius@iki.fi>
Subject: [PATCH 1/2] branch: exit status now reflects if branch listing finds an error
Date: Thu,  3 Jun 2010 10:48:01 +0300
Message-ID: <1275551282-21557-1-git-send-email-simo.melenius@iki.fi>
References: <20100603065527.GA23439@progeny.tock>
Cc: git@vger.kernel.org, Simo Melenius <simo.melenius@iki.fi>
To: jrnieder@gmail.com
X-From: git-owner@vger.kernel.org Thu Jun 03 09:49:05 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OK5Ah-0005LT-Hp
	for gcvg-git-2@lo.gmane.org; Thu, 03 Jun 2010 09:48:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757925Ab0FCHsn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Jun 2010 03:48:43 -0400
Received: from mail-pw0-f46.google.com ([209.85.160.46]:44068 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757671Ab0FCHsj (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Jun 2010 03:48:39 -0400
Received: by pwj2 with SMTP id 2so2096226pwj.19
        for <git@vger.kernel.org>; Thu, 03 Jun 2010 00:48:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references;
        bh=HnIdWgdoNX2LnOcTGrjlg8lVwT222Yz0+H0Y1j9HVh0=;
        b=SJS9CFgAJ68qbucweYXXYL+cKSRLvn1XONHuVgwIjyDptQe+VXuD+XJPkmB03rSXQO
         XN3DsgKbd3Ovfd81BSuGiu1DkdDl7k2P+CuuhlUzkY4uQoT24O0DhxPCKMgIikxl4Yw3
         V0AL5JYt8Q68rG1H6x20JtCoJFlaDy2CZg1fY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        b=qMXly7i1Vdkh6AN2zyOsvNirBgbnUrBZCFbUsFCr7dM86oCqHY1dUd7e4QD7uqNtKA
         2yeocPMcUWVDzUbROc3xAO07LqxYE1frQta0v0p3y1d2oLvlgqrVbMz/KT2TxBPkUfBe
         1KM4SXX2o7JEy37WinhVyX35EWWyNCR+tAEmY=
Received: by 10.141.105.19 with SMTP id h19mr7751839rvm.281.1275551319172;
        Thu, 03 Jun 2010 00:48:39 -0700 (PDT)
Received: from localhost.localdomain (xdsl-83-150-84-41.nebulazone.fi [83.150.84.41])
        by mx.google.com with ESMTPS id h11sm2833977rvm.0.2010.06.03.00.48.36
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 03 Jun 2010 00:48:38 -0700 (PDT)
X-Mailer: git-send-email 1.7.0.4
In-Reply-To: <20100603065527.GA23439@progeny.tock>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148297>

If some refs could not be read when listing branches, this can now be
observed in the exit status of the "git branch" command.

Signed-off-by: Simo Melenius <simo.melenius@iki.fi>
---
 builtin/branch.c |   25 ++++++++++++++++++++-----
 1 files changed, 20 insertions(+), 5 deletions(-)

diff --git a/builtin/branch.c b/builtin/branch.c
index 6cf7e72..46ca59c 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -257,9 +257,16 @@ static char *resolve_symref(const char *src, const char *prefix)
 	return xstrdup(dst);
 }
 
+struct append_ref_cb
+{
+	struct ref_list *ref_list;
+	int ret;
+};
+
 static int append_ref(const char *refname, const unsigned char *sha1, int flags, void *cb_data)
 {
-	struct ref_list *ref_list = (struct ref_list*)(cb_data);
+	struct append_ref_cb *cb = (struct append_ref_cb*)(cb_data);
+	struct ref_list *ref_list = cb->ref_list;
 	struct ref_item *newitem;
 	struct commit *commit;
 	int kind, i;
@@ -294,7 +301,10 @@ static int append_ref(const char *refname, const unsigned char *sha1, int flags,
 	if (ref_list->verbose || ref_list->with_commit || merge_filter != NO_FILTER) {
 		commit = lookup_commit_reference_gently(sha1, 1);
 		if (!commit)
-			return error("branch '%s' does not point at a commit", refname);
+		{
+			cb->ret = error("branch '%s' does not point at a commit", refname);
+			return cb->ret;
+		}
 
 		/* Filter with with_commit if specified */
 		if (!is_descendant_of(commit, ref_list->with_commit))
@@ -484,9 +494,10 @@ static void show_detached(struct ref_list *ref_list)
 	}
 }
 
-static void print_ref_list(int kinds, int detached, int verbose, int abbrev, struct commit_list *with_commit)
+static int print_ref_list(int kinds, int detached, int verbose, int abbrev, struct commit_list *with_commit)
 {
 	int i;
+	struct append_ref_cb cb;
 	struct ref_list ref_list;
 
 	memset(&ref_list, 0, sizeof(ref_list));
@@ -496,7 +507,9 @@ static void print_ref_list(int kinds, int detached, int verbose, int abbrev, str
 	ref_list.with_commit = with_commit;
 	if (merge_filter != NO_FILTER)
 		init_revisions(&ref_list.revs, NULL);
-	for_each_rawref(append_ref, &ref_list);
+	cb.ref_list = &ref_list;
+	cb.ret = 0;
+	for_each_rawref(append_ref, &cb);
 	if (merge_filter != NO_FILTER) {
 		struct commit *filter;
 		filter = lookup_commit_reference_gently(merge_filter_ref, 0);
@@ -527,6 +540,8 @@ static void print_ref_list(int kinds, int detached, int verbose, int abbrev, str
 	}
 
 	free_ref_list(&ref_list);
+
+	return cb.ret;
 }
 
 static void rename_branch(const char *oldname, const char *newname, int force)
@@ -679,7 +694,7 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
 	if (delete)
 		return delete_branches(argc, argv, delete > 1, kinds);
 	else if (argc == 0)
-		print_ref_list(kinds, detached, verbose, abbrev, with_commit);
+		return print_ref_list(kinds, detached, verbose, abbrev, with_commit);
 	else if (rename && (argc == 1))
 		rename_branch(head, argv[0], rename > 1);
 	else if (rename && (argc == 2))
-- 
1.7.0.4
