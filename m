From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Fallback on getpwuid if envar HOME is unset
Date: Mon, 20 Aug 2012 22:30:34 -0400
Message-ID: <20120821023033.GB20271@sigill.intra.peff.net>
References: <CAFFUb6WiXJ0n4NkhOQ=+mcfs+uaAo2_G6TOs7L=AuPwPVfxyMg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, gitster@pobox.com
To: Conley Owens <cco3@android.com>
X-From: git-owner@vger.kernel.org Tue Aug 21 04:31:28 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T3eFZ-0003Yp-75
	for gcvg-git-2@plane.gmane.org; Tue, 21 Aug 2012 04:31:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754945Ab2HUCai (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Aug 2012 22:30:38 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:43252 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754206Ab2HUCah (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Aug 2012 22:30:37 -0400
Received: (qmail 25851 invoked by uid 107); 21 Aug 2012 02:30:49 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 20 Aug 2012 22:30:49 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 20 Aug 2012 22:30:34 -0400
Content-Disposition: inline
In-Reply-To: <CAFFUb6WiXJ0n4NkhOQ=+mcfs+uaAo2_G6TOs7L=AuPwPVfxyMg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203922>

On Mon, Aug 20, 2012 at 06:28:57PM -0700, Conley Owens wrote:

> From f64ba3c908b33a2ea5a5ad1f0e5800af76b82ce9 Mon Sep 17 00:00:00 2001
> From: Conley Owens <cco3@android.com>
> Date: Mon, 20 Aug 2012 18:23:40 -0700
> Subject: [PATCH] Fallback on getpwuid if envar HOME is unset

Please drop these lines from the message body; they are redundant with
your email's headers.

This seems sensible on the surface, but I'm a bit curious: why isn't
$HOME set? And are there any reasons that somebody who has unset HOME
would not want to fallback?  For example, running under Apache, HOME is
often unset when calling CGI programs. Would it make sense for us to
look in ~www-data/.gitconfig in that case?

> diff --git a/path.c b/path.c
> index 66acd24..60affab 100644
> --- a/path.c
> +++ b/path.c
> @@ -144,6 +144,11 @@ void home_config_paths(char **global, char **xdg,
> char *file)
>         char *to_free = NULL;
> 
>         if (!home) {
> +         struct passwd *pw = xgetpwuid_self();
> +         home = pw->pw_dir;
> +       }
> +
> +       if (!home) {
>                 if (global)
>                         *global = NULL;
>         } else {

If we do go this route, it would probably make sense to wrap this like:

  const char *home_directory(void)
  {
          const char *dir = getenv("HOME");
          if (!dir) {
                  struct passwd *pw = xgetpwuid_self();
                  dir = pw->pw_dir;
          }
          return dir;
  }

and then call it consistently everywhere we do getenv("HOME"). You'd
want to double-check that each caller only uses the result for a short
period (unlike getenv, the results of getpwuid will be overwritten at
the next call).

-Peff
