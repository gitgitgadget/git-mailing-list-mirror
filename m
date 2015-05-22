From: Jeff King <peff@peff.net>
Subject: Re: Troubleshoot clone issue to NFS.
Date: Fri, 22 May 2015 03:12:24 -0400
Message-ID: <20150522071224.GA10734@peff.net>
References: <7FAE15F0A93C0144AD8B5FBD584E1C5519758FC3@C111KXTEMBX51.ERF.thomson.com>
 <CACsJy8AMhEKe-eM7jvYcEx+7ZmfvdD+p1s4VYHjKuAwZsDWc-w@mail.gmail.com>
 <CACsJy8Cs6GcRQ-kgnSqwxP4MPHfds9qiir1_O1hc5cZ+0QP-EA@mail.gmail.com>
 <7FAE15F0A93C0144AD8B5FBD584E1C5519759641@C111KXTEMBX51.ERF.thomson.com>
 <CACsJy8BULBJ=cL1+4TFX_7tYSCFL3MNEz1Ay0YGqx8W_8=nwAg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: steve.norman@thomsonreuters.com,
	Git Mailing List <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 22 09:12:35 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yvh8C-00085f-PK
	for gcvg-git-2@plane.gmane.org; Fri, 22 May 2015 09:12:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756275AbbEVHM2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 May 2015 03:12:28 -0400
Received: from cloud.peff.net ([50.56.180.127]:34509 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932124AbbEVHM1 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 May 2015 03:12:27 -0400
Received: (qmail 18289 invoked by uid 102); 22 May 2015 07:12:27 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 22 May 2015 02:12:27 -0500
Received: (qmail 12571 invoked by uid 107); 22 May 2015 07:12:29 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 22 May 2015 03:12:29 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 22 May 2015 03:12:24 -0400
Content-Disposition: inline
In-Reply-To: <CACsJy8BULBJ=cL1+4TFX_7tYSCFL3MNEz1Ay0YGqx8W_8=nwAg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269698>

On Fri, May 22, 2015 at 07:16:54AM +0700, Duy Nguyen wrote:

> > Is there anything else I can provide or test?
> 
> In builtin/index-pack.c, replace the line "collision_test_needed =
> has_sha1_file(sha1);" with "collision_test_needed = 0;". Security is
> compromised but for this test it should be ok. Then clone again. I
> hope the new number gets down close to v1.8.4.1.

Yeah, I think that is a good starting point. I timed a local clone
before and after 45e8a74; there is a small difference on my system
(about 5%), but it goes away with your suggestion.

The problem with has_sha1_file() prior to v1.8.4.2 is that it is racy
with respect to simultaneous operations; we might claim we do not have
an object, when in fact we do. As you noted, usually has_sha1_file()
returns true (i.e., we look up objects that we expect to have), and the
performance impact is minimal.

But for code paths where _not_ having the object is normal, the impact
is much greater. So I think there are two possibilities for improving
this:

  1. Find places where we expect the object will not exist (like the
     collision_test check you pointed out) and use a
     "has_sha1_file_fast" that accepts that it may very occasionally
     erroneously return false. In this case it would mean potentially
     skipping a collision check, but I think that is OK. That could have
     security implications, but only if an attacker:

       a. has broken sha1 to generate a colliding object

       b. can manipulate the victim into repacking in a loop

       c. can manipulate the victim into fetching (or receiving a push)
          simultaneously with (b)

     at which point they can try to race the repack procedure to add
     their colliding object to the repository. It seems rather unlikely
     (especially part a).

  2. Make reprepare_packed_git() cheaper in the common case that nothing
     has changed. It would probably be enough to stat("objects/pack").
     We know that packfiles themselves do not change; we may only add or
     delete them. And since the hierarchy of objects/pack is flat, we
     know that the mtime on that directory will change if any packs are
     added or removed.

     Of course, we are still doing an extra stat() for each has_sha1_file
     call. Whether that helps for the NFS case depends on whether stat()
     is significantly cheaper than opendir/readdir/closedir. On my local
     disk, the hacky patch below did seem to give me back the 5% lost by
     45e8a74 (I did it directly on master, since that old commit does
     not have the stat_validity infrastructure).

---
diff --git a/cache.h b/cache.h
index c97d807..17c840c 100644
--- a/cache.h
+++ b/cache.h
@@ -1661,6 +1661,7 @@ int sane_execvp(const char *file, char *const argv[]);
  */
 struct stat_validity {
 	struct stat_data *sd;
+	unsigned mode;
 };
 
 void stat_validity_clear(struct stat_validity *sv);
diff --git a/read-cache.c b/read-cache.c
index 36ff89f..1d8702f 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -2281,6 +2281,7 @@ void stat_validity_clear(struct stat_validity *sv)
 {
 	free(sv->sd);
 	sv->sd = NULL;
+	sv->mode = 0;
 }
 
 int stat_validity_check(struct stat_validity *sv, const char *path)
@@ -2291,18 +2292,19 @@ int stat_validity_check(struct stat_validity *sv, const char *path)
 		return sv->sd == NULL;
 	if (!sv->sd)
 		return 0;
-	return S_ISREG(st.st_mode) && !match_stat_data(sv->sd, &st);
+	return sv->mode == st.st_mode && !match_stat_data(sv->sd, &st);
 }
 
 void stat_validity_update(struct stat_validity *sv, int fd)
 {
 	struct stat st;
 
-	if (fstat(fd, &st) < 0 || !S_ISREG(st.st_mode))
+	if (fstat(fd, &st) < 0)
 		stat_validity_clear(sv);
 	else {
 		if (!sv->sd)
 			sv->sd = xcalloc(1, sizeof(struct stat_data));
+		sv->mode = st.st_mode;
 		fill_stat_data(sv->sd, &st);
 	}
 }
diff --git a/sha1_file.c b/sha1_file.c
index ccc6dac..abe1be9 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -1225,7 +1225,8 @@ static void report_pack_garbage(struct string_list *list)
 	report_helper(list, seen_bits, first, list->nr);
 }
 
-static void prepare_packed_git_one(char *objdir, int local)
+static void prepare_packed_git_one(char *objdir, int local,
+				   struct stat_validity *validity)
 {
 	struct strbuf path = STRBUF_INIT;
 	size_t dirnamelen;
@@ -1235,6 +1236,12 @@ static void prepare_packed_git_one(char *objdir, int local)
 
 	strbuf_addstr(&path, objdir);
 	strbuf_addstr(&path, "/pack");
+
+	if (stat_validity_check(validity, path.buf)) {
+		strbuf_release(&path);
+		return;
+	}
+
 	dir = opendir(path.buf);
 	if (!dir) {
 		if (errno != ENOENT)
@@ -1243,6 +1250,10 @@ static void prepare_packed_git_one(char *objdir, int local)
 		strbuf_release(&path);
 		return;
 	}
+
+	/* XXX dirfd is a BSD-ism that only made it into POSIX.1-2008 */
+	stat_validity_update(validity, dirfd(dir));
+
 	strbuf_addch(&path, '/');
 	dirnamelen = path.len;
 	while ((de = readdir(dir)) != NULL) {
@@ -1348,15 +1359,17 @@ static void rearrange_packed_git(void)
 static int prepare_packed_git_run_once = 0;
 void prepare_packed_git(void)
 {
+	static struct stat_validity validity;
 	struct alternate_object_database *alt;
 
 	if (prepare_packed_git_run_once)
 		return;
-	prepare_packed_git_one(get_object_directory(), 1);
+	prepare_packed_git_one(get_object_directory(), 1, &validity);
 	prepare_alt_odb();
 	for (alt = alt_odb_list; alt; alt = alt->next) {
 		alt->name[-1] = 0;
-		prepare_packed_git_one(alt->base, 0);
+		/* XXX should carry pack validity struct for each alternate */
+		prepare_packed_git_one(alt->base, 0, NULL);
 		alt->name[-1] = '/';
 	}
 	rearrange_packed_git();
