From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: git 565ebbf79f61873042c22a7126d002c104e056f4 broken on OpenBSD
Date: Wed, 26 Oct 2005 10:27:36 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0510261025440.10477@g5.osdl.org>
References: <86y84gfjv4.fsf@blue.stonehenge.com> <86u0f4fjah.fsf@blue.stonehenge.com>
 <Pine.LNX.4.63.0510261708280.2803@wbgn013.biozentrum.uni-wuerzburg.de>
 <86mzkwfh54.fsf@blue.stonehenge.com> <Pine.LNX.4.63.0510261725150.8507@wbgn013.biozentrum.uni-wuerzburg.de>
 <86irvkfg80.fsf@blue.stonehenge.com> <20051026161552.GA11483@delft.aura.cs.cmu.edu>
 <20051026165515.GA16616@delft.aura.cs.cmu.edu>
 <Pine.LNX.4.63.0510261901140.9686@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Jan Harkes <jaharkes@cs.cmu.edu>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 26 19:34:49 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EUp3z-0003UI-Jv
	for gcvg-git@gmane.org; Wed, 26 Oct 2005 19:27:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964840AbVJZR1p (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 26 Oct 2005 13:27:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964842AbVJZR1p
	(ORCPT <rfc822;git-outgoing>); Wed, 26 Oct 2005 13:27:45 -0400
Received: from smtp.osdl.org ([65.172.181.4]:20965 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S964840AbVJZR1o (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 26 Oct 2005 13:27:44 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j9QHRcFC004489
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Wed, 26 Oct 2005 10:27:39 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j9QHRats005632;
	Wed, 26 Oct 2005 10:27:37 -0700
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
In-Reply-To: <Pine.LNX.4.63.0510261901140.9686@wbgn013.biozentrum.uni-wuerzburg.de>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.55__
X-MIMEDefang-Filter: osdl$Revision: 1.127 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10683>



On Wed, 26 Oct 2005, Johannes Schindelin wrote:
> 
> On Wed, 26 Oct 2005, Jan Harkes wrote:
> 
> > -		if (ret == EXDEV && !rename(tmpfile, filename))
> > +		if (ret && ret != EEXIST && !rename(tmpfile, filename))
> 
> We don't need to test for ret, as we're already in a "if (ret)" block.  
> What would happen if ret==EEXIST, and we try to rename() nevertheless? It 
> should fail, too, right?

No, the rename will succeed and overwrite the existing file.

Which is strictly correct, but it's the wrong thing if we ever want to do 
collission detection.

So I'd actually prefer something like this patch instead.

		Linus

---
diff --git a/sha1_file.c b/sha1_file.c
index 7fdc469..642f00d 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -1232,19 +1232,20 @@ static int link_temp_to_file(const char 
 int move_temp_to_file(const char *tmpfile, char *filename)
 {
 	int ret = link_temp_to_file(tmpfile, filename);
-	if (ret) {
-		/*
-		 * Coda hack - coda doesn't like cross-directory links,
-		 * so we fall back to a rename, which will mean that it
-		 * won't be able to check collisions, but that's not a
-		 * big deal.
-		 *
-		 * The same holds for FAT formatted media.
-		 *
-		 * When this succeeds, we just return 0. We have nothing
-		 * left to unlink.
-		 */
-		if ((ret == EXDEV || ret == ENOTSUP) && !rename(tmpfile, filename))
+
+	/*
+	 * Coda hack - coda doesn't like cross-directory links,
+	 * so we fall back to a rename, which will mean that it
+	 * won't be able to check collisions, but that's not a
+	 * big deal.
+	 *
+	 * The same holds for FAT formatted media.
+	 *
+	 * When this succeeds, we just return 0. We have nothing
+	 * left to unlink.
+	 */
+	if (ret && ret != EEXIST) {
+		if (!rename(tmpfile, filename))
 			return 0;
 		ret = errno;
 	}
