From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] exec_cmd: system_path memory leak fix
Date: Sun, 23 Nov 2014 14:42:47 -0500
Message-ID: <20141123194247.GA16605@peff.net>
References: <1416750981-24446-1-git-send-email-kuleshovmail@gmail.com>
 <1416750981-24446-2-git-send-email-kuleshovmail@gmail.com>
 <xmqqioi5ycme.fsf@gitster.dls.corp.google.com>
 <87sih9en65.fsf@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Alex Kuleshov <kuleshovmail@gmail.com>
X-From: git-owner@vger.kernel.org Sun Nov 23 20:43:55 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xsd4c-0000GQ-2d
	for gcvg-git-2@plane.gmane.org; Sun, 23 Nov 2014 20:43:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751884AbaKWTmu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 23 Nov 2014 14:42:50 -0500
Received: from cloud.peff.net ([50.56.180.127]:43726 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751419AbaKWTmt (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 23 Nov 2014 14:42:49 -0500
Received: (qmail 10216 invoked by uid 102); 23 Nov 2014 19:42:49 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Sun, 23 Nov 2014 13:42:49 -0600
Received: (qmail 9316 invoked by uid 107); 23 Nov 2014 19:43:03 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Sun, 23 Nov 2014 14:43:03 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 23 Nov 2014 14:42:47 -0500
Content-Disposition: inline
In-Reply-To: <87sih9en65.fsf@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260101>

On Mon, Nov 24, 2014 at 01:19:29AM +0600, Alex Kuleshov wrote:

> 
> Signed-off-by: Alex Kuleshov <kuleshovmail@gmail.com>
> ---
>  exec_cmd.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/exec_cmd.c b/exec_cmd.c
> index 698e752..7ed9bcc 100644
> --- a/exec_cmd.c
> +++ b/exec_cmd.c
> @@ -13,7 +13,7 @@ const char *system_path(const char *path)
>  #else
>  	static const char *prefix = PREFIX;
>  #endif
> -	struct strbuf d = STRBUF_INIT;
> +	static struct strbuf d = STRBUF_INIT;
> 
>  	if (is_absolute_path(path))
>  		return path;
> @@ -34,8 +34,7 @@ const char *system_path(const char *path)
>  #endif
> 
>  	strbuf_addf(&d, "%s/%s", prefix, path);
> -	path = strbuf_detach(&d, NULL);
> -	return path;
> +	return d.buf;
>  }

If I am reading this right, calls to system_path() will always reuse the
same buffer, even if they are called with another "path" argument. So
all callers must make sure to make a copy if they are going to hold on
to it for a long time. Grepping for callers shows us saving the result
to a static variable in at least git_etc_gitattributes, copy_templates,
and get_html_page_path. Don't these all need to learn to xstrdup the
return value?

-Peff
