From: Jan =?UTF-8?B?S3LDvGdlcg==?= <jk@jk.gs>
Subject: [PATCH v2] rebase -i: more graceful handling of invalid commands
Date: Tue, 27 Oct 2009 15:58:14 +0100
Message-ID: <20091027155814.0de65db5@perceptron>
References: <40aa078e0910270313j5dc68576v86a3947f0dc7f9f@mail.gmail.com>
	<20091027133932.60b996c3@perceptron>
	<200910271521.09164.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: kusmabite@gmail.com, Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Tue Oct 27 15:58:27 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N2nVD-00071o-1N
	for gcvg-git-2@lo.gmane.org; Tue, 27 Oct 2009 15:58:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755106AbZJ0O6P convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 27 Oct 2009 10:58:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755042AbZJ0O6O
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Oct 2009 10:58:14 -0400
Received: from zoidberg.org ([88.198.6.61]:55300 "EHLO cthulhu.zoidberg.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754857AbZJ0O6O convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 27 Oct 2009 10:58:14 -0400
Received: from perceptron (xdsl-78-35-136-244.netcologne.de [::ffff:78.35.136.244])
  (IDENT: unknown, AUTH: LOGIN jast, TLS: TLSv1/SSLv3,128bits,AES128-SHA)
  by cthulhu.zoidberg.org with esmtp; Tue, 27 Oct 2009 15:58:16 +0100
  id 004D0244.4AE70A88.00003C3F
In-Reply-To: <200910271521.09164.trast@student.ethz.ch>
X-Mailer: Claws Mail 3.7.3 (GTK+ 2.16.1; i486-pc-linux-gnu)
X-Obscure-Spam: http://music-jk.net/
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131344>

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
Acked-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
---

Thomas Rast wrote:
> I think you need s/sha/sha1/ here?

Of course. For some reason I forgot testing the code path where the
SHA1 is actually valid. Sorry about that.

Dscho's ACK lifted off
<http://article.gmane.org/gmane.comp.version-control.git/131341>.

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
+		if git rev-parse --verify -q "$sha1" >/dev/null
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
