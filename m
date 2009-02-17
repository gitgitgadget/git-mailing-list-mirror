From: Jeff King <peff@peff.net>
Subject: Re: diff.defaultOptions implementation design [was diff.primer]
Date: Tue, 17 Feb 2009 14:56:58 -0500
Message-ID: <20090217195658.GC16067@coredump.intra.peff.net>
References: <1233598855-1088-1-git-send-email-keith@cs.ucla.edu> <1233598855-1088-2-git-send-email-keith@cs.ucla.edu> <20090203071516.GC21367@sigill.intra.peff.net> <alpine.GSO.2.00.0902030833250.5994@kiwi.cs.ucla.edu> <20090206161954.GA18956@coredump.intra.peff.net> <alpine.GSO.2.00.0902090921270.719@kiwi.cs.ucla.edu> <20090213222233.GA7424@coredump.intra.peff.net> <alpine.GSO.2.00.0902162312030.17111@kiwi.cs.ucla.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Keith Cascio <keith@CS.UCLA.EDU>
X-From: git-owner@vger.kernel.org Tue Feb 17 20:58:31 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LZW5N-0007UH-TI
	for gcvg-git-2@gmane.org; Tue, 17 Feb 2009 20:58:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753166AbZBQT5B (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Feb 2009 14:57:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753128AbZBQT5B
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Feb 2009 14:57:01 -0500
Received: from peff.net ([208.65.91.99]:43557 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751717AbZBQT5A (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Feb 2009 14:57:00 -0500
Received: (qmail 31721 invoked by uid 107); 17 Feb 2009 19:57:20 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Tue, 17 Feb 2009 14:57:20 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Tue, 17 Feb 2009 14:56:58 -0500
Content-Disposition: inline
In-Reply-To: <alpine.GSO.2.00.0902162312030.17111@kiwi.cs.ucla.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110447>

On Mon, Feb 16, 2009 at 11:24:33PM -0800, Keith Cascio wrote:

> I like the idea of using parse-options to handle diff options and I
> too would like all switches negatable.  I will come back to the other
> ideas you mention if necessary.  You laid it all out nicely.

If you are interested in parse-optification of diff options, search the
archive for messages from Pierre Habouzit on the topic in the last 6
months or so. It was discussed at the GitTogether, and he had some
preliminary patches.

> diff_setup().  But diff_setup() must still ascertain at least one
> runtime fact: whether or not we are running one of the commands that
> respects default options {diff, log, show}.  Is there an elegant way
> to ascertain that fact from inside diff_setup()?  How do you
> recommend?  (BTW I believe my design achieves this elegantly).

You can impact the argument parsing by touching the diffopt struct
before doing the parsing. I.e., something like:

  /* we generally get diff options from a rev_info structure */
  struct rev_info rev;
  /* initialize the structures */
  init_revisions(&rev, prefix);
  /* now set any preferences specific to this command */
  DIFF_OPT_SET(&rev.diffopt, ALLOW_DEFAULT_CONFIG);
  /* and then actually parse */
  setup_revisions(argc, argv, rev, "HEAD");

See for example how cmd_whatchanged does it in builtin-log.c. Any
porcelains which wanted this feature would opt in to it.

-Peff
