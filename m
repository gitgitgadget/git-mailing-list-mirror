From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 5/6] remote.c: introduce remote.pushdefault
Date: Fri, 22 Mar 2013 10:56:40 -0400
Message-ID: <20130322145640.GB3083@sigill.intra.peff.net>
References: <1363938756-13722-1-git-send-email-artagnon@gmail.com>
 <1363938756-13722-6-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 22 15:57:25 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UJ3PJ-0006mf-DV
	for gcvg-git-2@plane.gmane.org; Fri, 22 Mar 2013 15:57:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933754Ab3CVO4u (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Mar 2013 10:56:50 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:35752 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933657Ab3CVO4s (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Mar 2013 10:56:48 -0400
Received: (qmail 1303 invoked by uid 107); 22 Mar 2013 14:58:33 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 22 Mar 2013 10:58:33 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 22 Mar 2013 10:56:40 -0400
Content-Disposition: inline
In-Reply-To: <1363938756-13722-6-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218808>

On Fri, Mar 22, 2013 at 01:22:35PM +0530, Ramkumar Ramachandra wrote:

> diff --git a/remote.c b/remote.c
> index 185ac11..bdb542c 100644
> --- a/remote.c
> +++ b/remote.c
> @@ -350,6 +350,11 @@ static int handle_config(const char *key, const char *value, void *cb)
>  	const char *subkey;
>  	struct remote *remote;
>  	struct branch *branch;
> +	if (!prefixcmp(key, "remote.")) {
> +		if (!strcmp(key + 7, "pushdefault"))
> +			if (git_config_string(&pushremote_name, key, value))
> +				return -1;
> +	}
>  	if (!prefixcmp(key, "branch.")) {
>  		name = key + 7;
>  		subkey = strrchr(name, '.');

I was going to say "shouldn't we return 0" here, both on successful read
of pushdefault, but also just when we have remote.*. But the answer is
"yes" to the first one (we know we have handled the key), but "no" to
the second, because we end up parsing remote.*.* later.

So I think this should at least be:

  if (!prefixcmp(key, "remote.")) {
          if (!strcmp(key + 7, "pushdefault"))
                  return git_config_string(&pushremote_name, key, value));
          /* do not return; we handle other remote.* below */
  }

but also possibly just move it with the other remote parsing, like:

diff --git a/remote.c b/remote.c
index 02e6c4c..d3d740a 100644
--- a/remote.c
+++ b/remote.c
@@ -388,9 +388,16 @@ static int handle_config(const char *key, const char *value, void *cb)
 			add_instead_of(rewrite, xstrdup(value));
 		}
 	}
+
 	if (prefixcmp(key,  "remote."))
 		return 0;
 	name = key + 7;
+
+	/* Handle any global remote.* variables */
+	if (!strcmp(name, "pushdefault"))
+		return git_config_string(&pushremote_name, key, value);
+
+	/* Now handle any remote.NAME.* variables */
 	if (*name == '/') {
 		warning("Config remote shorthand cannot begin with '/': %s",
 			name);

-Peff
