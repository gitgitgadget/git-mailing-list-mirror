From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] drop unnecessary copying in credential_ask_one
Date: Wed, 1 Jan 2014 22:03:30 -0500
Message-ID: <20140102030330.GA10976@sigill.intra.peff.net>
References: <1388624793-5563-1-git-send-email-rctay89@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Tay Ray Chuan <rctay89@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jan 02 04:03:38 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VyYZN-0008Vw-Nl
	for gcvg-git-2@plane.gmane.org; Thu, 02 Jan 2014 04:03:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751268AbaABDDd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Jan 2014 22:03:33 -0500
Received: from cloud.peff.net ([50.56.180.127]:53693 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750896AbaABDDd (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Jan 2014 22:03:33 -0500
Received: (qmail 23039 invoked by uid 102); 2 Jan 2014 03:03:33 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 01 Jan 2014 21:03:32 -0600
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 01 Jan 2014 22:03:30 -0500
Content-Disposition: inline
In-Reply-To: <1388624793-5563-1-git-send-email-rctay89@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239849>

On Thu, Jan 02, 2014 at 09:06:33AM +0800, Tay Ray Chuan wrote:

> We were leaking memory in there, as after obtaining a string from
> git_getpass, we returned a copy of it, yet no one else held the original
> string, apart from credential_ask_one.

I don't think this change is correct by itself.

credential_ask_one calls git_prompt. That function in turn calls
git_terminal_prompt, which returns a pointer to a static buffer (because
it may be backed by the system getpass() implementation).

So there is no leak there, and dropping the strdup would be bad (the
call to ask for the password would overwrite the value we got for the
username).

However, git_prompt may also call do_askpass if GIT_ASKPASS is set, and
here there is a leak, as we duplicate the buffer.  To stop the leak, we
need to first harmonize the do_askpass and git_terminal_prompt code
paths to either both allocate, or both return a static buffer (and then
either strdup or not in the caller, depending on which way we go).

It looks like what I originally wrote was correct, as both code paths
matched.  But then I stupidly broke it with 31b49d9, which failed to
notice the "static" specifier on the strbuf in do_askpass, and started
using strbuf_detach.

I think this is the simplest fix:

-- >8 --
Subject: Revert "prompt: clean up strbuf usage"

This reverts commit 31b49d9b653803e7c7fd18b21c8bdd86e3421668.

That commit taught do_askpass to hand ownership of our
buffer back to the caller rather than simply return a
pointer into our internal strbuf.  What it failed to notice,
though, was that our internal strbuf is static, because we
are trying to emulate the getpass() interface.

By handing off ownership, we created a memory leak that
cannot be solved. Sometimes git_prompt returns a static
buffer from getpass() (or our smarter git_terminal_prompt
wrapper), and sometimes it returns an allocated string from
do_askpass.

Signed-off-by: Jeff King <peff@peff.net>
---
 prompt.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/prompt.c b/prompt.c
index d851807..d7bb17c 100644
--- a/prompt.c
+++ b/prompt.c
@@ -22,6 +22,7 @@ static char *do_askpass(const char *cmd, const char *prompt)
 	if (start_command(&pass))
 		return NULL;
 
+	strbuf_reset(&buffer);
 	if (strbuf_read(&buffer, pass.out, 20) < 0)
 		err = 1;
 
@@ -38,7 +39,7 @@ static char *do_askpass(const char *cmd, const char *prompt)
 
 	strbuf_setlen(&buffer, strcspn(buffer.buf, "\r\n"));
 
-	return strbuf_detach(&buffer, NULL);
+	return buffer.buf;
 }
 
 char *git_prompt(const char *prompt, int flags)
-- 
1.8.5.2.434.g63b1477






> 
> Signed-off-by: Tay Ray Chuan <rctay89@gmail.com>
> ---
>  credential.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/credential.c b/credential.c
> index 86397f3..0d02ad8 100644
> --- a/credential.c
> +++ b/credential.c
> @@ -54,7 +54,7 @@ static char *credential_ask_one(const char *what, struct credential *c)
>  
>  	strbuf_release(&desc);
>  	strbuf_release(&prompt);
> -	return xstrdup(r);
> +	return r;
>  }
>  
>  static void credential_getpass(struct credential *c)
> -- 
> 1.8.5-rc2
> 
