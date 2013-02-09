From: Jeff King <peff@peff.net>
Subject: Re: segfault for git log --graph --no-walk --grep a
Date: Fri, 8 Feb 2013 19:39:22 -0500
Message-ID: <20130209003921.GC5570@sigill.intra.peff.net>
References: <201302090052.22053.thom311@gmail.com>
 <7vsj56xsg5.fsf@alter.siamese.dyndns.org>
 <7vobfuxrns.fsf@alter.siamese.dyndns.org>
 <7vk3qixrc8.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Thomas Haller <thom311@gmail.com>, Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Feb 09 01:40:06 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U3yU5-000734-0U
	for gcvg-git-2@plane.gmane.org; Sat, 09 Feb 2013 01:40:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932275Ab3BIAjZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Feb 2013 19:39:25 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:42680 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932271Ab3BIAjY (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Feb 2013 19:39:24 -0500
Received: (qmail 1960 invoked by uid 107); 9 Feb 2013 00:40:50 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 08 Feb 2013 19:40:50 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 08 Feb 2013 19:39:22 -0500
Content-Disposition: inline
In-Reply-To: <7vk3qixrc8.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215834>

On Fri, Feb 08, 2013 at 04:29:11PM -0800, Junio C Hamano wrote:

> Perhaps something along this line...
> 
> -- >8 --
> Subject: "log --grep": commit's buffer may already have been discarded
> 
> Following up on be5c9fb9049e (logmsg_reencode: lazily load missing
> commit buffers, 2013-01-26), extract the part that reads the commit
> buffer data into a separate helper function, and use it when we
> apply the grep filter on the commit during the log walk.

This obviously makes sense if we don't want to get the route of
re-encoding for grep. Re-encoding would be a user-visible change, but I
wonder if it is the right thing to be doing.

> diff --git a/revision.c b/revision.c
> index d7562ee..caf8ef3 100644
> --- a/revision.c
> +++ b/revision.c
> @@ -2279,9 +2279,16 @@ static int commit_match(struct commit *commit, struct rev_info *opt)
>  		strbuf_addch(&buf, '\n');
>  	}
>  
> -	/* Copy the commit to temporary if we are using "fake" headers */
> -	if (buf.len)
> +	if (!commit->buffer) {
> +		/* we may not have commit->buffer */
> +		unsigned long size;
> +		char *msg = read_commit_object_data(commit, &size);
> +		strbuf_add(&buf, msg, size);
> +		free(msg);
> +	} else if (buf.len) {
> +		/* Copy the commit to temporary if we are using "fake" headers */
>  		strbuf_addstr(&buf, commit->buffer);
> +	}

Hmm. It would be nice to avoid the extra copy when we do not otherwise
need to use the strbuf. I would have expected something more like:

  const char *msg = commit->buffer;
  if (!msg)
          msg = read_commit_object_data(commit, NULL);

  [...]

  if (buf.len)
          retval = grep_buffer(&opt->grep_filter, buf.buf, buf.len);
  else
          retval = grep_buffer(&opt->grep_filter, msg, strlen(msg));

  strbuf_release(&buf);
  if (msg != commit->buffer)
          free(msg);
  return retval;

You would also need to adjust the other uses of commit->buffer
throughout the function to refer to msg.

-Peff
