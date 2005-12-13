From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] [COGITO] make cg-tag use git-check-ref-format
Date: Tue, 13 Dec 2005 03:13:12 -0800
Message-ID: <7vy82p9rnb.fsf@assigned-by-dhcp.cox.net>
References: <11344712912199-git-send-email-matlads@dsmagic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 13 12:13:43 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Em86B-0006Yx-5A
	for gcvg-git@gmane.org; Tue, 13 Dec 2005 12:13:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750806AbVLMLNO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 13 Dec 2005 06:13:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750811AbVLMLNO
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Dec 2005 06:13:14 -0500
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:12779 "EHLO
	fed1rmmtao03.cox.net") by vger.kernel.org with ESMTP
	id S1750806AbVLMLNO (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Dec 2005 06:13:14 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao03.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051213111228.OVZO20875.fed1rmmtao03.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 13 Dec 2005 06:12:28 -0500
To: Martin Atukunda <matlads@dsmagic.com>
In-Reply-To: <11344712912199-git-send-email-matlads@dsmagic.com> (Martin
	Atukunda's message of "Tue, 13 Dec 2005 13:54:51 +0300")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13575>

Martin Atukunda <matlads@dsmagic.com> writes:

> The egrep pattern used by cg-tag is too restrictive. While it will prevent
> control characters from being specified as a tag name, it will also reject
> nearly anything written in a non-English language, as noted by -hpa
>...
> -(echo $name | egrep -qv '[^a-zA-Z0-9_.@!:-]') || \
> +git-check-ref-format $name || \
>  	die "name contains invalid characters"

Perhaps you meant to say:

	git-check-ref-format "$name"

instead; after all you are dealing with potentially garbage
input from the user here.

While you are at it, you might want to also quote $_git/refs/tags
immediately follows the part that you patched, and there is
another.

-- >8 --
[PATCH] cg-tag: shell variable quoting.

Scripts sometimes tend to be loose in variable quoting, and
often they are justifiable (e.g. the variables are already
validated before used unquoted); but when checking the input, we
should try to be strict.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---

diff --git a/cg-tag b/cg-tag
index da4f2d5..1efb50d 100755
--- a/cg-tag
+++ b/cg-tag
@@ -28,7 +28,7 @@
 
 USAGE="cg-tag [-d DESCRIPTION] [-s [-k KEYNAME]] TAG_NAME [OBJECT_ID]"
 
-. ${COGITO_LIB}cg-Xlib || exit 1
+. "${COGITO_LIB}cg-Xlib" || exit 1
 
 sign=
 keyname=
@@ -54,10 +54,10 @@ id=$(cg-object-id -n "$id") || exit 1
 type=$(git-cat-file -t "$id")
 id=${id% *}
 
-(echo $name | egrep -qv '[^a-zA-Z0-9_.@!:-]') || \
-	die "name contains invalid characters"
+git-check-ref-format "$name" ||
+	die "name $name contains invalid characters"
 
-mkdir -p $_git/refs/tags
+mkdir -p "$_git/refs/tags"
 
 [ -s "$_git/refs/tags/$name" ] && die "tag already exists ($name)"
 [ "$id" ] || id="$(cat "$_git/$(git-symbolic-ref HEAD)")"
@@ -83,7 +83,7 @@ if [ "$sign" ]; then
 	fi
 	cat "$tagdir/tag.asc" >>"$tagdir/tag"
 fi
-if ! git-mktag <"$tagdir/tag" >$_git/refs/tags/$name; then
+if ! git-mktag <"$tagdir/tag" >"$_git/refs/tags/$name"; then
 	rm -rf "$tagdir"
 	die "error creating tag"
 fi
