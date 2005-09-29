From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [howto] Kernel hacker's guide to git, updated
Date: Thu, 29 Sep 2005 14:35:15 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0509291433040.5362@g5.osdl.org>
References: <433BC9E9.6050907@pobox.com> <20050929200252.GA31516@redhat.com>
 <Pine.LNX.4.60.0509292106080.17860@hermes-1.csi.cam.ac.uk>
 <20050929201127.GB31516@redhat.com> <Pine.LNX.4.64.0509291413060.5362@g5.osdl.org>
 <Pine.LNX.4.64.0509291425560.5362@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Anton Altaparmakov <aia21@cam.ac.uk>,
	Jeff Garzik <jgarzik@pobox.com>,
	Linux Kernel <linux-kernel@vger.kernel.org>,
	Git Mailing List <git@vger.kernel.org>
X-From: linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1030252AbVI2VgR@vger.kernel.org Thu Sep 29 23:37:51 2005
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1030252AbVI2VgR@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EL65B-0004oX-B8
	for glk-linux-kernel-3@gmane.org; Thu, 29 Sep 2005 23:36:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030252AbVI2VgR (ORCPT <rfc822;glk-linux-kernel-3@m.gmane.org>);
	Thu, 29 Sep 2005 17:36:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030250AbVI2VgQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Sep 2005 17:36:16 -0400
Received: from smtp.osdl.org ([65.172.181.4]:6374 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030247AbVI2VgP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Sep 2005 17:36:15 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j8TLZH4s029525
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Thu, 29 Sep 2005 14:35:17 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j8TLZGNX006339;
	Thu, 29 Sep 2005 14:35:16 -0700
To: Dave Jones <davej@redhat.com>
In-Reply-To: <Pine.LNX.4.64.0509291425560.5362@g5.osdl.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.45__
X-MIMEDefang-Filter: osdl$Revision: 1.118 $
X-Scanned-By: MIMEDefang 2.36
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9516>



On Thu, 29 Sep 2005, Linus Torvalds wrote:
> 
> Gaah. Using a new pine version, and it is back to corrupting whitespace.

Ok, disabling "text flowing" seems to have fixed it. It still leaves empty 
spaces at the end of lines when doing normal word-wrapping in the editor 
(and then seems to use those empty spaces as a "marker" for flowing), but 
that's at least just a small silly detail.

So how about this patch now? With it you can do

	git fetch --tags <linus-kernel-repo>

and it should fetch all my tags automatically.

		Linus
---
diff --git a/git-fetch.sh b/git-fetch.sh
--- a/git-fetch.sh
+++ b/git-fetch.sh
@@ -5,6 +5,8 @@
 _x40='[0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f]'
 _x40="$_x40$_x40$_x40$_x40$_x40$_x40$_x40$_x40"
 
+all=
+tags=
 append=
 force=
 update_head_ok=
@@ -17,6 +19,12 @@ do
 	-f|--f|--fo|--for|--forc|--force)
 		force=t
 		;;
+	--tags)
+		tags=t
+		;;
+	--all)
+		all=t
+		;;
 	-u|--u|--up|--upd|--upda|--updat|--update|--update-|--update-h|\
 	--update-he|--update-hea|--update-head|--update-head-|\
 	--update-head-o|--update-head-ok)
@@ -158,7 +166,16 @@ case "$update_head_ok" in
 	;;
 esac
 
-for ref in $(get_remote_refs_for_fetch "$@")
+taglist=
+if [ "$tags$all" ]; then
+	pattern='/refs\/tags/'
+	if [ "$all" ]; then
+		pattern='/refs/'
+	fi
+	taglist=$(git-ls-remote "$remote" | awk "$pattern"' { print $2":"$2 }')
+fi
+
+for ref in $(get_remote_refs_for_fetch "$@" $taglist)
 do
     refs="$refs $ref"
 
