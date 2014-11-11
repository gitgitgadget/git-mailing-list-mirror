From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 1/2] Clean stale environment pointer in
 finish_command()
Date: Mon, 10 Nov 2014 22:16:36 -0500
Message-ID: <20141111031636.GE21328@peff.net>
References: <cover.1415368490.git.johannes.schindelin@gmx.de>
 <cover.1415630072.git.johannes.schindelin@gmx.de>
 <df1b16208e443416f7185c8c8c110e637ea97ac4.1415630072.git.johannes.schindelin@gmx.de>
 <alpine.DEB.1.00.1411101539091.13845@s15462909.onlinehome-server.info>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: gitster@pobox.com, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Nov 11 04:16:44 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xo1wh-00016O-JO
	for gcvg-git-2@plane.gmane.org; Tue, 11 Nov 2014 04:16:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751537AbaKKDQj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Nov 2014 22:16:39 -0500
Received: from cloud.peff.net ([50.56.180.127]:38975 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751221AbaKKDQi (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Nov 2014 22:16:38 -0500
Received: (qmail 8253 invoked by uid 102); 11 Nov 2014 03:16:39 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 10 Nov 2014 21:16:39 -0600
Received: (qmail 14382 invoked by uid 107); 11 Nov 2014 03:16:48 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 10 Nov 2014 22:16:48 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 10 Nov 2014 22:16:36 -0500
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.00.1411101539091.13845@s15462909.onlinehome-server.info>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Nov 10, 2014 at 03:41:09PM +0100, Johannes Schindelin wrote:

> > However, start_command() will set "env" to env_array.argv only if "env"
> > was unset to begin with, and if it was already set, the caller will need
> > the original value. Therefore, we need to be very careful only to reset
> > "env" in finish_command() when it has been initialized in start_command().
> 
> In case it was unclear: this is needed for the the suggested switch from the
> previous method to construct the environment to the new env_array method
> to work.
> 
> (The env_array method unfortunately requires the code to initialize the
> environment twice because finish_command() insists on always releasing the
> env_array, even if the caller may want to reuse the generated array).

I don't think this is "unfortunately"; freeing the memory was the entire
purpose in adding env_array. If you want to easily reuse the same
environment in multiple commands, it is still perfectly fine to use
"env" directly, like:

  struct argv_array env = ARGV_ARRAY_INIT;
  struct child_process one = CHILD_PROCESS_INIT;
  struct child_process two = CHILD_PROCESS_INIT;

  ... setup env with argv_array_push ...

  one.argv = foo;
  one.env = env.argv;
  run_command(&one);

  two.argv = bar;
  two.env = env.argv;
  run_command(&two);

  argv_array_clear(&env);

You do not get the benefit of the auto-cleanup (you have to call
argv_array_clear yourself), but that is less bad than repeating the
setup of "env" twice.

It may be that Documentation/technical/api-run-command.txt needs to
make this more explicit (I just read over it and it looks OK to me. But
since I am the one who designed the feature, I am not the best test of
whether it is sufficiently clear).

-Peff
