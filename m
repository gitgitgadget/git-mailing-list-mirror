From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: git-index-pack really does suck..
Date: Tue, 3 Apr 2007 13:18:33 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0704031304420.6730@woody.linux-foundation.org>
References: <Pine.LNX.4.64.0704030754020.6730@woody.linux-foundation.org>
 <db69205d0704031227q1009eabfhdd82aa3636f25bb6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
To: Chris Lee <clee@kde.org>, Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Tue Apr 03 22:20:19 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HYpUD-0003sc-A6
	for gcvg-git@gmane.org; Tue, 03 Apr 2007 22:20:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422699AbXDCUTg (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 3 Apr 2007 16:19:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422704AbXDCUTf
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Apr 2007 16:19:35 -0400
Received: from smtp.osdl.org ([65.172.181.24]:41834 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1422695AbXDCUTd (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Apr 2007 16:19:33 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id l33KIYPD021640
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 3 Apr 2007 13:18:34 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l33KIXfY002121;
	Tue, 3 Apr 2007 13:18:33 -0700
In-Reply-To: <db69205d0704031227q1009eabfhdd82aa3636f25bb6@mail.gmail.com>
X-Spam-Status: No, hits=-0.457 required=5 tests=AWL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.119__
X-MIMEDefang-Filter: osdl$Revision: 1.177 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43651>



On Tue, 3 Apr 2007, Chris Lee wrote:
> 
> There's another issue here.
> 
> I'm running git-index-pack as part of a workflow like so:
> 
> $ git-verify-pack -v .git/objects/pack/*.idx > /tmp/all-objects
> $ grep 'blob' /tmp/all-objects > /tmp/blob-objects
> $ cat /tmp/blob-objects | awk '{print $1;}' | git-pack-objects
> --delta-base-offset --all-progress --stdout > blob.pack
> $ git-index-pack -v blob.pack
> 
> Now, when I run 'git-index-pack' on blob.pack in the current
> directory, memory usage is pretty horrific (even with the applied
> patch to not leak all everything). Shawn tells me that index-pack
> should only be decompressing the object twice - once from the repo and
> once from blob.pack - iff I call git-index-pack with --stdin, which I
> am not.
> 
> If I move the blob.pack into /tmp, and run git-index-pack on it there,
> it completes much faster and the memory usage never exceeds 200MB.
> (Inside the repo, it takes up over 3G of RES according to top.)

Yeah. What happens is that inside the repo, because we do all the 
duplicate object checks (verifying that there are no evil hash collisions) 
even after fixing the memory leak, we end up keeping *track* of all those 
objects.

And with a large repository, it's quite the expensive operation.

That whole "verify no SHA1 hash collision" code is really pretty damn 
paranoid. Maybe we shouldn't have it enabled by default.

So how about this updated patch? We could certainly make "git pull" imply 
"--paranoid" if we want to, but even that is likely pretty unnecessary. 
It's not like anybody has ever shown a SHA1 collision, and if the *local* 
repository is corrupt (and has an object with the wrong SHA1 - that's what 
the testsuite checks for), then it's probably good to get the valid object 
from the remote..

This includes the previous one-liner, but also adds the "--paranoid" flag 
and fixes up the Documentation and tests to match.

Junio, your choice, but regardless which one you choose:

	Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>

Thanks,

		Linus

---
 Documentation/git-index-pack.txt |    3 +--
 index-pack.c                     |    6 +++++-
 t/t5300-pack-object.sh           |    4 ++--
 3 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/Documentation/git-index-pack.txt b/Documentation/git-index-pack.txt
index 2229ee8..7d8d33b 100644
--- a/Documentation/git-index-pack.txt
+++ b/Documentation/git-index-pack.txt
@@ -8,8 +8,7 @@ git-index-pack - Build pack index file for an existing packed archive
 
 SYNOPSIS
 --------
-'git-index-pack' [-v] [-o <index-file>] <pack-file>
-'git-index-pack' --stdin [--fix-thin] [--keep] [-v] [-o <index-file>] [<pack-file>]
+'git-index-pack' [--stdin [--fix-thin] [--keep]] [-v] [--paranoid] [-o <index-file>] <pack-file>
 
 
 DESCRIPTION
diff --git a/index-pack.c b/index-pack.c
index 6284fe3..8a4c27a 100644
--- a/index-pack.c
+++ b/index-pack.c
@@ -45,6 +45,7 @@ static int nr_resolved_deltas;
 
 static int from_stdin;
 static int verbose;
+static int paranoid;
 
 static volatile sig_atomic_t progress_update;
 
@@ -348,7 +349,7 @@ static void sha1_object(const void *data, unsigned long size,
 			enum object_type type, unsigned char *sha1)
 {
 	hash_sha1_file(data, size, typename(type), sha1);
-	if (has_sha1_file(sha1)) {
+	if (paranoid && has_sha1_file(sha1)) {
 		void *has_data;
 		enum object_type has_type;
 		unsigned long has_size;
@@ -358,6 +359,7 @@ static void sha1_object(const void *data, unsigned long size,
 		if (size != has_size || type != has_type ||
 		    memcmp(data, has_data, size) != 0)
 			die("SHA1 COLLISION FOUND WITH %s !", sha1_to_hex(sha1));
+		free(has_data);
 	}
 }
 
@@ -839,6 +841,8 @@ int main(int argc, char **argv)
 		if (*arg == '-') {
 			if (!strcmp(arg, "--stdin")) {
 				from_stdin = 1;
+			} else if (!strcmp(arg, "--paranoid")) {
+				paranoid = 1;
 			} else if (!strcmp(arg, "--fix-thin")) {
 				fix_thin_pack = 1;
 			} else if (!strcmp(arg, "--keep")) {
diff --git a/t/t5300-pack-object.sh b/t/t5300-pack-object.sh
index 35e036a..407c71e 100755
--- a/t/t5300-pack-object.sh
+++ b/t/t5300-pack-object.sh
@@ -262,7 +262,7 @@ test_expect_success \
 		.git/objects/c8/2de19312b6c3695c0c18f70709a6c535682a67'
 
 test_expect_failure \
-    'make sure index-pack detects the SHA1 collision' \
-    'git-index-pack -o bad.idx test-3.pack'
+    'make sure index-pack detects the SHA1 collision when paranoid' \
+    'git-index-pack --paranoid -o bad.idx test-3.pack'
 
 test_done
