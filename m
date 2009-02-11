From: Jay Soffian <jaysoffian@gmail.com>
Subject: [PATCH 2/3] builtin-remote: teach show to display remote HEAD
Date: Wed, 11 Feb 2009 01:01:22 -0500
Message-ID: <1234332083-45147-3-git-send-email-jaysoffian@gmail.com>
References: <1234332083-45147-1-git-send-email-jaysoffian@gmail.com>
 <1234332083-45147-2-git-send-email-jaysoffian@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Jay Soffian <jaysoffian@gmail.com>, gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 11 07:02:59 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LX8BV-0008EH-Nx
	for gcvg-git-2@gmane.org; Wed, 11 Feb 2009 07:02:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751207AbZBKGBd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Feb 2009 01:01:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751177AbZBKGBd
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Feb 2009 01:01:33 -0500
Received: from an-out-0708.google.com ([209.85.132.246]:18162 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751191AbZBKGBb (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Feb 2009 01:01:31 -0500
Received: by an-out-0708.google.com with SMTP id c2so32219anc.1
        for <git@vger.kernel.org>; Tue, 10 Feb 2009 22:01:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=aSkCfgb37giIZEd6CZ/GCJwA0BQUbdPA3Hhcl6WrKV8=;
        b=D3qzwnLn3T5uZdd65RwC2oCsXoQKJ4w342fkBHlyygBETJN2pw58biZK6eJUB/084n
         Px9sXw1Xp542+zaRcPkSkid+QS86DdC+wBU8tB1Sn6tL78UMgD+6wK2BCTIQNdR7xA1I
         BkQ3MfqxpXWgVrQyabqHxxwe9nPTdlgu93TK0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=eFwy3ahb6lPeFpkzZKOYK6JMqi8YbfbRcHe9dvSSKF3NUbw0c1UflcsO3JYL/0KZBB
         zDyHROOfJ395HAPHlsamSWK82aCA8gGPta4Nkl3DogGkH3zTgrUWaGjmz29U+calLrKY
         PJe0nqSp0FW+Bjxg+nt4Mf/9IH9JLpAQwms64=
Received: by 10.100.46.10 with SMTP id t10mr853374ant.52.1234332090555;
        Tue, 10 Feb 2009 22:01:30 -0800 (PST)
Received: from localhost (cpe-075-182-093-216.nc.res.rr.com [75.182.93.216])
        by mx.google.com with ESMTPS id d21sm7707478and.6.2009.02.10.22.01.29
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 10 Feb 2009 22:01:29 -0800 (PST)
X-Mailer: git-send-email 1.6.2.rc0.187.g9fcfb
In-Reply-To: <1234332083-45147-2-git-send-email-jaysoffian@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109376>

The remote HEAD cannot be determined unambiguosly, so use the same
heuristics as builtin-clone's locate_head().

Signed-off-by: Jay Soffian <jaysoffian@gmail.com>
---
 builtin-remote.c |   39 +++++++++++++++++++++++++++++++++++++++
 1 files changed, 39 insertions(+), 0 deletions(-)

diff --git a/builtin-remote.c b/builtin-remote.c
index 00e7ca5..0be8bfd 100644
--- a/builtin-remote.c
+++ b/builtin-remote.c
@@ -212,6 +212,7 @@ static void read_branches(void)
 struct ref_states {
 	struct remote *remote;
 	struct string_list new, stale, tracked;
+	char *head_name;
 };
 
 static int handle_one_branch(const char *refname,
@@ -271,6 +272,38 @@ static int get_ref_states(const struct ref *ref, struct ref_states *states)
 	return 0;
 }
 
+static char *get_head_name(const struct ref *ref)
+{
+	const struct ref *remote_head = NULL;
+	const struct ref *remote_master = NULL;
+	const struct ref *r;
+	for (r = ref; r; r = r->next) {
+		if (!strcmp(r->name, "HEAD"))
+			remote_head = r;
+		if (!strcmp(r->name, "refs/heads/master"))
+			remote_master = r;
+	}
+
+	/* If there's no HEAD value at all, never mind. */
+	if (!remote_head)
+		return NULL;
+
+	/* If refs/heads/master could be right, it is. */
+	if (remote_master && !hashcmp(remote_master->old_sha1,
+				      remote_head->old_sha1))
+		return xstrdup(abbrev_branch(remote_master->name));
+
+	/* Look for another ref that points there */
+	for (r = ref; r; r = r->next)
+		if (r != remote_head &&
+		    !hashcmp(r->old_sha1, remote_head->old_sha1) &&
+		    !prefixcmp(r->name, "refs/heads/"))
+			return xstrdup(abbrev_branch(r->name));
+
+	/* Nothing is the same */
+	return NULL;
+}
+
 struct known_remote {
 	struct known_remote *next;
 	struct remote *remote;
@@ -638,6 +671,8 @@ static void free_remote_ref_states(struct ref_states *states)
 	string_list_clear(&states->new, 0);
 	string_list_clear(&states->stale, 0);
 	string_list_clear(&states->tracked, 0);
+	if (states->head_name)
+		free(states->head_name);
 }
 
 static int get_remote_ref_states(const char *name,
@@ -659,6 +694,7 @@ static int get_remote_ref_states(const char *name,
 		ref = transport_get_remote_refs(transport);
 		transport_disconnect(transport);
 
+		states->head_name = get_head_name(ref);
 		get_ref_states(ref, states);
 	}
 
@@ -703,6 +739,9 @@ static int show(int argc, const char **argv)
 		printf("* remote %s\n  URL: %s\n", *argv,
 			states.remote->url_nr > 0 ?
 				states.remote->url[0] : "(no URL)");
+		if (!no_query)
+			printf("  HEAD: %s\n", states.head_name ?
+				states.head_name : "(unknown)");
 
 		for (i = 0; i < branch_list.nr; i++) {
 			struct string_list_item *branch = branch_list.items + i;
-- 
1.6.2.rc0.187.g9fcfb
