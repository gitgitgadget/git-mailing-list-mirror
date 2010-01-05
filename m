From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v3 5/6] transport-helper.c::push_refs(): ignore
 helper-reported status if ref is not to be pushed
Date: Tue, 5 Jan 2010 01:32:53 -0500
Message-ID: <20100105063253.GA19368@coredump.intra.peff.net>
References: <20091224154352.ecefd242.rctay89@gmail.com>
 <20091224154258.08b4fe44.rctay89@gmail.com>
 <20091224154158.15ba580f.rctay89@gmail.com>
 <20091224154057.33611ae7.rctay89@gmail.com>
 <20091224154005.a642c8ec.rctay89@gmail.com>
 <20091224154445.ad4b7a01.rctay89@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Junio C Hamano <gitster@pobox.com>
To: Tay Ray Chuan <rctay89@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jan 05 07:33:09 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NS2yZ-0001me-TA
	for gcvg-git-2@lo.gmane.org; Tue, 05 Jan 2010 07:33:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754041Ab0AEGc7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Jan 2010 01:32:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754013Ab0AEGc6
	(ORCPT <rfc822;git-outgoing>); Tue, 5 Jan 2010 01:32:58 -0500
Received: from peff.net ([208.65.91.99]:42127 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753981Ab0AEGc4 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Jan 2010 01:32:56 -0500
Received: (qmail 28219 invoked by uid 107); 5 Jan 2010 06:37:41 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Tue, 05 Jan 2010 01:37:41 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Tue, 05 Jan 2010 01:32:53 -0500
Content-Disposition: inline
In-Reply-To: <20091224154445.ad4b7a01.rctay89@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136167>

On Thu, Dec 24, 2009 at 03:44:45PM +0800, Tay Ray Chuan wrote:

> -		ref->status = status;
> -		ref->remote_status = msg;
> +		switch (ref->status) {
> +		case REF_STATUS_REJECT_NONFASTFORWARD:
> +		case REF_STATUS_UPTODATE:
> +			/*
> +			 * Earlier, the ref was marked not to be pushed, so ignore what
> +			 * the remote helper said about the ref.
> +			 */
> +			continue;
> +		default:
> +			ref->status = status;
> +			ref->remote_status = msg;
> +		}

It seems like this should be checking for REF_STATUS_NONE explicitly
instead of trying to enumerate the reasons we might not have tried to
push. Shouldn't helpers _only_ be pushing REF_STATUS_NONE refs?

I think right now the two cases are equivalent, since non-ff and
uptodate are the only two states set before the helper is invoked. But
we have discussed in the past (and I still have a patch floating around
for) a REF_STATUS_REWIND which would treat strict rewinds differently
(silently ignoring them instead of making an error). Explicitly checking
REF_STATUS_NONE future-proofs against new states being added.

-Peff
