From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH v2 2/2] Handle more file writes correctly in shared repos
Date: Wed, 6 Jan 2016 14:09:49 +0100 (CET)
Message-ID: <c03e5a9d367b76d8a249680c752b4c4d935e9b91.1452085713.git.johannes.schindelin@gmx.de>
References: <4aa11f02f4de113bf38152b8815658da42690f43.1450549280.git.johannes.schindelin@gmx.de> <cover.1452085713.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: git@vger.kernel.org, Yaroslav Halchenko <yoh@onerussian.com>,
	=?ISO-8859-15?Q?SZEDER_G=E1bor?= <szeder@ira.uka.de>,
	Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jan 06 14:10:18 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aGnqz-0004dP-Ct
	for gcvg-git-2@plane.gmane.org; Wed, 06 Jan 2016 14:10:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752225AbcAFNKM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Jan 2016 08:10:12 -0500
Received: from mout.gmx.net ([212.227.17.20]:58095 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752026AbcAFNKK (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Jan 2016 08:10:10 -0500
Received: from virtualbox ([37.24.143.74]) by mail.gmx.com (mrgmx103) with
 ESMTPSA (Nemesis) id 0LsD9n-1a5ERK0LEt-013zTs; Wed, 06 Jan 2016 14:09:53
 +0100
X-X-Sender: virtualbox@virtualbox
In-Reply-To: <cover.1452085713.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:NHHq52N+9nciyYPdWL1nEG/FGfGs8mFNvx9qcVAJBqPZKDdQI8O
 kNtZpoPfAYP8b4+qt1xgjKMebZLjr5Z9xWhx4vZgOl5pLx9vd2xTXABcKPtPffHUZtJkyb4
 PmsYPM5NrMG2n6hANGXIkI3NK4G/MO2kuB7dJrQCoUp+Z8/bro8D8ZdmsahU4FIfudwxsbh
 yn1o96XraqOK4/1YWfDhA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:uX+RmY8OKYk=:GX3bJ5XXDpSHkmdlCcFoQx
 2OPb/aAqZJu52yZFIRLHl326TDvHQyjWAnx9N3IBXd3TKqEjxBPMMV6HlXqcMIBwLCtHWtbmH
 mdiA0EZzn1rwuYzyRqr0jTzAuxWm8nclGTUN86R9nkZaTyiek2QU620s1WM/VioWW0vqUDhvT
 UDLjV6sGl3F/6iJFheHDPEh5vWp3WfoiS2/gZVQOdGsUgLOlv38T6e1KZCN15nV/P/XDlW0p8
 YhAoJASBH0/bDWzDQh6L1zRR9RIdNBlfKHKvsFOxPyx8M5hqv6mcGQdt6U2SnMvpzezdbqpqc
 FLC4OMGqr9HyG/OcqMfm8MjGtHVKlyTXWMPYDJ9UXmpmN0kcIfY5gAsAnyDasyziXwfznxLZo
 NeZRTrgJQslRk0SMRX39d/9K3Kvu2p2Pg/M78Z78TLpBnkw6zueaLUt++HMDBfDQjr0o9N5Kk
 CWvXZZ75/GYaEQpcJF0gvigGsAeoODRKrY/Tom2eQqPmG86iMGEEHagyNwueSTH64PVo8ngo2
 0UGdwClb4mCnPT3tGf1FtUU1/ircfzHtpyX+EAgmZU7L1WWAi8LR48rIP1Q6Tu3Mh0YchdUWW
 XAsXeCl1kGMksqNLl9Pg8fS1PCtcrPkiymref6engOATdJXHwuv/Kz8q7+9c/muPxCs8oib+S
 tiOzeoULW73y2J4uNzHxyr39Lo6vG77bkD2NViZPB1NOvEkfeROlSC+5SQ1KbySTs2ku5Fibf
 Kl4B5A14C7U8xIEOy4imI9ajs9/ww7pTFf6GePzYaIMeHIlGfvlh090E3rSRwgSB4tPgEQcR 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283442>

In shared repositories, we have to be careful when writing files whose
permissions do not allow users other than the owner to write them.

In particular, we force the marks file of fast-export and the FETCH_HEAD
when fetching to be rewritten from scratch.

This commit does not touch the following users of fopen() that want to
write files:

- git am, when splitting mails (git-am correctly cleans up its directory
  after finishing, so there is no need to share those files between users)

- git apply, when writing rejected hunks

- git fsck, when writing lost&found blobs

- git merge-file, when writing merged files (when Git itself calls
  merge-file, the file in question was already there, with shared
  permissions).

- git submodule clone, when writing the .git file, because the file will
  not be overwritten

- git_terminal_prompt() in compat/terminal.c, because it is not writing to
  a file at all

- git diff --output, because the output file is clearly not intended to be
  shared between the users of the current repository

- git fast-import, when writing a crash report

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
