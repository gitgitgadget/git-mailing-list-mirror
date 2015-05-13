From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v7 1/3] tree-walk: learn get_tree_entry_follow_symlinks
Date: Wed, 13 May 2015 11:39:45 -0400
Message-ID: <20150513153944.GA17418@peff.net>
References: <1431481799-23560-1-git-send-email-dturner@twopensource.com>
 <1431481799-23560-2-git-send-email-dturner@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, David Turner <dturner@twitter.com>
To: dturner@twopensource.com
X-From: git-owner@vger.kernel.org Wed May 13 17:39:54 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YsYlF-0005Cr-Kp
	for gcvg-git-2@plane.gmane.org; Wed, 13 May 2015 17:39:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965181AbbEMPjt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 May 2015 11:39:49 -0400
Received: from cloud.peff.net ([50.56.180.127]:57946 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S965165AbbEMPjs (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 May 2015 11:39:48 -0400
Received: (qmail 1828 invoked by uid 102); 13 May 2015 15:39:48 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 13 May 2015 10:39:48 -0500
Received: (qmail 12558 invoked by uid 107); 13 May 2015 15:39:46 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 13 May 2015 11:39:46 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 13 May 2015 11:39:45 -0400
Content-Disposition: inline
In-Reply-To: <1431481799-23560-2-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268990>

On Tue, May 12, 2015 at 09:49:57PM -0400, dturner@twopensource.com wrote:

> +		} else if (S_ISLNK(*mode)) {
> +			/* Follow a symlink */
> +			unsigned long link_len;
> +			size_t len;
> +			char *contents, *contents_start;
> [...]
> +			contents = read_sha1_file(current_tree_sha1, &type,
> +						  &link_len);

Here we have potentially allocated a buffer for contents...

> +
> +			if (!contents)
> +				goto done;

No need to free here, it's NULL...

> +
> +			if (contents[0] == '/') {
> +				strbuf_addstr(result_path, contents);
> +				*mode = 0;
> +				retval = FOUND;
> +				goto done;
> +			}

But here we leak it on "goto done".

> +			if (remainder)
> +				len = first_slash - namebuf.buf;
> +			else
> +				len = namebuf.len;
> +
> +			contents_start = contents;
> +
> +			parent = &parents[parents_nr - 1];
> +			init_tree_desc(&t, parent->tree, parent->size);
> +			strbuf_splice(&namebuf, 0, len,
> +				      contents_start, link_len);
> +			if (remainder)
> +				namebuf.buf[link_len] = '/';
> +			free(contents);
> +		}

And this code path calls free(), so it is good.

So I think you just need a free() in the conditional above.

-Peff
