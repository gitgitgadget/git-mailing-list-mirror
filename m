From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 7/7] diff: avoid useless filespec population
Date: Fri, 2 Apr 2010 03:24:55 -0400
Message-ID: <20100402072455.GA2111@sigill.intra.peff.net>
References: <20100402000159.GA15101@coredump.intra.peff.net>
 <20100402001424.GG16462@coredump.intra.peff.net>
 <7vvdcal44p.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Apr 02 09:25:04 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NxbFW-00070q-Te
	for gcvg-git-2@lo.gmane.org; Fri, 02 Apr 2010 09:25:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759293Ab0DBHY6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Apr 2010 03:24:58 -0400
Received: from peff.net ([208.65.91.99]:52964 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759280Ab0DBHY5 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Apr 2010 03:24:57 -0400
Received: (qmail 10197 invoked by uid 107); 2 Apr 2010 07:25:32 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Fri, 02 Apr 2010 03:25:32 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 02 Apr 2010 03:24:55 -0400
Content-Disposition: inline
In-Reply-To: <7vvdcal44p.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143785>

On Fri, Apr 02, 2010 at 12:12:22AM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > This patch just pushes the fill_mmfile call a bit later, so we can avoid
> > populating the filespec in some cases.  There is one thing to note that
> > looks like a bug but isn't. We push the fill_mmfile down into the first
> > branch of a conditional. It seems like we would need it on the other
> > branch, too, but we don't; fill_textconv does it for us (in fact, before
> > this, we were just writing over the results of the fill_mmfile on that
> > branch).
> 
> ... and leaking the memory in the "cached" codepath, perhaps?

I don't think so. fill_mmfile never allocates, but rather points to
what's in the diff_filespec. So though we overwrote what was in the
mmfile, that data was still pointed to and eventually freed by the
diff_filespec struct.

fill_textconv will allocate if and only if we are doing a textconv
(either a buffer we get from read_sha1_file in the case of a cached
entry, or the detached strbuf from run-textconv otherwise). If we're not
doing a textconv, it falls back to basically doing the same as
fill_mmfile. And that's the reason for the

  if (textconv_one)
          free(data_one);

seen in patch 2/7 (and the matching one in builtin_diff from before).

-Peff
