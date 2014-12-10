From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v3] pkt-line: allow writing of LARGE_PACKET_MAX buffers
Date: Wed, 10 Dec 2014 04:53:20 -0500
Message-ID: <20141210095319.GA9099@peff.net>
References: <20141209174958.GA26167@peff.net>
 <20141209180916.GA26873@peff.net>
 <xmqqa92wla34.fsf@gitster.dls.corp.google.com>
 <20141210073447.GA20298@peff.net>
 <CAPig+cQQThA7wiz8iwkKX=ipg1n5w+gyeS8NqtbjGui986Hn+g@mail.gmail.com>
 <CAPig+cR4p9C46wU2-nNVy7rpXzbW0fGmqzik85UP_1j3YUEmjA@mail.gmail.com>
 <CAPig+cT9rRXdZ5OS8HPBuNOh2P-+PVYZkGR-74rBfXsc2nj_Zw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, Johannes Sixt <j6t@kdbg.org>,
	Michael Blume <blume.mike@gmail.com>,
	Git List <git@vger.kernel.org>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Wed Dec 10 10:53:31 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xydxa-0005Wi-GQ
	for gcvg-git-2@plane.gmane.org; Wed, 10 Dec 2014 10:53:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754047AbaLJJxY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Dec 2014 04:53:24 -0500
Received: from cloud.peff.net ([50.56.180.127]:50975 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754003AbaLJJxW (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Dec 2014 04:53:22 -0500
Received: (qmail 27547 invoked by uid 102); 10 Dec 2014 09:53:22 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 10 Dec 2014 03:53:22 -0600
Received: (qmail 8043 invoked by uid 107); 10 Dec 2014 09:53:26 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 10 Dec 2014 04:53:26 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 10 Dec 2014 04:53:20 -0500
Content-Disposition: inline
In-Reply-To: <CAPig+cT9rRXdZ5OS8HPBuNOh2P-+PVYZkGR-74rBfXsc2nj_Zw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261203>

On Wed, Dec 10, 2014 at 04:49:38AM -0500, Eric Sunshine wrote:

> On Wed, Dec 10, 2014 at 4:42 AM, Eric Sunshine <sunshine@sunshineco.com> wrote:
> > On Wed, Dec 10, 2014 at 3:36 AM, Eric Sunshine <sunshine@sunshineco.com> wrote:
> >> On Wed, Dec 10, 2014 at 2:34 AM, Jeff King <peff@peff.net> wrote:
> >>> Below is a another iteration on the patch. The actual code changes are
> >>> the same as the strbuf one, but the tests take care to avoid assuming
> >>> the filesystem can handle such a long path. Testing on Windows and OS X
> >>> is appreciated.
> >>
> >> All three new tests fail on OS X. Thus far brief examination of the
> >> first failing tests shows that 'expect' and 'actual' differ:
> >>
> >> expect:
> >>     long
> >>     master
> >>
> >> actual:
> >>     master
> >
> > The failure manifests as soon as the refname hits length 1024, at
> > which point for-each-ref stops reporting it. MAX_PATH on OS X is 1024,
> > so some part of the machinery invoked by for-each-ref likely is
> > rejecting refnames longer than that (even when coming from
> > packed-refs).
> 
> Clarification: for-each-ref ignores the ref when the full line read
> from packed-refs hits length 1024 (not when the refname itself hits
> length 1024).

Yes, the problem is in read_packed_refs:

    char refline[PATH_MAX];
    ...
    while (fgets(refline, sizeof(refline), f)) {
        ...
    }

This could be trivially converted to strbuf_getwholeline, but I am not
sure what else would break, or whether such a system would actually be
_usable_ with such long refs (e.g., would it break the first time you

Using fgets like this does shear lines, though. The next fgets call will
see the second half of the line. I think we are saved from doing
anything stupid by parse_ref_line, but it is mostly luck. So perhaps for
that reason the trivial conversion to strbuf is worth it, even if it
doesn't help any practical cases.

-Peff
