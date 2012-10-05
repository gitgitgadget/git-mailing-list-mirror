From: Jeff King <peff@peff.net>
Subject: Re: Super long branch names corrupt `.git/config`
Date: Thu, 4 Oct 2012 20:29:42 -0400
Message-ID: <20121005002942.GB17586@sigill.intra.peff.net>
References: <CAAmo=1BU5N8nbonEb1aZEx=-e8VexwsE74pjm_56dXmCDK+K6g@mail.gmail.com>
 <7v391uyr2w.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Ben Olive <sionide21@gmail.com>, git@vger.kernel.org,
	Ben Walton <bdwalton@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Oct 05 02:30:06 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TJvni-000706-LM
	for gcvg-git-2@plane.gmane.org; Fri, 05 Oct 2012 02:29:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751707Ab2JEA3p (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Oct 2012 20:29:45 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:41106 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751480Ab2JEA3o (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Oct 2012 20:29:44 -0400
Received: (qmail 26428 invoked by uid 107); 5 Oct 2012 00:30:16 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 04 Oct 2012 20:30:16 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 04 Oct 2012 20:29:42 -0400
Content-Disposition: inline
In-Reply-To: <7v391uyr2w.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207058>

On Thu, Oct 04, 2012 at 12:28:39PM -0700, Junio C Hamano wrote:

> Ben Olive <sionide21@gmail.com> writes:
> 
> > My `.git/config` can be corrupted if I try to get a local branch with
> > an extremely long name to track a remote branch.
> >
> > Here is a (contrived) example to reproduce the issue:
> 
> Don't do that, then ;-)
> 
> I think we have a change that is already cooking.
> 
> Ben (Walton), want to add a test for your 0971e99 (Remove the hard
> coded length limit on variable names in config files, 2012-09-30)
> before it hits 'next', perhaps?

I came up with this test earlier today when responding in this thread:

diff --git a/t/t7201-co.sh b/t/t7201-co.sh
index be9672e..a32ecd9 100755
--- a/t/t7201-co.sh
+++ b/t/t7201-co.sh
@@ -454,6 +454,11 @@ test_expect_success \
     'checkout with --track, but without -b, fails with too short tracked name' '
     test_must_fail git checkout --track renamer'
 
+test_expect_success 'checkout tracking with long branch name' '
+	z200=$_z40$_z40$_z40$_z40$_z40
+	git checkout --track -b foo-$z200
+'
+
 setup_conflicting_index () {
 	rm -f .git/index &&
 	O=$(echo original | git hash-object -w --stdin) &&

but it feels a little fake. Why 200? Because that will test the config
limit, but will not overflow the NAME_MAX limit (at least not on
Linux! No clue on other platforms) when we try to create
refs/heads/foo-$z200.

So while this is a nice concrete user-visible impact of Ben's patch, I
think it is a little flaky to be testing. We should probably have a
straight config test in t1303, though.

-Peff
