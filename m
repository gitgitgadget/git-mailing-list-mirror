From: Jeff King <peff@peff.net>
Subject: Re: [bug in next ?] git-fetch/git-push issue
Date: Mon, 5 Nov 2007 16:07:12 -0500
Message-ID: <20071105210711.GA9176@sigill.intra.peff.net>
References: <20071105175654.GD6205@artemis.corp> <Pine.LNX.4.64.0711051259580.7357@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Pierre Habouzit <madcoder@debian.org>,
	Nicolas Pitre <nico@cam.org>, Git ML <git@vger.kernel.org>
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Mon Nov 05 22:07:42 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ip9AS-00050G-RQ
	for gcvg-git-2@gmane.org; Mon, 05 Nov 2007 22:07:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753879AbXKEVHR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Nov 2007 16:07:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753110AbXKEVHR
	(ORCPT <rfc822;git-outgoing>); Mon, 5 Nov 2007 16:07:17 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:3020 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751938AbXKEVHQ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Nov 2007 16:07:16 -0500
Received: (qmail 25067 invoked by uid 111); 5 Nov 2007 21:07:13 -0000
Received: from c-24-125-35-113.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (24.125.35.113)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Mon, 05 Nov 2007 16:07:13 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 05 Nov 2007 16:07:12 -0500
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0711051259580.7357@iabervon.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63550>

On Mon, Nov 05, 2007 at 01:17:14PM -0500, Daniel Barkalow wrote:

> I think this is the bit that's wrong. I blame Jeff, in 334f4831. :)
> 
> The issue is that, in the previous version, we'd hit a continue on the 
> not-an-ancestor message and not reach the update_tracking_ref() section 
> for that ref. In 334f4831, all of the updating is after the loop, and it 
> doesn't filter out the refs that didn't actually get pushed.

Nope, that's not the problem. We _only_ update any tracking refs at all
if ret == 0, and if we fail to push, then we are setting ret to -2.

Hrm. Oh wait, it looks like we then totally write over the current value
of 'ret' when we do pack_objects. Oops.

I'm unclear how to fix this, as I'm not really sure what ret is
_supposed_ to be communicating. What does the '-2' mean, as compared to
a '-4'? Should we be doing a 'ret += pack_objects(out, remote_refs)' or
some other bit-masking magic?

-Peff
