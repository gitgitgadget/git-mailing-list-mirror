From: Jeff King <peff@peff.net>
Subject: [PATCH 0/3] convert read_packed_refs to use strbuf
Date: Wed, 10 Dec 2014 05:39:07 -0500
Message-ID: <20141210103907.GA22186@peff.net>
References: <20141209174958.GA26167@peff.net>
 <20141209180916.GA26873@peff.net>
 <xmqqa92wla34.fsf@gitster.dls.corp.google.com>
 <20141210073447.GA20298@peff.net>
 <CAPig+cQQThA7wiz8iwkKX=ipg1n5w+gyeS8NqtbjGui986Hn+g@mail.gmail.com>
 <CAPig+cR4p9C46wU2-nNVy7rpXzbW0fGmqzik85UP_1j3YUEmjA@mail.gmail.com>
 <CAPig+cT9rRXdZ5OS8HPBuNOh2P-+PVYZkGR-74rBfXsc2nj_Zw@mail.gmail.com>
 <20141210095319.GA9099@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, Johannes Sixt <j6t@kdbg.org>,
	Michael Blume <blume.mike@gmail.com>,
	Git List <git@vger.kernel.org>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Wed Dec 10 11:40:11 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xyegj-0007Du-PI
	for gcvg-git-2@plane.gmane.org; Wed, 10 Dec 2014 11:40:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755405AbaLJKju (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Dec 2014 05:39:50 -0500
Received: from cloud.peff.net ([50.56.180.127]:50987 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752466AbaLJKjK (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Dec 2014 05:39:10 -0500
Received: (qmail 29506 invoked by uid 102); 10 Dec 2014 10:39:10 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 10 Dec 2014 04:39:10 -0600
Received: (qmail 8222 invoked by uid 107); 10 Dec 2014 10:39:14 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 10 Dec 2014 05:39:14 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 10 Dec 2014 05:39:07 -0500
Content-Disposition: inline
In-Reply-To: <20141210095319.GA9099@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261205>

On Wed, Dec 10, 2014 at 04:53:19AM -0500, Jeff King wrote:

> > Clarification: for-each-ref ignores the ref when the full line read
> > from packed-refs hits length 1024 (not when the refname itself hits
> > length 1024).
> 
> Yes, the problem is in read_packed_refs:
> 
>     char refline[PATH_MAX];
>     ...
>     while (fgets(refline, sizeof(refline), f)) {
>         ...
>     }
> 
> This could be trivially converted to strbuf_getwholeline, but I am not
> sure what else would break, or whether such a system would actually be
> _usable_ with such long refs (e.g., would it break the first time you

I accidentally cut off the next line, but it was something like
"...first time you actually tried writing to the ref)".

> Using fgets like this does shear lines, though. The next fgets call will
> see the second half of the line. I think we are saved from doing
> anything stupid by parse_ref_line, but it is mostly luck. So perhaps for
> that reason the trivial conversion to strbuf is worth it, even if it
> doesn't help any practical cases.

Here's a patch to do that. It still doesn't let you create long refs on
OS X, as we get caught up in the PATH_MAX found in git_path() and
friends. Still, I think it's a step in the right direction, and it fixes
the shearing issue.

Patches 2 and 3 are just follow-on cleanups.

  [1/3]: read_packed_refs: use a strbuf for reading lines
  [2/3]: read_packed_refs: pass strbuf to parse_ref_line
  [3/3]: read_packed_refs: use skip_prefix instead of static array

I checked, and this miraculously does not conflict with any of the refs
work in pu. :)

-Peff
