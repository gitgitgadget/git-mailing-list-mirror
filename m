From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] commit: ensure correct permissions of the commit message
Date: Mon, 21 Dec 2015 01:59:44 -0500
Message-ID: <20151221065944.GA3550@sigill.intra.peff.net>
References: <4aa11f02f4de113bf38152b8815658da42690f43.1450549280.git.johannes.schindelin@gmx.de>
 <20151220074559.GF30662@sigill.intra.peff.net>
 <xmqq7fk8io3f.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
	git@vger.kernel.org, Yaroslav Halchenko <yoh@onerussian.com>,
	SZEDER =?utf-8?B?R8OhYm9y?= <szeder@ira.uka.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Dec 21 07:59:53 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aAuRj-0005S8-Hq
	for gcvg-git-2@plane.gmane.org; Mon, 21 Dec 2015 07:59:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750931AbbLUG7r (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Dec 2015 01:59:47 -0500
Received: from cloud.peff.net ([50.56.180.127]:44797 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750835AbbLUG7r (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Dec 2015 01:59:47 -0500
Received: (qmail 32314 invoked by uid 102); 21 Dec 2015 06:59:47 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 21 Dec 2015 00:59:47 -0600
Received: (qmail 18509 invoked by uid 107); 21 Dec 2015 06:59:56 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 21 Dec 2015 01:59:56 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 21 Dec 2015 01:59:44 -0500
Content-Disposition: inline
In-Reply-To: <xmqq7fk8io3f.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282785>

On Sun, Dec 20, 2015 at 05:31:48PM -0800, Junio C Hamano wrote:

> Actually, we do not even _need_ a sharedness for this ephemeral
> file.  The additional "adjust-shared-perm" is merely a workaround
> for the fact the next person cannot write into it when it is left
> behind, and because we do not want to remove it when we are done.
> 
> That does not measn that the next person cannot remove it when she
> finds there is a file there left behind.  So alternatively, we could
> do something like this, perhaps?
> 
>         FILE *fopen_forcibly(const char *path, const char *mode)
>         {
>                 FILE *ret = fopen(path, mode);
> 
>                 if (!ret && errno == EPERM) {
>                         if (!unlink(path))
>                                 ret = fopen(path, mode);
>                         else
>                                 errno = EPERM;
>                 }
>                 return ret;
>         }

Yeah, I think that is a much nicer solution for this case. It should
work even in a shared repo, since we set the permissions for the
surrounding $GIT_DIR appropriately[1].

I guess it would not apply to any files that do not want to truncate the
existing contents. Probably it should drop the "mode" parameter at all,
since anything but "w" would be crazy?

-Peff

[1] Assuming you use something like "git init --shared=true". I would
    not be surprised if there are many repos where somebody just set
    "core.sharedrepository" after the fact, but there is not much we can
    do. They _have_ to fix up the permissions in that case.
