From: Jeff King <peff@peff.net>
Subject: Re: [BUG] two-way read-tree can write null sha1s into index
Date: Mon, 7 Jan 2013 08:46:54 -0500
Message-ID: <20130107134654.GA22692@sigill.intra.peff.net>
References: <20121229103430.GG18903@elie.Belkin>
 <20121229110541.GA1408@sigill.intra.peff.net>
 <20121229205154.GA21058@sigill.intra.peff.net>
 <7vvcbg7d8x.fsf@alter.siamese.dyndns.org>
 <20130103083712.GC32377@sigill.intra.peff.net>
 <7vehi2xote.fsf@alter.siamese.dyndns.org>
 <20130103202343.GA4632@sigill.intra.peff.net>
 <7vip7evwdo.fsf@alter.siamese.dyndns.org>
 <20130103203606.GA8188@sigill.intra.peff.net>
 <7vzk0pvqvu.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jan 07 14:47:29 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TsD30-0007hZ-LN
	for gcvg-git-2@plane.gmane.org; Mon, 07 Jan 2013 14:47:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754610Ab3AGNrG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Jan 2013 08:47:06 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:46292 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753823Ab3AGNrF (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Jan 2013 08:47:05 -0500
Received: (qmail 10161 invoked by uid 107); 7 Jan 2013 13:48:17 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 07 Jan 2013 08:48:17 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 07 Jan 2013 08:46:54 -0500
Content-Disposition: inline
In-Reply-To: <7vzk0pvqvu.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212894>

On Thu, Jan 03, 2013 at 02:33:09PM -0800, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > Oh, I agree it's insane to try to carry through unmerged entries. I'm
> > just concerned that not all code paths are careful enough to check.
> 
> I would actually be surprised if some code path do assume somebody
> might give them an index with conflicting entries in it and guard
> against it.  We have been coding under the "index must exactly match
> the second tree when three-way unpack_trees() begin" requirement
> since day one.  An conflicted entry will appear as "index and HEAD
> not matching" and will cause reject_merge() early in threeway_merge()
> anyway, no?

Hmm. There is code in threeway_merge to handle a few cases:

        /*
         * We start with cases where the index is allowed to match
         * something other than the head: #14(ALT) and #2ALT, where it
         * is permitted to match the result instead.
         */
        /* #14, #14ALT, #2ALT */
        if (remote && !df_conflict_head && head_match && !remote_match) {
                if (index && !same(index, remote) && !same(index, head))
                        return o->gently ? -1 : reject_merge(index, o);
                return merged_entry(remote, index, o);
        }

but I do not think we have to worry, because we know that the index will
never match remote, either (and merged_entry has already been taught to
be wary of the conflicted bit, anyway). I'm not entirely clear on how
that would get triggered if all of the callers avoid operating on a
modified index.

-Peff
