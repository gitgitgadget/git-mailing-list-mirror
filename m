From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 4/4] notes: only append a blob to a blob
Date: Thu, 10 May 2012 11:19:04 -0400
Message-ID: <20120510151904.GB20639@sigill.intra.peff.net>
References: <1336658701-9004-5-git-send-email-pclouds@gmail.com>
 <1336661015-14149-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 10 17:19:14 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SSV97-0007ES-Id
	for gcvg-git-2@plane.gmane.org; Thu, 10 May 2012 17:19:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759900Ab2EJPTI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 May 2012 11:19:08 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:38840
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757805Ab2EJPTG (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 May 2012 11:19:06 -0400
Received: (qmail 29440 invoked by uid 107); 10 May 2012 15:19:26 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 10 May 2012 11:19:26 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 10 May 2012 11:19:04 -0400
Content-Disposition: inline
In-Reply-To: <1336661015-14149-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197579>

On Thu, May 10, 2012 at 09:43:35PM +0700, Nguyen Thai Ngoc Duy wrote:

>  Yeah. It made me look again to see if that was true, and I found that
>  my last patch was flawed. Reading object content in memory in "add
>  -C" is nonsense, not so much in "append -C".

Yeah. Although you would not want to "append -C" anything but blobs.
While the tree syntax concatenates, I believe the entries are supposed
to be in sorted order, no? And you would not want to concatenate commits
at all.

> +static const char *type_name(enum object_type type)
> +{
> +	switch (type) {
> +	case OBJ_BLOB: return _("a blob");
> +	case OBJ_TAG: return _("a tag");
> +	case OBJ_COMMIT: return _("a commit");
> +	case OBJ_TREE: return _("a tree");
> +	default:
> +		die("BUG: put a new string for type %d here", type);
> +	}
> +}

Don't we have object.c:typename for this?

> @@ -204,8 +216,12 @@ static void create_note(const unsigned char *object, struct msg_arg *msg,
>  		strbuf_grow(&(msg->buf), size + 1);
>  		if (msg->buf.len && prev_buf && size)
>  			strbuf_insert(&(msg->buf), 0, "\n", 1);
> -		if (prev_buf && size)
> +		if (prev_buf && size) {
> +			if (type != OBJ_BLOB || msg->type != OBJ_BLOB)
> +				die(_("cannot append %s to %s"),
> +				    type_name(type), type_name(msg->type));
>  			strbuf_insert(&(msg->buf), 0, prev_buf, size);
> +		}

I think this is wrong for the reasons above. You would not want to
concatenate a tree to a tree.

-Peff
