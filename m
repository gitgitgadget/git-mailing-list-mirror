From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] fetch: don't try to update unfetched tracking refs
Date: Mon, 27 May 2013 12:19:34 -0400
Message-ID: <20130527161934.GB9235@sigill.intra.peff.net>
References: <9c6fd36368cd6b0fba4855be4d31106781c02f58.1369654825.git.john@keeping.me.uk>
 <20130527154252.GB8250@sigill.intra.peff.net>
 <20130527160129.GN27005@serenity.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Mon May 27 18:19:46 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uh098-0000Gv-AL
	for gcvg-git-2@plane.gmane.org; Mon, 27 May 2013 18:19:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754888Ab3E0QTi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 27 May 2013 12:19:38 -0400
Received: from cloud.peff.net ([50.56.180.127]:44937 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754694Ab3E0QTh (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 May 2013 12:19:37 -0400
Received: (qmail 32690 invoked by uid 102); 27 May 2013 16:20:15 -0000
Received: from c-71-62-74-146.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.62.74.146)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 27 May 2013 11:20:15 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 27 May 2013 12:19:34 -0400
Content-Disposition: inline
In-Reply-To: <20130527160129.GN27005@serenity.lan>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225604>

On Mon, May 27, 2013 at 05:01:29PM +0100, John Keeping wrote:

> > I'm not sure I understand what the last sentence means. I tried to add a
> > test like:
> [...]
> > but it does not fail with the existing code. Can you give an example
> > that fails?
> 
> I have this in my .git/config for git.git:
> 
>     [remote "origin"]
>             url = git://github.com/gitster/git
>             fetch = +refs/heads/*:refs/remotes/origin/*
>             fetch = +refs/notes/amlog:refs/notes/amlog

Ah, I see. It is not "the refspec on the command-line does not match a
configured refspec", but rather "there exists a configured non-pattern
refspec that does not match what was on the command-line (even if what
was on the command-line did match another refspec)".

So your fix makes perfect sense. Do you mind squashing in this test
below? I think it is a little less subtle than what you posted, as it
sets up the situation explicitly in the test. It also checks that the
refs we _did_ match still get updated ("master" in this case).

diff --git a/t/t5510-fetch.sh b/t/t5510-fetch.sh
index ff43e08..fde6891 100755
--- a/t/t5510-fetch.sh
+++ b/t/t5510-fetch.sh
@@ -422,6 +422,22 @@ test_expect_success 'configured fetch updates tracking' '
 	)
 '
 
+test_expect_success 'non-matching refspecs do not confuse tracking update' '
+	cd "$D" &&
+	git update-ref refs/odd/location HEAD &&
+	(
+		cd three &&
+		git update-ref refs/remotes/origin/master base-origin-master &&
+		git config --add remote.origin.fetch \
+			refs/odd/location:refs/remotes/origin/odd &&
+		o=$(git rev-parse --verify refs/remotes/origin/master) &&
+		git fetch origin master &&
+		n=$(git rev-parse --verify refs/remotes/origin/master) &&
+		test "$o" != "$n" &&
+		test_must_fail git rev-parse --verify refs/remotes/origin/odd
+	)
+'
+
 test_expect_success 'pushing nonexistent branch by mistake should not segv' '
 
 	cd "$D" &&

Thanks for the fix.

Acked-by: Jeff King <peff@peff.net>

-Peff
