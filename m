From: Jay Soffian <jaysoffian@gmail.com>
Subject: [PATCH 3/4] builtin-remote: teach show to display remote HEAD
Date: Fri, 13 Feb 2009 03:54:34 -0500
Message-ID: <1234515275-91263-4-git-send-email-jaysoffian@gmail.com>
References: <1234515275-91263-1-git-send-email-jaysoffian@gmail.com>
 <1234515275-91263-2-git-send-email-jaysoffian@gmail.com>
 <1234515275-91263-3-git-send-email-jaysoffian@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Jay Soffian <jaysoffian@gmail.com>, peff@peff.net,
	gitster@pobox.com, barkalow@iabervon.org
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 13 09:56:42 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LXtqe-0003hw-8J
	for gcvg-git-2@gmane.org; Fri, 13 Feb 2009 09:56:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752760AbZBMIyt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Feb 2009 03:54:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752235AbZBMIys
	(ORCPT <rfc822;git-outgoing>); Fri, 13 Feb 2009 03:54:48 -0500
Received: from an-out-0708.google.com ([209.85.132.250]:64096 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752134AbZBMIyp (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Feb 2009 03:54:45 -0500
Received: by an-out-0708.google.com with SMTP id c2so626868anc.1
        for <git@vger.kernel.org>; Fri, 13 Feb 2009 00:54:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=CTh2ZDNDBDF9i8x5N1MfcyqzGhdryt5XygwGzne9nXQ=;
        b=Xg+Hrg8iqno/mgeGwQXQJX0G6NzkP7nxNnxHOtysZzU1q88m5MTe1hyaGt81Ae2QqH
         GPg7aJn3qpWgvWhpObXaRzcIyDcOEPcWv55T/uUIxLHktESYgBbEpKuVLCqyhA7UEDJq
         aIbkAMRyzXzEXFJ2Y/dwgaiIUAr3/e/IVewGo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=rw/qJWDAS/+Z6odSmqJqAMwdBN97QGO0+lLzFDxt+Ce1s5y3AgOAGE8UXEjjyXZQ9G
         cBmE33bykmIx8ljnsLHbJWRjXY7mQM22slB8AjHgRNDOJP2DMdFwN8aMnCufAD2iOPbC
         J5xsh3CheXy+jfRLbhTozJw/88IIcHwdGP+q8=
Received: by 10.100.133.1 with SMTP id g1mr2534442and.15.1234515284238;
        Fri, 13 Feb 2009 00:54:44 -0800 (PST)
Received: from localhost (cpe-075-182-093-216.nc.res.rr.com [75.182.93.216])
        by mx.google.com with ESMTPS id d38sm1992087and.49.2009.02.13.00.54.43
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 13 Feb 2009 00:54:43 -0800 (PST)
X-Mailer: git-send-email 1.6.2.rc0.209.g7c178
In-Reply-To: <1234515275-91263-3-git-send-email-jaysoffian@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109731>

This is in preparation for teaching remote how to set
refs/remotes/<remote>/HEAD to match what HEAD is set to at <remote>, but
is useful in its own right.

Signed-off-by: Jay Soffian <jaysoffian@gmail.com>
---
 builtin-remote.c |   26 ++++++++++++++++++++++++++
 1 files changed, 26 insertions(+), 0 deletions(-)

diff --git a/builtin-remote.c b/builtin-remote.c
index b89a353..465c87a 100644
--- a/builtin-remote.c
+++ b/builtin-remote.c
@@ -212,6 +212,7 @@ static void read_branches(void)
 struct ref_states {
 	struct remote *remote;
 	struct string_list new, stale, tracked;
+	char *head_name;
 };
 
 static int handle_one_branch(const char *refname,
@@ -271,6 +272,26 @@ static int get_ref_states(const struct ref *ref, struct ref_states *states)
 	return 0;
 }
 
+static char *get_head_name(const struct ref *refs)
+{
+	const struct ref *head_points_at;
+	struct ref *mapped_refs = NULL;
+	struct ref **tail = &mapped_refs;
+	struct refspec refspec;
+
+	refspec.force = 0;
+	refspec.pattern = 1;
+	refspec.src = refspec.dst = "refs/heads/";
+
+	get_fetch_map(refs, &refspec, &tail, 0);
+
+	head_points_at = guess_remote_head(refs, mapped_refs, NULL);
+	if (head_points_at)
+		return xstrdup(abbrev_branch(head_points_at->name));
+
+	return NULL;
+}
+
 struct known_remote {
 	struct known_remote *next;
 	struct remote *remote;
@@ -637,6 +658,7 @@ static void free_remote_ref_states(struct ref_states *states)
 	string_list_clear(&states->new, 0);
 	string_list_clear(&states->stale, 0);
 	string_list_clear(&states->tracked, 0);
+	free(states->head_name);
 }
 
 static int get_remote_ref_states(const char *name,
@@ -658,6 +680,7 @@ static int get_remote_ref_states(const char *name,
 		ref = transport_get_remote_refs(transport);
 		transport_disconnect(transport);
 
+		states->head_name = get_head_name(ref);
 		get_ref_states(ref, states);
 	}
 
@@ -702,6 +725,9 @@ static int show(int argc, const char **argv)
 		printf("* remote %s\n  URL: %s\n", *argv,
 			states.remote->url_nr > 0 ?
 				states.remote->url[0] : "(no URL)");
+		if (!no_query)
+			printf("  HEAD: %s\n", states.head_name ?
+				states.head_name : "(unknown)");
 
 		for (i = 0; i < branch_list.nr; i++) {
 			struct string_list_item *branch = branch_list.items + i;
-- 
1.6.2.rc0.209.g7c178
