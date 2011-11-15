From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v4 3/3] upload-archive: use start_command instead of fork
Date: Tue, 15 Nov 2011 12:37:15 -0500
Message-ID: <20111115173715.GA4478@sigill.intra.peff.net>
References: <1319472131-3968-1-git-send-email-kusmabite@gmail.com>
 <201111151122.48378.trast@student.ethz.ch>
 <20111115102807.GA18649@sigill.intra.peff.net>
 <201111151311.46832.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Franck Bui-Huu <vagabon.xyz@gmail.com>,
	Erik Faye-Lund <kusmabite@gmail.com>, git@vger.kernel.org,
	gitster@pobox.com, j6t@kdbg.org, rene.scharfe@lsrfire.ath.cx
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Tue Nov 15 18:37:31 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RQMwt-0006DE-09
	for gcvg-git-2@lo.gmane.org; Tue, 15 Nov 2011 18:37:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757010Ab1KORhV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Nov 2011 12:37:21 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:42712
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756982Ab1KORhR (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Nov 2011 12:37:17 -0500
Received: (qmail 8527 invoked by uid 107); 15 Nov 2011 17:37:22 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 15 Nov 2011 12:37:22 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 15 Nov 2011 12:37:15 -0500
Content-Disposition: inline
In-Reply-To: <201111151311.46832.trast@student.ethz.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185473>

On Tue, Nov 15, 2011 at 01:11:46PM +0100, Thomas Rast wrote:

> But after a closer look I think this patch just prodded it enough to
> unearth long-existing undefined behaviour: prepare_argv() summarizes
> to something like
> 
> static void prepare_argv(const char **sent_argv, const char **argv)
> {
> 	char *p, buf[4096];
> 
> 	for (p = buf;;) {
> 		len = packet_read_line(0, p, (buf + sizeof buf) - p);
> 		/* ... p always points into buf ... */
> 		sent_argv[sent_argc++] = p;
> 		p += len;
> 		*p++ = 0;
> 	}
> 	sent_argv[sent_argc] = NULL;
> }
> 
> The code appears to have looked like this ever since the addition of
> that file back in 39345a2 (Add git-upload-archive, 2006-09-07).  So
> the elements of sent_argv have apparently always pointed into the
> stack-allocated 'buf'.

Oh, yikes. That is definitely the problem, but it does come from
c09cd77e. The prepare_argv function used to be "run_upload_archive", and
it would prepare argv on the stack, call into write_archive with it, and
then return; nobody else cares about the value afterwards.

Erik's patch converts it into a function that writes the new argv into a
parameter and returns, and the now-invalid stack-allocated memory is
used by the calling function.

> A quick band-aid would be to heap-allocate it instead:

That works.  An even shorter band-aid is to mark it as "static".

I think the code would be more readable if it just used the new
argv_array.

Junio, this bug is in 1.7.8-rc*. Do you want the one-liner fix for the
release, or the nicer fix?

-Peff
