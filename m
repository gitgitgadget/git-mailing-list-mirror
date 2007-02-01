From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Instructions concerning detached head lead to lost local changes
Date: Thu, 1 Feb 2007 15:49:57 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0702011536570.15057@woody.linux-foundation.org>
References: <87mz3xa3vr.wl%cworth@cworth.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Carl Worth <cworth@cworth.org>
X-From: git-owner@vger.kernel.org Fri Feb 02 00:50:08 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HClgu-0002FP-6j
	for gcvg-git@gmane.org; Fri, 02 Feb 2007 00:50:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932666AbXBAXuE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 1 Feb 2007 18:50:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933203AbXBAXuE
	(ORCPT <rfc822;git-outgoing>); Thu, 1 Feb 2007 18:50:04 -0500
Received: from smtp.osdl.org ([65.172.181.24]:49882 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932666AbXBAXuC (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Feb 2007 18:50:02 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id l11Nnwx6011137
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Thu, 1 Feb 2007 15:49:58 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l11NnvXt026974;
	Thu, 1 Feb 2007 15:49:57 -0800
In-Reply-To: <87mz3xa3vr.wl%cworth@cworth.org>
X-Spam-Status: No, hits=-0.433 required=5 tests=AWL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.111__
X-MIMEDefang-Filter: osdl$Revision: 1.172 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38437>



On Thu, 1 Feb 2007, Carl Worth wrote:
> 
> But I found that after "git checkout -f master" I lost the dirty
> changes I had made. And I don't see anything in the message above
> telling me a better way to get from the state I was in to the state I
> wanted.

Yeah, I think "-f" was a mistake. 

There was already real meaning for "-f": force update of all the files, 
regardless of whether they are dirty or unmerged or anything else.

And that meaning is totally independent of the new meaning of -f, which 
says "drop the old detached head". Sometimes you might want to use them 
together, but they shouldn't really be tied together.

Maybe something like this, which adds "--drop" as the flag to say "ok to 
drop the old detached head"? I'm not married to that name, it's meant more 
as an RFC than as anything to be applied as-is.

NOTE! This makes "-f" _imply_ "--drop" too, since it does make sense that 
if somebody just wants to force it, he can - regardless of any dirty 
state, regardless of the current state of the HEAD.

But using just "git checkout --drop new-head" will have the old "dirty 
state follows along with branch changes" semantics.

		Linus

PS. I don't think "--drop" really makes much sense as a name. Especially 
when written out like that, it sounds like we're dropping the *new* 
branch, not the old one. Maybe something like "--no-check" instead?

---
diff --git a/git-checkout.sh b/git-checkout.sh
index deb4795..8e852df 100755
--- a/git-checkout.sh
+++ b/git-checkout.sh
@@ -11,6 +11,7 @@ oldbranch=$(git-symbolic-ref $old_name 2>/dev/null)
 new=
 new_name=
 force=
+drop=
 branch=
 newbranch=
 newbranch_log=
@@ -36,10 +37,14 @@ while [ "$#" != "0" ]; do
 		;;
 	"-f")
 		force=1
+		drop=1
 		;;
 	-m)
 		merge=1
 		;;
+	--drop)
+		drop=1
+		;;
 	--)
 		break
 		;;
@@ -163,7 +168,7 @@ If you want to create a new branch from this checkout, you may do so
 elif test -z "$oldbranch" && test -n "$branch"
 then
 	# Coming back...
-	if test -z "$force"
+	if test -z "$drop"
 	then
 		git show-ref -d -s | grep "$old" >/dev/null || {
 			echo >&2 \
