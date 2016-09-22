Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.3 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6561A207EC
	for <e@80x24.org>; Thu, 22 Sep 2016 06:47:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752503AbcIVGre (ORCPT <rfc822;e@80x24.org>);
        Thu, 22 Sep 2016 02:47:34 -0400
Received: from cloud.peff.net ([104.130.231.41]:46514 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752003AbcIVGrd (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Sep 2016 02:47:33 -0400
Received: (qmail 17916 invoked by uid 109); 22 Sep 2016 06:47:32 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 22 Sep 2016 06:47:32 +0000
Received: (qmail 6359 invoked by uid 111); 22 Sep 2016 06:47:45 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 22 Sep 2016 02:47:45 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 22 Sep 2016 02:47:30 -0400
Date:   Thu, 22 Sep 2016 02:47:30 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Anatoly Borodin <anatoly.borodin@gmail.com>, git@vger.kernel.org
Subject: Re: Bug: pager.<cmd> doesn't work well with editors
Message-ID: <20160922064730.277nzkqlxbcx2kjg@sigill.intra.peff.net>
References: <nrmbrl$hsk$1@blaine.gmane.org>
 <nrmd6u$imf$1@blaine.gmane.org>
 <xmqqh99bho7a.fsf@gitster.mtv.corp.google.com>
 <20160920014733.7whjuxfuimx5ztdb@sigill.intra.peff.net>
 <xmqqponxb56a.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqponxb56a.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Sep 21, 2016 at 09:15:09AM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > And this isn't really limited to the editor. It's more _annoying_ with
> > the editor, but really "pager.tag" does not make any sense to set right
> > now, because it is handled outside of the "tag" command entirely, and
> > doesn't know what mode the tag command will be running in.
> 
> Stepping back even further, perhaps the whole pager.<cmd> was a bad
> interim move.  For those who set "less" without "-F", being able to
> set pager.<cmd> to false may still be necessary, but I am wondering
> about setting it to true or a command string here.
> 
> It did mean well and may have helped when "git <cmd>" that produces
> reams of output had not yet learned to auto-paginate as a stop-gap
> measure by allowing users to set pager.<cmd>, but I wonder if the
> ideal course of action was to identify (or "wait until people show
> their desire") individual operating modes of various commands and
> teach them to auto-paginate.  For example, "tag -l" may be one of
> them that we would want to teach to.

I don't think it is a bad move overall. I use "pager.log" to pipe
through a specific command (that is different than I would use for other
commands).

So I like the idea of configurability; the problem is just that it is
happening at the wrong level. The individual commands should be in
charge of it, with something like:

  /*
   * See if pager.log is configured, falling back to "true" (due to the
   * second argument). If so, and stdout is a tty, run the pager.
   *
   * This would be run at the top of cmd_log().
   */
  setup_auto_pager("log", 1);

  ...

  /*
   * As above, but note that we run this in cmd_tag() only at the right
   * moment. We'd probably actually flip the "0" here to a "1", but
   * this represents the current default.
   */
  if (mode_list)
	  setup_auto_pager("tag.list", 0);

That's a lot more boilerplate (each command needs to decide if and when
it should support the pager), but a one-liner in each spot is not so
bad.  Both builtins and external could use the C interface, but it's
trickier for other languages to redirect their own stdout (we want the
pager to run as a separate process, but we also need to wait for it at
the end).

Though I suspect for most cases, external scripts are really paging the
output of some other command anyway. So it would be enough to provide
something like:

  if git pager --query bisect.log
  then
	bisect_log | git pager bisect.log
  else
	bisect_log
  fi

(you can lose the "--query" form if you don't mind _always_ piping
through "cat" when there's no pager in use, but that seems like a
pointless inefficiency).

So I think it's all workable, and for the most part would even remain
backwards compatible, with the exception that "pager.foo" would not work
for a third-party "git-foo" until the author updates it to call "git
pager".

I don't have a particular plan to work on it anytime soon, but maybe
somebody could pick it up as relatively low-hanging fruit.

-Peff
