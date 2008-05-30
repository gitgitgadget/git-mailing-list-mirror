From: Linus Torvalds <torvalds@linuxfoundation.org>
Subject: Re: reducing prune sync()s
Date: Thu, 29 May 2008 17:27:35 -0700 (PDT)
Message-ID: <alpine.LFD.1.10.0805291656260.3141@woody.linux-foundation.org>
References: <20080529205743.GC17123@redhat.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
To: "Frank Ch. Eigler" <fche@redhat.com>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri May 30 02:28:52 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K1sUF-00006p-7O
	for gcvg-git-2@gmane.org; Fri, 30 May 2008 02:28:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753611AbYE3A17 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 May 2008 20:27:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753377AbYE3A17
	(ORCPT <rfc822;git-outgoing>); Thu, 29 May 2008 20:27:59 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:37634 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753205AbYE3A16 (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 29 May 2008 20:27:58 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m4U0Rb2l008043
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 29 May 2008 17:27:38 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m4U0RZkq030734;
	Thu, 29 May 2008 17:27:36 -0700
In-Reply-To: <20080529205743.GC17123@redhat.com>
User-Agent: Alpine 1.10 (LFD 962 2008-03-14)
X-Spam-Status: No, hits=-2.312 required=5 tests=BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83258>



On Thu, 29 May 2008, Frank Ch. Eigler wrote:
> 
> Would there be interest in making this sync disableable with
> git-config?

No, that's just too scary. But..

>	  Or perhaps having the blanket sync be replaced a
> list of fsync()s for only the relevant git repository files?

That would be much better. The code was ported from shell script, and 
there is no fsync() in shell, but the rule should basically be that you 
can remove all the objects that correspond to a pack-file after you have 
made sure that the pack-file (and it's index - we can re-generate the pack 
index, but realistically speaking it's *much* better to not have to) is 
stable on disk.

Soemthing like this *may* work. THIS IS TOTALLY UNTESTED. And when I say 
"TOTALLY UNTESTED", I mean it. Zero testing. None. Nada. Zilch. Testing is 
for people who are actually interested in the feature (hint, hint).

But if somebody tests this and actually does an strace and sees that yes, 
it does the fsync() on each pack-file it cares about, then I'll happily 
sign off on this patch. It's fairly obvious.

What it does is to make "has_sha1_pack()" return the actual packed_git 
pointer it found that contains the SHA1 in question, instead of just an 
integer boolean. That changes no users, since everybody tests it for just 
truthiness value anyway.

It then introduces a "sha1_is_stably_packed()" function that not just 
looks up the pack entry, but also does an fsync() on it if it isn't 
already marked stable. Fairly trivial, as I said. But this is important 
code, so it really does need actual real-life testing. Trivial code often 
has trivial bugs.

		Linus

---
 builtin-prune-packed.c |   23 +++++++++++++++++++++--
 cache.h                |    6 ++++--
 sha1_file.c            |    9 ++++++---
 3 files changed, 31 insertions(+), 7 deletions(-)

diff --git a/builtin-prune-packed.c b/builtin-prune-packed.c
index 23faf31..b64a5d4 100644
--- a/builtin-prune-packed.c
+++ b/builtin-prune-packed.c
@@ -10,6 +10,26 @@ static const char prune_packed_usage[] =
 
 static struct progress *progress;
 
+static int sha1_is_stably_packed(const unsigned char *sha1)
+{
+	struct packed_git *pack;
+
+	pack = has_sha1_pack(sha1, NULL);
+	if (!pack)
+		return 0;
+	if (!pack->pack_stable) {
+		int fd = pack->pack_fd;
+		if (fd < 0) {
+			if (open_packed_git(pack) < 0)
+				return 0;
+			fd = pack->pack_fd;
+		}
+		fsync(fd);
+		pack->pack_stable = 1;
+	}
+	return 1;
+}
+
 static void prune_dir(int i, DIR *dir, char *pathname, int len, int opts)
 {
 	struct dirent *de;
@@ -23,7 +43,7 @@ static void prune_dir(int i, DIR *dir, char *pathname, int len, int opts)
 		memcpy(hex+2, de->d_name, 38);
 		if (get_sha1_hex(hex, sha1))
 			continue;
-		if (!has_sha1_pack(sha1, NULL))
+		if (!sha1_is_stably_packed(sha1))
 			continue;
 		memcpy(pathname + len, de->d_name, 38);
 		if (opts & DRY_RUN)
@@ -85,7 +105,6 @@ int cmd_prune_packed(int argc, const char **argv, const char *prefix)
 		/* Handle arguments here .. */
 		usage(prune_packed_usage);
 	}
-	sync();
 	prune_packed_objects(opts);
 	return 0;
 }
diff --git a/cache.h b/cache.h
index eab1a17..3bb85eb 100644
--- a/cache.h
+++ b/cache.h
@@ -540,7 +540,7 @@ extern int write_sha1_from_fd(const unsigned char *sha1, int fd, char *buffer,
 extern int write_sha1_to_fd(int fd, const unsigned char *sha1);
 extern int move_temp_to_file(const char *tmpfile, const char *filename);
 
-extern int has_sha1_pack(const unsigned char *sha1, const char **ignore);
+extern struct packed_git *has_sha1_pack(const unsigned char *sha1, const char **ignore);
 extern int has_sha1_file(const unsigned char *sha1);
 
 extern int has_pack_file(const unsigned char *sha1);
@@ -646,7 +646,8 @@ extern struct packed_git {
 	int index_version;
 	time_t mtime;
 	int pack_fd;
-	int pack_local;
+	unsigned int pack_local:1,
+		     pack_stable:1;
 	unsigned char sha1[20];
 	/* something like ".git/objects/pack/xxxxx.pack" */
 	char pack_name[FLEX_ARRAY]; /* more */
@@ -708,6 +709,7 @@ extern struct packed_git *find_sha1_pack(const unsigned char *sha1,
 
 extern void pack_report(void);
 extern int open_pack_index(struct packed_git *);
+extern int open_packed_git(struct packed_git *p);
 extern unsigned char* use_pack(struct packed_git *, struct pack_window **, off_t, unsigned int *);
 extern void close_pack_windows(struct packed_git *);
 extern void unuse_pack(struct pack_window **);
diff --git a/sha1_file.c b/sha1_file.c
index 9679040..52e9824 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -703,7 +703,7 @@ static int open_packed_git_1(struct packed_git *p)
 	return 0;
 }
 
-static int open_packed_git(struct packed_git *p)
+int open_packed_git(struct packed_git *p)
 {
 	if (!open_packed_git_1(p))
 		return 0;
@@ -824,6 +824,7 @@ struct packed_git *add_packed_git(const char *path, int path_len, int local)
 	p->windows = NULL;
 	p->pack_fd = -1;
 	p->pack_local = local;
+	p->pack_stable = 0;
 	p->mtime = st.st_mtime;
 	if (path_len < 40 || get_sha1_hex(path + path_len - 40, p->sha1))
 		hashclr(p->sha1);
@@ -2381,10 +2382,12 @@ int has_pack_file(const unsigned char *sha1)
 	return 1;
 }
 
-int has_sha1_pack(const unsigned char *sha1, const char **ignore_packed)
+struct packed_git *has_sha1_pack(const unsigned char *sha1, const char **ignore_packed)
 {
 	struct pack_entry e;
-	return find_pack_entry(sha1, &e, ignore_packed);
+	if (find_pack_entry(sha1, &e, ignore_packed))
+		return e.p;
+	return NULL;
 }
 
 int has_sha1_file(const unsigned char *sha1)
