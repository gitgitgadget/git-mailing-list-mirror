From: Jeff King <peff@peff.net>
Subject: Re: Using bitmaps to accelerate fetch and clone
Date: Thu, 27 Sep 2012 17:36:02 -0400
Message-ID: <20120927213602.GA12512@sigill.intra.peff.net>
References: <CAJo=hJstK1tGrWhtBt3s+R1a6C0ge3wMtJnoo43Fjfg5A57eVw@mail.gmail.com>
 <CACsJy8D0vkyEArNChXE0igUkanH6PwjmPitq22a9sudfmWF4kA@mail.gmail.com>
 <20120927172037.GB1547@sigill.intra.peff.net>
 <CAJo=hJuXCYa=MKSqCRsxmwFdFYZamK_94zc3fE0tmvwUAVA2Ow@mail.gmail.com>
 <20120927182233.GA2519@sigill.intra.peff.net>
 <CAJo=hJs4NXatb2vsZWWCamLGLmi+FoWkTaf3Ky-nereXkHEptA@mail.gmail.com>
 <20120927185229.GD2519@sigill.intra.peff.net>
 <20120927201809.GA11772@sigill.intra.peff.net>
 <7vfw63p2wi.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Shawn Pearce <spearce@spearce.org>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	git <git@vger.kernel.org>, Colby Ranger <cranger@google.com>,
	David Barr <barr@github.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Sep 27 23:36:21 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1THLkl-0001DW-RL
	for gcvg-git-2@plane.gmane.org; Thu, 27 Sep 2012 23:36:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755378Ab2I0VgF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Sep 2012 17:36:05 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:33189 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754952Ab2I0VgF (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Sep 2012 17:36:05 -0400
Received: (qmail 6428 invoked by uid 107); 27 Sep 2012 21:36:32 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 27 Sep 2012 17:36:32 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 27 Sep 2012 17:36:02 -0400
Content-Disposition: inline
In-Reply-To: <7vfw63p2wi.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206522>

On Thu, Sep 27, 2012 at 02:33:01PM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > So yeah, we would want to put the pack trailer sha1 into the
> > supplementary index file, and check that it matches when we open it.
> > It's a slight annoyance, but it's O(1).
> 
> Yes.  If I am not mistaken, that is exactly how an .idx file makes
> sure that it describes the matching .pack file (it has packfile
> checksum in its trailer).  Otherwise you can repack the same set of
> objects into a new .pack file and make existing .idx very confused.

Yeah. In theory you wouldn't name the new packfile into place without
also generating a new index for it. But even if you do it right, there's
a race condition, and checking the trailer sha1 at least lets us know
that they don't match (I assume we just reject the index, then; I guess
this can result in an operation failing, but in practice it doesn't
really happen, as we don't bother packing unless there are actually new
objects).

-Peff
