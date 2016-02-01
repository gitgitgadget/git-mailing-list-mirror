From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 5/6] checkout-index: disallow "--no-stage" option
Date: Sun, 31 Jan 2016 22:18:24 -0500
Message-ID: <20160201031824.GA12217@sigill.intra.peff.net>
References: <20160131112215.GA4589@sigill.intra.peff.net>
 <20160131113029.GE5116@sigill.intra.peff.net>
 <xmqqvb69w4u8.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Feb 01 04:18:32 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aQ50Z-0000SI-Is
	for gcvg-git-2@plane.gmane.org; Mon, 01 Feb 2016 04:18:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753294AbcBADS2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 31 Jan 2016 22:18:28 -0500
Received: from cloud.peff.net ([50.56.180.127]:35285 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752816AbcBADS1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 31 Jan 2016 22:18:27 -0500
Received: (qmail 18290 invoked by uid 102); 1 Feb 2016 03:18:27 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Sun, 31 Jan 2016 22:18:27 -0500
Received: (qmail 20702 invoked by uid 107); 1 Feb 2016 03:18:52 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Sun, 31 Jan 2016 22:18:52 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 31 Jan 2016 22:18:24 -0500
Content-Disposition: inline
In-Reply-To: <xmqqvb69w4u8.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285182>

On Sun, Jan 31, 2016 at 06:18:39PM -0800, Junio C Hamano wrote:

> >  builtin/checkout-index.c | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> >
> > diff --git a/builtin/checkout-index.c b/builtin/checkout-index.c
> > index f8179a7..7a9b561 100644
> > --- a/builtin/checkout-index.c
> > +++ b/builtin/checkout-index.c
> > @@ -133,6 +133,8 @@ static struct lock_file lock_file;
> >  static int option_parse_stage(const struct option *opt,
> >  			      const char *arg, int unset)
> >  {
> > +	if (unset)
> > +		return error(_("--stage cannot be negated"));
> 
> Hmm, it is surprising that there is no parse-options flag that says
> "this cannot be negated".

There is, but you have to stop using the nice OPT_CALLBACK macro and do
a full-on "{}" struct literal in the options. Since we have a callback,
I figured doing this is less ugly to look at. But it does mean making up
our own message.

I didn't actually try it yesterday; having just done so, it's a lot less
bad than I expected. And I also noticed yet another problem with it. :-/

How about this as a replacement patch?

-- >8 --
Subject: [PATCH] checkout-index: disallow "--no-stage" option

We do not really expect people to use "--no-stage", but if
they do, git currently segfaults. We could instead have it
undo the effects of a previous "--stage", but this gets
tricky around the "to_tempfile" flag. We cannot simply reset
it to 0, because we don't know if it was set by a previous
"--stage=all" or an explicit "--temp" option.

We could solve this by setting a flag and resolving
to_tempfile later, but it's not worth the effort. Nobody
actually wants to use "--no-stage"; we are just trying to
fix a potential segfault here.

While we're in the area, let's improve the user-facing
messages for this option. The error string should be
translatable, and we should give some hint in the "-h"
output about what can go in the argument field.

Signed-off-by: Jeff King <peff@peff.net>
---
I also notice that you cannot use "--stage=0" to reset a previous
"--stage=1". It probably would not hurt to allow that, but I left it out
of this patch.

 builtin/checkout-index.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/builtin/checkout-index.c b/builtin/checkout-index.c
index f8179a7..92c6967 100644
--- a/builtin/checkout-index.c
+++ b/builtin/checkout-index.c
@@ -141,7 +141,7 @@ static int option_parse_stage(const struct option *opt,
 		if ('1' <= ch && ch <= '3')
 			checkout_stage = arg[0] - '0';
 		else
-			die("stage should be between 1 and 3 or all");
+			die(_("stage should be between 1 and 3 or all"));
 	}
 	return 0;
 }
@@ -173,9 +173,9 @@ int cmd_checkout_index(int argc, const char **argv, const char *prefix)
 			N_("write the content to temporary files")),
 		OPT_STRING(0, "prefix", &state.base_dir, N_("string"),
 			N_("when creating files, prepend <string>")),
-		OPT_CALLBACK(0, "stage", NULL, NULL,
+		{ OPTION_CALLBACK, 0, "stage", NULL, "1-3|all",
 			N_("copy out the files from named stage"),
-			option_parse_stage),
+			PARSE_OPT_NONEG, option_parse_stage },
 		OPT_END()
 	};
 
-- 
2.7.0.489.g6faad84
