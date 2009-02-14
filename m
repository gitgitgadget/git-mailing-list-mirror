From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 4/4] builtin-remote: add set-head verb
Date: Fri, 13 Feb 2009 21:18:31 -0500
Message-ID: <20090214021831.GB9907@coredump.intra.peff.net>
References: <1234515275-91263-1-git-send-email-jaysoffian@gmail.com> <1234515275-91263-2-git-send-email-jaysoffian@gmail.com> <1234515275-91263-3-git-send-email-jaysoffian@gmail.com> <1234515275-91263-4-git-send-email-jaysoffian@gmail.com> <1234515275-91263-5-git-send-email-jaysoffian@gmail.com> <7vtz6yabsy.fsf@gitster.siamese.dyndns.org> <20090214002253.GA7769@coredump.intra.peff.net> <7vab8p4w1u.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Jay Soffian <jaysoffian@gmail.com>, git@vger.kernel.org,
	barkalow@iabervon.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Feb 14 03:20:04 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LYA8P-0005zC-MK
	for gcvg-git-2@gmane.org; Sat, 14 Feb 2009 03:20:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753654AbZBNCSf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Feb 2009 21:18:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753643AbZBNCSe
	(ORCPT <rfc822;git-outgoing>); Fri, 13 Feb 2009 21:18:34 -0500
Received: from peff.net ([208.65.91.99]:34984 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753598AbZBNCSd (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Feb 2009 21:18:33 -0500
Received: (qmail 27791 invoked by uid 107); 14 Feb 2009 02:18:51 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Fri, 13 Feb 2009 21:18:51 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Fri, 13 Feb 2009 21:18:31 -0500
Content-Disposition: inline
In-Reply-To: <7vab8p4w1u.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109804>

On Fri, Feb 13, 2009 at 06:00:29PM -0800, Junio C Hamano wrote:

> > It was immediately obvious to me as "auto" (I think I even suggested
> > "-a" in another thread, so maybe that is why it seems so sensible to
> > me).
> 
> Yeah, latest round has --auto in it.  Thanks, Jay.

Oops. I even went back and double-checked to make sure that it was not
there, but it would have helped if I actually checked the latest
version. :(

> I do not care too deeply if an explicit request to "set-head --auto"
> screws up and sets a HEAD that was pointing at the right branch to another
> branch because the command is not taught to give preference to the branch
> HEAD originally points at, so I do not think I have any more issues with
> the series for now, even though I may notice things later.

I think that is reasonable; that is a separate enhancement which can
come later and is no reason to block the existing patches.

> I have this series queued to private topic branch but it still does not
> pass tests (breaks #8 and #18 of t5505 at least) by itself; the previous
> round was no better.  I think it is just the matter of updating the
> expected output in the tests, but I didn't look further.

Test #8 is just a matter of updating output. But #18 is explicitly about
checking that "remote show" does not show symbolic refs. But Jay's patch
is about explicitly showing symbolic refs (just doing so as a ref-name
instead of a sha1):

  * FAIL 18: "remote show" does not show symbolic refs
                git clone one three &&
                (cd three &&
                 git remote show origin > output &&
                 ! grep HEAD < output &&
                 ! grep -i stale < output)

I guess we could tighten the grep to

  ! egrep "HEAD: [0-9a-f]{40}" < output

but it may just make sense to get rid of the test; the exact output is
already covered by test #8. Squashable patch is below.

---
diff --git a/t/t5505-remote.sh b/t/t5505-remote.sh
index eb63718..8808580 100755
--- a/t/t5505-remote.sh
+++ b/t/t5505-remote.sh
@@ -136,6 +136,7 @@ EOF
 cat > test/expect << EOF
 * remote origin
   URL: $(pwd)/one
+  HEAD: master
   Remote branch merged with 'git pull' while on branch master
     master
   New remote branch (next fetch will store in remotes/origin)
@@ -338,16 +339,6 @@ test_expect_success 'update default (overridden, with funny whitespace)' '
 
 '
 
-test_expect_success '"remote show" does not show symbolic refs' '
-
-	git clone one three &&
-	(cd three &&
-	 git remote show origin > output &&
-	 ! grep HEAD < output &&
-	 ! grep -i stale < output)
-
-'
-
 test_expect_success 'reject adding remote with an invalid name' '
 
 	test_must_fail git remote add some:url desired-name
