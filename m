From: Junio C Hamano <junkio@cox.net>
Subject: Re: git fetch over ssh trouble
Date: Thu, 25 Jan 2007 22:10:34 -0800
Message-ID: <7vejpi2u91.fsf@assigned-by-dhcp.cox.net>
References: <20070126050842.GA18058@fieldses.org>
	<7vmz462wdh.fsf@assigned-by-dhcp.cox.net>
	<20070126053400.GB18058@fieldses.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "J. Bruce Fields" <bfields@fieldses.org>
X-From: git-owner@vger.kernel.org Fri Jan 26 07:10:40 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HAKIJ-0002rW-VQ
	for gcvg-git@gmane.org; Fri, 26 Jan 2007 07:10:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030767AbXAZGKg (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 26 Jan 2007 01:10:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030769AbXAZGKg
	(ORCPT <rfc822;git-outgoing>); Fri, 26 Jan 2007 01:10:36 -0500
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:57720 "EHLO
	fed1rmmtao01.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030767AbXAZGKf (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Jan 2007 01:10:35 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao01.cox.net
          (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP
          id <20070126061034.OIJS9173.fed1rmmtao01.cox.net@fed1rmimpo01.cox.net>;
          Fri, 26 Jan 2007 01:10:34 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id Fi9d1W00C1kojtg0000000; Fri, 26 Jan 2007 01:09:37 -0500
In-Reply-To: <20070126053400.GB18058@fieldses.org> (J. Bruce Fields's message
	of "Fri, 26 Jan 2007 00:34:00 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37804>

"J. Bruce Fields" <bfields@fieldses.org> writes:

>> I wonder what should happen when you do not have anything
>> defined for "linus-nfs" shorthand.
>
> Oops; I didn't notice that!
>
>> Should it fetch HEAD?
>
> In my case I'd want it to either default to what I actually wanted
> (+refs/heads/*:refs/remotes/linux-nfs/*), or just fail with something
> helpful:
>
> 	"Nothing to fetch"?
> 	"No refspec given, and no default fetch configured for linux-nfs"?
> 	"What do you want me to fetch?"?
>
> I don't know.

Saying "let's grab everything" is certainly tempting, but I
think it is a bit too much.  How about doing this instead, then?

-- >8 --
[PATCH] parse-remote: do not barf on a remote shorthand without any refs to fetch.

Signed-off-by: Junio C Hamano <junkio@cox.net>

diff --git a/git-parse-remote.sh b/git-parse-remote.sh
index 1122c83..7e87f2e 100755
--- a/git-parse-remote.sh
+++ b/git-parse-remote.sh
@@ -81,7 +81,14 @@ get_remote_default_refs_for_push () {
 # is to help prevent randomly "globbed" ref from being chosen as
 # a merge candidate
 expand_refs_wildcard () {
+	remote="$1"
+	shift
 	first_one=yes
+	if test "$#" = 0
+	then
+		echo empty
+		echo >&2 "Nothing specified for fetching with remote.$remote.fetch"
+	fi
 	for ref
 	do
 		lref=${ref#'+'}
@@ -132,7 +139,7 @@ canon_refs_list_for_fetch () {
 	if test "$1" = "-d"
 	then
 		shift ; remote="$1" ; shift
-		set $(expand_refs_wildcard "$@")
+		set $(expand_refs_wildcard "$remote" "$@")
 		is_explicit="$1"
 		shift
 		if test "$remote" = "$(get_default_remote)"
