From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] travis-ci: run previously failed tests first, then
 slowest to fastest
Date: Fri, 22 Jan 2016 01:07:20 -0500
Message-ID: <20160122060720.GA15681@sigill.intra.peff.net>
References: <1453195469-51696-1-git-send-email-larsxschneider@gmail.com>
 <20160119191234.GA17562@sigill.intra.peff.net>
 <xmqqegdd8997.fsf@gitster.mtv.corp.google.com>
 <20160120002606.GA9359@glandium.org>
 <xmqqfuxt6n00.fsf@gitster.mtv.corp.google.com>
 <DBA834D2-BFC9-4A2F-94D9-A1D0D60377BD@gmail.com>
 <20160122023359.GA686558@vauxhall.crustytoothpaste.net>
 <20160122055255.GA14657@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Lars Schneider <larsxschneider@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Mike Hommey <mh@glandium.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 22 07:07:29 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aMUsZ-0003Ti-P9
	for gcvg-git-2@plane.gmane.org; Fri, 22 Jan 2016 07:07:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752170AbcAVGHY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Jan 2016 01:07:24 -0500
Received: from cloud.peff.net ([50.56.180.127]:58426 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751344AbcAVGHW (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Jan 2016 01:07:22 -0500
Received: (qmail 6628 invoked by uid 102); 22 Jan 2016 06:07:22 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 22 Jan 2016 01:07:22 -0500
Received: (qmail 29563 invoked by uid 107); 22 Jan 2016 06:07:44 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 22 Jan 2016 01:07:44 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 22 Jan 2016 01:07:20 -0500
Content-Disposition: inline
In-Reply-To: <20160122055255.GA14657@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284548>

On Fri, Jan 22, 2016 at 12:52:55AM -0500, Jeff King wrote:

> I get a few of the threads failing (in test 4) after 2-3 minutes. The
> "-v" output is pretty unenlightening, though. I don't see anything
> racy-looking in the test unless it is something with "read-tree" and
> stat mtimes.

And indeed, doing this:

diff --git a/t/t0025-crlf-auto.sh b/t/t0025-crlf-auto.sh
index c164b46..d34775b 100755
--- a/t/t0025-crlf-auto.sh
+++ b/t/t0025-crlf-auto.sh
@@ -56,6 +56,7 @@ test_expect_success 'text=true causes a CRLF file to be normalized' '
 
 	rm -f .gitattributes tmp LFonly CRLFonly LFwithNUL &&
 	echo "CRLFonly text" > .gitattributes &&
+	sleep 1 &&
 	git read-tree --reset -u HEAD &&
 
 	# Note, "normalized" means that git will normalize it if added

let me run for over 5 minutes with no failures in test 4 (I eventually
did hit one in test 9). I don't claim to understand what is going on,
though.

-Peff
