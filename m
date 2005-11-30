From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: git-name-rev off-by-one bug
Date: Tue, 29 Nov 2005 17:51:38 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0511291742000.3135@g5.osdl.org>
References: <20051130001503.28498.qmail@science.horizon.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: junkio@cox.net, git@vger.kernel.org, pasky@suse.cz
X-From: git-owner@vger.kernel.org Wed Nov 30 02:57:48 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EhHDz-00056W-Ew
	for gcvg-git@gmane.org; Wed, 30 Nov 2005 02:57:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750771AbVK3B5X (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 29 Nov 2005 20:57:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750780AbVK3B5X
	(ORCPT <rfc822;git-outgoing>); Tue, 29 Nov 2005 20:57:23 -0500
Received: from smtp.osdl.org ([65.172.181.4]:37274 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750771AbVK3B5W (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 29 Nov 2005 20:57:22 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id jAU1penO012465
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 29 Nov 2005 17:51:40 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id jAU1pcuU031020;
	Tue, 29 Nov 2005 17:51:39 -0800
To: linux@horizon.com
In-Reply-To: <20051130001503.28498.qmail@science.horizon.com>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.57__
X-MIMEDefang-Filter: osdl$Revision: 1.127 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12978>



On Tue, 29 Nov 2005, linux@horizon.com wrote:
>
> You seem to be saying that producing a merge with conflict markers is
> what you (almost) always want, so it's the default.  No objections.
> 
> But why collapse the index and only keep stage2?  Why not leave all
> stages in the index *and* the merge-with-conflict-markers in the working
> directory?

That may actually work really well. It would also avoid one bug that we 
have right now: if you fix things up by hand, but forget to explicitly do 
a "git-update-index filename" or "git commit filename", a plain regular 
"git commit" will happily commit all the changes _except_ for the ones you 
have merged manually. It's happened once to me.

If we left things in the index in an unmerged state, we'd be guaranteed to 
either _fail_ that git commit unless somebody has done the 
git-update-index (or names the files specifically on the commit command 
line, which will do it for you).

So I think I agree. 

Junio?

The problem (I think) was that "git-diff-file" did bad things with 
unmerged entries. That's what the comment in git-merge-one-file implies. 
But otherwise this should just make it so..

Do you want to test this out?

		Linus

---
diff --git a/git-merge-one-file.sh b/git-merge-one-file.sh
index c3eca8b..739a072 100755
--- a/git-merge-one-file.sh
+++ b/git-merge-one-file.sh
@@ -79,11 +79,7 @@ case "${1:-.}${2:-.}${3:-.}" in
 		;;
 	esac
 
-	# We reset the index to the first branch, making
-	# git-diff-file useful
-	git-update-index --add --cacheinfo "$6" "$2" "$4"
-		git-checkout-index -u -f -- "$4" &&
-		merge "$4" "$orig" "$src2"
+	merge "$4" "$orig" "$src2"
 	ret=$?
 	rm -f -- "$orig" "$src2"
 
