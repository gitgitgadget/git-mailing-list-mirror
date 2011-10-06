From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: [PATCH v3 2/5] cleanup: use internal memory allocation wrapper functions everywhere
Date: Thu,  6 Oct 2011 13:22:22 -0500
Message-ID: <U4wiHVyDLLG1PhI-8iY3YhQhUEJpupTAsAMAf7ha--5LJd-HaCPI_bAfH_gLpi4Z_VB9uFLivO__yWGFob6NjBHVz3Jg2A4WNU2nLePu9VdvuY0-bP95SnEKthVUIq_iVrm6ELT6mec@cipher.nrlssc.navy.mil>
References: <VYN8m1JCy102-eaWWa-bsunEvt3zeXLJkVg7FZKZCtXT-Ww0vg7a8xA7NTvrZTiovKTnJ9Hlom0@cipher.nrlssc.navy.mil>
Cc: git@vger.kernel.org, peff@peff.net, j.sixt@viscovery.net,
	Brandon Casey <drafnel@gmail.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Thu Oct 06 20:23:11 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RBsb8-0002ZA-MI
	for gcvg-git-2@lo.gmane.org; Thu, 06 Oct 2011 20:23:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758899Ab1JFSXA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Oct 2011 14:23:00 -0400
Received: from mail4.nrlssc.navy.mil ([128.160.11.9]:45183 "EHLO
	mail3.nrlssc.navy.mil" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1758841Ab1JFSW6 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Oct 2011 14:22:58 -0400
Received: by mail3.nrlssc.navy.mil id p96IMoHB031883; Thu, 6 Oct 2011 13:22:50 -0500
In-Reply-To: <VYN8m1JCy102-eaWWa-bsunEvt3zeXLJkVg7FZKZCtXT-Ww0vg7a8xA7NTvrZTiovKTnJ9Hlom0@cipher.nrlssc.navy.mil>
X-OriginalArrivalTime: 06 Oct 2011 18:22:49.0974 (UTC) FILETIME=[F46C0160:01CC8454]
X-Virus-Scanned: clamav-milter 0.97.2 at mail4
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183007>

From: Brandon Casey <drafnel@gmail.com>

The "x"-prefixed versions of strdup, malloc, etc. will check whether the
allocation was successful and terminate the process otherwise.

A few uses of malloc were left alone since they already implemented a
graceful path of failure or were in a quasi external library like xdiff.

Additionally, the call to malloc in compat/win32/syslog.c was not modified
since the syslog() implemented there is a die handler and a call to the
x-wrappers within a die handler could result in recursion should memory
allocation fail.  This will have to be addressed separately.

Signed-off-by: Brandon Casey <drafnel@gmail.com>
---
 attr.c             |    2 +-
 builtin/mv.c       |    2 +-
 compat/mingw.c     |    2 +-
 compat/qsort.c     |    2 +-
 remote.c           |    2 +-
 show-index.c       |    2 +-
 transport-helper.c |    4 ++--
 7 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/attr.c b/attr.c
index fe38fcc..0793859 100644
--- a/attr.c
+++ b/attr.c
@@ -533,7 +533,7 @@ static void bootstrap_attr_stack(void)
 
 		if (!is_bare_repository() || direction == GIT_ATTR_INDEX) {
 			elem = read_attr(GITATTRIBUTES_FILE, 1);
-			elem->origin = strdup("");
+			elem->origin = xstrdup("");
 			elem->prev = attr_stack;
 			attr_stack = elem;
 			debug_push(elem);
diff --git a/builtin/mv.c b/builtin/mv.c
index 40f33ca..e9d191f 100644
--- a/builtin/mv.c
+++ b/builtin/mv.c
@@ -29,7 +29,7 @@ static const char **copy_pathspec(const char *prefix, const char **pathspec,
 			to_copy--;
 		if (to_copy != length || base_name) {
 			char *it = xmemdupz(result[i], to_copy);
-			result[i] = base_name ? strdup(basename(it)) : it;
+			result[i] = base_name ? xstrdup(basename(it)) : it;
 		}
 	}
 	return get_pathspec(prefix, result);
diff --git a/compat/mingw.c b/compat/mingw.c
index 6ef0cc4..8947418 100644
--- a/compat/mingw.c
+++ b/compat/mingw.c
@@ -1183,7 +1183,7 @@ static int WSAAPI getaddrinfo_stub(const char *node, const char *service,
 	}
 	ai->ai_addrlen = sizeof(struct sockaddr_in);
 	if (hints && (hints->ai_flags & AI_CANONNAME))
-		ai->ai_canonname = h ? strdup(h->h_name) : NULL;
+		ai->ai_canonname = h ? xstrdup(h->h_name) : NULL;
 	else
 		ai->ai_canonname = NULL;
 
diff --git a/compat/qsort.c b/compat/qsort.c
index d93dce2..9574d53 100644
--- a/compat/qsort.c
+++ b/compat/qsort.c
@@ -55,7 +55,7 @@ void git_qsort(void *b, size_t n, size_t s,
 		msort_with_tmp(b, n, s, cmp, buf);
 	} else {
 		/* It's somewhat large, so malloc it.  */
-		char *tmp = malloc(size);
+		char *tmp = xmalloc(size);
 		msort_with_tmp(b, n, s, cmp, tmp);
 		free(tmp);
 	}
diff --git a/remote.c b/remote.c
index b8ecfa5..7840d2f 100644
--- a/remote.c
+++ b/remote.c
@@ -840,7 +840,7 @@ char *apply_refspecs(struct refspec *refspecs, int nr_refspec,
 						    refspec->dst, &ret))
 				return ret;
 		} else if (!strcmp(refspec->src, name))
-			return strdup(refspec->dst);
+			return xstrdup(refspec->dst);
 	}
 	return NULL;
 }
diff --git a/show-index.c b/show-index.c
index 4c0ac13..63f9da5 100644
--- a/show-index.c
+++ b/show-index.c
@@ -48,7 +48,7 @@ int main(int argc, char **argv)
 			unsigned char sha1[20];
 			uint32_t crc;
 			uint32_t off;
-		} *entries = malloc(nr * sizeof(entries[0]));
+		} *entries = xmalloc(nr * sizeof(entries[0]));
 		for (i = 0; i < nr; i++)
 			if (fread(entries[i].sha1, 20, 1, stdin) != 1)
 				die("unable to read sha1 %u/%u", i, nr);
diff --git a/transport-helper.c b/transport-helper.c
index 4eab844..0713126 100644
--- a/transport-helper.c
+++ b/transport-helper.c
@@ -183,7 +183,7 @@ static struct child_process *get_helper(struct transport *transport)
 			ALLOC_GROW(refspecs,
 				   refspec_nr + 1,
 				   refspec_alloc);
-			refspecs[refspec_nr++] = strdup(capname + strlen("refspec "));
+			refspecs[refspec_nr++] = xstrdup(capname + strlen("refspec "));
 		} else if (!strcmp(capname, "connect")) {
 			data->connect = 1;
 		} else if (!prefixcmp(capname, "export-marks ")) {
@@ -445,7 +445,7 @@ static int fetch_with_import(struct transport *transport,
 		if (data->refspecs)
 			private = apply_refspecs(data->refspecs, data->refspec_nr, posn->name);
 		else
-			private = strdup(posn->name);
+			private = xstrdup(posn->name);
 		read_ref(private, posn->old_sha1);
 		free(private);
 	}
-- 
1.7.7
