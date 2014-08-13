From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] pack-objects: turn off bitmaps when we see --shallow
 lines
Date: Wed, 13 Aug 2014 01:09:36 -0400
Message-ID: <20140813050935.GA21559@peff.net>
References: <20140812043452.GA11784@peff.net>
 <CACsJy8AQ4vC4QKR_y62h_Gjd619QfBg-rDB2F6HFj2fvJj41tg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 13 07:09:52 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XHQoq-0005P6-3Z
	for gcvg-git-2@plane.gmane.org; Wed, 13 Aug 2014 07:09:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751271AbaHMFJr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Aug 2014 01:09:47 -0400
Received: from cloud.peff.net ([50.56.180.127]:51147 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750742AbaHMFJp (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Aug 2014 01:09:45 -0400
Received: (qmail 14775 invoked by uid 102); 13 Aug 2014 05:09:45 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (204.237.18.137)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 13 Aug 2014 00:09:45 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 13 Aug 2014 01:09:36 -0400
Content-Disposition: inline
In-Reply-To: <CACsJy8AQ4vC4QKR_y62h_Gjd619QfBg-rDB2F6HFj2fvJj41tg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255184>

On Tue, Aug 12, 2014 at 10:13:03PM +0700, Duy Nguyen wrote:

> On Tue, Aug 12, 2014 at 11:34 AM, Jeff King <peff@peff.net> wrote:
> > Arguably is_repository_shallow should return 1 if anybody has registered
> > a shallow graft, but that wouldn't be enough to fix this (we'd still
> > need to check it again _after_ reading the --shallow lines). So I think
> > this fix is fine here. I don't know if any other parts of the code would
> > care, though.
> 
> It's getting too subtle (is_repository_shallow fails to return 1).
> register_shallow() is used elsewhere too, luckily pack bitmap's use is
> still limited in pack-objects (I think).

It is, though I have some patches in the works to use it in more places.

I was tempted to make a check in prepare_bitmap_walk() to just return -1
(the same as if there are no bitmaps at all) if any commit grafts are in
use. That would also catch new callers. But the graft (and replace)
rules are not always the same. We should not respect those features when
packing or pruning (though I think pruning _does_ currently respect
grafts, which seems like an accident waiting to happen).

I think this is a good minimal fix for now, but I'll revisit the
replace/graft/shallow issues when I add more bitmap users outside of
pack-objects.

> I prefer (in future) to teach is_repository_shallow about
> register_shallow and move it to right before
> get_object_list_from_bitmap() is called, and some sort of mechanism to
> say "hey I'm all set, never change shallow repo status again from now
> on, or just die if you have to do it" to protect us from similar bugs.
> But for now your fix is good (and simple).

Yeah, that sounds like a good direction for the shallow part of it.

-Peff
