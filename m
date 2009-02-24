From: Jay Soffian <jaysoffian@gmail.com>
Subject: [PATCH 03/23] builtin-remote: teach show to display remote HEAD
Date: Tue, 24 Feb 2009 04:50:51 -0500
Message-ID: <41dd1de0e111b3f135a061848d1e92d9b7994623.1235467368.git.jaysoffian@gmail.com>
References: <cover.1235467368.git.jaysoffian@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Jay Soffian <jaysoffian@gmail.com>, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 24 10:54:43 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lbtzs-0002Ej-QD
	for gcvg-git-2@gmane.org; Tue, 24 Feb 2009 10:54:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755901AbZBXJv3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Feb 2009 04:51:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755828AbZBXJv1
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Feb 2009 04:51:27 -0500
Received: from yx-out-2324.google.com ([74.125.44.30]:21822 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755833AbZBXJvX (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Feb 2009 04:51:23 -0500
Received: by yx-out-2324.google.com with SMTP id 8so1005599yxm.1
        for <git@vger.kernel.org>; Tue, 24 Feb 2009 01:51:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=A10UIg3Rp9n/5RqO0oS6RAaDWMJLQnclmIyjxP1ASt0=;
        b=V5mlRazxGauxm6NsP4ECOT5XHGczIgGxyO7A78evRGlxCetDrbmWT8x67Rn/98Uyw4
         v6gaMgUBg/VExUAZBx4bdpLJPKYahrVWYqwWhYRpYVCea2kl1iMwggFR201Zdu59AaPd
         bvRtPUXDEdDeTtS/SDIgVCGD/ZqVqlfLejYK4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=XB+VrXHeKRCq0sVrM6a1IPtPGfGsSEcFH6OhzLaxw0s/js8P67RFLf+sMPZ4LgtmYj
         gd+YTUFr6E9TAtlFP762O+zH7rpDcn+mKjpaRnXs6mO7GDeHs2LUpsJEEur/5dG8nnlN
         t+AX2uHEkF73nN4EtJkdEcYFnj+P3QRwuhazI=
Received: by 10.100.154.17 with SMTP id b17mr2497203ane.43.1235469082328;
        Tue, 24 Feb 2009 01:51:22 -0800 (PST)
Received: from localhost (cpe-075-182-093-216.nc.res.rr.com [75.182.93.216])
        by mx.google.com with ESMTPS id d29sm10495531and.34.2009.02.24.01.51.21
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 24 Feb 2009 01:51:21 -0800 (PST)
X-Mailer: git-send-email 1.6.2.rc1.291.g83eb
In-Reply-To: <cover.1235467368.git.jaysoffian@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111253>

This is in preparation for teaching remote how to set
refs/remotes/<remote>/HEAD to match what HEAD is set to at <remote>, but
is useful in its own right.

Signed-off-by: Jay Soffian <jaysoffian@gmail.com>
---
 builtin-remote.c  |   26 ++++++++++++++++++++++++++
 t/t5505-remote.sh |    3 ++-
 2 files changed, 28 insertions(+), 1 deletions(-)

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
diff --git a/t/t5505-remote.sh b/t/t5505-remote.sh
index eb63718..826d0c3 100755
--- a/t/t5505-remote.sh
+++ b/t/t5505-remote.sh
@@ -136,6 +136,7 @@ EOF
 cat > test/expect << EOF
 * remote origin
   URL: $(pwd)/one
+  HEAD: master
   Remote branch merged with 'git pull' while on branch master
     master
   New remote branch (next fetch will store in remotes/origin)
@@ -343,7 +344,7 @@ test_expect_success '"remote show" does not show symbolic refs' '
 	git clone one three &&
 	(cd three &&
 	 git remote show origin > output &&
-	 ! grep HEAD < output &&
+	 ! grep "^ *HEAD$" < output &&
 	 ! grep -i stale < output)
 
 '
-- 
1.6.2.rc1.291.g83eb
