From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/5] t5312: test object deletion code paths in a
 corrupted repository
Date: Thu, 19 Mar 2015 16:51:47 -0400
Message-ID: <20150319205147.GA7775@peff.net>
References: <20150317072750.GA22155@peff.net>
 <20150317072844.GA25191@peff.net>
 <xmqqfv90iwjj.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Mar 19 21:52:05 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YYhQ3-00027H-G0
	for gcvg-git-2@plane.gmane.org; Thu, 19 Mar 2015 21:51:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751624AbbCSUvv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Mar 2015 16:51:51 -0400
Received: from cloud.peff.net ([50.56.180.127]:35438 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751622AbbCSUvu (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Mar 2015 16:51:50 -0400
Received: (qmail 4238 invoked by uid 102); 19 Mar 2015 20:51:50 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 19 Mar 2015 15:51:50 -0500
Received: (qmail 17353 invoked by uid 107); 19 Mar 2015 20:52:01 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 19 Mar 2015 16:52:01 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 19 Mar 2015 16:51:47 -0400
Content-Disposition: inline
In-Reply-To: <xmqqfv90iwjj.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265830>

On Thu, Mar 19, 2015 at 01:04:16PM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > +test_expect_success 'create history with missing tip commit' '
> > +	test_tick && git commit --allow-empty -m one &&
> > +	recoverable=$(git rev-parse HEAD) &&
> > +	git cat-file commit $recoverable >saved &&
> > +	test_tick && git commit --allow-empty -m two &&
> > +	missing=$(git rev-parse HEAD) &&
> > +	# point HEAD elsewhere
> > +	git checkout $base &&
> 
> Could you spell this as "$base^0" (or "--detach") to clarify the
> intention?  I have been scraching my head for a few minutes just
> now, trying to figure out what you are doing here.  I _think_ you
> wanted master to point at the missing "two" and wanted to make sure
> all other refs (including HEAD) to point away from it.

Yes, exactly. I've squashed in your suggestion and added a comment
explaining it:

diff --git a/t/t5312-prune-corruption.sh b/t/t5312-prune-corruption.sh
index 1001a69..1cdbd9f 100755
--- a/t/t5312-prune-corruption.sh
+++ b/t/t5312-prune-corruption.sh
@@ -50,14 +50,24 @@ test_expect_success 'clean up bogus ref' '
 	rm .git/refs/heads/bogus..name
 '
 
+# We create two new objects here, "one" and "two". Our
+# master branch points to "two", which is deleted,
+# corrupting the repository. But we'd like to make sure
+# that the otherwise unreachable "one" is not pruned
+# (since it is the user's best bet for recovering
+# from the corruption).
+#
+# Note that we also point HEAD somewhere besides "two",
+# as we want to make sure we test the case where we
+# pick up the reference to "two" by iterating the refs,
+# not by resolving HEAD.
 test_expect_success 'create history with missing tip commit' '
 	test_tick && git commit --allow-empty -m one &&
 	recoverable=$(git rev-parse HEAD) &&
 	git cat-file commit $recoverable >saved &&
 	test_tick && git commit --allow-empty -m two &&
 	missing=$(git rev-parse HEAD) &&
-	# point HEAD elsewhere
-	git checkout $base &&
+	git checkout --detach $base &&
 	rm .git/objects/$(echo $missing | sed "s,..,&/,") &&
 	test_must_fail git cat-file -e $missing
 '

> > +# we do not want to count on running pack-refs to
> > +# actually pack it, as it is perfectly reasonable to
> > +# skip processing a broken ref
> > +test_expect_success 'create packed-refs file with broken ref' '
> > +	rm -f .git/refs/heads/master &&
> > +	cat >.git/packed-refs <<-EOF
> > +	$missing refs/heads/master
> > +	$recoverable refs/heads/other
> > +	EOF
> 
> I do not know offhand if the lack of the pack-refs feature header
> matters here; I assume it does not?

It doesn't matter. We also do similarly gross things in other
corruption-related tests, but I suspect if you git-blamed them all you
would find that I am responsible. :)

> A safer check may be to pack and then make it missing, I guess, but
> I do not know if the difference matters.

Yeah, I considered that. The trouble is that we are relying on the
earlier setup that made the object go missing. We cannot pack the refs
in the setup step, because the earlier tests are checking the loose-ref
behavior. So we would have to actually restore the object, pack, and
then re-delete it.

Another option would be to restructure the whole test script to perform
each individual corruption in its own sub-repo. I thought that would end
up making things harder to understand due to the extra setup
boilerplate, but it would make the tests less fragile with respect to
each other (e.g., see the "clean up bogus ref" step which exists only to
clean up our earlier corruption that could influence later tests).

-Peff
