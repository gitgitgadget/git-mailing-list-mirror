From: Petr Baudis <pasky@suse.cz>
Subject: Re: lost again on syntax change - local repository?
Date: Mon, 28 Nov 2005 20:15:46 +0100
Message-ID: <20051128191546.GT22159@pasky.or.cz>
References: <861x118r9t.fsf@blue.stonehenge.com> <20051128104831.GN22159@pasky.or.cz> <86d5kk7wbv.fsf@blue.stonehenge.com> <20051128134111.GP22159@pasky.or.cz> <86zmno6g3v.fsf@blue.stonehenge.com> <20051128143428.GS22159@pasky.or.cz> <868xv86dam.fsf@blue.stonehenge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 28 20:17:49 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EgoTY-0005dI-P8
	for gcvg-git@gmane.org; Mon, 28 Nov 2005 20:15:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932197AbVK1TPe (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 28 Nov 2005 14:15:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932192AbVK1TPd
	(ORCPT <rfc822;git-outgoing>); Mon, 28 Nov 2005 14:15:33 -0500
Received: from w241.dkm.cz ([62.24.88.241]:55516 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S932197AbVK1TPc (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 28 Nov 2005 14:15:32 -0500
Received: (qmail 28627 invoked by uid 2001); 28 Nov 2005 20:15:46 +0100
To: "Randal L. Schwartz" <merlyn@stonehenge.com>
Content-Disposition: inline
In-Reply-To: <868xv86dam.fsf@blue.stonehenge.com>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12898>

Dear diary, on Mon, Nov 28, 2005 at 03:46:09PM CET, I got a letter
where "Randal L. Schwartz" <merlyn@stonehenge.com> said that...
> However, I get this:
> 
>     localhost:..git/Play/local.git % echo "/Users/merlyn/Projects/git/Play/remote.git" | grep -q ":"
>     localhost:..git/Play/local.git % echo $status
>     1
> 
> So, perhaps the "bash" on this system is broken for that elif chain?
> 
> localhost:..git/Play/local.git % bash --version
> GNU bash, version 2.05b.0(1)-release (powerpc-apple-darwin8.0)
> Copyright (C) 2002 Free Software Foundation, Inc.
> 
> Gah.  Yet Another Hidden Dependency.

Perplexing. Can't reproduce it with bash-2.05b either.

Could you try the following, please?

diff --git a/cg-push b/cg-push
index 1d59422..323ef26 100755
--- a/cg-push
+++ b/cg-push
@@ -56,13 +56,13 @@ if echo "$uri" | grep -q '#'; then
 	uri=$(echo $uri | cut -d '#' -f 1)
 fi
 
-if echo "$uri" | grep -q "^http://"; then
+if [ "${uri#http://}" != "$uri" ]; then
 	die "pushing over HTTP not supported yet"
-elif echo "$uri" | grep -q "^git+ssh://"; then
+elif [ "${uri#git+ssh://}" != "$uri" ]; then
 	send_pack_update "$name" "$(echo "$uri" | sed 's#^git+ssh://\([^/]*\)\(/.*\)$#\1:\2#')" $_git_head$sprembranch "${tags[@]}"
-elif echo "$uri" | grep -q "^rsync://"; then
+elif [ "${uri#rsync://}" != "$uri" ]; then
         die "pushing over rsync not supported"
-elif echo "$uri" | grep -q ":"; then
+elif [ "${uri#*:}" != "$uri" ]; then
 	echo "WARNING: I guessed the host:path syntax was used and fell back to the git+ssh protocol."
 	echo "WARNING: The host:path syntax is evil because it is implicit. Please just use a URI."
 	send_pack_update "$name" "$uri" $_git_head$sprembranch "${tags[@]}"

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
VI has two modes: the one in which it beeps and the one in which
it doesn't.
