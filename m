From: Jeff King <peff@peff.net>
Subject: Re: [RFC/PATCH] Fix path prefixing in grep_object
Date: Sun, 25 Aug 2013 00:41:09 -0400
Message-ID: <20130825044108.GA21300@sigill.intra.peff.net>
References: <1377394558-371-1-git-send-email-hordp@cisco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	phil.hord@gmail.com
To: Phil Hord <hordp@cisco.com>
X-From: git-owner@vger.kernel.org Sun Aug 25 06:41:21 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VDS8b-0003rI-Og
	for gcvg-git-2@plane.gmane.org; Sun, 25 Aug 2013 06:41:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756008Ab3HYElM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 25 Aug 2013 00:41:12 -0400
Received: from cloud.peff.net ([50.56.180.127]:52515 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755980Ab3HYElL (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Aug 2013 00:41:11 -0400
Received: (qmail 11602 invoked by uid 102); 25 Aug 2013 04:41:11 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sat, 24 Aug 2013 23:41:10 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 25 Aug 2013 00:41:09 -0400
Content-Disposition: inline
In-Reply-To: <1377394558-371-1-git-send-email-hordp@cisco.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232914>

On Sat, Aug 24, 2013 at 09:35:58PM -0400, Phil Hord wrote:

> When the pathspec given to grep includes a tree name, the full
> name of matched files is assembled using colon as a separator.
> If the pathspec includes a tree name, it should use a slash
> instead.
> 
> Check if the pathspec already names a tree and ref (including
> a colon) and use a slash if so.

Makes sense.

> I'm not sure about the detection I used here.  It works, but it is
> not terribly robust.  Is there a better way to handle this?  Maybe
> something like 'prefix_pathspec(name,"");'.

I think the information you want has been thrown away by the time we get
to grep_object. Only get_sha1 knows whether the name was really a direct
tree reference or if it had to traverse paths.

So we are necessarily reconstructing based on what we know of the
syntax. And I think that your rule is OK, because we know that refnames
cannot contain a colon. So even though pathnames can, we do not have to
care; we only want to know "is there a path in the name", and if we have
at least one colon, the answer is yes.

>  builtin/grep.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

A test would be nice. Both to make sure we do not re-break it, and because
it helps demonstrate the problem very easily (it took me a minute to
figure out what was going on from your description).

> diff --git a/builtin/grep.c b/builtin/grep.c
> index 03bc442..d0deae4 100644
> --- a/builtin/grep.c
> +++ b/builtin/grep.c
> @@ -480,8 +480,9 @@ static int grep_object(struct grep_opt *opt, const struct pathspec *pathspec,
>  		len = name ? strlen(name) : 0;
>  		strbuf_init(&base, PATH_MAX + len + 1);
>  		if (len) {
> +			int has_colon = !!strchr(name,':');
>  			strbuf_add(&base, name, len);
> -			strbuf_addch(&base, ':');
> +			strbuf_addch(&base, has_colon?'/':':');

Please use whitespace with your ternary operator. The '/':':' made me
think I was reading Perl for a minute. :)

-Peff
