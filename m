From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v3 1/4] replace: add --graft option
Date: Sun, 8 Jun 2014 08:09:36 -0400
Message-ID: <20140608120936.GB21827@sigill.intra.peff.net>
References: <20140604194118.23903.3019.chriscool@tuxfamily.org>
 <20140604194353.23903.89933.chriscool@tuxfamily.org>
 <xmqqfvjjrpq9.fsf@gitster.dls.corp.google.com>
 <CAP8UFD3k98_6Uh+noJgt4xqEooATVMAEf58FFkuy6rHBnP10zw@mail.gmail.com>
 <CAP8UFD2u-DReCv2ZXhAzH_UMW5P--+a=AKS-N88xE6zmdWBLqQ@mail.gmail.com>
 <CAP8UFD344NFECqtO-uK-2wHA7XEko3XMJWuhW9+KGBdaiqGq+w@mail.gmail.com>
 <20140608112333.GA9691@sigill.intra.peff.net>
 <20140608120439.GA21827@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	git <git@vger.kernel.org>, Jakub Narebski <jnareb@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Christian Couder <christian.couder@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jun 08 14:35:59 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wtbuw-0002sM-Sj
	for gcvg-git-2@plane.gmane.org; Sun, 08 Jun 2014 14:09:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753527AbaFHMJj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Jun 2014 08:09:39 -0400
Received: from cloud.peff.net ([50.56.180.127]:39725 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753313AbaFHMJi (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Jun 2014 08:09:38 -0400
Received: (qmail 26721 invoked by uid 102); 8 Jun 2014 12:09:38 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sun, 08 Jun 2014 07:09:38 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 08 Jun 2014 08:09:36 -0400
Content-Disposition: inline
In-Reply-To: <20140608120439.GA21827@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251056>

On Sun, Jun 08, 2014 at 08:04:39AM -0400, Jeff King wrote:

> diff --git a/builtin/blame.c b/builtin/blame.c
> index a52a279..1945ea4 100644
> --- a/builtin/blame.c
> +++ b/builtin/blame.c
> @@ -2313,7 +2313,7 @@ static struct commit *fake_working_tree_commit(struct diff_options *opt,
>  		    ident, ident, path,
>  		    (!contents_from ? path :
>  		     (!strcmp(contents_from, "-") ? "standard input" : contents_from)));
> -	commit->buffer = strbuf_detach(&msg, NULL);
> +	set_commit_buffer(commit, strbuf_detach(&msg, NULL), msg.len);

Side note: this is wrong, as the fake commit created by blame here does
not have its "index" field set. This is a bug waiting to happen the
first time somebody uses a slab in builtin/blame.c. It looks like
merge-recursive does the same thing in make_virtual_commit.

We probably want to provide a function to allocate a commit, including
the index, and use it consistently.

I'll try to work up a series doing that, and the fuller slab API I
mentioned in the previous message, but probably not until tomorrow.

-Peff
