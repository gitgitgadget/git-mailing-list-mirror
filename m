From: Jan =?UTF-8?B?S3LDvGdlcg==?= <jk@jk.gs>
Subject: [PATCH] rebase -i: more graceful handling of invalid commands
Date: Tue, 27 Oct 2009 13:39:32 +0100
Message-ID: <20091027133932.60b996c3@perceptron>
References: <40aa078e0910270313j5dc68576v86a3947f0dc7f9f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: kusmabite@gmail.com
X-From: git-owner@vger.kernel.org Tue Oct 27 13:40:01 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N2lLE-0007Ty-3R
	for gcvg-git-2@lo.gmane.org; Tue, 27 Oct 2009 13:40:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754223AbZJ0Mje convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 27 Oct 2009 08:39:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754142AbZJ0Mjd
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Oct 2009 08:39:33 -0400
Received: from zoidberg.org ([88.198.6.61]:59900 "EHLO cthulhu.zoidberg.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754125AbZJ0Mjd convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 27 Oct 2009 08:39:33 -0400
Received: from perceptron (xdsl-78-35-136-244.netcologne.de [::ffff:78.35.136.244])
  (IDENT: unknown, AUTH: LOGIN jast, TLS: TLSv1/SSLv3,128bits,AES128-SHA)
  by cthulhu.zoidberg.org with esmtp; Tue, 27 Oct 2009 13:39:34 +0100
  id 004D0114.4AE6EA08.00002D20
In-Reply-To: <40aa078e0910270313j5dc68576v86a3947f0dc7f9f@mail.gmail.com>
X-Mailer: Claws Mail 3.7.3 (GTK+ 2.16.1; i486-pc-linux-gnu)
X-Obscure-Spam: http://music-jk.net/
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131329>

Currently, when there is an invalid command, the rest of the line is
still treated as if the command had been valid, i.e. rebase -i attempts
to produce a patch, using the next argument as a SHA1 name. If there is
no next argument or an invalid one, very confusing error messages
appear (the line was '.'; path to git-rebase-todo substituted):

Unknown command: .
fatal: ambiguous argument 'Please fix this in the file $somefile.':
unknown revision or path not in the working tree.
Use '--' to separate paths from revisions
fatal: Not a valid object name Please fix this in the file $somefile.
fatal: bad revision 'Please fix this in the file $somefile.'

Instead, verify the validity of the remaining line and error out earlie=
r
if necessary.

Signed-off-by: Jan Kr=C3=BCger <jk@jk.gs>
---

> I recently came over a not-overly-helpful error in git rebase -i, whe=
n
> a line got wrapped by the editor so that a part of the commit-message
> was interpreted as a command:

Here is a suggested fix.

 git-rebase--interactive.sh |    7 ++++++-
 1 files changed, 6 insertions(+), 1 deletions(-)

diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index a1879e3..fdd8eb6 100755
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -416,7 +416,12 @@ do_next () {
 		;;
 	*)
 		warn "Unknown command: $command $sha1 $rest"
-		die_with_patch $sha1 "Please fix this in the file $TODO."
+		if git rev-parse --verify -q "$sha" >/dev/null
+		then
+			die_with_patch $sha1 "Please fix this in the file $TODO."
+		else
+			die "Please fix this in the file $TODO."
+		fi
 		;;
 	esac
 	test -s "$TODO" && return
--=20
1.6.5.rc1
