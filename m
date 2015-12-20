From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] commit: ensure correct permissions of the commit message
Date: Sun, 20 Dec 2015 02:45:59 -0500
Message-ID: <20151220074559.GF30662@sigill.intra.peff.net>
References: <4aa11f02f4de113bf38152b8815658da42690f43.1450549280.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Yaroslav Halchenko <yoh@onerussian.com>,
	SZEDER =?utf-8?B?R8OhYm9y?= <szeder@ira.uka.de>
To: Johannes Schindelin <johannes.schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sun Dec 20 08:46:08 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aAYgx-0001Vf-TO
	for gcvg-git-2@plane.gmane.org; Sun, 20 Dec 2015 08:46:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932104AbbLTHqD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 20 Dec 2015 02:46:03 -0500
Received: from cloud.peff.net ([50.56.180.127]:44658 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754115AbbLTHqC (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Dec 2015 02:46:02 -0500
Received: (qmail 21761 invoked by uid 102); 20 Dec 2015 07:46:02 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Sun, 20 Dec 2015 01:46:02 -0600
Received: (qmail 11287 invoked by uid 107); 20 Dec 2015 07:46:10 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Sun, 20 Dec 2015 02:46:10 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 20 Dec 2015 02:45:59 -0500
Content-Disposition: inline
In-Reply-To: <4aa11f02f4de113bf38152b8815658da42690f43.1450549280.git.johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282763>

On Sat, Dec 19, 2015 at 07:21:59PM +0100, Johannes Schindelin wrote:

> It was pointed out by Yaroslav Halchenko that the file containing the
> commit message had the wrong permissions in a shared setting.
> 
> Let's fix that.
> 
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>

I think this is probably a step forward, but I have to wonder how many
other files are in a similar situation (e.g., git-am state files, etc).
I think people generally haven't noticed because shared repositories are
generally about a shared bare rendezvous repo. So refs and objects are
important, but we don't expect people to commit.

So I don't have any real problem with this, but I suspect it's just the
tip of the iceberg. We might want something like:

  FILE *fopen_shared(const char *path, const char *mode)
  {
	FILE *ret = fopen(path, mode);
	if (!ret)
		return NULL;
	if (adjust_shared_perm(path)) {
		fclose(ret);
		return NULL;
	}
	return ret;
  }

but of course the hard part is auditing all of the existing fopen()
calls to see who needs to use it. :)

-Peff
