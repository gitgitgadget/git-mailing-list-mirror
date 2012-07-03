From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v4 00/18] Extending the shelf-life of "git describe"
 output
Date: Tue, 3 Jul 2012 15:34:10 -0400
Message-ID: <20120703193410.GA20503@sigill.intra.peff.net>
References: <1341268449-27801-1-git-send-email-gitster@pobox.com>
 <20120703071940.GB16679@sigill.intra.peff.net>
 <7v3958wvtx.fsf@alter.siamese.dyndns.org>
 <20120703183839.GA5765@sigill.intra.peff.net>
 <7vy5n0vg9l.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jul 03 21:34:20 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sm8rb-0007g8-9Y
	for gcvg-git-2@plane.gmane.org; Tue, 03 Jul 2012 21:34:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757078Ab2GCTeO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Jul 2012 15:34:14 -0400
Received: from 99-108-225-23.lightspeed.iplsin.sbcglobal.net ([99.108.225.23]:52499
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753188Ab2GCTeN (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Jul 2012 15:34:13 -0400
Received: (qmail 25033 invoked by uid 107); 3 Jul 2012 19:34:20 -0000
Received: from c-71-206-173-132.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.206.173.132)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 03 Jul 2012 15:34:20 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 03 Jul 2012 15:34:10 -0400
Content-Disposition: inline
In-Reply-To: <7vy5n0vg9l.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200935>

On Tue, Jul 03, 2012 at 11:41:42AM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > It looks right to me (and certainly fixes the behavior I mentioned).
> 
> OK, I have further updates on the topic; pushed out to 'pu'.

Looks reasonable to me. One thing I wondered about is in:

> static int get_short_sha1(const char *name, int len, unsigned char *sha1,
>			  unsigned flags)
> {
> [...]
>	memset(&ds, 0, sizeof(ds));
>	if (flags & GET_SHA1_COMMIT)
>		ds.fn = disambiguate_commit_only;
>	else if (flags & GET_SHA1_COMMITTISH)
>		ds.fn = disambiguate_committish_only;
>	else if (flags & GET_SHA1_TREE)
>		ds.fn = disambiguate_tree_only;
>	else if (flags & GET_SHA1_TREEISH)
>		ds.fn = disambiguate_treeish_only;
>	else if (flags & GET_SHA1_BLOB)
>		ds.fn = disambiguate_blob_only;

What happens if I set multiple flags? One or more of them will be
ignored (you _could_ try to establish a hierarchy, for example that
TREEISH is a superset of COMMITISH, but that could not handle the *_only
cases, which really are mutually exclusive). IOW, I think these are not
really flags but rather enum elements.

It is probably an OK trade-off since we are also stuffing true flags
like GET_SHA1_QUIETLY in the same field, and we don't want to make the
parameter list too unwieldy by splitting out the enum. But it might be
worth throwing a comment into cache.h that a certain set of the flags
are mutually exclusive. Or I guess you could mask off that part and make
sure only one bit was set, which would catch the error at run-time. But
I think a comment is probably sufficient.

-Peff
