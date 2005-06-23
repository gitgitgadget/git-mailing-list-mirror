From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Updated git HOWTO for kernel hackers
Date: Wed, 22 Jun 2005 19:39:24 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0506221929430.11175@ppc970.osdl.org>
References: <42B9E536.60704@pobox.com> <20050622230905.GA7873@kroah.com>
 <Pine.LNX.4.58.0506221623210.11175@ppc970.osdl.org> <42B9FCAE.1000607@pobox.com>
 <Pine.LNX.4.58.0506221724140.11175@ppc970.osdl.org> <42BA14B8.2020609@pobox.com>
 <Pine.LNX.4.58.0506221853280.11175@ppc970.osdl.org> <42BA1B68.9040505@pobox.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Greg KH <greg@kroah.com>,
	Linux Kernel <linux-kernel@vger.kernel.org>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Jun 23 04:31:50 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DlHV6-00031I-Rs
	for gcvg-git@gmane.org; Thu, 23 Jun 2005 04:31:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261987AbVFWChk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 22 Jun 2005 22:37:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261984AbVFWChk
	(ORCPT <rfc822;git-outgoing>); Wed, 22 Jun 2005 22:37:40 -0400
Received: from smtp.osdl.org ([65.172.181.4]:1442 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261930AbVFWChY (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 22 Jun 2005 22:37:24 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j5N2bJjA015041
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Wed, 22 Jun 2005 19:37:19 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j5N2bIUA021525;
	Wed, 22 Jun 2005 19:37:18 -0700
To: Jeff Garzik <jgarzik@pobox.com>
In-Reply-To: <42BA1B68.9040505@pobox.com>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.40__
X-MIMEDefang-Filter: osdl$Revision: 1.111 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Wed, 22 Jun 2005, Jeff Garzik wrote:
> 
> The problem is still that nothing says "oh, btw, I created 'xyz' tag for 
> you" AFAICS?
> 
> IMO the user (GregKH and me, at least) just wants to know their set of 
> tags and heads is up-to-date on local disk.  Wants to know what tags are 
> out there.  It's quite annoying when two data sets are out of sync 
> (.git/objects and .git/refs/tags).

Well, I really think this is the exact same issue as when you write any 
annoucement, and say "please pull from branch xyz of repo abc".

What I'm saying is that for a tagged release, that really translates to
"please pull tag xyz from repo abc" and the tools like git-ssh-pull will 
just do the right thing: they'll pull the tag itself _and_ they'll pull 
the objects it points to.

Of course, right now "git fetch" is hardcoded to always write FETCH_HEAD 
(not the tag name), but I'm saying ythat _literally_ you can do this 
already:

	git fetch repo-name tags/xyz &&
		( cat .git/FETCH_HEAD > .git/tags/xyz )

and it should do exactly what you want. Hmm?

So if we script this (maybe teach "git-fetch-script" to take "tag" as its 
first argument and do this on its own), and people learn to just do

	git fetch tag v2.6.18.5

when Chris or Greg make an announcement about "v2.6.18.5", then you're all
done, no?

The change to "git-fetch-script" would look something like the appended.. 
Totally untested, of course. Give it a try,

			Linus

---
diff --git a/git-fetch-script b/git-fetch-script
--- a/git-fetch-script
+++ b/git-fetch-script
@@ -1,5 +1,12 @@
 #!/bin/sh
 #
+destination=FETCH_HEAD
+
+if [ "$1" = "tag" ]; then
+	shift
+	destination="refs/tags/$2"
+fi
+
 merge_repo=$1
 merge_name=${2:-HEAD}
 
@@ -35,7 +42,7 @@ download_objects () {
 }
 
 echo "Getting remote $merge_name"
-download_one "$merge_repo/$merge_name" "$GIT_DIR"/FETCH_HEAD || exit 1
+download_one "$merge_repo/$merge_name" "$GIT_DIR/$dest" || exit 1
 
 echo "Getting object database"
-download_objects "$merge_repo" "$(cat "$GIT_DIR"/FETCH_HEAD)" || exit 1
+download_objects "$merge_repo" "$(cat "$GIT_DIR/$dest")" || exit 1
