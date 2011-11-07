From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] blame.c: Properly initialize strbuf after calling
 textconv_object(), again
Date: Mon, 7 Nov 2011 11:49:46 -0500
Message-ID: <20111107164946.GD27055@sigill.intra.peff.net>
References: <4EB7FEE6.9000609@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Sebastian Schuberth <sschuberth@gmail.com>
X-From: git-owner@vger.kernel.org Mon Nov 07 17:49:55 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RNSOP-0006bO-Ko
	for gcvg-git-2@lo.gmane.org; Mon, 07 Nov 2011 17:49:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932668Ab1KGQtt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Nov 2011 11:49:49 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:35816
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754911Ab1KGQts (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Nov 2011 11:49:48 -0500
Received: (qmail 27712 invoked by uid 107); 7 Nov 2011 16:49:49 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 07 Nov 2011 11:49:49 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 07 Nov 2011 11:49:46 -0500
Content-Disposition: inline
In-Reply-To: <4EB7FEE6.9000609@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184997>

On Mon, Nov 07, 2011 at 04:53:10PM +0100, Sebastian Schuberth wrote:

> --- a/builtin/blame.c
> +++ b/builtin/blame.c
> @@ -2114,7 +2114,7 @@ static struct commit *fake_working_tree_commit(struct diff_options *opt,
>  		case S_IFREG:
>  			if (DIFF_OPT_TST(opt, ALLOW_TEXTCONV) &&
>  			    textconv_object(read_from, mode, null_sha1, &buf.buf, &buf_len)) {
> -				buf.alloc = buf_len;
> +				buf.alloc = buf_len + 1;
>  				buf.len = buf_len;
>  			}
>  			else if (strbuf_read_file(&buf, read_from, st.st_size) != st.st_size)

Your patch is correct in the sense that this fixes a bug, but it just
seems wrong to be touching the alloc parameter outside of the strbuf
code. It looks like the intent is to do the equivalent of:

  strbuf_add(&buf, some_heap_buf, len);
  free(some_heap_buf);

but avoid the extra allocation and copy. Should there be a
"strbuf_attach" function to encapsulate this pattern?

-Peff
