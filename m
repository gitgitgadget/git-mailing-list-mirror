From: Jeff King <peff@peff.net>
Subject: Re: [PATCHv2 3/3] completion: match ctags symbol names in grep
 patterns
Date: Thu, 27 Oct 2011 23:05:20 -0700
Message-ID: <20111028060517.GA3993@sigill.intra.peff.net>
References: <20111021172239.GA22289@sigill.intra.peff.net>
 <20111021173021.GC24417@sigill.intra.peff.net>
 <20111023212928.GG22551@goldbirke>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: SZEDER =?utf-8?B?R8OhYm9y?= <szeder@ira.uka.de>
X-From: git-owner@vger.kernel.org Fri Oct 28 08:05:32 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RJfZL-00007l-DJ
	for gcvg-git-2@lo.gmane.org; Fri, 28 Oct 2011 08:05:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754609Ab1J1GF1 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 28 Oct 2011 02:05:27 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:56924
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754388Ab1J1GF1 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Oct 2011 02:05:27 -0400
Received: (qmail 8050 invoked by uid 107); 28 Oct 2011 06:11:14 -0000
Received: from m9a4036d0.tmodns.net (HELO sigill.intra.peff.net) (208.54.64.154)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 28 Oct 2011 02:11:14 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 27 Oct 2011 23:05:20 -0700
Content-Disposition: inline
In-Reply-To: <20111023212928.GG22551@goldbirke>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184340>

On Sun, Oct 23, 2011 at 11:29:28PM +0200, SZEDER G=C3=A1bor wrote:

> On Fri, Oct 21, 2011 at 01:30:21PM -0400, Jeff King wrote:
> > This incorporates the suggestions from G=C3=A1bor's review, with on=
e
> > exception: it still looks only in the current directory for the "ta=
gs"
> > files. I think that might have some performance implications, so I'=
d
> > rather add it separately, if at all.
>=20
> I agree that scanning through a whole working tree for tags files
> would cost too much.  But I think that a tags file at the top of the
> working tree is common enough to be supported, and checking its
> existence is fairly cheap.

Actually, it's not too expensive. Asking git for the top of the working
tree means it has to traverse up to there anyway. So the trick is just
doing our search without invoking too many external tools which would
cause unnecessary forks.

The patch is below, but I'm still not sure it's a good idea.

Grep only looks in the current subdirectory for matches. So if I am in
"src/foo/bar/", and the tags file is in "src/", then is it really a goo=
d
way to generate completions? Most of what's in the tags file will
probably be in _other_ subdirectories of "src/", and won't be matched b=
y
grep at all. So we will give useless entries to bash to complete.

> So how about something like this for the case arm? (I didn't actually
> tested it.)
>=20
> 		local tagsfile
> 		if test -r tags; then
> 			tagsfile=3Dtags
> 		else
> 			local dir=3D"$(__gitdir)"

You don't want __gitdir here, but rather "git rev-parse --show-cdup".

> Btw, there is a bug in the case statement: 'git --no-pager grep <TAB>=
'
> offers refs instead of symbols, because $cword is not 2 and $prev
> doesn't start with a dash.  But it's not worse than the current
> behavior, so I don't think this bug is a show-stopper for the patch.

Yeah. The intent of the "$cword is 2" thing is to know that we are the
first non-option argument. Arguably, _get_comp_words_by_ref should
somehow tell us which position we are completing relative to the actual
command name.

-Peff

---
diff --git a/contrib/completion/git-completion.bash b/contrib/completio=
n/git-completion.bash
index af283cb..b0ed657 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1429,6 +1429,39 @@ _git_gitk ()
 	_gitk
 }
=20
+__git_cdup_dirs() {
+	local prefix=3D$(git rev-parse --show-cdup 2>/dev/null)
+	local oldifs=3D$IFS
+	local dots
+	local i
+	IFS=3D/
+	for i in $prefix; do
+		dots=3D$dots../
+		echo "$dots"
+	done
+	IFS=3D$oldifs
+}
+
+__git_find_in_cdup_one() {
+	local dir=3D$1; shift
+	for i in "$@"; do
+		if test -r "$dir$i"; then
+			echo "$dir$i"
+			return 0
+		fi
+	done
+	return 1
+}
+
+__git_find_in_cdup() {
+	__git_find_in_cdup_one "" "$@" && return
+
+	local dir
+	for dir in $(__git_cdup_dirs); do
+		__git_find_in_cdup_one "$dir" "$@" && return
+	done
+}
+
 __git_match_ctag() {
 	awk "/^${1////\\/}/ { print \$1 }" "$2"
 }
@@ -1457,8 +1490,9 @@ _git_grep ()
=20
 	case "$cword,$prev" in
 	2,*|*,-*)
-		if test -r tags; then
-			__gitcomp "$(__git_match_ctag "$cur" tags)"
+		local tags=3D$(__git_find_in_cdup tags)
+		if test -n "$tags"; then
+			__gitcomp "$(__git_match_ctag "$cur" "$tags")"
 			return
 		fi
 		;;
