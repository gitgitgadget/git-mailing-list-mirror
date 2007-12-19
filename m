From: Charles Bailey <charles@hashpling.org>
Subject: Re: [PATCH] Re-re-re-fix common tail optimization
Date: Wed, 19 Dec 2007 14:37:12 +0000
Message-ID: <20071219143712.GA3483@hashpling.org>
References: <20071215155150.GA24810@coredump.intra.peff.net> <7vprx7n90t.fsf@gitster.siamese.dyndns.org> <20071215200202.GA3334@sigill.intra.peff.net> <20071216070614.GA5072@sigill.intra.peff.net> <7v8x3ul927.fsf@gitster.siamese.dyndns.org> <7v7ijejq6j.fsf@gitster.siamese.dyndns.org> <20071216212104.GA32307@coredump.intra.peff.net> <7v3au2joo2.fsf_-_@gitster.siamese.dyndns.org> <20071219141845.GA2146@hashpling.org> <20071219142715.GB14187@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Dec 19 15:38:11 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J503e-0000gH-4E
	for gcvg-git-2@gmane.org; Wed, 19 Dec 2007 15:38:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753072AbXLSOhh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Dec 2007 09:37:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752716AbXLSOhh
	(ORCPT <rfc822;git-outgoing>); Wed, 19 Dec 2007 09:37:37 -0500
Received: from pih-relay08.plus.net ([212.159.14.134]:59010 "EHLO
	pih-relay08.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752706AbXLSOhg (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Dec 2007 09:37:36 -0500
Received: from [212.159.69.125] (helo=hashpling.plus.com)
	 by pih-relay08.plus.net with esmtp (Exim) id 1J502s-0006nM-RW; Wed, 19 Dec 2007 14:37:15 +0000
Received: from fermat.hashpling.org (fermat.hashpling.org [127.0.0.1])
	by hashpling.plus.com (8.13.8/8.13.6) with ESMTP id lBJEbC31003772;
	Wed, 19 Dec 2007 14:37:12 GMT
Received: (from charles@localhost)
	by fermat.hashpling.org (8.13.8/8.13.6/Submit) id lBJEbCm7003771;
	Wed, 19 Dec 2007 14:37:12 GMT
Content-Disposition: inline
In-Reply-To: <20071219142715.GB14187@coredump.intra.peff.net>
User-Agent: Mutt/1.4.2.1i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68912>

On Wed, Dec 19, 2007 at 09:27:15AM -0500, Jeff King wrote:
> On Wed, Dec 19, 2007 at 02:18:45PM +0000, Charles Bailey wrote:
> 
> > Just to add to the woe on this one, this test breaks on MacOS X due to
> > the pattern length limitations of the default sed on that platform.
> > 
> > Interested in a patch?
> 
> Somebody beat you to it. :) Can you confirm that the fix in
> 
>   <1198007158-27576-1-git-send-email-win@wincent.com>
> 
> works for you?
> 
> -Peff


Ooh, the excitement, I've never had the opportunity to "git am"
before.

Yes, I can confirm.  It works for me.

For reference I had the following, which is fewer lines but not
inherently better in any other way.

Charles.



diff --git a/t/t4024-diff-optimize-common.sh b/t/t4024-diff-optimize-common.sh
index 20fe87b..ffb2c8f 100755
--- a/t/t4024-diff-optimize-common.sh
+++ b/t/t4024-diff-optimize-common.sh
@@ -7,8 +7,9 @@ test_description='common tail optimization'
 z=zzzzzzzz ;# 8
 z="$z$z$z$z$z$z$z$z" ;# 64
 z="$z$z$z$z$z$z$z$z" ;# 512
-z="$z$z$z$z" ;# 2048
-z2047=$(expr "$z" : '.\(.*\)') ; #2047
+z="$z$z" ;# 1024
+z1023=$(expr "$z" : '.\(.*\)') ; #1023
+z2047=$z$z1023
 
 test_expect_success setup '
 
@@ -35,8 +36,8 @@ diff --git a/file-a b/file-a
 --- a/file-a
 +++ b/file-a
 @@ -1 +1 @@
--aZ
-+AZ
+-aZZz
++AZZz
 diff --git a/file-b b/file-b
 --- a/file-b
 +++ b/file-b
@@ -47,9 +48,9 @@ diff --git a/file-c b/file-c
 --- a/file-c
 +++ b/file-c
 @@ -1 +1 @@
--cZ
+-cZZz
 \ No newline at end of file
-+CZ
++CZZz
 \ No newline at end of file
 diff --git a/file-d b/file-d
 --- a/file-d
@@ -61,7 +62,7 @@ EOF
 
 test_expect_success 'diff -U0' '
 
-	git diff -U0 | sed -e "/^index/d" -e "s/$z2047/Z/g" >actual &&
+	git diff -U0 | sed -e "/^index/d" -e "s/$z1023/Z/g" >actual &&
 	diff -u expect actual
 
 '
-- 
1.5.3.7.11.ga3d7
