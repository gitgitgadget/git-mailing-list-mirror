From: Pete Wyckoff <pw@padd.com>
Subject: Re: [PATCH 2/2] commit, write-tree: allow to ignore CE_INTENT_TO_ADD
 while writing trees
Date: Mon, 16 Jan 2012 11:46:40 -0500
Message-ID: <20120116164640.GA3590@padd.com>
References: <1326681407-6344-1-git-send-email-pclouds@gmail.com>
 <1326681407-6344-3-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jan 16 17:46:52 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rmphp-0002k9-89
	for gcvg-git-2@lo.gmane.org; Mon, 16 Jan 2012 17:46:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753839Ab2APQqo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Jan 2012 11:46:44 -0500
Received: from honk.padd.com ([74.3.171.149]:40610 "EHLO honk.padd.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751024Ab2APQqn (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Jan 2012 11:46:43 -0500
Received: from arf.padd.com (unknown [50.55.142.76])
	by honk.padd.com (Postfix) with ESMTPSA id 92ADAE8B;
	Mon, 16 Jan 2012 08:46:42 -0800 (PST)
Received: by arf.padd.com (Postfix, from userid 7770)
	id 576AB31446; Mon, 16 Jan 2012 11:46:40 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <1326681407-6344-3-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188633>

pclouds@gmail.com wrote on Mon, 16 Jan 2012 09:36 +0700:
> Normally cache-tree will not produce trees from an index that has
> CE_INTENT_TO_ADD entries. This is a safe measure to avoid
> mis-interpreting user's intention regarding this flag.
> 
> There are situations however where users want to create trees/commits
> regardless i-t-a entries. Allow such cases with commit.ignoreIntentToAdd
> for git-commit and --ignore-intent-to-add for git-write-tree.

Recently I tried to use "--intent-to-add" on a new file, but when
committing was annoyed by the confusing error, and that I was
forced to do something with that new file.

With commit.ignoreIntentToAdd I can happily commit while leaving
the new file for later.  It stays in the index and is easy to see
in "git status".

I don't understand the need for an option in write-tree; just the
configuration variable is required.

Here's some changes to the docs you might squash in.  It took me
a while to figure out what this variable was about, and I tried
to explain it more clearly for a non-developer audience.

		-- Pete

--------8<------------
From 2471de7083ca3198f59a4734c0d11e9446874de1 Mon Sep 17 00:00:00 2001
From: Pete Wyckoff <pw@padd.com>
Date: Mon, 16 Jan 2012 11:44:26 -0500
Subject: [PATCH] documentation for commit.ignoreIntentToAdd

---
 Documentation/config.txt  |   13 ++++++++-----
 Documentation/git-add.txt |   15 ++++++++-------
 2 files changed, 16 insertions(+), 12 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 7ba8777..a2cbb50 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -821,6 +821,14 @@ color.ui::
 	`never` if you prefer git commands not to use color unless enabled
 	explicitly with some other configuration or the `--color` option.
 
+commit.ignoreIntentToAdd::
+	When 'git add' is invoked with `-N`, an "intent-to-add" entry is
+	made in the index.  At commit time, these entries must be removed
+	from the index ("git reset ...") or added ("git add ...").  This
+	boolean variable makes it possible to commit while leaving the
+	"intent-to-add" entries still in the index.  See the description
+	of the `-N` option in linkgit:git-add[1] for details.
+
 commit.status::
 	A boolean to enable/disable inclusion of status information in the
 	commit message template when using an editor to prepare the commit
@@ -831,11 +839,6 @@ commit.template::
 	"{tilde}/" is expanded to the value of `$HOME` and "{tilde}user/" to the
 	specified user's home directory.
 
-commit.ignoreIntentToAdd::
-	Allow to commit the index as-is even if there are
-	intent-to-add entries (see option `-N` in linkgit:git-add[1])
-	in index.
-
 credential.helper::
 	Specify an external helper to be called when a username or
 	password credential is needed; the helper may consult external
diff --git a/Documentation/git-add.txt b/Documentation/git-add.txt
index ec548ea..1c2ac44 100644
--- a/Documentation/git-add.txt
+++ b/Documentation/git-add.txt
@@ -125,14 +125,15 @@ subdirectories.
 	useful for, among other things, showing the unstaged content of
 	such files with `git diff`.
 +
-Paths added with this option have intent-to-add flag in index. The
-flag is removed once real content is added or updated. By default you
-cannot commit the index as-is from until this flag is removed from all
-entries (i.e. all entries have real content). See commit.ignoreIntentToAdd
-regardless the flag.
+When committing, these paths must be either added to the index (without
+the `-N` flag) or removed (with "git reset").  However, a configuration
+variable `commit.ignoreIntentToAdd` can be set to allow commits to
+proceed, while the intent-to-add paths remain in the index.
 +
-Committing with `git commit -a` or with selected paths works
-regardless the config key and the flag.
+Regardless of the configuration variable, invoking `git commit -a` will
+commit all files including the ones marked with intent-to-add.
+Specifying a <filepattern> can be used to commit files other than the
+ones marked with intent-to-add.
 
 --refresh::
 	Don't add the file(s), but only refresh their stat()
-- 
1.7.9.rc0.18.gdae96
