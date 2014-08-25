From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] bisect: save heap memory. allocate only the required
 amount
Date: Mon, 25 Aug 2014 11:00:28 -0400
Message-ID: <20140825150028.GA28176@peff.net>
References: <1408889844-5407-1-git-send-email-arjun024@gmail.com>
 <20140825133550.GE17288@peff.net>
 <CAP8UFD2FAfg5GenJXOkOsjU9vmCO3R3Difp6-mrP_cp4zXQENg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Arjun Sreedharan <arjun024@gmail.com>, git <git@vger.kernel.org>,
	Christian Couder <chriscool@tuxfamily.org>,
	Junio C Hamano <gitster@pobox.com>,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= <pclouds@gmail.com>
To: Christian Couder <christian.couder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 25 17:00:41 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XLvl9-00034y-5e
	for gcvg-git-2@plane.gmane.org; Mon, 25 Aug 2014 17:00:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754634AbaHYPAc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Aug 2014 11:00:32 -0400
Received: from cloud.peff.net ([50.56.180.127]:58442 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754548AbaHYPAa (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Aug 2014 11:00:30 -0400
Received: (qmail 16611 invoked by uid 102); 25 Aug 2014 15:00:30 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 25 Aug 2014 10:00:30 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 25 Aug 2014 11:00:28 -0400
Content-Disposition: inline
In-Reply-To: <CAP8UFD2FAfg5GenJXOkOsjU9vmCO3R3Difp6-mrP_cp4zXQENg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255829>

On Mon, Aug 25, 2014 at 04:06:52PM +0200, Christian Couder wrote:

> > This allocation should be name_len + 1 for the NUL-terminator, no?
> 
> I wondered about that too, but as struct name_decoration is defined like this:
> 
> struct name_decoration {
>         struct name_decoration *next;
>         int type;
>         char name[1];
> };
> 
> the .name field of this struct already has one char, so the allocation
> above should be ok.

Yeah, you're right. I would argue it should just be FLEX_ARRAY for
consistency with other spots, though (in which case add_name_decoration
needs to be updated with a +1).

Running "git grep '^	char [^ ]*\[[01]]' -- '*.[ch]'" shows that this
is one of only two spots that don't use FLEX_ARRAY (and the other has a
comment explaining why not).

-Peff
