From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] builtin-remote: (get_one_entry): use strbuf
Date: Mon, 22 Jun 2009 17:32:04 -0400
Message-ID: <20090622213204.GB19364@coredump.intra.peff.net>
References: <4A3778B8.5040903@drmicha.warpmail.net>
 <1245659059-11852-1-git-send-email-bert.wesarg@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Jim Meyering <jim@meyering.net>, git@vger.kernel.org
To: Bert Wesarg <bert.wesarg@googlemail.com>
X-From: git-owner@vger.kernel.org Mon Jun 22 23:32:22 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MIr7l-0005XK-O5
	for gcvg-git-2@gmane.org; Mon, 22 Jun 2009 23:32:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752183AbZFVVcK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Jun 2009 17:32:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751700AbZFVVcJ
	(ORCPT <rfc822;git-outgoing>); Mon, 22 Jun 2009 17:32:09 -0400
Received: from peff.net ([208.65.91.99]:34139 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751608AbZFVVcI (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Jun 2009 17:32:08 -0400
Received: (qmail 9095 invoked by uid 107); 22 Jun 2009 21:33:54 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Mon, 22 Jun 2009 17:33:54 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Mon, 22 Jun 2009 17:32:04 -0400
Content-Disposition: inline
In-Reply-To: <1245659059-11852-1-git-send-email-bert.wesarg@googlemail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122061>

On Mon, Jun 22, 2009 at 10:24:19AM +0200, Bert Wesarg wrote:

> --- a/builtin-remote.c
> +++ b/builtin-remote.c
> @@ -1276,17 +1276,17 @@ static int update(int argc, const char **argv)
>  static int get_one_entry(struct remote *remote, void *priv)
>  {
>  	struct string_list *list = priv;
> +	struct strbuf url_buf = STRBUF_INIT;
> +	const char *url_str = NULL;
>  	const char **url;
>  	int i, url_nr;
> -	void **utilp;
>  
>  	if (remote->url_nr > 0) {
> -		utilp = &(string_list_append(remote->name, list)->util);
> -		*utilp = xmalloc(strlen(remote->url[0])+strlen(" (fetch)")+1);
> -		strcpy((char *) *utilp, remote->url[0]);
> -		strcat((char *) *utilp, " (fetch)");
> -	} else
> -		string_list_append(remote->name, list)->util = NULL;
> +		strbuf_addf(&url_buf, "%s (fetch)", remote->url[0]);
> +		url_str = strbuf_detach(&url_buf, NULL);
> +	}
> +	string_list_append(remote->name, list)->util = url_str;
> +

This causes const warnings due to the 'const' on url_str. One solution
is just s/const char/char/.

However, I think it is actually more readable to do away with url_str
entirely. The original if/else logic was much easier to follow than
realizing that url_str is initialized to NULL, and then never changed.
IOW:

  if (remote->url_nr > 0) {
          strbuf_addf(&url_buf, "%s (fetch)", remote->url[0]);
          string_list_append(remote->name, list)->util =
                  strbuf_detach(&url_buf, NULL);
  }
  else
          string_list_append(remote->name, list)->util = NULL;

> @@ -1296,10 +1296,9 @@ static int get_one_entry(struct remote *remote, void *priv)
>  	}
>  	for (i = 0; i < url_nr; i++)
>  	{
> -		utilp = &(string_list_append(remote->name, list)->util);
> -		*utilp = xmalloc(strlen(url[i])+strlen(" (push)")+1);
> -		strcpy((char *) *utilp, url[i]);
> -		strcat((char *) *utilp, " (push)");
> +		strbuf_addf(&url_buf, "%s (push)", url[i]);
> +		url_str = strbuf_detach(&url_buf, NULL);
> +		string_list_append(remote->name, list)->util = url_str;
>  	}

And then this one is re-using url_str for a totally unrelated thing,
but could just be:

  string_list_append(remote->name, list)->util =
          strbuf_detach(&url_buf, NULL);

But that is somewhat nit-picking. As long as the const-warning goes
away, I will be happy enough.

-Peff
