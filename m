From: Stephan Beyer <s-beyer@gmx.net>
Subject: t3503: Add test case for identical files
Date: Sun, 6 Jul 2008 13:32:38 +0200
Message-ID: <20080706113238.GB6731@leksak.fem-net>
References: <1214879914-17866-2-git-send-email-s-beyer@gmx.net> <7vbq1f68rh.fsf@gitster.siamese.dyndns.org> <20080703210950.GC6677@leksak.fem-net> <alpine.DEB.1.00.0807040138090.2849@eeepc-johanness> <20080704003857.GG6677@leksak.fem-net> <alpine.DEB.1.00.0807040252490.2849@eeepc-johanness> <20080704015326.GI6677@leksak.fem-net> <alpine.DEB.1.00.0807041617320.9925@racer> <7vzlovq0t6.fsf@gitster.siamese.dyndns.org> <alpine.DEB.1.00.0807060331250.3557@eeepc-johanness>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Daniel Barkalow <barkalow@iabervon.org>,
	Christian Couder <chriscool@tuxfamily.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sun Jul 06 13:33:44 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KFSUw-0002h2-5g
	for gcvg-git-2@gmane.org; Sun, 06 Jul 2008 13:33:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752917AbYGFLcm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Jul 2008 07:32:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753206AbYGFLcm
	(ORCPT <rfc822;git-outgoing>); Sun, 6 Jul 2008 07:32:42 -0400
Received: from mail.gmx.net ([213.165.64.20]:34328 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751912AbYGFLcl (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Jul 2008 07:32:41 -0400
Received: (qmail invoked by alias); 06 Jul 2008 11:32:40 -0000
Received: from q137.fem.tu-ilmenau.de (EHLO leksak.fem-net) [141.24.46.137]
  by mail.gmx.net (mp037) with SMTP; 06 Jul 2008 13:32:40 +0200
X-Authenticated: #1499303
X-Provags-ID: V01U2FsdGVkX1/zKaBtF1fzQdp6YkCxy4gHoWpSxVTXhanQ6MWJ9e
	guJoyLrBSpCf6q
Received: from sbeyer by leksak.fem-net with local (Exim 4.69)
	(envelope-from <s-beyer@gmx.net>)
	id 1KFSTu-0006k5-5X; Sun, 06 Jul 2008 13:32:38 +0200
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.00.0807060331250.3557@eeepc-johanness>
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.55
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87519>

---

On Sun, Jul 06, 2008, Johannes Schindelin wrote:
> Hi,
> 
> On Sat, 5 Jul 2008, Junio C Hamano wrote:
> 
> > Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> > 
> > > There is no good reason why cherry-picking root commits should not be 
> > > allowed.
> > 
> > Hmm, does "cherry-pick a root commit" even have a well defined 
> > semantics, other than "if there is no overlap in files just add the 
> > files in"?
> 
> Yes.  You can easily add the files identically, or some similar files, in 
> which case you get an easily-resolved conflict.

I think this test case shows that it works for identical files.
This patch is btw just to show Junio that it works. ;)
Because I'd like to see Dscho's patch in git, too.

Regards.

 t/t3503-cherry-pick-root.sh |   21 ++++++++++++++++++++-
 1 files changed, 20 insertions(+), 1 deletions(-)

diff --git a/t/t3503-cherry-pick-root.sh b/t/t3503-cherry-pick-root.sh
index b0faa29..bcb6610 100755
--- a/t/t3503-cherry-pick-root.sh
+++ b/t/t3503-cherry-pick-root.sh
@@ -6,14 +6,23 @@ test_description='test cherry-picking a root commit'
 
 test_expect_success setup '
 
+	: > file0 &&
 	echo first > file1 &&
+	echo second > file2 &&
+	git add file0 &&
 	git add file1 &&
 	test_tick &&
 	git commit -m "first" &&
 
+	git symbolic-ref HEAD refs/heads/sharefile &&
+	rm .git/index file0 &&
+	git add file1 &&
+	git add file2 &&
+	test_tick &&
+	git commit -m "file1 and file2" &&
+
 	git symbolic-ref HEAD refs/heads/second &&
 	rm .git/index file1 &&
-	echo second > file2 &&
 	git add file2 &&
 	test_tick &&
 	git commit -m "second"
@@ -23,6 +32,16 @@ test_expect_success setup '
 test_expect_success 'cherry-pick a root commit' '
 
 	git cherry-pick master &&
+	test -f file0 &&
+	test first = $(cat file1)
+
+'
+
+test_expect_success 'cherry-pick a root commit with identical files' '
+
+	git checkout sharefile &&
+	git cherry-pick master &&
+	test -f file0 &&
 	test first = $(cat file1)
 
 '
-- 
1.5.6.361.g18ea7
Stephan Beyer <s-beyer@gmx.net>, PGP 0x6EDDD207FCC5040F
