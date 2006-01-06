From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Ignore tags that contain colons in their names
Date: Fri, 06 Jan 2006 14:37:57 -0800
Message-ID: <7v1wzlrni2.fsf@assigned-by-dhcp.cox.net>
References: <43BBCA0A.6020906@kleinhenz.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 06 23:39:05 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ev0EY-0007m3-Kw
	for gcvg-git@gmane.org; Fri, 06 Jan 2006 23:38:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964868AbWAFWiE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 6 Jan 2006 17:38:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964864AbWAFWiB
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Jan 2006 17:38:01 -0500
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:31473 "EHLO
	fed1rmmtao09.cox.net") by vger.kernel.org with ESMTP
	id S964868AbWAFWh7 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Jan 2006 17:37:59 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao09.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060106223802.WCQJ25099.fed1rmmtao09.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 6 Jan 2006 17:38:02 -0500
To: Simon Richter <Simon.Richter@kleinhenz.de>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14225>

Simon Richter <Simon.Richter@kleinhenz.de> writes:

> a repo I was trying to clone contained a tag that somehow had a colon
> in its name, which is illegal. The attached patch makes git-fetch
> ignore these tags rather than barf.

Good intentions, but colon is not the only character.
I suspect we need to do something like this instead.

---
diff --git a/git-fetch.sh b/git-fetch.sh
index 125bcea..b46b3e5 100755
--- a/git-fetch.sh
+++ b/git-fetch.sh
@@ -188,11 +188,20 @@ esac
 reflist=$(get_remote_refs_for_fetch "$@")
 if test "$tags"
 then
-	taglist=$(git-ls-remote --tags "$remote" |
-		sed -e '
-			/\^/d
-			s/^[^	]*	//
-			s/.*/.&:&/')
+	taglist=$(IFS="	" &&
+		  git-ls-remote --tags "$remote" |
+	          while read sha1 name
+		  do
+			case "$name" in
+			(*^*) continue ;;
+			esac
+		  	if git-check-ref-format "$name"
+			then
+			    echo ".${name}:${name}"
+			else
+			    echo >&2 "warning: tag ${name} ignored"
+			fi
+		  done)
 	if test "$#" -gt 1
 	then
 		# remote URL plus explicit refspecs; we need to merge them.
