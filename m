From: Johan Herland <johan@herland.net>
Subject: [PATCH] Fix premature free of ref_lists while writing temporary refs to file
Date: Tue, 26 Feb 2008 16:35:51 +0100
Message-ID: <200802261635.51407.johan@herland.net>
References: <alpine.LNX.1.00.0802251604460.19024@iabervon.org> <200802261358.33357.johan@herland.net> <200802261437.18950.johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Kristian =?utf-8?q?H=C3=B8gsberg?= <krh@redhat.com>,
	Santi =?utf-8?q?B=C3=A9jar?= <sbejar@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 26 16:38:11 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JU1rt-0007JQ-SY
	for gcvg-git-2@gmane.org; Tue, 26 Feb 2008 16:37:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755930AbYBZPgm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Feb 2008 10:36:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755726AbYBZPgm
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Feb 2008 10:36:42 -0500
Received: from sam.opera.com ([213.236.208.81]:40413 "EHLO smtp.opera.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754982AbYBZPgl (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Feb 2008 10:36:41 -0500
Received: from pc107.coreteam.oslo.opera.com (pat-tdc.opera.com [213.236.208.22])
	by smtp.opera.com (8.13.4/8.13.4/Debian-3sarge3) with ESMTP id m1QFZp3p010477
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Tue, 26 Feb 2008 15:35:52 GMT
User-Agent: KMail/1.9.7
In-Reply-To: <200802261437.18950.johan@herland.net>
Content-Disposition: inline
X-Virus-Scanned: ClamAV 0.91.1/6003/Tue Feb 26 11:34:31 2008 on smtp.opera.com
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75145>

We cannot call write_ref_sha1() from within a for_each_ref() callback, since
it will free() the ref_list that the for_each_ref() is currently traversing.

Therefore rewrite setup_tmp_ref() to not call write_ref_sha1(), as already
hinted at in a comment.

This causes the t5700-clone-reference testcases to pass for me.

Signed-off-by: Johan Herland <johan@herland.net>
---

On Tuesday 26 February 2008, Johan Herland wrote:
> On Tuesday 26 February 2008, Johan Herland wrote:
> > Running this test with GDB, I get the following backtrace:
> > 
> > #0  0x0000000000474b87 in is_null_sha1 (sha1=0x100000008 <Address 0x100000008 out of bounds>) at cache.h:464
> > #1  0x0000000000474ad3 in do_one_ref (base=0x4dc8ff "refs/", fn=0x419471 <setup_tmp_ref>, trim=0, cb_data=0x7498d0, entry=0xffffffff) at refs.c:474
> > #2  0x0000000000474e28 in do_for_each_ref (base=0x4dc8ff "refs/", fn=0x419471 <setup_tmp_ref>, trim=0, cb_data=0x7498d0) at refs.c:558
> > #3  0x0000000000474ecd in for_each_ref (fn=0x419471 <setup_tmp_ref>, cb_data=0x7498d0) at refs.c:580
> > #4  0x0000000000419706 in setup_reference (repo=0x745070 "C/.git") at builtin-clone.c:211
> > #5  0x0000000000419fce in cmd_clone (argc=2, argv=0x7fff7a282fa0, prefix=0x0) at builtin-clone.c:422
> > #6  0x0000000000404ba3 in run_command (p=0x6ff710, argc=7, argv=0x7fff7a282fa0) at git.c:248
> > #7  0x0000000000404d55 in handle_internal_command (argc=7, argv=0x7fff7a282fa0) at git.c:378
> > #8  0x0000000000404ebe in main (argc=7, argv=0x7fff7a282fa0) at git.c:442
> > 
> > Seems the "loose" ref_list in do_for_each_ref() becomes corrupted.
> 
> ...and the corruption is done when setup_tmp_ref() calls write_ref_sha1()
> which calls invalidate_cached_refs() (which frees the ref_list that
> do_for_each_ref() is iterating over).
> 
> Not sure how to best solve this. Maybe setup_tmp_ref() shouldn't use
> write_ref_sha1(), but write the ref file directly instead, as hinted
> at in a comment in setup_tmp_ref()?

Here is a shot at fixing this, although I'm not sure it's the best way
of doing so.


Have fun! :)

...Johan

 builtin-clone.c |   43 ++++++++++++++++++++-----------------------
 1 files changed, 20 insertions(+), 23 deletions(-)

diff --git a/builtin-clone.c b/builtin-clone.c
index 6e34e52..d5baffc 100644
--- a/builtin-clone.c
+++ b/builtin-clone.c
@@ -136,14 +136,12 @@ static int
 setup_tmp_ref(const char *refname,
 	      const unsigned char *sha1, int flags, void *cb_data)
 {
-	const char *ref_temp = cb_data;
+	const char *ref_temp = cb_data, *sha1_hex = sha1_to_hex(sha1);
 	char *path;
-	struct lock_file lk;
-	struct ref_lock *rl;
+	int fd;
 
 	/*
 
-	echo "$ref_git/objects" >"$GIT_DIR/objects/info/alternates"
 	(
 		GIT_DIR="$ref_git" git for-each-ref \
 			--format='%(objectname) %(*objectname)'
@@ -158,25 +156,24 @@ setup_tmp_ref(const char *refname,
 
 	*/
 
-	/* We go a bit out of way to use write_ref_sha1() here.  We
-	 * could just write the ref file directly, since neither
-	 * locking or reflog really matters here.  However, let's use
-	 * the standard interface for writing refs as much as is
-	 * possible given that get_git_dir() != the repo we're writing
-	 * the refs in. */
-
-	printf("%s -> %s/%s\n",
-	       sha1_to_hex(sha1), ref_temp, sha1_to_hex(sha1));
-
-	path = mkpath("%s/%s", ref_temp, sha1_to_hex(sha1));
-	rl = xmalloc(sizeof *rl);
-	rl->force_write = 1;
-	rl->lk = &lk;
-	rl->ref_name = xstrdup(sha1_to_hex(sha1));
-	rl->orig_ref_name = xstrdup(rl->ref_name);
-	rl->lock_fd = hold_lock_file_for_update(rl->lk, path, 1);
-	if (write_ref_sha1(rl, sha1, NULL) < 0)
-		die("failed to write temporary ref %s", lk.filename);
+	/* Write the ref file directly, since neither locking or reflog really
+	 * matters here. We should probably use some standard interface for
+	 * writing refs here, although write_ref_sha1() does not work.
+	 * (It frees the ref_list that is currently being iterated by
+	 * for_each_ref().) Keep in mind that get_git_dir() != the repo we're
+	 * writing the refs in. */
+
+	path = mkpath("%s/%s", ref_temp, sha1_hex);
+
+	printf("%s -> %s\n", sha1_hex, path);
+
+	fd = open(path, O_CREAT | O_WRONLY, 0666);
+	if (fd < 0)
+		die("failed to create %s", path);
+	write_or_die(fd, sha1_hex, strlen(sha1_hex));
+	if (close(fd))
+		die("could not close %s", path);
+	fprintf(stderr, "Wrote %s to %s\n", sha1_hex, path);
 
 	return 0;
 }
-- 
1.5.4.3.342.g99e8
