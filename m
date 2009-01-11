From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/4] chain kill signals for cleanup functions
Date: Sun, 11 Jan 2009 06:40:32 -0500
Message-ID: <20090111114032.GA30032@coredump.intra.peff.net>
References: <20090111112222.GA29656@coredump.intra.peff.net> <20090111113211.GB29791@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Sun Jan 11 12:41:59 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LLyha-0003Mn-6B
	for gcvg-git-2@gmane.org; Sun, 11 Jan 2009 12:41:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751343AbZAKLkf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 Jan 2009 06:40:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751221AbZAKLkf
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Jan 2009 06:40:35 -0500
Received: from peff.net ([208.65.91.99]:59049 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750938AbZAKLke (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Jan 2009 06:40:34 -0500
Received: (qmail 22832 invoked by uid 107); 11 Jan 2009 11:40:34 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Sun, 11 Jan 2009 06:40:34 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sun, 11 Jan 2009 06:40:32 -0500
Content-Disposition: inline
In-Reply-To: <20090111113211.GB29791@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105171>

On Sun, Jan 11, 2009 at 06:32:12AM -0500, Jeff King wrote:

> @@ -1968,7 +1969,7 @@ static void run_external_diff(const char *pgm,
>  			atexit_asked = 1;
>  			atexit(remove_tempfile);
>  		}
> -		signal(SIGINT, remove_tempfile_on_signal);
> +		sigchain_push(SIGINT, remove_tempfile_on_signal);

Hmm.

Note that because we are now pushing instead of just replacing the
signal handler, it might matter if it gets called multiple times (though
I think most of the cleanup functions are relatively harmless if run
multiple times). Most of the callsites protect against installing the
signal handler twice, but I think this one should probably be moved up
inside the atexit_asked condition:

  if (! atexit_asked &&
      (temp[0].name == temp[0].tmp_path ||
       temp[1].name == temp[1].tmp_path)) {
          atexit_asked = 1;
          atexit(remove_tempfile);
  }
  sigchain_push_common(remove_tempfile_on_signal);

-Peff
