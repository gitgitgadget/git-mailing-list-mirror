From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v4] transport-helper: report errors properly
Date: Mon, 8 Apr 2013 15:28:29 -0400
Message-ID: <20130408192829.GC7337@sigill.intra.peff.net>
References: <1365432004-20132-1-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Sverre Rabbelier <srabbelier@gmail.com>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 08 21:28:40 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UPHk7-00083g-RB
	for gcvg-git-2@plane.gmane.org; Mon, 08 Apr 2013 21:28:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935718Ab3DHT2f (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Apr 2013 15:28:35 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:34164 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S935713Ab3DHT2e (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Apr 2013 15:28:34 -0400
Received: (qmail 14360 invoked by uid 107); 8 Apr 2013 19:30:25 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 08 Apr 2013 15:30:25 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 08 Apr 2013 15:28:29 -0400
Content-Disposition: inline
In-Reply-To: <1365432004-20132-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220500>

On Mon, Apr 08, 2013 at 09:40:04AM -0500, Felipe Contreras wrote:

> If a push fails because the remote-helper died (with fast-export), the
> user won't see any error message. So let's add one.
> 
> At the same time lets add tests to ensure this error is reported, and
> while we are at it, check the error from fast-import

Thanks, I think this patch is definitely the right direction.

It seems like there is a lot of back-story that had to be clarified
during the review/discussion. Is there a reason not to summarize it here
so later readers of this commit are enlightened?

I'm thinking something like:

  If a push fails because the remote-helper died (with fast-export), the
  user does not see any error message. We do correctly die with a failed
  exit code, as we notice that the helper has died while reading back
  the ref status from the helper. However, we don't print any message.
  This is OK if the helper itself printed a useful error message, but we
  cannot count on that; let's let the user know that the helper failed.

  In the long run, it may make more sense to propagate the error back up
  to push, so that it can present the usual status table and give a
  nicer message. But this is a much simpler fix that can help
  immediately.

  While we're adding tests, let's also confirm that the remote-helper
  dying is also detect when importing refs. We currently do so robustly
  when the helper uses the "done" feature (and that is what we test). We
  cannot do so reliably when the helper does not use the "done" feature,
  but it is not even worth testing; the right solution is for the helper
  to start using "done".

>  	export)
> +		if test -n "$GIT_REMOTE_TESTGIT_FAILURE"
> +		then
> +			sleep 1 # don't let fast-export get SIGPIPE
> +			exit 1
> +		fi

We can do away with this sleep with:

  while read line; do
          test "$line" = "done" && break
  done

The version I posted yesterday had both the read and the sleep, but the
sleep was only necessary there to demonstrate the race with
check_command.

> +# We sleep to give fast-export a chance to catch the SIGPIPE
> +test_expect_success 'proper failure checks for pushing' '

I think we can drop this comment now, right?

-Peff
