From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] use child_process_init() to initialize struct
 child_process variables
Date: Fri, 31 Oct 2014 23:33:27 -0400
Message-ID: <20141101033327.GA8307@peff.net>
References: <54500212.7040603@web.de>
 <20141029172109.GA32234@peff.net>
 <xmqqlhnyy9e2.fsf@gitster.dls.corp.google.com>
 <20141030213523.GA21017@peff.net>
 <FEC7DC4C920D4F97B5F165B10BC564D2@PhilipOakley>
 <xmqqvbmzsyfy.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Philip Oakley <philipoakley@iee.org>,
	=?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Nov 01 04:33:38 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XkPRX-0008Jw-G0
	for gcvg-git-2@plane.gmane.org; Sat, 01 Nov 2014 04:33:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752402AbaKADda (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 31 Oct 2014 23:33:30 -0400
Received: from cloud.peff.net ([50.56.180.127]:35605 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751906AbaKADd3 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 31 Oct 2014 23:33:29 -0400
Received: (qmail 13629 invoked by uid 102); 1 Nov 2014 03:33:29 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 31 Oct 2014 22:33:29 -0500
Received: (qmail 18017 invoked by uid 107); 1 Nov 2014 03:33:34 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 31 Oct 2014 23:33:34 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 31 Oct 2014 23:33:27 -0400
Content-Disposition: inline
In-Reply-To: <xmqqvbmzsyfy.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Oct 31, 2014 at 02:48:17PM -0700, Junio C Hamano wrote:

> Programs that read a pack data stream unpack-objects were originally
> designed to ignore cruft after the pack data stream ends, and
> because the bundle file format ends with pack data stream, you
> should have been able to append extra information at the end without
> breaking older clients.  Alas, this principle is still true for
> unpack-objects, but index-pack broke it fairly early on, and we use
> the latter to deal with bundles, so we cannot just tuck extra info
> at the end of an existing bundle.  You'd instead need a new option
> to create a bundle that cannot be read by existing clients X-<.

I think you could use a similar NUL-trick to what we do in the online
protocol, and have a ref section like:

  ...sha1... refs/heads/master
  ...sha1... refs/heads/confused-with-master
  ...sha1... HEAD\0symref=refs/heads/master

The current parser reads into a strbuf up to the newline, but we ignore
everything after the NUL, treating it like a C string. Prior to using
strbufs, we used fgets, which behaves similarly (you could not know from
fgets that there is extra data after the NUL, but that is OK; we only
want older versions to ignore the data, not do anything useful with it).

-Peff
