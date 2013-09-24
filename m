From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/2] remote: fix trivial memory leak
Date: Tue, 24 Sep 2013 01:19:08 -0400
Message-ID: <20130924051908.GG2766@sigill.intra.peff.net>
References: <1379772563-11000-1-git-send-email-felipe.contreras@gmail.com>
 <1379772563-11000-3-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Tue Sep 24 07:19:32 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VOL20-0005Du-IV
	for gcvg-git-2@plane.gmane.org; Tue, 24 Sep 2013 07:19:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750716Ab3IXFTN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Sep 2013 01:19:13 -0400
Received: from cloud.peff.net ([50.56.180.127]:53040 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750706Ab3IXFTM (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Sep 2013 01:19:12 -0400
Received: (qmail 31838 invoked by uid 102); 24 Sep 2013 05:19:12 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 24 Sep 2013 00:19:12 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 24 Sep 2013 01:19:08 -0400
Content-Disposition: inline
In-Reply-To: <1379772563-11000-3-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235260>

On Sat, Sep 21, 2013 at 09:09:23AM -0500, Felipe Contreras wrote:

> diff --git a/remote.c b/remote.c
> index efcba93..654e7f5 100644
> --- a/remote.c
> +++ b/remote.c
> @@ -480,7 +480,6 @@ static void read_config(void)
>  	int flag;
>  	if (default_remote_name) /* did this already */
>  		return;
> -	default_remote_name = xstrdup("origin");
>  	current_branch = NULL;
>  	head_ref = resolve_ref_unsafe("HEAD", sha1, 0, &flag);
>  	if (head_ref && (flag & REF_ISSYMREF) &&
> @@ -489,6 +488,8 @@ static void read_config(void)
>  			make_branch(head_ref + strlen("refs/heads/"), 0);
>  	}
>  	git_config(handle_config, NULL);
> +	if (!default_remote_name)
> +		default_remote_name = xstrdup("origin");
>  	alias_all_urls();

I wondered if we might also leak when seeing duplicate config options
(i.e., leaking the old one when replacing it with the new). But we don't
actually strdup() the configured remote names, but instead just point
into the "struct branch", which owns the data.

So I think an even better fix would be:

-- >8 --
Subject: remote: do not copy "origin" string literal

Our default_remote_name starts at "origin", but may be
overridden by the config file. In the former case, we
allocate a new string, but in the latter case, we point to
the remote name in an existing "struct branch".

This gives the variable inconsistent free() semantics (we
are sometimes responsible for freeing the string and
sometimes pointing to somebody else's storage), and causes a
small leak when the allocated string is overridden by
config.

We can fix both by simply dropping the extra copy and
pointing to the string literal.

Noticed-by: Felipe Contreras <felipe.contreras@gmail.com>
Signed-off-by: Jeff King <peff@peff.net>
---
 remote.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/remote.c b/remote.c
index e9fedfa..9f1a8aa 100644
--- a/remote.c
+++ b/remote.c
@@ -483,7 +483,7 @@ static void read_config(void)
 	int flag;
 	if (default_remote_name) /* did this already */
 		return;
-	default_remote_name = xstrdup("origin");
+	default_remote_name = "origin";
 	current_branch = NULL;
 	head_ref = resolve_ref_unsafe("HEAD", sha1, 0, &flag);
 	if (head_ref && (flag & REF_ISSYMREF) &&
-- 
1.8.4.rc3.19.g9da5bf6
