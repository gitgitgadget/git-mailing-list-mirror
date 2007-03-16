From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH, fixed] git-fetch, git-branch: Support local --track via a special remote `.'
Date: Thu, 15 Mar 2007 17:21:11 -0700
Message-ID: <7vr6rqyr60.fsf@assigned-by-dhcp.cox.net>
References: <etavpn$ma0$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Paolo Bonzini <bonzini@gnu.org>
X-From: git-owner@vger.kernel.org Fri Mar 16 01:21:17 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HS0C4-0002Nc-6y
	for gcvg-git@gmane.org; Fri, 16 Mar 2007 01:21:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753457AbXCPAVN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 15 Mar 2007 20:21:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753463AbXCPAVN
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Mar 2007 20:21:13 -0400
Received: from fed1rmmtao104.cox.net ([68.230.241.42]:63164 "EHLO
	fed1rmmtao104.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753457AbXCPAVM (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Mar 2007 20:21:12 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao104.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070316002112.BBZA1606.fed1rmmtao104.cox.net@fed1rmimpo02.cox.net>;
          Thu, 15 Mar 2007 20:21:12 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id bCMC1W00A1kojtg0000000; Thu, 15 Mar 2007 20:21:12 -0400
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42304>

Paolo Bonzini <bonzini@gnu.org> writes:

> 	To make the name of fetch_dumb more consistent with the
> 	functionality, I renamed it to fetch_heads, as well as
> 	renaming fetch_native to fetch_packs.

I agree renaming fetch_dumb vs fetch_native to names that
reflect their nature better might be a good idea.  The former is
to perform fetching objects and updating tracking ref for one
ref at a time, while the latter is to do the fetching and
updating all relevant tracking refs in one go.  The 'per-ref'
behaviour is exactly why the former is called "dumb".

If you really want to rename, perhaps making the former
fetch_per_ref and the latter fetch_all_at_once would reflect
their nature better.  While I do not have strong preference
either way, I think "fetch_head" is a slight improvement over
"fetch_dumb", because it tells that "per-ref" nature a bit
better, and "fetch_pack" is not any better than "fetch_native".

While talking about names, I think calling data_source 'builtin'
feels very wrong, as we _might_ want to later add other kinds of
repository the system knows about.  I would have picked 'self',
as this change is about referring the repository itself using a
fake name '.' for it.

I think it would be a lot more efficient if you made the 'self'
fetch piggyback on fetch_all_at_once side, like the attached
patch.

This is on top of your patch to illustrate the difference, and
does not have the renaming I suggested (i.e. dumb->per_ref,
packs->all_at_once, and builtin->self).

diff --git a/git-fetch.sh b/git-fetch.sh
index cbbb5ca..ffe6847 100755
--- a/git-fetch.sh
+++ b/git-fetch.sh
@@ -170,6 +170,10 @@ fetch_packs () {
 		die "shallow clone with bundle is not supported"
 	    git-bundle unbundle "$remote" $rref ||
 	    echo failed "$remote"
+	elif test "." = "$remote"
+	then
+		git-show-ref $rref ||
+		echo failed .
 	else
 	  git-fetch-pack --thin $exec $keep $shallow_depth $no_progress \
 		"$remote" $rref ||
@@ -280,10 +284,6 @@ fetch_heads () {
 	      rsync_slurped_objects=t
 	  }
 	  ;;
-      .)
-	  local_name=$remote_name
-	  head=$(git-rev-parse --verify "$local_name")
-	  ;;
       esac
 
       append_fetch_head "$head" "$remote" \
@@ -296,7 +296,7 @@ fetch_heads () {
 fetch_main () {
 	data_source=$(get_data_source "$remote_nick")
 	if test "$data_source" = builtin; then
-		fetch_heads "$@"
+		fetch_packs "$@"
 	else
 		case "$remote" in
 		http://* | https://* | ftp://* | rsync://* )
