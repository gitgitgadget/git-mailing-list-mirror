From: Petr Baudis <pasky@suse.cz>
Subject: Re: lost again on syntax change - local repository?
Date: Mon, 28 Nov 2005 15:34:28 +0100
Message-ID: <20051128143428.GS22159@pasky.or.cz>
References: <861x118r9t.fsf@blue.stonehenge.com> <20051128104831.GN22159@pasky.or.cz> <86d5kk7wbv.fsf@blue.stonehenge.com> <20051128134111.GP22159@pasky.or.cz> <86zmno6g3v.fsf@blue.stonehenge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 28 15:36:51 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Egk5V-0002bM-3b
	for gcvg-git@gmane.org; Mon, 28 Nov 2005 15:34:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750719AbVK1OeO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 28 Nov 2005 09:34:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750722AbVK1OeO
	(ORCPT <rfc822;git-outgoing>); Mon, 28 Nov 2005 09:34:14 -0500
Received: from w241.dkm.cz ([62.24.88.241]:54923 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S1750719AbVK1OeN (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 28 Nov 2005 09:34:13 -0500
Received: (qmail 9455 invoked by uid 2001); 28 Nov 2005 15:34:28 +0100
To: "Randal L. Schwartz" <merlyn@stonehenge.com>
Content-Disposition: inline
In-Reply-To: <86zmno6g3v.fsf@blue.stonehenge.com>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12883>

Dear diary, on Mon, Nov 28, 2005 at 02:45:24PM CET, I got a letter
where "Randal L. Schwartz" <merlyn@stonehenge.com> said that...
> >>>>> "Petr" == Petr Baudis <pasky@suse.cz> writes:
> 
> Petr> It would sure be bad if this was the case. However I'm really sorry, but
> Petr> I still can't reproduce it.
> 
> Reproduce by this:
> 
>     localhost:~/Projects/Git/Play % cg-admin-setuprepo remote.git
>     localhost:~/Projects/Git/Play % mkdir local.git
>     localhost:~/Projects/Git/Play % cd local.git
>     localhost:..Git/Play/local.git % cg-init -minitial
>     defaulting to local storage area
>     Committing initial tree 4b825dc642cb6eb9a060e54bf8d69288fbee4904
>     Committed as 958ed484382609786ca9ae611cc54802cb7697a9.
>     localhost:..Git/Play/local.git % cg-branch-add origin "$(cd ..; pwd)/remote.git#master"           
>     localhost:..Git/Play/local.git % cg-push
>     WARNING: I guessed the host:path syntax was used and fell back to the git+ssh protocol.
>     WARNING: The host:path syntax is evil because it is implicit. Please just use a URI.
>     ssh: \033]2;[zsh] localhost: No address associated with nodename
>     fatal: unexpected EOF

Still works for me.

Could you patch cg-push like

diff --git a/cg-push b/cg-push
index 1d59422..bdab3b8 100755
--- a/cg-push
+++ b/cg-push
@@ -47,6 +47,7 @@ name=${ARGS[0]}
 [ "$name" ] || { [ -s $_git/branches/origin ] && name=origin; }
 [ "$name" ] || die "where to push to?"
 uri=$(cat "$_git/branches/$name" 2>/dev/null) || die "unknown branch: $name"
+echo "using $uri"
 
 rembranch=master
 sprembranch=
@@ -54,6 +55,7 @@ if echo "$uri" | grep -q '#'; then
 	rembranch=$(echo $uri | cut -d '#' -f 2)
 	sprembranch=":$rembranch"
 	uri=$(echo $uri | cut -d '#' -f 1)
+	echo "now using $uri"
 fi
 
 if echo "$uri" | grep -q "^http://"; then
@@ -63,6 +65,7 @@ elif echo "$uri" | grep -q "^git+ssh://"
 elif echo "$uri" | grep -q "^rsync://"; then
         die "pushing over rsync not supported"
 elif echo "$uri" | grep -q ":"; then
+	echo "matched ':' in $uri ?!"
 	echo "WARNING: I guessed the host:path syntax was used and fell back to the git+ssh protocol."
 	echo "WARNING: The host:path syntax is evil because it is implicit. Please just use a URI."
 	send_pack_update "$name" "$uri" $_git_head$sprembranch "${tags[@]}"

please?

(We are a bit careless about quoting here, which I will fix now,
but that shouldn't be the problem.)

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
VI has two modes: the one in which it beeps and the one in which
it doesn't.
