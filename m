From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Reserve a slot for argv[0] in default_arg.
Date: Sun, 4 Oct 2009 14:27:46 -0400
Message-ID: <20091004182746.GA22995@coredump.intra.peff.net>
References: <1254576571-29274-1-git-send-email-urkedal@nbi.dk>
 <20091004133333.GA13894@sigill.intra.peff.net>
 <20091004141355.GA15783@eideticdew.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Petter Urkedal <urkedal@nbi.dk>
X-From: git-owner@vger.kernel.org Sun Oct 04 20:29:25 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MuVpV-0000ZX-Fp
	for gcvg-git-2@lo.gmane.org; Sun, 04 Oct 2009 20:29:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756877AbZJDS2c (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 4 Oct 2009 14:28:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756834AbZJDS2c
	(ORCPT <rfc822;git-outgoing>); Sun, 4 Oct 2009 14:28:32 -0400
Received: from peff.net ([208.65.91.99]:51408 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752360AbZJDS2c (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 Oct 2009 14:28:32 -0400
Received: (qmail 12293 invoked by uid 107); 4 Oct 2009 18:31:20 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Sun, 04 Oct 2009 14:31:20 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sun, 04 Oct 2009 14:27:46 -0400
Content-Disposition: inline
In-Reply-To: <20091004141355.GA15783@eideticdew.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129513>

On Sun, Oct 04, 2009 at 04:13:55PM +0200, Petter Urkedal wrote:

> I was wondering myself.  I tried to switch off optimisation, but that
> had no effect.  I'm suspecting PIE, but it could be some other
> configuration implied by the Gentoo "hardened" use-flag.

Nope, it's just a plain old git bug...

> I can reproduce it on my machine with
> 
>     mkdir test-repo; cd test-repo
>     /path/to/git init
>     /path/to/git config showbranch.default --topo-order
>     /path/to/git show-branch

Ah, thanks, for some reason I wasn't able to produce it before, but I
can easily replicate it here. I think it's a regression from converting
show-branch to use parse_options, which happened in May, but I didn't
actually bisect it. I'm not sure showbranch.default has worked at all
since then (which I guess goes to show how many people are actually
using it).

So your fix is definitely right, and the test case below (which can be
squashed in) fails reliably without it.

t3202 is maybe a bit of weird place to put it, but we don't seem to test
show-branch anywhere else. It could probably use a "check that
show-branch works at all" set of tests, but I am not volunteering to
write such a thing. I have always found its output to be one step above
line noise.

I also looked at putting it in t1200-tutorial.sh near the show-branch
call, but that script is an utter mess. Most of the tests don't actually
check the exit status of commands, and there is a random "test_done"
halfway through the script which skips all of the later tests (including
the show-branch test!). Removing that to enable the later tests reveals
that they are broken, with such obviously non-working crap as

  git merge -s "Merge upstream changes." master

which is clearly bogus. I wonder if we should just remove that script
altogether; at best it just seems redundant with other tests, and it is
full of obvious errors.

> Comment's are treated as whitespace, but I'll adjust it for readability.
> Maybe worse: I missed the 8-column indentation.  So, here is the patch
> again (attached, I hope Git can extract it).

Thanks, that looks better (I actually didn't even notice the indent
problem the first time, but yes, it should be 8 columns).

Squashable test case is below.

-Peff

---
diff --git a/t/t3202-show-branch-octopus.sh b/t/t3202-show-branch-octopus.sh
index 7fe4a6e..0a5d5e6 100755
--- a/t/t3202-show-branch-octopus.sh
+++ b/t/t3202-show-branch-octopus.sh
@@ -56,4 +56,12 @@ test_expect_success 'show-branch with more than 8 branches' '
 
 '
 
+test_expect_success 'show-branch with showbranch.default' '
+	for i in $numbers; do
+		git config --add showbranch.default branch$i
+	done &&
+	git show-branch >out &&
+	test_cmp expect out
+'
+
 test_done
