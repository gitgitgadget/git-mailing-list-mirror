From: Jeff King <peff@peff.net>
Subject: [PATCH 0/2] reset -p and unborn branches
Date: Fri, 25 Oct 2013 02:51:17 -0400
Message-ID: <20131025065117.GA15192@sigill.intra.peff.net>
References: <CAPWpf+wi0zH2sOnuqiZuKkf+kC0RMug_ASb-J-TGGLd2RFT1wg@mail.gmail.com>
 <CAPWpf+xqutvhq1jyVkxr6LyKsANTCS6M=vj5XY=EgUfiS3Z8xg@mail.gmail.com>
 <CAPWpf+x5KUjD2K81pJAsV_XuPkd=BT06qPjvr8s7tEe5YqBt=w@mail.gmail.com>
 <CAPWpf+zkA68pzR3qx5xma8BNiONwt5o8iNba0x8fmmiDAWpHuw@mail.gmail.com>
 <xmqqvc0mj9wi.fsf_-_@gitster.dls.corp.google.com>
 <20131025042421.GB11810@sigill.intra.peff.net>
 <CANiSa6iYLp-iNdcv_qbFTitrfFxaDBVUy9YyUAF4QKM+-35P4A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Maarten de Vries <maarten@de-vri.es>,
	git mailing list <git@vger.kernel.org>
To: Martin von Zweigbergk <martinvonz@gmail.com>
X-From: git-owner@vger.kernel.org Fri Oct 25 08:51:26 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VZbEz-0002bg-6e
	for gcvg-git-2@plane.gmane.org; Fri, 25 Oct 2013 08:51:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751426Ab3JYGvV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Oct 2013 02:51:21 -0400
Received: from cloud.peff.net ([50.56.180.127]:55358 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751168Ab3JYGvU (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Oct 2013 02:51:20 -0400
Received: (qmail 5705 invoked by uid 102); 25 Oct 2013 06:51:20 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 25 Oct 2013 01:51:20 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 25 Oct 2013 02:51:17 -0400
Content-Disposition: inline
In-Reply-To: <CANiSa6iYLp-iNdcv_qbFTitrfFxaDBVUy9YyUAF4QKM+-35P4A@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236684>

On Thu, Oct 24, 2013 at 10:42:52PM -0700, Martin von Zweigbergk wrote:

> > I think that's the correct fix for the regression.  You are restoring
> > the original, pre-166ec2e9 behavior for just the HEAD case. I do not
> > think add--interactive does any other magic between a symbolic rev and
> > its sha1, except for recognizing HEAD specially. However, if you wanted
> > to minimize the potential impact of 166ec2e9, you could pass the sha1
> > _only_ in the unborn case, like this:
> 
> Plus, the end result is more readable, IMHO.

Agreed. Unfortunately it is slightly wrong, because for the non-patch
cases, we may look at "rev" later, and we would want it to still say
"HEAD" rather than a sha1. This is fixed in my patches below.

> >   1. Pass the head/not-head flag as a separate option.
> >
> >   2. Pass HEAD even in the unborn case; teach add--interactive to
> >      convert an unborn HEAD to the empty tree.
> >
> >   3. Teach add--interactive to recognize the empty tree sha1 as an
> >      "unstage" path.
> [...]
> Makes sense to me. I'm sure others can implement that much faster than
> I can, but I feel a little guilty, so I'm happy to do it if no one
> else wants to, as long as we agree this is the way we want to go.

As it turns out, add--interactive already _does_ know how to handle an
unborn HEAD. It just didn't use it for this particular code path. So I
think doing (2) makes the most sense, and the result is that the patch
in reset.c ends up nice and simple.

  [1/2]: add-interactive: handle unborn branch in patch mode
  [2/2]: reset: pass real rev name to add--interactive

-Peff
