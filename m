From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 1/6] commit: provide a function to find a header in a
 buffer
Date: Wed, 27 Aug 2014 14:00:16 -0400
Message-ID: <20140827180016.GA6269@peff.net>
References: <20140827075503.GA19521@peff.net>
 <20140827075600.GA26384@peff.net>
 <xmqqioldet75.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
	Erik Faye-Lund <kusmabite@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Aug 27 20:00:25 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XMhWB-0004N7-Ur
	for gcvg-git-2@plane.gmane.org; Wed, 27 Aug 2014 20:00:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934964AbaH0SAT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Aug 2014 14:00:19 -0400
Received: from cloud.peff.net ([50.56.180.127]:60213 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750908AbaH0SAS (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Aug 2014 14:00:18 -0400
Received: (qmail 13965 invoked by uid 102); 27 Aug 2014 18:00:18 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 27 Aug 2014 13:00:18 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 27 Aug 2014 14:00:16 -0400
Content-Disposition: inline
In-Reply-To: <xmqqioldet75.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256017>

On Wed, Aug 27, 2014 at 10:30:22AM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > +const char *find_commit_header(const char *msg, const char *key, size_t *out_len)
> [...]
> 
> Hmph.  Does this have to worry about continuation lines in the
> header part e.g. mergetag?  If the original in pretty.c was only
> about the encoding, it may not have mattered, but now because it is
> made public, it may matter more.

If you mean parsing past continuation lines, then no, we do not need to
worry. We go line by line and look for the key at the beginning of a
line, so we would skip past any continuation lines.

If you mean including continuation lines in the output, I don't think
that's a good idea here. It would mean the function would have to copy
the value out (to get rid of the continuation whitespace) rather than
point directly into the msg buffer.

That may be something some callers want, but they should build it
separately around this find_commit_header, so that callers that want a
single line (like "encoding" or "author") do not have to pay the price.
I didn't bother building it out here since there are no callers which
want it yet (though I did not look at the mergetag code, which could
possibly be converted).

In the meantime, I hoped this comment would suffice for any callers to
know whether it was suitable:

+/*
+ * Search the commit object contents given by "msg" for the header "key".
+ * Returns a pointer to the start of the header contents, or NULL. The length
+ * of the header, up to the first newline, is returned via out_len.
+ *
+ * Note that some headers (like mergetag) may be multi-line. It is the caller's
+ * responsibility to parse further in this case!
+ */
+extern const char *find_commit_header(const char *msg, const char *key,
+                                     size_t *out_len);

-Peff
