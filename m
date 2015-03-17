From: Jeff King <peff@peff.net>
Subject: [PATCH 2/5] refs: introduce a "ref paranoia" flag
Date: Tue, 17 Mar 2015 03:29:57 -0400
Message-ID: <20150317072957.GB25191@peff.net>
References: <20150317072750.GA22155@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Michael Haggerty <mhagger@alum.mit.edu>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 17 08:30:10 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YXlx2-0004lI-9l
	for gcvg-git-2@plane.gmane.org; Tue, 17 Mar 2015 08:30:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752505AbbCQHaD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Mar 2015 03:30:03 -0400
Received: from cloud.peff.net ([50.56.180.127]:33914 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752486AbbCQH37 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Mar 2015 03:29:59 -0400
Received: (qmail 25576 invoked by uid 102); 17 Mar 2015 07:30:00 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 17 Mar 2015 02:29:59 -0500
Received: (qmail 22804 invoked by uid 107); 17 Mar 2015 07:30:10 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 17 Mar 2015 03:30:10 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 17 Mar 2015 03:29:57 -0400
Content-Disposition: inline
In-Reply-To: <20150317072750.GA22155@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265615>

Most operations that iterate over refs are happy to ignore
broken cruft. However, some operations should be performed
with knowledge of these broken refs, because it is better
for the operation to choke on a missing object than it is to
silently pretend that the ref did not exist (e.g., if we are
computing the set of reachable tips in order to prune
objects).

These processes could just call for_each_rawref, except that
ref iteration is often hidden behind other interfaces. For
instance, for a destructive "repack -ad", we would have to
inform "pack-objects" that we are destructive, and then it
would in turn have to tell the revision code that our
"--all" should include broken refs.

It's much simpler to just set a global for "dangerous"
operations that includes broken refs in all iterations.

Signed-off-by: Jeff King <peff@peff.net>
---
I waffled on documenting this for end users. I'm not sure if people
would ever want to actually use the environment variable themselves. The
best hypothetical I could come up with was the:

  git clone --no-local repo.git backup.git &&
  rm -rf repo.git

scenario.

 Documentation/git.txt | 11 +++++++++++
 cache.h               |  8 ++++++++
 environment.c         |  1 +
 refs.c                |  5 +++++
 4 files changed, 25 insertions(+)

diff --git a/Documentation/git.txt b/Documentation/git.txt
index af30620..8da85a6 100644
--- a/Documentation/git.txt
+++ b/Documentation/git.txt
@@ -1026,6 +1026,17 @@ GIT_ICASE_PATHSPECS::
 	variable when it is invoked as the top level command by the
 	end user, to be recorded in the body of the reflog.
 
+`GIT_REF_PARANOIA`::
+	If set to `1`, include broken or badly named refs when iterating
+	over lists of refs. In a normal, non-corrupted repository, this
+	does nothing. However, enabling it may help git to detect and
+	abort some operations in the presence of broken refs. Git sets
+	this variable automatically when performing destructive
+	operations like linkgit:git-prune[1]. You should not need to set
+	it yourself unless you want to be paranoid about making sure
+	an operation has touched every ref (e.g., because you are
+	cloning a repository to make a backup).
+
 
 Discussion[[Discussion]]
 ------------------------
diff --git a/cache.h b/cache.h
index 761c570..162ea6f 100644
--- a/cache.h
+++ b/cache.h
@@ -614,6 +614,14 @@ extern int protect_hfs;
 extern int protect_ntfs;
 
 /*
+ * Include broken refs in all ref iterations, which will
+ * generally choke dangerous operations rather than letting
+ * them silently proceed without taking the broken ref into
+ * account.
+ */
+extern int ref_paranoia;
+
+/*
  * The character that begins a commented line in user-editable file
  * that is subject to stripspace.
  */
diff --git a/environment.c b/environment.c
index 1ade5c9..a40044c 100644
--- a/environment.c
+++ b/environment.c
@@ -24,6 +24,7 @@ int is_bare_repository_cfg = -1; /* unspecified */
 int log_all_ref_updates = -1; /* unspecified */
 int warn_ambiguous_refs = 1;
 int warn_on_object_refname_ambiguity = 1;
+int ref_paranoia = -1;
 int repository_format_version;
 const char *git_commit_encoding;
 const char *git_log_output_encoding;
diff --git a/refs.c b/refs.c
index e23542b..7f0e7be 100644
--- a/refs.c
+++ b/refs.c
@@ -1934,6 +1934,11 @@ static int do_for_each_ref(struct ref_cache *refs, const char *base,
 	data.fn = fn;
 	data.cb_data = cb_data;
 
+	if (ref_paranoia < 0)
+		ref_paranoia = git_env_bool("GIT_REF_PARANOIA", 0);
+	if (ref_paranoia)
+		data.flags |= DO_FOR_EACH_INCLUDE_BROKEN;
+
 	return do_for_each_entry(refs, base, do_one_ref, &data);
 }
 
-- 
2.3.3.520.g3cfbb5d
