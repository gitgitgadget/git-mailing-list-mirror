From: Jan =?UTF-8?B?S3LDvGdlcg==?= <jk@jk.gs>
Subject: [PATCH v2] git-pull.sh --rebase: overhaul error handling when no
 candidates are found
Date: Thu, 12 Nov 2009 17:08:14 +0100
Message-ID: <20091112170814.1858aba4@perceptron>
References: <1257945756.26362.79.camel@heerbeest>
	<48B54636-1825-48B3-BECD-4150A55B013F@dbservice.com>
	<1257965806.26362.132.camel@heerbeest>
	<D6B0AE61-6CA3-4F79-BB50-B8795415BAB7@dbservice.com>
	<1257968052.26362.155.camel@heerbeest>
	<AC99BA30-A36D-4798-8E7D-9D69EFE99D55@dbservice.com>
	<1258035449.26362.273.camel@heerbeest>
	<20091112155310.7836c388@perceptron>
	<20091112150626.GA24848@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jan Nieuwenhuizen <janneke-list@xs4all.nl>,
	Tomas Carnecky <tom@dbservice.com>,
	git list <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Nov 12 17:08:37 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N8cDl-00085x-3j
	for gcvg-git-2@lo.gmane.org; Thu, 12 Nov 2009 17:08:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753419AbZKLQIQ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 12 Nov 2009 11:08:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753314AbZKLQIP
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Nov 2009 11:08:15 -0500
Received: from zoidberg.org ([88.198.6.61]:51194 "EHLO cthulhu.zoidberg.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753268AbZKLQIO convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 12 Nov 2009 11:08:14 -0500
Received: from perceptron (xdsl-78-35-170-176.netcologne.de [::ffff:78.35.170.176])
  (IDENT: unknown, AUTH: LOGIN jast, TLS: TLSv1/SSLv3,128bits,AES128-SHA)
  by cthulhu.zoidberg.org with esmtp; Thu, 12 Nov 2009 17:08:16 +0100
  id 004D0190.4AFC32F2.000057F1
In-Reply-To: <20091112150626.GA24848@coredump.intra.peff.net>
X-Mailer: Claws Mail 3.7.3 (GTK+ 2.18.3; i486-pc-linux-gnu)
X-Obscure-Spam: http://music-jk.net/
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132779>

* The longish error message displayed when the user uses "git pull" but
  has no remote/merge/rebase lines configured for the current branch
  contains example configuration to remedy the situation... but the
  example uses a rather invalid syntax, using the dotted syntax "git
  config" accepts, but also "=3D" separators which are used in the conf=
ig
  file format. It also implies that this syntax is valid in git config
  files. This changes the example to use valid config file syntax.

* When git pull --rebase is used, error_on_no_merge_candidates still
  thinks we're trying to merge, so the resulting message talks about
  merge all the time. This makes the message depend on the mode of
  operation.

Signed-off-by: Jan Kr=C3=BCger <jk@jk.gs>
---
So this still uses config file syntax, but the erroneous check for
using the "rebase" setting is gone. Instead, if --rebase is in effect,
include "rebase =3D true" in the sample config snippet.

By the way, Jeff, it's precisely your patch that confused me into
thinking there was a bug. I sort of assumed the messages you added had
already been there in the version Jan N. is using. Stupid assumption, I
guess.

 git-pull.sh |   41 ++++++++++++++++++++++++++---------------
 1 files changed, 26 insertions(+), 15 deletions(-)

diff --git a/git-pull.sh b/git-pull.sh
index 37f3d93..315ec51 100755
--- a/git-pull.sh
+++ b/git-pull.sh
@@ -91,45 +91,56 @@ error_on_no_merge_candidates () {
 		esac
 	done
=20
+	if [ true =3D "$rebase" ]; then
+		op_type=3Drebase
+		op_prep=3Dagainst
+	else
+		op_type=3Dmerge
+		op_prep=3Dwith
+	fi
+
 	curr_branch=3D${curr_branch#refs/heads/}
 	upstream=3D$(git config "branch.$curr_branch.merge")
 	remote=3D$(git config "branch.$curr_branch.remote")
=20
 	if [ $# -gt 1 ]; then
-		echo "There are no candidates for merging in the refs that you just =
fetched."
+		echo "There are no candidates for using the refs that you just fetch=
ed."
 		echo "Generally this means that you provided a wildcard refspec whic=
h had no"
 		echo "matches on the remote end."
 	elif [ $# -gt 0 ] && [ "$1" !=3D "$remote" ]; then
 		echo "You asked to pull from the remote '$1', but did not specify"
-		echo "a branch to merge. Because this is not the default configured =
remote"
+		echo "a branch to use. Because this is not the default configured re=
mote"
 		echo "for your current branch, you must specify a branch on the comm=
and line."
 	elif [ -z "$curr_branch" ]; then
 		echo "You are not currently on a branch, so I cannot use any"
 		echo "'branch.<branchname>.merge' in your configuration file."
-		echo "Please specify which branch you want to merge on the command"
+		echo "Please specify which branch you want to use on the command"
 		echo "line and try again (e.g. 'git pull <repository> <refspec>')."
 		echo "See git-pull(1) for details."
 	elif [ -z "$upstream" ]; then
 		echo "You asked me to pull without telling me which branch you"
-		echo "want to merge with, and 'branch.${curr_branch}.merge' in"
-		echo "your configuration file does not tell me either.	Please"
-		echo "specify which branch you want to merge on the command line and=
"
+		echo "want to $op_type $op_prep, and 'branch.${curr_branch}.merge' i=
n"
+		echo "your configuration file does not tell me either. Please"
+		echo "specify which branch you want to use on the command line and"
 		echo "try again (e.g. 'git pull <repository> <refspec>')."
 		echo "See git-pull(1) for details."
 		echo
-		echo "If you often merge with the same branch, you may want to"
-		echo "configure the following variables in your configuration"
-		echo "file:"
+		echo "If you often $op_type $op_prep the same branch, you may want t=
o"
+		echo "use something like the following in your configuration file:"
 		echo
-		echo "    branch.${curr_branch}.remote =3D <nickname>"
-		echo "    branch.${curr_branch}.merge =3D <remote-ref>"
-		echo "    remote.<nickname>.url =3D <url>"
-		echo "    remote.<nickname>.fetch =3D <refspec>"
+		echo "    [branch \"${curr_branch}\"]"
+		echo "    remote =3D <nickname>"
+		echo "    merge =3D <remote-ref>"
+		test rebase =3D "$op_type" &&
+			echo "    rebase =3D true"
+		echo "    [remote \"<nickname>\"]"
+		echo "    url =3D <url>"
+		echo "    fetch =3D <refspec>"
 		echo
 		echo "See git-config(1) for details."
 	else
-		echo "Your configuration specifies to merge the ref '${upstream#refs=
/heads/}' from the"
-		echo "remote, but no such ref was fetched."
+		echo "Your configuration specifies to $op_type $op_prep the ref '${u=
pstream#refs/heads/}'"
+		echo "from the remote, but no such ref was fetched."
 	fi
 	exit 1
 }
--=20
1.6.5.2.156.g89436
