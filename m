From: worley@alum.mit.edu (Dale R. Worley)
Subject: Bug:  Failure if stdin is closed.
Date: Thu, 11 Jul 2013 11:11:24 -0400
Message-ID: <201307111511.r6BFBO44010988@freeze.ariadne.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 11 17:13:28 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UxIWq-0002BG-1R
	for gcvg-git-2@plane.gmane.org; Thu, 11 Jul 2013 17:11:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755975Ab3GKPL1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Jul 2013 11:11:27 -0400
Received: from qmta08.westchester.pa.mail.comcast.net ([76.96.62.80]:35233
	"EHLO qmta08.westchester.pa.mail.comcast.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751111Ab3GKPL0 (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 11 Jul 2013 11:11:26 -0400
Received: from omta21.westchester.pa.mail.comcast.net ([76.96.62.72])
	by qmta08.westchester.pa.mail.comcast.net with comcast
	id z0Zk1l0031ZXKqc583BReM; Thu, 11 Jul 2013 15:11:25 +0000
Received: from freeze.ariadne.com ([24.34.72.61])
	by omta21.westchester.pa.mail.comcast.net with comcast
	id z3BR1l0071KKtkw3h3BReA; Thu, 11 Jul 2013 15:11:25 +0000
Received: from freeze.ariadne.com (freeze.ariadne.com [127.0.0.1])
	by freeze.ariadne.com (8.14.5/8.14.5) with ESMTP id r6BFBO3H010989
	for <git@vger.kernel.org>; Thu, 11 Jul 2013 11:11:24 -0400
Received: (from worley@localhost)
	by freeze.ariadne.com (8.14.5/8.14.5/Submit) id r6BFBO44010988;
	Thu, 11 Jul 2013 11:11:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=comcast.net;
	s=q20121106; t=1373555485;
	bh=8hiuuAyqrdJSzO2bbqE6vkY/Ubqa/tSwSZ877BrbyI4=;
	h=Received:Received:Received:Received:Date:Message-Id:From:To:
	 Subject;
	b=UGVoFJHLIcVSmL6VFyMbvGKqh7yBo7hmcaNlmCxn07WP8eSn0c+SHJ69TqsKaQM6E
	 O+ljG37c7QnaqzpVVdOIwWTJ5+VP5Wxzu3eIs3HGgLjuJ0jkJ2d42hMm+HJRghjH7J
	 3t8sLmOzCwUVuZBa9wJw8zBaPHFbHFRL/P91LwMkRTjSvS3cqrIt1Ki3D5RBFzP4ED
	 UmzhStqSZdVhca27Rx+rn8oBx4wY13HIJxCcem9AeE00nT4iNktNJTNxc9ECnxGuCZ
	 AeuN1jnSbt0aX4lFvhZwLFxdq503VFBYIKYaky3lkdGQ4BGwkKzDQjvuSiXGs+gCtb
	 rACxqgL+Buj3w==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230106>

(The original problem and the discussion that ensued is on the
git-users mailing list:
https://groups.google.com/forum/#!topic/git-users/lNQ7Cn35EqA)

"git commit" (and probably other operations) fail if standard input
(fd 0) is closed when git starts.  A simple test case follows.  (The
execution is version 1.7.7.6, but the code listed below is from a very
recent commit.)


$ git --version
git version 1.7.7.6
$ git status
# On branch master
nothing to commit (working directory clean)
$ echo This is a test >ffff
$ git status
# On branch master
# Untracked files:
#   (use "git add <file>..." to include in what will be committed)
#
#	ffff
nothing added to commit but untracked files present (use "git add" to track)
$ git add ffff
$ # The notation "0<&-" means "close standard input (fd 0) in the process that
$ # executes this command.  It may be specific to the bash shell.
$ git commit -m xxxx 0<&-
error: unable to create temporary sha1 filename : No such file or directory

error: Error building trees
$ git status
# On branch master
# Changes to be committed:
#   (use "git reset HEAD <file>..." to unstage)
#
#	new file:   ffff
#
$ git commit -m xxxx
[master 54c146c] xxxx
 1 files changed, 1 insertions(+), 0 deletions(-)
 create mode 100644 ffff
$ git status
# On branch master
# Your branch is ahead of 'origin/master' by 1 commit.
#
nothing to commit (working directory clean)
$ 


The fundamental error is that git_mkstemps_mode() in wrapper.c assumes
that if open() is successful, its return value must be >0.  That is
not true, because if fd 0 is closed, then open() can successfully
return 0.  I have not tested it, but it looks like the fix is:

 int git_mkstemps_mode(char *pattern, int suffix_len, int mode)
 {
	 static const char letters[] =
		 "abcdefghijklmnopqrstuvwxyz"
		 "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
		 "0123456789";
	 static const int num_letters = 62;
	 uint64_t value;
	 struct timeval tv;
	 char *template;
	 size_t len;
	 int fd, count;

	 len = strlen(pattern);

	 if (len < 6 + suffix_len) {
		 errno = EINVAL;
		 return -1;
	 }

	 if (strncmp(&pattern[len - 6 - suffix_len], "XXXXXX", 6)) {
		 errno = EINVAL;
		 return -1;
	 }

	 /*
	  * Replace pattern's XXXXXX characters with randomness.
	  * Try TMP_MAX different filenames.
	  */
	 gettimeofday(&tv, NULL);
	 value = ((size_t)(tv.tv_usec << 16)) ^ tv.tv_sec ^ getpid();
	 template = &pattern[len - 6 - suffix_len];
	 for (count = 0; count < TMP_MAX; ++count) {
		 uint64_t v = value;
		 /* Fill in the random bits. */
		 template[0] = letters[v % num_letters]; v /= num_letters;
		 template[1] = letters[v % num_letters]; v /= num_letters;
		 template[2] = letters[v % num_letters]; v /= num_letters;
		 template[3] = letters[v % num_letters]; v /= num_letters;
		 template[4] = letters[v % num_letters]; v /= num_letters;
		 template[5] = letters[v % num_letters]; v /= num_letters;

		 fd = open(pattern, O_CREAT | O_EXCL | O_RDWR, mode);
-		 if (fd > 0)
+		 if (fd >= 0)
			 return fd;
		 /*
		  * Fatal error (EPERM, ENOSPC etc).
		  * It doesn't make sense to loop.
		  */
		 if (errno != EEXIST)
			 break;
		 /*
		  * This is a random value.  It is only necessary that
		  * the next TMP_MAX values generated by adding 7777 to
		  * VALUE are different with (module 2^32).
		  */
		 value += 7777;
	 }
	 /* We return the null string if we can't find a unique file name.  */
	 pattern[0] = '\0';
	 return -1;
 }


However, when looking at the code, I noticed that few of the functions
have comments describing what they do, and none describe their input
and output values.  In particular, there are no comments specifying
what the error return values are.  This is appalling for a supposedly
professional-quality project!

Dale
