Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 16B171F516
	for <e@80x24.org>; Thu, 28 Jun 2018 18:16:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966406AbeF1SQb (ORCPT <rfc822;e@80x24.org>);
        Thu, 28 Jun 2018 14:16:31 -0400
Received: from cloud.peff.net ([104.130.231.41]:58692 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1753318AbeF1SQb (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Jun 2018 14:16:31 -0400
Received: (qmail 23365 invoked by uid 109); 28 Jun 2018 18:16:31 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 28 Jun 2018 18:16:31 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 23808 invoked by uid 111); 28 Jun 2018 18:16:51 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 28 Jun 2018 14:16:51 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 28 Jun 2018 14:16:29 -0400
Date:   Thu, 28 Jun 2018 14:16:29 -0400
From:   Jeff King <peff@peff.net>
To:     Todd Zullinger <tmz@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] doc: substitute ETC_GIT(CONFIG|ATTRIBUTES) in generated
 docs
Message-ID: <20180628181629.GF31766@sigill.intra.peff.net>
References: <20180627045637.13818-1-tmz@pobox.com>
 <20180627141430.GA13904@sigill.intra.peff.net>
 <20180627150352.GJ20217@zaya.teonanacatl.net>
 <20180628141556.GA15799@sigill.intra.peff.net>
 <20180628163606.GP20217@zaya.teonanacatl.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180628163606.GP20217@zaya.teonanacatl.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jun 28, 2018 at 12:36:06PM -0400, Todd Zullinger wrote:

> >> It might be enough if the default values are relatively sane
> >> and consistent.  That would be a slight improvement over the
> >> current situation still.
> > 
> > Yeah. Taking a step back from the implementation questions, I think
> > "$(prefix)/etc/gitconfig" is not very helpful text. I'd be happy to see
> > us come up with a generic way of saying that which is more
> > comprehensible to end-users. Your patches side-step that by filling in
> > the real value, but unfortunately we can't do that everywhere. :)
> > 
> > There may not be a good "token" value, though. I.e., we may need to have
> > two sets of verbiage: the specific one, and the generic one.
> 
> Yeah.  About the best generic term I can come up with is
> using '$sysconfdir'.  But I have no idea if that's something
> most readers will recognize as a placeholder for something
> like /etc.

I don't that's much better than $(prefix). It's at least _correct_ more
often, but unless you're used to autotools conventions, it's pretty
obscure. Can we just say "the system configuration direction (e.g.,
/etc)" or something like that?

That definitely requires doing some kind of ifdef in the asciidoc
source, but I think the end result will be much more comprehensible to
end users. And IMHO the readability hit to the source is not too bad (at
least I don't find the DEFAULT_PAGER one to be).

Something like this:

diff --git a/Documentation/git-config.txt b/Documentation/git-config.txt
index 18ddc78f42..ab20dd5235 100644
--- a/Documentation/git-config.txt
+++ b/Documentation/git-config.txt
@@ -113,13 +113,16 @@ For reading options: read only from global `~/.gitconfig` and from
 See also <<FILES>>.
 
 --system::
-	For writing options: write to system-wide
-	`$(prefix)/etc/gitconfig` rather than the repository
-	`.git/config`.
+	For writing options: write to the system-wide gitconfig file
+	rather then the repository config.
 +
-For reading options: read only from system-wide `$(prefix)/etc/gitconfig`
+For reading options: read only from system-wide gitconfig file
 rather than from all available files.
 +
+The exact location of the system-wide file is configured when Git is
+built.
+ifdef::git-doc-generic[In many builds, it is `/etc/gitconfig`.]
+ifndef::git-doc-generic[In your build, it is +{etc-gitconfig}+.]
 See also <<FILES>>.
 
 --local::

Though I would also be happy if we simply said "system-wide gitconfig"
here and then had the conditional part in FILES.

I'd actually argue that all of the "source" options should be grouped,
like:

  --local::
  --global::
  --system::
  --file=<file>::
	When writing, write to the repository-local, user-global, or
	system-wide configuration file (or any `<file>` you specify).
	When reading, read from a specific file rather than from all
	available files. See <<FILES> below for more details.

And then let <<FILES>> describe in prose the various files, where they
might be, etc. That also cleans up the `.git/config` thing, which is a
mild fiction (it is really `$GIT_DIR/config`).

> A number of the path references are in the FILES sections of
> the man pages.  It might not be much of an improvement if we
> try to stuff too much text in those references.  Perhaps if
> those used '$sysconfdir/gitconfig' a subsequent note could
> expand on that?  It could even be wrapped in an ifdef
> similar to that used for the default editor/pager.

So yeah, I think I am arguing along the same lines, but just saying
"system-wide gitconfig" or similar instead of $sysconfdir/gitconfig. I
think the English is a little less daunting.

> > I think it shouldn't go into config.mak.uname, since the idea there was
> > to keep the long list of platform defaults separate from other logic
> > (the Makefile is already long enough!). So I'm basically proposing the
> > same thing but in its own file. :)
> 
> Ahh, something that the top-level Makefile would create and
> then subdir Makefiles would include, perhaps similar to the
> way GIT-VERSION-FILE is updated and included?  That could
> prove useful to some of the tools in contrib which duplicate
> logic.

No, I had just envisioned it would be a static file, like
config.mak.paths or something. I'm literally just trying to break out
bits of our Makefile into bite-sized files so they're easier look at.

> Skipping that larger de-duplication cleanup, here's a stab
> at implementing the DOC_GENERIC knob (and the DOC_ overrides
> for ETC_GIT(CONFIG|ATTRIBUTES).  The defaults with
> '/GENERIC-SYSCONFDIR' in them are just placeholders waiting
> for a better name. :)

So obviously I like the direction of this patch, but if you agree with
my line of thinking above you'd need to turn DOC_GENERIC into an
attribute and use in-source conditionals. Hopefully you do agree. :)

> Thanks for thinking this through and providing some good
> directions to work on!

Thank you for working on it! I was thinking about this because of the
response I wrote in:

  https://public-inbox.org/git/20180626124316.GA15419@sigill.intra.peff.net/

If you're interested, this could all be rolled into a cleanup series.
But if not, I can wait for this to resolve and then build on top.

-Peff
