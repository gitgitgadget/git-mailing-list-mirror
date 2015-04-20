From: Jeff King <peff@peff.net>
Subject: Re: [BUG] Performance regression due to #33d4221: write_sha1_file:
 freshen existing objects
Date: Mon, 20 Apr 2015 15:53:38 -0400
Message-ID: <20150420195337.GA15447@peff.net>
References: <CADoxLGPYOkgzb4bkdHq5tK0aJS2M=nWGzO=YYXPDcy-gh45q-g@mail.gmail.com>
 <20150417140315.GA13506@peff.net>
 <CADoxLGOPXDgb0LBcSBm+xRDhbnGV_y-TXENyPV7oK_+KZzPKRQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Stefan Saasen <ssaasen@atlassian.com>
X-From: git-owner@vger.kernel.org Mon Apr 20 21:53:46 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YkHlJ-0002bg-TN
	for gcvg-git-2@plane.gmane.org; Mon, 20 Apr 2015 21:53:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752317AbbDTTxl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Apr 2015 15:53:41 -0400
Received: from cloud.peff.net ([50.56.180.127]:47782 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750872AbbDTTxk (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Apr 2015 15:53:40 -0400
Received: (qmail 8848 invoked by uid 102); 20 Apr 2015 19:53:40 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 20 Apr 2015 14:53:40 -0500
Received: (qmail 27938 invoked by uid 107); 20 Apr 2015 19:54:06 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 20 Apr 2015 15:54:06 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 20 Apr 2015 15:53:38 -0400
Content-Disposition: inline
In-Reply-To: <CADoxLGOPXDgb0LBcSBm+xRDhbnGV_y-TXENyPV7oK_+KZzPKRQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267493>

On Sat, Apr 18, 2015 at 01:35:51PM +1000, Stefan Saasen wrote:

> Here are the timings for the two patches:
> [...]

Thanks, that matches what I was hoping for.

> My tweaked version of your second patch is:
> [...]
> -       return find_pack_entry(sha1, &e) && freshen_file(e.p->pack_name);
> +       if (!find_pack_entry(sha1, &e))
> +              return 0;
> +       if (e.p->freshened)
> +              return 1;
> +       return e.p->freshened = freshen_file(e.p->pack_name);
>  }

Whooops, yeah, setting the flag is probably helpful. :)

We usually try to avoid assignments in a return like this, so I've
written it out a little more verbosely in my final version. I'll send
those patches in a moment.

  [1/2]: sha1_file: freshen pack objects before loose
  [2/2]: sha1_file: only freshen packs once per run

> Is there a chance to backport those changes to the 2.2+ branches?

That's up to Junio. These patches can be applied straight to the
jk/prune-mtime topic. Usually he would then merge the topic up to
"maint", which at this would potentially become the next v2.3.x. If an
issue is critical (e.g., a security vulnerability), he'll sometimes
merge and roll maintenance releases for older versions. But I don't know
if this counts as critical (it is for you, certainly, but I don't think
that many people are affected, as the crucial factor here is really the
slow NFS filesystem operations).

-Peff
