From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Documentation: update git-pull.txt for clone's new default behavior
Date: Sun, 31 Dec 2006 17:44:37 -0800
Message-ID: <7vwt47bjwa.fsf@assigned-by-dhcp.cox.net>
References: <11676088584199-git-send-email-bfields@fieldses.org>
	<1167608858759-git-send-email-bfields@fieldses.org>
	<11676088582634-git-send-email-bfields@fieldses.org>
	<7vd55zd1nm.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Shawn Pearce <spearce@spearce.org>,
	Luben Tuikov <ltuikov@yahoo.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Jan 01 02:44:46 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H1CEH-00066E-Ot
	for gcvg-git@gmane.org; Mon, 01 Jan 2007 02:44:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932853AbXAABom (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 31 Dec 2006 20:44:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932852AbXAABom
	(ORCPT <rfc822;git-outgoing>); Sun, 31 Dec 2006 20:44:42 -0500
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:36250 "EHLO
	fed1rmmtao06.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932853AbXAABol (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 31 Dec 2006 20:44:41 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao06.cox.net
          (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP
          id <20070101014438.QUWE2628.fed1rmmtao06.cox.net@fed1rmimpo01.cox.net>;
          Sun, 31 Dec 2006 20:44:38 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id 5djr1W00W1kojtg0000000; Sun, 31 Dec 2006 20:43:52 -0500
To: bfields@fieldses.org
In-Reply-To: <7vd55zd1nm.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Sun, 31 Dec 2006 16:35:41 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35718>

Junio C Hamano <junkio@cox.net> writes:

> What we wanted to do ideally was to forbid "git pull" that does
> not have explicit refspec from the command line, without
> configuring branch.*.merge.  However this broke established
> workflow of people who has remote.$origin.fetch configured to
> list the remote branch to fetch explicitly; the merged branch
> selection has always been "the first set of branches listed in
> the configuration" and these peoples had their configuration
> right without needing to have branch.*.merge at all.
>
> Unfortunately git is too flexible around this area.  
>
> We probably could somehow arrante the remote branches that came
> from wildcarding not subject to the merge branch selection
> logic, but honestly I am tired of looking at that code for now.

I am still tired of looking at the code, but I would rather 
look at it now than having to still look at it next year.

How about doing this?  The difference this time around is that
if you have non-wildcard refspec listed first, which usually
is the case for people with established git workflow with
existing repositories, we use the old-and-proven rule to
merge the first set of refs.  An earlier round botched this
completely by basing the logic on lack of branch.*.merge,
which broke for many people.

-- >8 --
[PATCH] Do not merge random set of refs out of wildcarded refs

When your fetch configuration has only the wildcards, we would
pick the lexicographically first ref from the remote side for
merging, which was complete nonsense.  Make sure nothing except
the one that is specified with branch.*.merge is merged in this
case.

Signed-off-by: Junio C Hamano <junkio@cox.net>

---

diff --git a/git-parse-remote.sh b/git-parse-remote.sh
index 144f170..d2e4c2b 100755
--- a/git-parse-remote.sh
+++ b/git-parse-remote.sh
@@ -76,16 +76,32 @@ get_remote_default_refs_for_push () {
 # from get_remote_refs_for_fetch when it deals with refspecs
 # supplied on the command line.  $ls_remote_result has the list
 # of refs available at remote.
+#
+# The first token returned is either "explicit" or "glob"; this
+# is to help prevent randomly "globbed" ref from being chosen as
+# a merge candidate
 expand_refs_wildcard () {
+	first_one=yes
 	for ref
 	do
 		lref=${ref#'+'}
 		# a non glob pattern is given back as-is.
 		expr "z$lref" : 'zrefs/.*/\*:refs/.*/\*$' >/dev/null || {
+			if test -n "$first_one"
+			then
+				echo "explicit"
+				first_one=
+			fi
 			echo "$ref"
 			continue
 		}
 
+		# glob
+		if test -n "$first_one"
+		then
+			echo "glob"
+			first_one=
+		fi
 		from=`expr "z$lref" : 'z\(refs/.*/\)\*:refs/.*/\*$'`
 		to=`expr "z$lref" : 'zrefs/.*/\*:\(refs/.*/\)\*$'`
 		local_force=
@@ -116,7 +132,8 @@ canon_refs_list_for_fetch () {
 	if test "$1" = "-d"
 	then
 		shift ; remote="$1" ; shift
-		set x $(expand_refs_wildcard "$@")
+		set $(expand_refs_wildcard "$@")
+		is_explicit="$1"
 		shift
 		if test "$remote" = "$(get_default_remote)"
 		then
@@ -125,6 +142,10 @@ canon_refs_list_for_fetch () {
 			merge_branches=$(git-repo-config \
 			    --get-all "branch.${curr_branch}.merge")
 		fi
+		if test -z "$merge_branches" && test $is_explicit != explicit
+		then
+			merge_branches=..this.will.never.match.any.ref..
+		fi
 	fi
 	for ref
 	do
