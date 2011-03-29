From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Portability: returning void
Date: Tue, 29 Mar 2011 18:36:18 -0400
Message-ID: <20110329223618.GC23510@sigill.intra.peff.net>
References: <71372d7d-dd08-4945-a8bc-c7b981c09fb2-mfwitten@gmail.com>
 <20110329200230.GA377@elie>
 <20110329221652.GB23510@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Michael Witten <mfwitten@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	David Barr <david.barr@cordelta.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 30 00:36:34 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q4hWU-000320-6d
	for gcvg-git-2@lo.gmane.org; Wed, 30 Mar 2011 00:36:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752368Ab1C2WgV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Mar 2011 18:36:21 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:36412
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751683Ab1C2WgU (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Mar 2011 18:36:20 -0400
Received: (qmail 1863 invoked by uid 107); 29 Mar 2011 22:37:02 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 29 Mar 2011 18:37:02 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 29 Mar 2011 18:36:18 -0400
Content-Disposition: inline
In-Reply-To: <20110329221652.GB23510@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170335>

On Tue, Mar 29, 2011 at 06:16:52PM -0400, Jeff King wrote:

> On Tue, Mar 29, 2011 at 03:02:48PM -0500, Jonathan Nieder wrote:
> 
> > Next step is to figure out the longstanding mysterious bash + prove
> > hang in t0081.
>
> [...]
> 
>   2. Tests should kill their backgrounded sleeps themselves. I think I
>      saw some "kill $!" lines in there, but maybe we are missing one.

Indeed, those kill lines aren't doing what you expect. Try instrumenting
like this:

diff --git a/t/t0081-line-buffer.sh b/t/t0081-line-buffer.sh
index 1dbe1c9..3b2f8ce 100755
--- a/t/t0081-line-buffer.sh
+++ b/t/t0081-line-buffer.sh
@@ -1,4 +1,4 @@
-#!/bin/sh
+#!/bin/bash
 
 test_description="Test the svn importer's input handling routines.
 
@@ -56,6 +56,7 @@ long_read_test () {
 	binary $readsize
 	copy $copysize
 	EOF
+	echo >>/tmp/foo killing $!
 	kill $! &&
 	test_line_count = $lines output &&
 	tail -n 1 <output >actual &&
@@ -90,6 +91,7 @@ test_expect_success PIPE '0-length read, no input available' '
 	binary 0
 	copy 0
 	EOF
+	echo >>/tmp/foo killing $!
 	kill $! &&
 	test_cmp expect actual
 '
@@ -119,6 +121,7 @@ test_expect_success PIPE '1-byte read, no input available' '
 	binary 1
 	copy 1
 	EOF
+	echo >>/tmp/foo killing $!
 	kill $! &&
 	test_cmp expect actual
 '

And then run the test under prove, and check "ps" for remaining sleep
processes. You will see that the killed process IDs do not match up with
the sleep processes. Except for one sleep process, which actually got
killed. That is the second one in the list above. It works because it's:

  {
    sleep 100 >input &
  } &&
  ...
  kill $!

whereas the other ones are like:

  {
    do_something &&
    sleep 100
  } >input &

So my guess is that we have to start a subshell for the latter ones, and
_that_ is what gets killed. And that may explain the bash vs dash
behavior; dash, upon receiving the kill signal, presumably kills its
child, but bash does not (I didn't confirm that; it's just a theory).

I'm not sure what the best solution is. Perhaps putting the subshell
into its own process group and killing the whole PGRP?

-Peff
