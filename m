From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] Fix "unpack-objects --strict"
Date: Thu, 13 Aug 2009 12:33:45 -0700
Message-ID: <7vd46zbjae.fsf@alter.siamese.dyndns.org>
References: <20090813103231.GY14475@mail-vs.djpig.de>
 <20090813111933.GZ14475@mail-vs.djpig.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Martin Koegler <mkoegler@auto.tuwien.ac.at>
To: Frank Lichtenheld <frank@lichtenheld.de>
X-From: git-owner@vger.kernel.org Thu Aug 13 21:34:07 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mbg3k-0003cZ-Ko
	for gcvg-git-2@gmane.org; Thu, 13 Aug 2009 21:34:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755496AbZHMTdw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Aug 2009 15:33:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755486AbZHMTdw
	(ORCPT <rfc822;git-outgoing>); Thu, 13 Aug 2009 15:33:52 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:51399 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752372AbZHMTdv (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Aug 2009 15:33:51 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 291E628882;
	Thu, 13 Aug 2009 15:33:51 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 9FE0928881; Thu, 13 Aug 2009
 15:33:46 -0400 (EDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 3AAC9756-8840-11DE-BA3B-AEF1826986A2-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125858>

When unpack-objects is run under the --strict option, objects that have
pointers to other objects are verified for the reachability at the end, by
calling check_object() on each of them, and letting check_object to walk
the reachable objects from them using fsck_walk() recursively.

The function however misunderstands the semantics of fsck_walk() function
when it makes a call to it, setting itself as the callback.  fsck_walk()
expects the callback function to return a non-zero value to signal an
error (negative value causes an immediate abort, positive value is still
an error but allows further checks on sibling objects) and return zero to
signal a success.  The function however returned 1 on some non error
cases, and to cover up this mistake, complained only when fsck_walk() did
not detect any error.

To fix this double-bug, make the function return zero on all success
cases, and also check for non-zero return from fsck_walk() for an error.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

Caused by b41860b (unpack-objects: prevent writing of inconsistent
objects, 2008-02-25), which introduced these checks and also the code to
keep unverified objects in core until check_objects() verifies their
reachability.  While I think it is a good idea to check for incomplete
pack data, I do not think it is necessary to keep them in core.  We can
simply error out to signal the caller not to update the refs.

We probably should write everything as they become unpackable (i.e. as
their delta bases becomes available) while keeping track of object names
(but not data) of structured objects that we received, and running only
one level of reachability check on them at the end.  That would certainly
reduce the memory consumption and may simplify the complexity of the code
at the same time.

But I'll leave that to other people.  Hint, hint...

 builtin-unpack-objects.c       |    8 ++++----
 t/t5531-deep-submodule-push.sh |   32 ++++++++++++++++++++++++++++++++
 2 files changed, 36 insertions(+), 4 deletions(-)

diff --git a/builtin-unpack-objects.c b/builtin-unpack-objects.c
index 557148a..109b7c8 100644
--- a/builtin-unpack-objects.c
+++ b/builtin-unpack-objects.c
@@ -184,7 +184,7 @@ static int check_object(struct object *obj, int type, void *data)
 		return 0;
 
 	if (obj->flags & FLAG_WRITTEN)
-		return 1;
+		return 0;
 
 	if (type != OBJ_ANY && obj->type != type)
 		die("object type mismatch");
@@ -195,15 +195,15 @@ static int check_object(struct object *obj, int type, void *data)
 		if (type != obj->type || type <= 0)
 			die("object of unexpected type");
 		obj->flags |= FLAG_WRITTEN;
-		return 1;
+		return 0;
 	}
 
 	if (fsck_object(obj, 1, fsck_error_function))
 		die("Error in object");
-	if (!fsck_walk(obj, check_object, NULL))
+	if (fsck_walk(obj, check_object, NULL))
 		die("Error on reachable objects of %s", sha1_to_hex(obj->sha1));
 	write_cached_object(obj);
-	return 1;
+	return 0;
 }
 
 static void write_rest(void)
diff --git a/t/t5531-deep-submodule-push.sh b/t/t5531-deep-submodule-push.sh
new file mode 100755
index 0000000..13b8e40
--- /dev/null
+++ b/t/t5531-deep-submodule-push.sh
@@ -0,0 +1,32 @@
+#!/bin/sh
+
+test_description='unpack-objects'
+
+. ./test-lib.sh
+
+test_expect_success setup '
+	git init --bare pub.git &&
+	GIT_DIR=pub.git git config receive.fsckobjects true &&
+	git init work &&
+	(
+		cd work &&
+		git init gar/bage &&
+		(
+			cd gar/bage &&
+			>junk &&
+			git add junk &&
+			git commit -m "Initial junk"
+		) &&
+		git add gar/bage &&
+		git commit -m "Initial superproject"
+	)
+'
+
+test_expect_failure push '
+	(
+		cd work &&
+		git push ../pub.git master
+	)
+'
+
+test_done
