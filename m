From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v8 1/4] sha1_file.c: support reading from a loose object
 of unknown type
Date: Fri, 17 Apr 2015 16:51:26 -0400
Message-ID: <20150417205125.GA7067@peff.net>
References: <552E9816.6040502@gmail.com>
 <1429117143-4882-1-git-send-email-karthik.188@gmail.com>
 <xmqqmw29jg78.fsf@gitster.dls.corp.google.com>
 <20150415221824.GB27566@peff.net>
 <20150417142310.GA12479@peff.net>
 <xmqqd232hgj8.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Karthik Nayak <karthik.188@gmail.com>, git@vger.kernel.org,
	sunshine@sunshineco.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Apr 17 22:51:35 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YjDEb-00070X-Mm
	for gcvg-git-2@plane.gmane.org; Fri, 17 Apr 2015 22:51:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751882AbbDQUv3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 Apr 2015 16:51:29 -0400
Received: from cloud.peff.net ([50.56.180.127]:46945 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751354AbbDQUv3 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Apr 2015 16:51:29 -0400
Received: (qmail 19628 invoked by uid 102); 17 Apr 2015 20:51:28 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 17 Apr 2015 15:51:28 -0500
Received: (qmail 5921 invoked by uid 107); 17 Apr 2015 20:51:53 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 17 Apr 2015 16:51:53 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 17 Apr 2015 16:51:26 -0400
Content-Disposition: inline
In-Reply-To: <xmqqd232hgj8.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267389>

On Fri, Apr 17, 2015 at 09:21:31AM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > If there _is_ a performance implication to worry about here, I think it
> > would be that we are doing an extra malloc/free.
> 
> Thanks for reminding me; yes, that also worried me.

As an aside, I worried about the extra allocation for reading the header
in the first place. But it looks like we only do this on the --literally
code path (and otherwise use the normal unpack_sha1_header).  Still, I
wonder if we could make this work automagically.  That is, speculatively
unpack the first N bytes, assuming we hit the end-of-header. If not,
then go to a strbuf as the slow path. Then it would be fine to cover all
cases; the normal ones would be fast, and only ridiculous things would
incur the extra allocation.

-Peff
