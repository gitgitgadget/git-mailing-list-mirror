From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/3] gpg: Close stderr once finished with it in
 verify_signed_buffer()
Date: Thu, 31 Jan 2013 00:50:53 -0500
Message-ID: <20130131055053.GA11912@sigill.intra.peff.net>
References: <1359597666-10108-1-git-send-email-sboyd@codeaurora.org>
 <1359597666-10108-2-git-send-email-sboyd@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Stephen Boyd <sboyd@codeaurora.org>
X-From: git-owner@vger.kernel.org Thu Jan 31 06:51:27 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U0n3U-0006CG-NP
	for gcvg-git-2@plane.gmane.org; Thu, 31 Jan 2013 06:51:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751375Ab3AaFu5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Jan 2013 00:50:57 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:54420 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750921Ab3AaFu4 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Jan 2013 00:50:56 -0500
Received: (qmail 3478 invoked by uid 107); 31 Jan 2013 05:52:19 -0000
Received: from c-71-206-173-132.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.206.173.132)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 31 Jan 2013 00:52:19 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 31 Jan 2013 00:50:53 -0500
Content-Disposition: inline
In-Reply-To: <1359597666-10108-2-git-send-email-sboyd@codeaurora.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215091>

On Wed, Jan 30, 2013 at 06:01:04PM -0800, Stephen Boyd wrote:

> Failing to close the stderr pipe in verify_signed_buffer() causes
> git to run out of file descriptors if there are many calls to
> verify_signed_buffer(). An easy way to trigger this is to run
> 
>  git log --show-signature --merges | grep "key"
> 
> on the linux kernel git repo. Eventually it will fail with
> 
>  error: cannot create pipe for gpg: Too many open files
>  error: could not run gpg.
> 
> Close the stderr pipe so that this can't happen.

I was able to easily reproduce the bug and verify your fix here.

> diff --git a/gpg-interface.c b/gpg-interface.c
> index 0863c61..2c0bed3 100644
> --- a/gpg-interface.c
> +++ b/gpg-interface.c
> @@ -133,6 +133,8 @@ int verify_signed_buffer(const char *payload, size_t payload_size,
>  	if (gpg_output)
>  		strbuf_read(gpg_output, gpg.err, 0);
>  	ret = finish_command(&gpg);
> +	if (gpg_output)
> +		close(gpg.err);

The strbuf_read above will read to EOF, so it should be equivalent (and
IMHO slightly more readable) to do:

diff --git a/gpg-interface.c b/gpg-interface.c
index 0863c61..5f142f6 100644
--- a/gpg-interface.c
+++ b/gpg-interface.c
@@ -130,8 +130,10 @@ int verify_signed_buffer(const char *payload, size_t payload_size,
 	write_in_full(gpg.in, payload, payload_size);
 	close(gpg.in);
 
-	if (gpg_output)
+	if (gpg_output) {
 		strbuf_read(gpg_output, gpg.err, 0);
+		close(gpg.err);
+	}
 	ret = finish_command(&gpg);
 
 	unlink_or_warn(path);

But that is a minor nit; either way, the patch looks good to me.

-Peff
