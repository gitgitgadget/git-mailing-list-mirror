From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] Teach progress eye-candy to fetch_refs_from_bundle()
Date: Sun, 18 Sep 2011 16:52:32 -0700
Message-ID: <7vmxe1be7z.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Shawn O. Pearce" <spearce@spearce.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 19 01:52:44 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R5RAA-0007wQ-37
	for gcvg-git-2@lo.gmane.org; Mon, 19 Sep 2011 01:52:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932698Ab1IRXwh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 18 Sep 2011 19:52:37 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:58497 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932620Ab1IRXwg (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Sep 2011 19:52:36 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5E70E59B8;
	Sun, 18 Sep 2011 19:52:35 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:mime-version:content-type; s=sasl; bh=2
	ZHvkBsZ0Z9AWPjSO6dM6L4BDUw=; b=jfPJLjnspqLe4K809/EsdX2augvior2lo
	5vAnvlZbE+3SMa5dplISdbbakxcFDcsqnHf2Wm56aoxFdbZsNUKSNMF+AL+7imvc
	UIFCJrx2xDzNzCUK8WjZ3WriW6CnDe/O66pKNB8B0NeXkYOdtQoNgF8RfxZMmcWl
	/BE/qC3F5A=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:message-id:mime-version:content-type; q=dns; s=
	sasl; b=bacBDO4o3Qez0VFV6L0th2hK05SfCvapo+LU3HOjZJ49x2PtdUnq9wMZ
	KhPPMM4xAtrUxjEmVVhKsXfS8T63kitdUlYMhO7tA8vqPijkni0d5em2mjYL1gGv
	mfb7ksNHVXctqf6jrsahfCqErKjUZSK+NocfJELs3HpnKiur6eA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 554E559B7;
	Sun, 18 Sep 2011 19:52:35 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 8571959B5; Sun, 18 Sep 2011
 19:52:34 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 47C74D9C-E251-11E0-957F-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181655>

With the usual "git" transport, a large-ish transfer with "git fetch" and
"git pull" give progress eye-candy to avoid boring users.  However, not
when they are reading from a bundle. I.e.

    $ git pull ../git-bundle.bndl master

This teaches bundle.c:unbundle() to give "-v" option to index-pack and
tell it to give progress bar when transport decides it is necessary.

The operation in the other direction, "git bundle create", could also
learn to honor --quiet but that is a separate issue.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/bundle.c |    2 +-
 bundle.c         |    7 +++++--
 bundle.h         |    3 ++-
 transport.c      |    3 ++-
 4 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/builtin/bundle.c b/builtin/bundle.c
index 81046a9..92a8a60 100644
--- a/builtin/bundle.c
+++ b/builtin/bundle.c
@@ -58,7 +58,7 @@ int cmd_bundle(int argc, const char **argv, const char *prefix)
 	} else if (!strcmp(cmd, "unbundle")) {
 		if (!startup_info->have_repository)
 			die(_("Need a repository to unbundle."));
-		return !!unbundle(&header, bundle_fd) ||
+		return !!unbundle(&header, bundle_fd, 0) ||
 			list_bundle_refs(&header, argc, argv);
 	} else
 		usage(builtin_bundle_usage);
diff --git a/bundle.c b/bundle.c
index f48fd7d..6bf8497 100644
--- a/bundle.c
+++ b/bundle.c
@@ -380,12 +380,15 @@ int create_bundle(struct bundle_header *header, const char *path,
 	return 0;
 }
 
-int unbundle(struct bundle_header *header, int bundle_fd)
+int unbundle(struct bundle_header *header, int bundle_fd, int flags)
 {
 	const char *argv_index_pack[] = {"index-pack",
-		"--fix-thin", "--stdin", NULL};
+					 "--fix-thin", "--stdin", NULL, NULL};
 	struct child_process ip;
 
+	if (flags & BUNDLE_VERBOSE)
+		argv_index_pack[3] = "-v";
+
 	if (verify_bundle(header, 0))
 		return -1;
 	memset(&ip, 0, sizeof(ip));
diff --git a/bundle.h b/bundle.h
index e2aedd6..c5a22c8 100644
--- a/bundle.h
+++ b/bundle.h
@@ -18,7 +18,8 @@ int read_bundle_header(const char *path, struct bundle_header *header);
 int create_bundle(struct bundle_header *header, const char *path,
 		int argc, const char **argv);
 int verify_bundle(struct bundle_header *header, int verbose);
-int unbundle(struct bundle_header *header, int bundle_fd);
+#define BUNDLE_VERBOSE 1
+int unbundle(struct bundle_header *header, int bundle_fd, int flags);
 int list_bundle_refs(struct bundle_header *header,
 		int argc, const char **argv);
 
diff --git a/transport.c b/transport.c
index fa279d5..e194061 100644
--- a/transport.c
+++ b/transport.c
@@ -432,7 +432,8 @@ static int fetch_refs_from_bundle(struct transport *transport,
 			       int nr_heads, struct ref **to_fetch)
 {
 	struct bundle_transport_data *data = transport->data;
-	return unbundle(&data->header, data->fd);
+	return unbundle(&data->header, data->fd,
+			transport->progress ? BUNDLE_VERBOSE : 0);
 }
 
 static int close_bundle(struct transport *transport)
