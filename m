From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: auto-packing on kernel.org? please?
Date: Mon, 21 Nov 2005 12:38:31 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0511211211130.13959@g5.osdl.org>
References: <Pine.LNX.4.64.0510131113490.15297@g5.osdl.org>
 <20051121190151.GA2568@hpsvcnb.fc.hp.com> <Pine.LNX.4.64.0511211110480.13959@g5.osdl.org>
 <7v3blprcwk.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 21 21:41:54 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EeIRW-0005Hy-Eo
	for gcvg-git@gmane.org; Mon, 21 Nov 2005 21:39:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932473AbVKUUi7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 21 Nov 2005 15:38:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932472AbVKUUi7
	(ORCPT <rfc822;git-outgoing>); Mon, 21 Nov 2005 15:38:59 -0500
Received: from smtp.osdl.org ([65.172.181.4]:53645 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932463AbVKUUi6 (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 21 Nov 2005 15:38:58 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id jALKcZnO007979
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Mon, 21 Nov 2005 12:38:35 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id jALKcV7l031533;
	Mon, 21 Nov 2005 12:38:33 -0800
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7v3blprcwk.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.55__
X-MIMEDefang-Filter: osdl$Revision: 1.127 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12478>



On Mon, 21 Nov 2005, Junio C Hamano wrote:
> 
> One cop-out: do fsck-objects upfront before making a pack.  This
> would populate your buffer cache so it might not be a bad thing.

Well, it's extremely expensive most of the time. It's often as expensive 
as the packing itself. So I don't like that option very much.

> Alternatively:
> 
>         name=$( {
>                 git-rev-list --objects $rev_list $(git-rev-parse $rev_parse) ||
>                 echo Gaaahhh
>         } | git-pack-objects --non-empty $pack_objects .tmp-pack)

Actually, some dim memories prodded me to some man-page digging, and the 
"pipefail" option in particular.

It seems to be a common option to both ksh and bash, so

	set -o pipefail

seems like it should fix this. Sadly, I think it's pretty recent in bash 
(ksh apparently got it in -93, bash seems to have gotten it only as of 
version 3.0, which is definitely recent enough that we can't just assume 
it).

[ Also, bash seems to have a variable called $PIPESTATUS, but that's 
  bash-specific (I don't know when it was enabled). ]

Anyway, doing a

	set -o pipefail

should never be the wrong thing to do, but the problem is figuring out 
whether the option is available or not, since if it isn't available, it's 
considered an error ;/

So with all that, how about we take your "Gaah" idea, and simplify it: 
just pipe stderr too. That, together with making git-pack-objects tell 
what garbage it got, actually does the rigth thing:

	[torvalds@g5 git-clone]$ git repack -a -d
	fatal: expected sha1, got garbage:
	 error: Could not read 7f59dbbb8f8d479c1d31453eac06ec765436a780

with this pretty simple patch.

Whaddaya think?

			Linus

---
diff --git a/git-repack.sh b/git-repack.sh
index 4e16d34..c0f271d 100755
--- a/git-repack.sh
+++ b/git-repack.sh
@@ -41,7 +41,7 @@ esac
 if [ "$local" ]; then
 	pack_objects="$pack_objects --local"
 fi
-name=$(git-rev-list --objects $rev_list $(git-rev-parse $rev_parse) |
+name=$(git-rev-list --objects $rev_list $(git-rev-parse $rev_parse) 2>&1 |
 	git-pack-objects --non-empty $pack_objects .tmp-pack) ||
 	exit 1
 if [ -z "$name" ]; then
diff --git a/pack-objects.c b/pack-objects.c
index 4e941e7..8864a31 100644
--- a/pack-objects.c
+++ b/pack-objects.c
@@ -524,7 +524,7 @@ int main(int argc, char **argv)
 		unsigned char sha1[20];
 
 		if (get_sha1_hex(line, sha1))
-			die("expected sha1, got garbage");
+			die("expected sha1, got garbage:\n %s", line);
 		hash = 0;
 		p = line+40;
 		while (*p) {
