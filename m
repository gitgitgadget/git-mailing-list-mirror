Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33922C001B0
	for <git@archiver.kernel.org>; Tue,  8 Aug 2023 19:59:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229992AbjHHT7z (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Aug 2023 15:59:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230293AbjHHT7j (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Aug 2023 15:59:39 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5ADC5168B6C
        for <git@vger.kernel.org>; Tue,  8 Aug 2023 11:14:37 -0700 (PDT)
Received: (qmail 32683 invoked by uid 109); 8 Aug 2023 18:14:36 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 08 Aug 2023 18:14:36 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 22663 invoked by uid 111); 8 Aug 2023 18:14:36 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 08 Aug 2023 14:14:36 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 8 Aug 2023 14:14:36 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 1/2] send-email: drop FakeTerm hack
Message-ID: <20230808181436.GA2097200@coredump.intra.peff.net>
References: <20230808180935.GA2096901@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230808180935.GA2096901@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Back in 280242d1cc (send-email: do not barf when Term::ReadLine does not
like your terminal, 2006-07-02), we added a fallback for when
Term::ReadLine's constructor failed: we'd have a FakeTerm object
instead, which would then die if anybody actually tried to call
readline() on it. Since we instantiated the $term variable at program
startup, we needed this workaround to let the program run in modes when
we did not prompt the user.

But later, in f4dc9432fd (send-email: lazily load modules for a big
speedup, 2021-05-28), we started loading Term::ReadLine lazily only when
ask() is called. So at that point we know we're trying to prompt the
user, and we can just die if ReadLine instantiation fails, rather than
making this fake object to lazily delay showing the error.

This should be OK even if there is no tty (e.g., we're in a cron job),
because Term::ReadLine will return a stub object in that case whose "IN"
and "OUT" functions return undef. And since 5906f54e47 (send-email:
don't attempt to prompt if tty is closed, 2009-03-31), we check for that
case and skip prompting.

And we can be sure that FakeTerm was not kicking in for such a
situation, because it has actually been broken since that commit! It
does not define "IN" or "OUT" methods, so perl would barf with an error.
If FakeTerm was in use, we were neither honoring what 5906f54e47 tried
to do, nor producing the readable message that 280242d1cc intended.

So we're better off just dropping FakeTerm entirely, and letting the
error reported by constructing Term::ReadLine through.

Signed-off-by: Jeff King <peff@peff.net>
---
The smaller change is to implement:

  sub IN { return undef }

for FakeTerm, which would then behave according to 5906f54e47's "no tty"
behavior. But after reading through the relevant history, I'm fairly
convinced that just dropping it is the right path. If it were actually
kicking in ever, people would be complaining about the obscure
"$term->IN is not defined" error message from perl.

 git-send-email.perl | 22 ++--------------------
 1 file changed, 2 insertions(+), 20 deletions(-)

diff --git a/git-send-email.perl b/git-send-email.perl
index affbb88509..4cb6ee9327 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -26,18 +26,6 @@
 
 Getopt::Long::Configure qw/ pass_through /;
 
-package FakeTerm;
-sub new {
-	my ($class, $reason) = @_;
-	return bless \$reason, shift;
-}
-sub readline {
-	my $self = shift;
-	die "Cannot use readline on FakeTerm: $$self";
-}
-package main;
-
-
 sub usage {
 	print <<EOT;
 git send-email' [<options>] <file|directory>
@@ -972,16 +960,10 @@ sub get_patch_subject {
 }
 
 sub term {
-	my $term = eval {
-		require Term::ReadLine;
-		$ENV{"GIT_SEND_EMAIL_NOTTY"}
+	require Term::ReadLine;
+	return $ENV{"GIT_SEND_EMAIL_NOTTY"}
 			? Term::ReadLine->new('git-send-email', \*STDIN, \*STDOUT)
 			: Term::ReadLine->new('git-send-email');
-	};
-	if ($@) {
-		$term = FakeTerm->new("$@: going non-interactive");
-	}
-	return $term;
 }
 
 sub ask {
-- 
2.42.0.rc0.376.g66bfc4f195

