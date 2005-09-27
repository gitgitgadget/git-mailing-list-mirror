From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Cogito: cg-clone doesn't like packed tag objects
Date: Tue, 27 Sep 2005 10:56:24 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0509271020530.3308@g5.osdl.org>
References: <7virwna2oi.fsf@assigned-by-dhcp.cox.net> <7v3bnra20z.fsf@assigned-by-dhcp.cox.net>
 <43348086.2040006@zytor.com> <20050924011833.GJ10255@pasky.or.cz>
 <20050926212536.GF26340@pasky.or.cz> <7virwna2oi.fsf@assigned-by-dhcp.cox.net>
 <20050926222944.GG26340@pasky.or.cz> <7vr7bb5d8w.fsf@assigned-by-dhcp.cox.net>
 <8764snyufn.fsf@ualberta.net> <7v4q875bbj.fsf@assigned-by-dhcp.cox.net>
 <20050927094029.GA30889@pasky.or.cz> <7v64sm30dh.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Petr Baudis <pasky@suse.cz>, Tom Prince <tom.prince@ualberta.net>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 27 19:57:02 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EKJh8-0003oy-BZ
	for gcvg-git@gmane.org; Tue, 27 Sep 2005 19:56:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965034AbVI0R4m (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 27 Sep 2005 13:56:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965033AbVI0R4m
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Sep 2005 13:56:42 -0400
Received: from smtp.osdl.org ([65.172.181.4]:63888 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S965034AbVI0R4l (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 27 Sep 2005 13:56:41 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j8RHuP4s030738
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 27 Sep 2005 10:56:25 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j8RHuOta023739;
	Tue, 27 Sep 2005 10:56:24 -0700
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7v64sm30dh.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.45__
X-MIMEDefang-Filter: osdl$Revision: 1.118 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9411>



On Tue, 27 Sep 2005, Junio C Hamano wrote:
> 
> This is a bit hard and needs some thinking to do cleanly,
> because what is in info/refs is what is sent from the publisher
> side over git-native protocol at the beginning of the handshake,
> and it is not easy to add that to git-native protocol cleanly
> and backward-compatibly (I think I know how without breaking
> existing clients, but it is not clean).

Argh.

"git-upload-pack" very much on purpose never sends partial object stores: 
it really doesn't want to send a tag-object for you to even _look_ at 
unless it also sends all the objects that you are missing that the tag 
refers to.

I'd really be much happier with the tag fetching being separate.

For example, making

	git fetch --tags <dest>

fetch all tags _and_ the objects that they depend on would seem a _lot_ 
more appropriate.

The thing is, tags really may be totally private. For example, it makes 
sense to fetch tags when you pull an official tree (ie my kernel tree, or 
your git tree), but it does NOT make sense for me to fetch tags 
(automatically or not) when I pull from a developers tree.

That's why git fetch doesn't get the tags by default. It's WRONG. 

But we could certainly make it _easier_ to get tags when you want them. 
"git-ls-remote" already helps you, and

	git-ls-remote ... | cut -f2 | grep '^refs/tags/'

completes the picture. No protocol changes necessary, just some added 
magic to git-fetch.sh.

Actually, here's a simple and stupid patch.

Untested as usual, but hey, how hard can it be?

		Linus

----
diff --git a/git-fetch.sh b/git-fetch.sh
--- a/git-fetch.sh
+++ b/git-fetch.sh
@@ -5,6 +5,7 @@
 _x40='[0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f]'
 _x40="$_x40$_x40$_x40$_x40$_x40$_x40$_x40$_x40"
 
+tags=
 append=
 force=
 update_head_ok=
@@ -17,6 +18,9 @@ do
 	-f|--f|--fo|--for|--forc|--force)
 		force=t
 		;;
+	--tags)
+		tags=t
+		;;
 	-u|--u|--up|--upd|--upda|--updat|--update|--update-|--update-h|\
 	--update-he|--update-hea|--update-head|--update-head-|\
 	--update-head-o|--update-head-ok)
@@ -151,7 +155,12 @@ case "$update_head_ok" in
 	;;
 esac
 
-for ref in $(get_remote_refs_for_fetch "$@")
+taglist=
+if [ "$tags" ]; then
+	taglist=$(git-ls-remote "$remote" | awk '/refs\/tags/ { print $2":"$2 }')
+fi
+
+for ref in $(get_remote_refs_for_fetch "$@" $taglist)
 do
     refs="$refs $ref"
 
