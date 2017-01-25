Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BD4181F6DC
	for <e@80x24.org>; Wed, 25 Jan 2017 18:35:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752510AbdAYSfw (ORCPT <rfc822;e@80x24.org>);
        Wed, 25 Jan 2017 13:35:52 -0500
Received: from cloud.peff.net ([104.130.231.41]:44603 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752438AbdAYSfu (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Jan 2017 13:35:50 -0500
Received: (qmail 24839 invoked by uid 109); 25 Jan 2017 18:35:44 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 25 Jan 2017 18:35:44 +0000
Received: (qmail 14096 invoked by uid 111); 25 Jan 2017 18:35:44 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 25 Jan 2017 13:35:44 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 25 Jan 2017 13:35:42 -0500
Date:   Wed, 25 Jan 2017 13:35:42 -0500
From:   Jeff King <peff@peff.net>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Junio C Hamano <gitster@pobox.com>,
        David Aguilar <davvid@gmail.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        GIT Mailing-list <git@vger.kernel.org>
Subject: Re: Fixing the warning about warning(""); was: Re: [PATCH]
 difftool.c: mark a file-local symbol with static
Message-ID: <20170125183542.pe5qolexqqx6jhsi@sigill.intra.peff.net>
References: <xmqqinr4bkf4.fsf@gitster.mtv.corp.google.com>
 <59da5383-16a0-b327-75a8-b4c4ad7bd479@ramsayjones.plus.com>
 <20161201040234.3rnuttitneweedn5@sigill.intra.peff.net>
 <xmqq60n3bjel.fsf@gitster.mtv.corp.google.com>
 <20161201185056.eso5rhec7izlbywa@sigill.intra.peff.net>
 <20170122052608.tpr5pihfgafhoynj@gmail.com>
 <20170124142346.u3d7l6772mtkgpcf@sigill.intra.peff.net>
 <xmqqlgu0ceia.fsf@gitster.mtv.corp.google.com>
 <20170124230500.h3fasbvutjkkke5h@sigill.intra.peff.net>
 <alpine.DEB.2.20.1701251135090.3469@virtualbox>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.20.1701251135090.3469@virtualbox>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jan 25, 2017 at 11:36:50AM +0100, Johannes Schindelin wrote:

> > Gross, but at least it's self documenting. :)
> > 
> > I guess a less horrible version of that is:
> > 
> >   static inline warning_blank_line(void)
> >   {
> > 	warning("%s", "");
> >   }
> > 
> > We'd potentially need a matching one for error(), but at last it avoids
> > macro trickery.
> 
> I fail to see how this function, or this definition, makes the code better
> than simply calling `warning("%s", "");` and be done with it.

The only advantage is that it is self-documenting, so somebody does not
come through later and convert ("%s", "") back to (""). We could also
write a comment. But I am happy if we simply catch it in review (or
preferably the person is clueful enough to read the output of git-blame
and see why it is that way in the first place).

So maybe:

-- >8 --
Subject: [PATCH] difftool: hack around -Wzero-length-format warning

Building with "gcc -Wall" will complain that the format in:

  warning("")

is empty. Which is true, but the warning is over-eager. We
are calling the function for its side effect of printing
"warning:", even with an empty string.

Our DEVELOPER Makefile knob disables the warning, but not
everybody uses it. Let's silence the warning in the code so
that nobody reports it or tries to "fix" it.

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/difftool.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/difftool.c b/builtin/difftool.c
index 42ad9e804..b5e85ab07 100644
--- a/builtin/difftool.c
+++ b/builtin/difftool.c
@@ -567,7 +567,7 @@ static int run_dir_diff(const char *extcmd, int symlinks, const char *prefix,
 				warning(_("both files modified: '%s' and '%s'."),
 					wtdir.buf, rdir.buf);
 				warning(_("working tree file has been left."));
-				warning("");
+				warning("%s", "");
 				err = 1;
 			} else if (unlink(wtdir.buf) ||
 				   copy_file(wtdir.buf, rdir.buf, st.st_mode))
-- 
2.11.0.840.gd37c5973a
