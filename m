From: Jeff King <peff@peff.net>
Subject: Re: [RFC/WIP PATCH 04/11] upload-pack-2: Implement the version 2 of
 upload-pack
Date: Wed, 27 May 2015 16:14:33 -0400
Message-ID: <20150527201433.GB14309@peff.net>
References: <1432677675-5118-1-git-send-email-sbeller@google.com>
 <1432677675-5118-5-git-send-email-sbeller@google.com>
 <20150527063558.GB885@peff.net>
 <CAPig+cSFEN+V0668FPDM1jY2KdW_nVaEn7+AOWJj_KwUU_UVPw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Stefan Beller <sbeller@google.com>, Git List <git@vger.kernel.org>,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Wed May 27 22:14:43 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yxhir-0002j3-7s
	for gcvg-git-2@plane.gmane.org; Wed, 27 May 2015 22:14:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752137AbbE0UOg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 May 2015 16:14:36 -0400
Received: from cloud.peff.net ([50.56.180.127]:36823 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752035AbbE0UOg (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 May 2015 16:14:36 -0400
Received: (qmail 11209 invoked by uid 102); 27 May 2015 20:14:35 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 27 May 2015 15:14:35 -0500
Received: (qmail 10078 invoked by uid 107); 27 May 2015 20:14:40 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 27 May 2015 16:14:40 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 27 May 2015 16:14:33 -0400
Content-Disposition: inline
In-Reply-To: <CAPig+cSFEN+V0668FPDM1jY2KdW_nVaEn7+AOWJj_KwUU_UVPw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270081>

On Wed, May 27, 2015 at 01:30:28PM -0400, Eric Sunshine wrote:

> > Like Eric, I find the whole next_capability thing a little ugly. His
> > suggestion to pass in the parsing state is an improvement, but I wonder
> > why we need to parse at all. Can we keep the capabilities as:
> >
> >   const char *capabilities[] = {
> >         "multi_ack",
> >         "thin-pack",
> >         ... etc ...
> >   };
> >
> > and then loop over the array?
> 
> Yes, that would be much nicer. I also had this in mind but didn't know
> if there was a strong reason for the capabilities to be shoehorned
> into a single string as they are currently.

I don't think there is a good reason, beyond it being the simplest thing
for the current code to work. But as you can see from the existing
packet_write() in upload-pack, it's already going through some
contortions to handle optional capabilities (i.e., "capabilities" is by
no means the full list anymore).

Doing it item by item will mean we can't use a single packet_write() in
the v1 code, but it's OK to format into a buffer here (we already need
such a buffer for format_symref_info anyway).

-Peff
