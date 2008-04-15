From: Jeff King <peff@peff.net>
Subject: Re: branch description
Date: Tue, 15 Apr 2008 18:37:16 -0400
Message-ID: <20080415223716.GA1891@sigill.intra.peff.net>
References: <9b3e2dc20804150951scf8b3c7x26f3a56eab1f9840@mail.gmail.com> <f9d2a5e10804151031o1d09c1f9od0ad78dcf9b746c5@mail.gmail.com> <C55CA6EB-D427-4CF5-923E-DE0071D2F870@silverinsanity.com> <7vej97x78v.fsf@gitster.siamese.dyndns.org> <20080415191930.GC31395@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Brian Gernhardt <benji@silverinsanity.com>,
	Russ Dill <russ.dill@gmail.com>,
	Stephen Sinclair <radarsat1@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Apr 16 00:38:41 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jltmv-00070s-Df
	for gcvg-git-2@gmane.org; Wed, 16 Apr 2008 00:38:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755761AbYDOWhU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Apr 2008 18:37:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756394AbYDOWhT
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Apr 2008 18:37:19 -0400
Received: from [208.65.91.99] ([208.65.91.99]:1163 "EHLO peff.net"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1755655AbYDOWhS (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Apr 2008 18:37:18 -0400
Received: (qmail 21505 invoked by uid 111); 15 Apr 2008 22:37:17 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Tue, 15 Apr 2008 18:37:17 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 15 Apr 2008 18:37:16 -0400
Content-Disposition: inline
In-Reply-To: <20080415191930.GC31395@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79638>

On Tue, Apr 15, 2008 at 03:19:30PM -0400, Jeff King wrote:

> > Not complicated at all.  Put that description in-tree in a known location
> > (say, "help-branch") in-tree and your propagation problem is solved.
> >
> > And have a scriptlet in $HOME/bin/git-help-branch to grep from that file.
> 
> It is perhaps a little slow if you want to do things like adding the
> help text to branch name decorations in log output. Maybe instead of a
> flat file, you could parallel the ref name hierarchy in a tree? I.e.,

It occurred to me that you actually meant "just stick it in a file in
your actual work tree", not on a separate branch (for some reason,
reading the name "help-branch" made me think you meant a ref).

So that is obviously the very simple solution. But for fun, and because
maybe somebody could learn something, here is a script implementing my
approach. I dunno if it is worth including in contrib.

-- >8 --
contrib: add git-refinfo

This is a cute hack to show one possible way of storing ref
descriptions. It might be useful to somebody. It also serves
as a relatively short and simple example of how to script
git.

Signed-off-by: Jeff King <peff@peff.net>
---
 contrib/examples/git-refinfo.sh |   87 +++++++++++++++++++++++++++++++++++++++
 1 files changed, 87 insertions(+), 0 deletions(-)
 create mode 100755 contrib/examples/git-refinfo.sh

diff --git a/contrib/examples/git-refinfo.sh b/contrib/examples/git-refinfo.sh
new file mode 100755
index 0000000..b79a20f
--- /dev/null
+++ b/contrib/examples/git-refinfo.sh
@@ -0,0 +1,87 @@
+#!/bin/sh
+#
+# git-refinfo: a ref-description mechanism
+#
+# git-refinfo maintains a mapping of refnames to descriptions;
+# it stores the mapping as a version-controlled tree. Each
+# path in the tree represents a ref name, and the contents of
+# that path are the description.
+#
+# That means you can either use git-refinfo to set or examine
+# ref descriptions, or you can simply "git checkout refinfo"
+# and view and edit the files directly.
+
+REFINFO=refs/heads/refinfo
+SUBDIRECTORY_OK=Yes
+USAGE='
+git-refinfo set [<ref>] <description>
+git-refinfo get [<ref> ...]'
+. git-sh-setup
+
+die_usage() {
+	echo >&2 "usage: $USAGE"
+	exit 1
+}
+
+full_ref() {
+	git show-ref "$1" | sed -e 's/^[^ ]* //' -e '1q'
+}
+
+heads() {
+	git show-ref --heads | sed 's/.*refs\/heads\///'
+}
+
+do_get() {
+	ref=`full_ref "$1"`
+	case "$ref" in
+	'') desc= ;;
+	 *) desc=`git cat-file blob "$REFINFO:$ref" 2>/dev/null` ;;
+	esac
+	printf '%s\t%s\n' "$1" "$desc"
+}
+
+do_set() {
+	ref=`full_ref "$1"`
+	case "$ref" in
+	'')
+		case "$1" in
+		refs/*) ref=$1 ;;
+		heads/*) ref=refs/$1 ;;
+		*) ref=refs/heads/* ;;
+		esac
+		;;
+	esac
+	GIT_INDEX_FILE=$GIT_DIR/refinfo-index; export GIT_INDEX_FILE
+	rm -f $GIT_INDEX
+	old=`git rev-parse --verify $REFINFO 2>/dev/null`
+	case "$old" in
+	'') parents= ;;
+	 *) parents="-p $old"; git read-tree $REFINFO ;;
+	esac
+	blob=`printf '%s\n' "$2" | git hash-object -w --stdin`
+	git update-index --add --cacheinfo 0644 $blob "$ref"
+	tree=`git write-tree`
+	commit=`echo "update $1" | git commit-tree $tree $parents`
+	git update-ref -m refinfo $REFINFO $commit $old
+}
+
+case "$1" in
+set)
+	shift
+	case "$#" in
+	1) do_set "`git symbolic-ref HEAD`" "$1" ;;
+	2) do_set "$1" "$2" ;;
+	*) die_usage ;;
+	esac
+	;;
+get)
+	shift
+	case "$#" in
+	0) for i in `heads`; do do_get "$i"; done ;;
+	*) for i in "$@"; do do_get "$i"; done ;;
+	esac
+	;;
+*)
+	die_usage
+esac
+exit 0
-- 
1.5.5.63.g4e41c
