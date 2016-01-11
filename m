From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH v3 2/2] Handle more file writes correctly in shared repos
Date: Mon, 11 Jan 2016 19:35:54 +0100 (CET)
Message-ID: <cfac7c2f2bfc8ae72c003899619d47fe856fd1e8.1452537321.git.johannes.schindelin@gmx.de>
References: <cover.1452085713.git.johannes.schindelin@gmx.de> <cover.1452537321.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: git@vger.kernel.org, Yaroslav Halchenko <yoh@onerussian.com>,
	=?ISO-8859-15?Q?SZEDER_G=E1bor?= <szeder@ira.uka.de>,
	Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jan 11 19:36:22 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aIhKH-0003h4-7I
	for gcvg-git-2@plane.gmane.org; Mon, 11 Jan 2016 19:36:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933219AbcAKSgR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Jan 2016 13:36:17 -0500
Received: from mout.gmx.net ([212.227.17.20]:50732 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932451AbcAKSgP (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Jan 2016 13:36:15 -0500
Received: from virtualbox ([37.24.143.74]) by mail.gmx.com (mrgmx101) with
 ESMTPSA (Nemesis) id 0M3NEK-1a0tS83AuW-00r1SR; Mon, 11 Jan 2016 19:35:56
 +0100
X-X-Sender: virtualbox@virtualbox
In-Reply-To: <cover.1452537321.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:wwlvwbmOo9PJu2CFd4tFLcZwrcBDXac6sUsxWiImbJXiXsBjY20
 dvpBB9si72r2LFd3qChVjXzjDSPQihqPOYZR/+BNTGPinm9MI9/OGzQRlYVSARaImYVfq+0
 52PylQ7KJZvjO401oO91fqCP9ykWCcXo+37XZlbEd4uUNHBxMDTe4WsOydZ7/tjE8aTp3aQ
 e6/0yqoSUkXo+EIrNuXwQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:4UscRGI/zJI=:lp3PEAs8dQ+RdG2V1HE4Fp
 vdZyQEdIO9wis0XjoQsyEugNQmwtMapvy3Hq1o3f/raZhPkEQyQLpxD3t9i7uk1os8XVX8p00
 XU8Oi7Zx7m2HMEIyWQCj2Xmx7VPHWQUzg+k/yvNv+sVbt4WAM9wA1Uf1U17LEirBa7QUrFS/M
 WMhqy9M2Ra1YiYTuJ0rPUWeeJhBagk3rjxE3O9lYFkopxdsrOZbSwCyBTeAkdzgtMtjcfDhQ9
 gXGv2hHBiqhCKxd9BOWg6Vvm62+Fu4eA8rDuvh0enxi6cRiVDfzMRE5cyvWzWl9I5FlFfkedm
 J1slGY4WBPfd6fwnDvZaVDIHZtw25HZ73tv8xqrpU9kObOmKE5O+kpe/BEEN6ACR/JD6Xw6hB
 2WkhWbHaoDnO6qqsvckgaAhbNSG6Z+eLXc6wVsk6Z4hF8K2yqBlmdDG39DugwUql4EgVp2dqE
 I6XNkBEr9amcxX1ip3hF8g09QwzaOz25n79BtMGezy7+RAxItVlI56MIBW7k7zJVP4ffT6XbK
 w0wx0cAfLkmZGMP53R0ZDumVK2TcQB+4sd8pK12YYYkrQSqeW9A7qvjslzNKm75INCaWYIAj8
 LDx/u7fBjvXacAYBN1P6mXUidAlXD393Ljmq5OKRhv/aj9QLtrFYdya+rWuNbOR54iDIFfJEn
 pthuaZJcDdzVg9/hy0NTrtXVFgTJ3t/dz37pdlVyBFtMC3zjQbZaZo2435FKC+bLpEAoFEq/C
 lZV9iTbx1RqxwkJW//Uqd1JIVFJPSpoF1GvlTqIg98i+/hrD2vo0iMQ08cxiu+15TG2POZfO 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283697>

In shared repositories, we have to be careful when writing files whose
permissions do not allow users other than the owner to write them.

In particular, we force the marks file of fast-export and the FETCH_HEAD
when fetching to be rewritten from scratch.

This commit does not touch the following users of fopen() that want to
write files:

- git am, when splitting mails (git-am correctly cleans up its directory
  after finishing, so there is no need to share those files between users)

- git apply, when writing rejected hunks (to be conservative, as it is not
  clear whether to write those files in shared mode or not)

- git fsck, when writing lost&found blobs (to be conservative, as it is
  not clear whether to write those files in shared mode or not)

- git merge-file, when writing merged files (when Git itself calls
  merge-file, the file in question was already there, with shared
  permissions).

- git submodule clone, when writing the .git file, because the file will
  not be overwritten

- git_terminal_prompt() in compat/terminal.c, because it is not writing to
  a file at all

- git diff --output, because the output file is clearly not intended to be
  shared between the users of the current repository

- git fast-import, when writing a crash report, because the reports' file
  names are unique due to an embedded process ID

- mailinfo() in mailinfo.c, because the output is clearly not intended to
  be shared between the users of the current repository

- check_or_regenerate_marks() in remote-testsvn.c, because this is only
  used for Git's internal testing

- git rerere, when writing resolved files, because the files in question
  were already written with the correct permissions

Note that this patch does not touch callers of write_file() and
write_file_gently(), which would benefit from the same scrutiny as to
usage in shared repositories. Most notable users: branch, daemon,
submodule & worktree, and a worrisome call in transport.c when updating
one ref (which ignores the shared flag).

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 builtin/fast-export.c | 2 +-
 builtin/fetch.c       | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/builtin/fast-export.c b/builtin/fast-export.c
index d9ac5d8..2471297 100644
--- a/builtin/fast-export.c
+++ b/builtin/fast-export.c
@@ -880,7 +880,7 @@ static void export_marks(char *file)
 	FILE *f;
 	int e = 0;
 
-	f = fopen(file, "w");
+	f = fopen_for_writing(file);
 	if (!f)
 		die_errno("Unable to open marks file %s for writing.", file);
 
diff --git a/builtin/fetch.c b/builtin/fetch.c
index 586840d..33f04c1 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -840,7 +840,7 @@ static void check_not_current_branch(struct ref *ref_map)
 static int truncate_fetch_head(void)
 {
 	const char *filename = git_path_fetch_head();
-	FILE *fp = fopen(filename, "w");
+	FILE *fp = fopen_for_writing(filename);
 
 	if (!fp)
 		return error(_("cannot open %s: %s\n"), filename, strerror(errno));
-- 
2.6.3.windows.1.300.g1c25e49
