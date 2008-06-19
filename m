From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH v2] Make git_dir a path relative to work_tree in
 setup_work_tree()
Date: Thu, 19 Jun 2008 12:34:06 -0700 (PDT)
Message-ID: <alpine.LFD.1.10.0806191206350.2907@woody.linux-foundation.org>
References: <alpine.LNX.1.00.0806182327090.19665@iabervon.org> <7vod5xuvtj.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Daniel Barkalow <barkalow@iabervon.org>,
	Linus Torvalds <torvalds@linuxfoundation.org>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jun 19 21:36:03 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K9PvN-0002w7-5a
	for gcvg-git-2@gmane.org; Thu, 19 Jun 2008 21:36:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753242AbYFSTfE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Jun 2008 15:35:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753234AbYFSTfD
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Jun 2008 15:35:03 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:44488 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753145AbYFSTfB (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 19 Jun 2008 15:35:01 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m5JJY7xL007586
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 19 Jun 2008 12:34:09 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m5JJY69Z005580;
	Thu, 19 Jun 2008 12:34:06 -0700
In-Reply-To: <7vod5xuvtj.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.10 (LFD 962 2008-03-14)
X-Spam-Status: No, hits=-3.847 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85519>



On Thu, 19 Jun 2008, Junio C Hamano wrote:
> 
> Other than that, I think the change is Ok, but as a "performance tweak",
> it should be backed by some numbers, please?

Daniel's patch didn't apply for me as-is, so I recreated it with some 
differences (appended), and here are the numbers from ten runs each.

There is some IO for me - probably due to more-or-less random flushing of 
the journal - so the variation is bigger than I'd like, but whatever:

	Before:
		real    0m8.135s
		real    0m7.933s
		real    0m8.080s
		real    0m7.954s
		real    0m7.949s
		real    0m8.112s
		real    0m7.934s
		real    0m8.059s
		real    0m7.979s
		real    0m8.038s


	After:
		real    0m7.685s
		real    0m7.968s
		real    0m7.703s
		real    0m7.850s
		real    0m7.995s
		real    0m7.817s
		real    0m7.963s
		real    0m7.955s
		real    0m7.848s
		real    0m7.969s

Now, going by "best of ten" (on the assumption that the longer numbers 
are all due to IO), I'm saying a 7.933s -> 7.685s reduction, and it does 
seem to be outside of the noise (ie the "after" case never broke 8s, while 
the "before" case did so half the time).

So looks like about 3% to me. 

Doing it for a slightly smaller test-case (just the "arch" subdirectory) 
gets more stable numbers probably due to not filling the journal with 
metadata updates, so we have:

	Before:
		real    0m1.633s
		real    0m1.633s
		real    0m1.633s
		real    0m1.632s
		real    0m1.632s
		real    0m1.630s
		real    0m1.634s
		real    0m1.631s
		real    0m1.632s
		real    0m1.632s

	After:
		real    0m1.610s
		real    0m1.609s
		real    0m1.610s
		real    0m1.608s
		real    0m1.607s
		real    0m1.610s
		real    0m1.609s
		real    0m1.611s
		real    0m1.608s
		real    0m1.611s

where I'ld just take the averages and say 1.632 vs 1.610, which is just 
over 1% peformance improvement.

So it's not in the noise, but it's not as big as I initially thought and 
measured.

(That said, it obviously depends on how deep the working directory path is 
too, and whether it is behind NFS or something else that might need to 
cause more work to look up).

Modified/updated patch appended.

			Linus

----
 cache.h |    1 +
 path.c  |   17 +++++++++++++++++
 setup.c |    3 ++-
 3 files changed, 20 insertions(+), 1 deletions(-)

diff --git a/cache.h b/cache.h
index 01c8502..29aae0c 100644
--- a/cache.h
+++ b/cache.h
@@ -526,6 +526,7 @@ static inline int is_absolute_path(const char *path)
 }
 const char *make_absolute_path(const char *path);
 const char *make_nonrelative_path(const char *path);
+const char *make_relative_path(const char *abs, const char *base);
 
 /* Read and unpack a sha1 file into memory, write memory to a sha1 file */
 extern int sha1_object_info(const unsigned char *, unsigned long *);
diff --git a/path.c b/path.c
index 7a35a26..6e3df18 100644
--- a/path.c
+++ b/path.c
@@ -330,6 +330,23 @@ const char *make_nonrelative_path(const char *path)
 /* We allow "recursive" symbolic links. Only within reason, though. */
 #define MAXDEPTH 5
 
+const char *make_relative_path(const char *abs, const char *base)
+{
+	static char buf[PATH_MAX + 1];
+	int baselen;
+	if (!base)
+		return abs;
+	baselen = strlen(base);
+	if (prefixcmp(abs, base))
+		return abs;
+	if (abs[baselen] == '/')
+		baselen++;
+	else if (base[baselen - 1] != '/')
+		return abs;
+	strcpy(buf, abs + baselen);
+	return buf;
+}
+
 const char *make_absolute_path(const char *path)
 {
 	static char bufs[2][PATH_MAX + 1], *buf = bufs[0], *next_buf = bufs[1];
diff --git a/setup.c b/setup.c
index d630e37..3b111ea 100644
--- a/setup.c
+++ b/setup.c
@@ -292,9 +292,10 @@ void setup_work_tree(void)
 	work_tree = get_git_work_tree();
 	git_dir = get_git_dir();
 	if (!is_absolute_path(git_dir))
-		set_git_dir(make_absolute_path(git_dir));
+		git_dir = make_absolute_path(git_dir);
 	if (!work_tree || chdir(work_tree))
 		die("This operation must be run in a work tree");
+	set_git_dir(make_relative_path(git_dir, work_tree));
 	initialized = 1;
 }
 
