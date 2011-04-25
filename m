From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/2] send-pack: avoid deadlock when pack-object dies early
Date: Mon, 25 Apr 2011 12:50:07 -0400
Message-ID: <20110425165007.GB1589@sigill.intra.peff.net>
References: <20110331184243.GA12027@sigill.intra.peff.net>
 <201104142136.25778.j6t@kdbg.org>
 <20110414202110.GA6525@sigill.intra.peff.net>
 <201104142243.33522.j6t@kdbg.org>
 <20110414205113.GA7451@sigill.intra.peff.net>
 <7vsjtkfs10.fsf@alter.siamese.dyndns.org>
 <4DB48B2C.2090904@kdbg.org>
 <4DB48CCD.40304@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Mon Apr 25 18:50:34 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QEOzZ-0003Lk-Va
	for gcvg-git-2@lo.gmane.org; Mon, 25 Apr 2011 18:50:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755070Ab1DYQuM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Apr 2011 12:50:12 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:59439
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752526Ab1DYQuL (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Apr 2011 12:50:11 -0400
Received: (qmail 10757 invoked by uid 107); 25 Apr 2011 16:51:51 -0000
Received: from c-67-172-212-47.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (67.172.212.47)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 25 Apr 2011 12:51:51 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 25 Apr 2011 12:50:07 -0400
Content-Disposition: inline
In-Reply-To: <4DB48CCD.40304@kdbg.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172031>

On Sun, Apr 24, 2011 at 10:49:17PM +0200, Johannes Sixt wrote:

> diff --git a/builtin-send-pack.c b/builtin-send-pack.c
> index 089058b..b371c79 100644
> --- a/builtin-send-pack.c
> +++ b/builtin-send-pack.c
> @@ -376,6 +376,9 @@ static void print_helper_status(struct ref *ref)
>  static int sideband_demux(int in, int out, void *data)
>  {
>  	int *fd = data;
> +#ifndef ASYNC_AS_THREAD
> +	close(fd[1]);
> +#endif

In the comments for 1/2, you said this goes directly on 38a81b4e. But in
that commit, we use #ifndef WIN32 to decide whether or not to fork for
async code. So shouldn't this use the same test (I don't even see
ASYNC_AS_THREAD defined anywhere else)?

And of course in more modern versions, it should be NO_PTHREADS, as you
noted.

-Peff
