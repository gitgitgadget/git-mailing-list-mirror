From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] t/lib-gpg: adjust permissions for gnupg 2.1
Date: Tue, 2 Dec 2014 16:07:53 -0500
Message-ID: <20141202210753.GD23461@peff.net>
References: <547DB6C3.5010704@drmicha.warpmail.net>
 <9c28f16c677bbc774e5b8dfc79b6ffe2c55d1720.1417527514.git.git@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Tue Dec 02 22:08:01 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xvufw-0000TO-VP
	for gcvg-git-2@plane.gmane.org; Tue, 02 Dec 2014 22:08:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933028AbaLBVHy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Dec 2014 16:07:54 -0500
Received: from cloud.peff.net ([50.56.180.127]:47383 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932365AbaLBVHx (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Dec 2014 16:07:53 -0500
Received: (qmail 30358 invoked by uid 102); 2 Dec 2014 21:07:52 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 02 Dec 2014 15:07:52 -0600
Received: (qmail 18798 invoked by uid 107); 2 Dec 2014 21:07:54 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 02 Dec 2014 16:07:54 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 02 Dec 2014 16:07:53 -0500
Content-Disposition: inline
In-Reply-To: <9c28f16c677bbc774e5b8dfc79b6ffe2c55d1720.1417527514.git.git@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260594>

On Tue, Dec 02, 2014 at 02:40:27PM +0100, Michael J Gruber wrote:

> Before gnupg 2.1 (aka "modern branch"), gpghome would contain only files
> which allowed t/lib-gpg.sh to set permissions explicitely, and we did
> that since
> 28a1b07 (t/lib-gpg: adjust permissions for gnupg 2.1, 2014-12-02)
> in order to adjust wrong permissions from a checkout on ro file systems.

I think this 28a1b07 is wrong. Did you mean e7f224f?

> gnupg 2.1 creates a new directory in gpghome which would get its x bit removed.

Thanks for digging in this. The story is a little more tricky, though,
and I do not think this patch is strictly necessary.

We copy lib-gpg/* to the trash directory, and only run gpg on it there.
So it is there that gpg2.1 will munge the files, _after_ we have
copied and done our chmod. And that works fine with the current code.

The problem came when I was trying to test/debug, and outside of the
tests did "cd lib-gpg && gpg2 ...". That munged my lib-gpg directory,
and the resulting breakage was copied into each subsequent trash
directory.

So while your patch is not necessary, it is a nice defense against this
sort of manual munging, or against future patches which add more
directories. But...

> Adjust and use +X so that any directory would get its x bit set. This
> also keeps the x bit on files which had it set for whatever wrong
> reason, but we care only about having at least the necessary
> permissions for the tests to run.

Taking a step back, though, I am not sure I understand the reasoning
behind the original e7f224f. The rationale in the commit message is that
we want to make sure that the files are writable. But why would they not
be? They are created by "cp -R", so unless your umask does not allow the
owner to write to the files, they should be writable, no? And if your
umask is set that way, lots of things are going to break.

And indeed, if I remove the chmods completely, like:

diff --git a/t/lib-gpg.sh b/t/lib-gpg.sh
index cd2baef..6ee4bb6 100755
--- a/t/lib-gpg.sh
+++ b/t/lib-gpg.sh
@@ -17,8 +17,6 @@ else
 		# Name and email: C O Mitter <committer@example.com>
 		# No password given, to enable non-interactive operation.
 		cp -R "$TEST_DIRECTORY"/lib-gpg ./gpghome
-		chmod 0700 gpghome
-		chmod 0600 gpghome/*
 		GNUPGHOME="$(pwd)/gpghome"
 		export GNUPGHOME
 		test_set_prereq GPG

the tests run fine for me. What am I missing?

I do think the original "0700" chmod _is_ useful, though. But not
because it makes sure things are writable, but because it makes sure
that it is _not_ world-readable. GPG complains about the lax permissions
(of course it does not know that the keyrings are not really secrets in
this case). However, this does not actually prevent the tests from
running successfully.

So from my perspective, the simplest thing is to keep the original
"chmod 0700" for that reason (or make it "chmod go-rwx", if you like),
and drop the inner chmod completely (effectively reverting e7f224f). But
again, perhaps there is some case that it covers that I do not
understand.

-Peff
