From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [howto] Kernel hacker's guide to git, updated
Date: Thu, 29 Sep 2005 14:14:36 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0509291413060.5362@g5.osdl.org>
References: <433BC9E9.6050907@pobox.com> <20050929200252.GA31516@redhat.com>
 <Pine.LNX.4.60.0509292106080.17860@hermes-1.csi.cam.ac.uk>
 <20050929201127.GB31516@redhat.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: Anton Altaparmakov <aia21@cam.ac.uk>,
	Jeff Garzik <jgarzik@pobox.com>,
	Linux Kernel <linux-kernel@vger.kernel.org>,
	Git Mailing List <git@vger.kernel.org>
X-From: linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S964891AbVI2VPB@vger.kernel.org Thu Sep 29 23:17:57 2005
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S964891AbVI2VPB@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EL5lO-0006tV-2Q
	for glk-linux-kernel-3@gmane.org; Thu, 29 Sep 2005 23:16:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964891AbVI2VPB (ORCPT <rfc822;glk-linux-kernel-3@m.gmane.org>);
	Thu, 29 Sep 2005 17:15:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751334AbVI2VPA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Sep 2005 17:15:00 -0400
Received: from smtp.osdl.org ([65.172.181.4]:48352 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751333AbVI2VO7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Sep 2005 17:14:59 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j8TLEb4s028564
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Thu, 29 Sep 2005 14:14:38 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j8TLEa1s005481;
	Thu, 29 Sep 2005 14:14:36 -0700
To: Dave Jones <davej@redhat.com>
In-Reply-To: <20050929201127.GB31516@redhat.com>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.45__
X-MIMEDefang-Filter: osdl$Revision: 1.118 $
X-Scanned-By: MIMEDefang 2.36
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9510>



On Thu, 29 Sep 2005, Dave Jones wrote:
>
> Ah. I didn't know this. Thanks.
> Hmm, it'd be nice to have a shorthand 'not have to type the url, pull everything'.
> Something like 'git pull all'.

Something like this?

Except it's called "git fetch --all", and it's obviously totally untested.

 		Linus
--
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
