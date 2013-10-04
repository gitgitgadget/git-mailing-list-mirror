From: Jeff King <peff@peff.net>
Subject: [PATCH] for-each-ref: avoid loading objects to print %(objectname)
Date: Fri, 4 Oct 2013 03:56:07 -0400
Message-ID: <20131004075606.GA26197@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 04 09:56:15 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VS0FC-0005W7-Hz
	for gcvg-git-2@plane.gmane.org; Fri, 04 Oct 2013 09:56:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752025Ab3JDH4L (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Oct 2013 03:56:11 -0400
Received: from cloud.peff.net ([50.56.180.127]:34036 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750842Ab3JDH4K (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Oct 2013 03:56:10 -0400
Received: (qmail 31797 invoked by uid 102); 4 Oct 2013 07:56:09 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 04 Oct 2013 02:56:09 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 04 Oct 2013 03:56:07 -0400
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235704>

If you ask for-each-ref to print each ref and its object,
like:

  git for-each-ref --format='%(objectname) %(refname)'

this should involve little more work than looking at the ref
files themselves (along with packed-refs). However,
for-each-ref will actually load each object from disk just
to print its sha1. For most repositories, this isn't a big
deal, but it can be noticeable if you have a large number of
refs to print. Here are best-of-five timings for the command
above on a repo with ~10K refs:

  [before]
  real    0m0.112s
  user    0m0.092s
  sys     0m0.016s

  [after]
  real    0m0.014s
  user    0m0.012s
  sys     0m0.000s

This patch checks for %(objectname) and %(objectname:short)
before we actually parse the object (and the rest of the
code is smart enough to avoid parsing if we have filled all
of our placeholders).

Note that we can't simply move the objectname parsing code
into the early loop. If the "deref" form %(*objectname) is
used, then we do need to parse the object in order to peel
the tag. So instead of moving the code, we factor it out
into a separate function that can be called for both cases.

While we're at it, we add some basic tests for the
dereferenced placeholders, which were not tested at all
before. This helps ensure we didn't regress that case.

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/for-each-ref.c  | 29 ++++++++++++++++++++---------
 t/t6300-for-each-ref.sh |  4 ++++
 2 files changed, 24 insertions(+), 9 deletions(-)

diff --git a/builtin/for-each-ref.c b/builtin/for-each-ref.c
index 1d4083c..d096051 100644
--- a/builtin/for-each-ref.c
+++ b/builtin/for-each-ref.c
@@ -205,6 +205,22 @@ static void *get_obj(const unsigned char *sha1, struct object **obj, unsigned lo
 	return buf;
 }
 
+static int grab_objectname(const char *name, const unsigned char *sha1,
+			    struct atom_value *v)
+{
+	if (!strcmp(name, "objectname")) {
+		char *s = xmalloc(41);
+		strcpy(s, sha1_to_hex(sha1));
+		v->s = s;
+		return 1;
+	}
+	if (!strcmp(name, "objectname:short")) {
+		v->s = xstrdup(find_unique_abbrev(sha1, DEFAULT_ABBREV));
+		return 1;
+	}
+	return 0;
+}
+
 /* See grab_values */
 static void grab_common_values(struct atom_value *val, int deref, struct object *obj, void *buf, unsigned long sz)
 {
@@ -225,15 +241,8 @@ static void grab_common_values(struct atom_value *val, int deref, struct object
 			v->ul = sz;
 			v->s = s;
 		}
-		else if (!strcmp(name, "objectname")) {
-			char *s = xmalloc(41);
-			strcpy(s, sha1_to_hex(obj->sha1));
-			v->s = s;
-		}
-		else if (!strcmp(name, "objectname:short")) {
-			v->s = xstrdup(find_unique_abbrev(obj->sha1,
-							  DEFAULT_ABBREV));
-		}
+		else if (deref)
+			grab_objectname(name, obj->sha1, v);
 	}
 }
 
@@ -676,6 +685,8 @@ static void populate_value(struct refinfo *ref)
 			}
 			continue;
 		}
+		else if (!deref && grab_objectname(name, ref->objectname, v))
+			continue;
 		else
 			continue;
 
diff --git a/t/t6300-for-each-ref.sh b/t/t6300-for-each-ref.sh
index 752f5cb..2b4b9a9 100755
--- a/t/t6300-for-each-ref.sh
+++ b/t/t6300-for-each-ref.sh
@@ -58,6 +58,8 @@ test_atom head type ''
 test_atom head numparent 0
 test_atom head object ''
 test_atom head type ''
+test_atom head *objectname ''
+test_atom head *objecttype ''
 test_atom head author 'A U Thor <author@example.com> 1151939924 +0200'
 test_atom head authorname 'A U Thor'
 test_atom head authoremail '<author@example.com>'
@@ -91,6 +93,8 @@ test_atom tag type 'commit'
 test_atom tag numparent ''
 test_atom tag object '67a36f10722846e891fbada1ba48ed035de75581'
 test_atom tag type 'commit'
+test_atom tag *objectname '67a36f10722846e891fbada1ba48ed035de75581'
+test_atom tag *objecttype 'commit'
 test_atom tag author ''
 test_atom tag authorname ''
 test_atom tag authoremail ''
-- 
1.8.4.1.4.gf327177
