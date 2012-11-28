From: Jeff King <peff@peff.net>
Subject: Re: Query for certain branches, but not the rest
Date: Tue, 27 Nov 2012 20:57:14 -0500
Message-ID: <20121128015714.GB23776@sigill.intra.peff.net>
References: <CAMP44s02=E3imOv00dwyXR13nQdo1XeZTjJb_y0EVQoyYMEcQw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Wed Nov 28 02:57:34 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TdWu4-0001Fx-Dn
	for gcvg-git-2@plane.gmane.org; Wed, 28 Nov 2012 02:57:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750961Ab2K1B5R (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Nov 2012 20:57:17 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:58849 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750776Ab2K1B5R (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Nov 2012 20:57:17 -0500
Received: (qmail 32470 invoked by uid 107); 28 Nov 2012 01:58:12 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 27 Nov 2012 20:58:12 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 27 Nov 2012 20:57:14 -0500
Content-Disposition: inline
In-Reply-To: <CAMP44s02=E3imOv00dwyXR13nQdo1XeZTjJb_y0EVQoyYMEcQw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210664>

On Sun, Nov 25, 2012 at 10:24:59AM +0100, Felipe Contreras wrote:

> Suppose I have these branches:
> 
>   fc/feature-a
>   fc/feature-b
>   master
>   next
> 
> I want to show this: fc/feature-a fc/feature-b ^master ^next. I can do
> 'git log --branches=fc' to show the branches that begin with fc/, but
> there's no way to specify the rest. If they were under a prefix, I
> could do '--not --branches=prefix', but they are not.
> 
> Anybody knows a way to query branches that don't have any prefix?

I don't think there is a way. `--branches` can take a pattern (and there
is always `--glob`), but we do not pass FNM_PATHNAME to fnmatch, so "*"
will match across `/` boundaries.

You are stuck with:

  git log --branches=fc --not $(
    git for-each-ref --format='%(refname:short)' refs/heads |
    grep -v /
  )

which is at least robust due to the restrictions on refnames (i.e., no
whitespace).

As an aside, I noticed that:

  git log --branches=does-not-exist

will see that we matched no refs and fall back to showing HEAD. That
seems a bit surprising to me.

-Peff
