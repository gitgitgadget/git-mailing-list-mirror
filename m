From: Jeff King <peff@peff.net>
Subject: Re: Re* [PATCH v3 19/22] resolve_ref(): emit warnings for
 improperly-formatted references
Date: Tue, 11 Oct 2011 19:07:49 -0400
Message-ID: <20111011230749.GA29785@sigill.intra.peff.net>
References: <1316121043-29367-1-git-send-email-mhagger@alum.mit.edu>
 <1316121043-29367-20-git-send-email-mhagger@alum.mit.edu>
 <20111011161652.GA15629@sigill.intra.peff.net>
 <7vr52jfm8i.fsf@alter.siamese.dyndns.org>
 <7vmxd7flkw.fsf@alter.siamese.dyndns.org>
 <7v39ezffq5.fsf_-_@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Michael Haggerty <mhagger@alum.mit.edu>, git@vger.kernel.org,
	cmn@elego.de, A Large Angry SCM <gitzilla@gmail.com>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Sverre Rabbelier <srabbelier@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Oct 12 01:07:58 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RDlQT-0007iW-Es
	for gcvg-git-2@lo.gmane.org; Wed, 12 Oct 2011 01:07:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751491Ab1JKXHw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Oct 2011 19:07:52 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:57904
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751378Ab1JKXHv (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Oct 2011 19:07:51 -0400
Received: (qmail 6541 invoked by uid 107); 11 Oct 2011 23:07:54 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 11 Oct 2011 19:07:54 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 11 Oct 2011 19:07:49 -0400
Content-Disposition: inline
In-Reply-To: <7v39ezffq5.fsf_-_@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183344>

On Tue, Oct 11, 2011 at 01:14:26PM -0700, Junio C Hamano wrote:

> Junio C Hamano <gitster@pobox.com> writes:
> 
> >> I think we've discussed tightening it a few years ago already.
> >>
> >> HEAD, MERGE_HEAD, FETCH_HEAD, etc. all are "^[_A-Z]*$" and it may even be
> >> a good idea to insist "^[_A-Z]*HEAD$" or even "^([A-Z][A-Z]*_)?HEAD$".
> >
> > Perhaps like this? Only compile tested...
> 
> Not quite. There are at least three bugs in the patch.
> 
>  - Some subsystems use random refnames like NOTES_MERGE_PARTIAL that would
>    not match "^([A-Z][A-Z]*_)?HEAD$". The rule needs to be relaxed;
> 
>  - dwim_ref() can be fed "refs/heads/master" and is expected to dwim it to
>    the master branch.
> 
>  - These codepaths get pointer+length so that it can be told to parse only
>    the first 4 bytes in "HEAD:$path".

One more bug. :)

We also look at ref_rev_parse_rules in shorten_unambiguous_ref. So even
with your patch, I still get the warning with:

  $ git branch config
  $ git for-each-ref --format='%(refname:short)' refs/heads/

It looks like we also use it in remote.c:count_refspec_match, but I
haven't figured out if that can trigger a warning or not.

-Peff
