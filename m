From: Thomas Rast <trast@student.ethz.ch>
Subject: [PATCH v2] bash: offer to show (un)staged changes
Date: Mon, 19 Jan 2009 22:38:09 +0100
Message-ID: <1232401089-27512-1-git-send-email-trast@student.ethz.ch>
References: <20090119172939.GA14053@spearce.org>
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Junio C Hamano <junio@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 19 22:39:51 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LP1qU-00052e-OJ
	for gcvg-git-2@gmane.org; Mon, 19 Jan 2009 22:39:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760086AbZASViJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Jan 2009 16:38:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754468AbZASViH
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Jan 2009 16:38:07 -0500
Received: from xsmtp0.ethz.ch ([82.130.70.14]:54955 "EHLO XSMTP0.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760083AbZASViF (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Jan 2009 16:38:05 -0500
Received: from xfe2.d.ethz.ch ([82.130.124.42]) by XSMTP0.ethz.ch with Microsoft SMTPSVC(6.0.3790.3959);
	 Mon, 19 Jan 2009 22:38:03 +0100
Received: from localhost.localdomain ([129.132.153.233]) by xfe2.d.ethz.ch over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Mon, 19 Jan 2009 22:38:03 +0100
X-Mailer: git-send-email 1.6.1.397.gb7e802
In-Reply-To: <20090119172939.GA14053@spearce.org>
X-OriginalArrivalTime: 19 Jan 2009 21:38:03.0443 (UTC) FILETIME=[353D0830:01C97A7E]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106393>

Add a bit of code to __git_ps1 that lets it append '*' to the branch
name if there are any unstaged changes, and '+' if there are any
staged changes.

Since this is a rather expensive operation and will force a lot of
data into the cache whenever you first enter a repository, you have to
enable it manually by setting bash.showDirtyState to a true value.

Signed-off-by: Thomas Rast <trast@student.ethz.ch>

---

Shawn O. Pearce wrote:
> Junio C Hamano <gitster@pobox.com> wrote:
> > This makes the feature unavailable for people who care about the stat
> > dirtiness and explicitly set diff.autorefreshindex to false, doesn't it?
> 
> Yup, and I'm one of those people who sets autorefresindex to false
> in my ~/.gitconfig, usually before I even have user.{name,email} set.

I tried to alleviate the problem with a combination of diff options
that hopefully does the right thing in all cases.

> I do like the idea of what Thomas is trying to do here, but its
> so bloody expensive to compute dirty state on every prompt in
> some repositories that I'd shoot myself.  E.g. WebKit is huge,
> computing the dirty state inside of the WebKit repository on each
> prompt would absolutely kill CLI performance to a point of it not
> being usuable.  But git.git is small enough its OK on pretty much
> everything except Cygwin.
> 
> So as much as I'd like to use this without the update-index --refresh
> bit, I'm not sure its viable in every project out there.

I mostly work on small-ish repos, and while the initial loading is
_very_ noticeable, it's ok after that.  But your point about repos
being different is very good, so I changed the patch to use a
git-config variable instead of a shell environment variable.  That
way, you could even configure it to a different setting per-repo.

(Which might end up rather confusing, but at least it's possible.)


 contrib/completion/git-completion.bash |   22 ++++++++++++++++++++--
 1 files changed, 20 insertions(+), 2 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index f8b845a..7864ca7 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -34,6 +34,10 @@
 #       are currently in a git repository.  The %s token will be
 #       the name of the current branch.
 #
+#	In addition, if you set bash.showDirtyState to a true value,
+#	unstaged (*) and staged (+) changes will be shown next to the
+#	branch name.
+#
 # To submit patches:
 #
 #    *) Read Documentation/SubmittingPatches
@@ -116,10 +120,24 @@ __git_ps1 ()
 			fi
 		fi
 
+		local w
+		local i
+
+		if test "$(git config --bool bash.showDirtyState)" = "true"; then
+			git diff --no-ext-diff --ignore-submodules \
+				--quiet --exit-code || w="*"
+			if git rev-parse --quiet --verify HEAD >/dev/null; then
+				git diff-index --cached --quiet \
+					--ignore-submodules HEAD -- || i="+"
+			else
+				i="#"
+			fi
+		fi
+
 		if [ -n "${1-}" ]; then
-			printf "$1" "${b##refs/heads/}$r"
+			printf "$1" "${b##refs/heads/}$w$i$r"
 		else
-			printf " (%s)" "${b##refs/heads/}$r"
+			printf " (%s)" "${b##refs/heads/}$w$i$r"
 		fi
 	fi
 }
-- 
tg: (7bbd8d6..) t/ps1-dirty-state (depends on: origin/master)
