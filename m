From: Junio C Hamano <junkio@cox.net>
Subject: Re: Pulling tags from git.git
Date: Tue, 07 Mar 2006 02:33:38 -0800
Message-ID: <7voe0ilf25.fsf@assigned-by-dhcp.cox.net>
References: <4dd15d180603061044h3f70d48bk8006c15e605fdca1@mail.gmail.com>
	<4dd15d180603061054k36d1a434se7377ded1b3240bb@mail.gmail.com>
	<440D5285.3050401@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 07 11:33:52 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FGZVk-0002Sd-0Q
	for gcvg-git@gmane.org; Tue, 07 Mar 2006 11:33:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751658AbWCGKdl (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 7 Mar 2006 05:33:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752031AbWCGKdl
	(ORCPT <rfc822;git-outgoing>); Tue, 7 Mar 2006 05:33:41 -0500
Received: from fed1rmmtao10.cox.net ([68.230.241.29]:34259 "EHLO
	fed1rmmtao10.cox.net") by vger.kernel.org with ESMTP
	id S1751658AbWCGKdl (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Mar 2006 05:33:41 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao10.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060307103148.WJLS20441.fed1rmmtao10.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 7 Mar 2006 05:31:48 -0500
To: Andreas Ericsson <ae@op5.se>
In-Reply-To: <440D5285.3050401@op5.se> (Andreas Ericsson's message of "Tue, 07
	Mar 2006 10:29:41 +0100")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17331>

Andreas Ericsson <ae@op5.se> writes:

> With the git or git+ssh protocol, tags will be autofollowed
> when you do a pull (only signed tags, I think).  The
> auto-following is done by detecting tags that are fetched,

Ah, you are correct.  We do not follow lightweight tags; I am
not sure if we should.

We detect from ls-remote output if you have objects pointed by
remote tags (either signed or unsigned -- we cannot tell it from
ls-remote output) and fetch those tags that point at what we
have.

The auto following is done only when you are tracking remote
branches, BTW.  Promiscuous fetch for immediate merging does not
follow tags.

Totally untested, so if somebody is interested, please test it,
and if it works, sign it off and bounce it back to me ;-).

-- >8 --
[PATCH] make "git fetch" follow unannotated tags as well.

---
diff --git a/git-fetch.sh b/git-fetch.sh
index 0346d4a..90c8882 100755
--- a/git-fetch.sh
+++ b/git-fetch.sh
@@ -375,7 +375,7 @@ case "$no_tags$tags" in
 		# using local tracking branch.
 		taglist=$(IFS=" " &&
 		git-ls-remote $upload_pack --tags "$remote" |
-		sed -ne 's|^\([0-9a-f]*\)[ 	]\(refs/tags/.*\)^{}$|\1 \2|p' |
+		sed -e 's/\^{}$//' -e 's/	/ /' |
 		while read sha1 name
 		do
 			test -f "$GIT_DIR/$name" && continue
@@ -386,7 +386,8 @@ case "$no_tags$tags" in
 			git-cat-file -t "$sha1" >/dev/null 2>&1 || continue
 			echo >&2 "Auto-following $name"
 			echo ".${name}:${name}"
-		done)
+		done |
+		sort -u)
 	esac
 	case "$taglist" in
 	'') ;;
