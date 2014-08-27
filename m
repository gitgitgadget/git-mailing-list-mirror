From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 1/6] commit: provide a function to find a header in a
 buffer
Date: Wed, 27 Aug 2014 15:14:14 -0400
Message-ID: <20140827191414.GA7561@peff.net>
References: <20140827075503.GA19521@peff.net>
 <20140827075600.GA26384@peff.net>
 <xmqqioldet75.fsf@gitster.dls.corp.google.com>
 <20140827180016.GA6269@peff.net>
 <xmqqwq9tda8t.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
	Erik Faye-Lund <kusmabite@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Aug 27 21:14:28 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XMifk-0005UE-MO
	for gcvg-git-2@plane.gmane.org; Wed, 27 Aug 2014 21:14:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755454AbaH0TOR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Aug 2014 15:14:17 -0400
Received: from cloud.peff.net ([50.56.180.127]:60264 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750764AbaH0TOQ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Aug 2014 15:14:16 -0400
Received: (qmail 17712 invoked by uid 102); 27 Aug 2014 19:14:16 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 27 Aug 2014 14:14:16 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 27 Aug 2014 15:14:14 -0400
Content-Disposition: inline
In-Reply-To: <xmqqwq9tda8t.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256023>

On Wed, Aug 27, 2014 at 12:05:06PM -0700, Junio C Hamano wrote:

> > If you mean including continuation lines in the output, I don't think
> > that's a good idea here. It would mean the function would have to copy
> > the value out (to get rid of the continuation whitespace) rather than
> > point directly into the msg buffer.
> 
> I meant the counting of out_len.  You do not copy the contents for
> the caller for a single line case either, so I wouldn't expect it.
> 
> You locate where the stuff begins to make it easier for the caller
> to read or copy, and the caller may choose to stop reading from the
> location up to out_len bytes, or it may choose to ignore out_len and
> stop at the first newline.  For the latter kind of caller, it does
> not matter if out_len does not point at the end of the "field"
> (i.e. for a continued-line case), but for the former, wouldn't it be
> more useful if out_len told where the end of the "field" is?

I think they are a direct tradeoff. If you include only the first line,
then callers who want multiple lines have to keep parsing.  If you
include multiple lines, then callers who care only about the first line
will have to re-find the newline rather than just using "out_len"
directly.

I suppose you could argue that people who are only expecting one line
(e.g., "encoding") should just assume that out_len ends at the first
line. For correctly-formatted commits, that works the same under either
scheme. For a broken commit where "encoding" _is_ multi-line, one case
would ignore the continued bits and the other case would return an
unexpected encoding value with newlines in it. The choice probably
doesn't matter much in practice.

Mostly I just punted on it with a comment since I did not plan to add
any multi-line callers, and I figured we could sort it out then. If you
feel strongly, it should be pretty easy to check for continuation and
extend out_len if necessary.

-Peff
