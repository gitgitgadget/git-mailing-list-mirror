Return-Path: <SRS0=jwDG=D4=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DF91C4363A
	for <git@archiver.kernel.org>; Wed, 21 Oct 2020 21:29:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 37ED1223C7
	for <git@archiver.kernel.org>; Wed, 21 Oct 2020 21:29:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2506136AbgJUV3T (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 21 Oct 2020 17:29:19 -0400
Received: from cloud.peff.net ([104.130.231.41]:38722 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2411695AbgJUV3T (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Oct 2020 17:29:19 -0400
Received: (qmail 4551 invoked by uid 109); 21 Oct 2020 21:29:18 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 21 Oct 2020 21:29:18 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 21254 invoked by uid 111); 21 Oct 2020 21:29:17 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 21 Oct 2020 17:29:17 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 21 Oct 2020 17:29:17 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Nikos Chantziaras <realnc@gmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org
Subject: Re: git svn log: Use of uninitialized value $sha1_short
Message-ID: <20201021212917.GA62005@coredump.intra.peff.net>
References: <rmpve5$q2s$1@ciao.gmane.io>
 <20201021202642.GA60606@coredump.intra.peff.net>
 <xmqqwnzj5mq5.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqwnzj5mq5.fsf@gitster.c.googlers.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Oct 21, 2020 at 01:48:50PM -0700, Junio C Hamano wrote:

> > Looks like it got renamed, and this reference was somehow missed?
> >
> >   $ git log -1 -Ssha1_short perl
> >   commit 9ab33150a0d14089d0496dd8354d4a969e849571
> >   Author: brian m. carlson <sandals@crustytoothpaste.net>
> >   Date:   Mon Jun 22 18:04:12 2020 +0000
> >   
> >       perl: create and switch variables for hash constants
> >       
> >       git-svn has several variables for SHA-1 constants, including short hash
> >       values and full length hash values.  Since these are no longer SHA-1
> >       specific, let's start them with "oid" instead of "sha1".  Add a
> >       constant, oid_length, which is the length of the hash algorithm in use
> >       in hex.  We use the hex version because overwhelmingly that's what's
> >       used by git-svn.
> >   [...]
> 
> Looks that way.  '$::' as opposed to plain '$' threw the replacement
> off the track?

That was my guess, too, but that commit does convert some other
references of that form. <shrug>

>  perl/Git/SVN/Log.pm | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git i/perl/Git/SVN/Log.pm w/perl/Git/SVN/Log.pm
> index 3858fcf27d..9c819188ea 100644
> --- i/perl/Git/SVN/Log.pm
> +++ w/perl/Git/SVN/Log.pm
> @@ -298,7 +298,7 @@ sub cmd_show_log {
>  			get_author_info($c, $1, $2, $3);
>  		} elsif (/^${esc_color}(?:tree|parent|committer) /o) {
>  			# ignore
> -		} elsif (/^${esc_color}:\d{6} \d{6} $::sha1_short/o) {
> +		} elsif (/^${esc_color}:\d{6} \d{6} $::oid_short/o) {
>  			push @{$c->{raw}}, $_;
>  		} elsif (/^${esc_color}[ACRMDT]\t/) {
>  			# we could add $SVN->{svn_path} here, but that requires

Yeah, I'm almost certain this is the solution, but it was a little
disturbing that no tests catch it. Besides the warning, it probably is a
functional problem (I guess that regex is now overly broad since its
last half is blank). But maybe it doesn't matter much. It looks like
we're parsing raw diff output from git-log. Short of a really bizarre
--format parameter, those are the only lines that would match /^:/
anyway.

The tests do catch it if we do:

diff --git a/perl/Git/SVN/Log.pm b/perl/Git/SVN/Log.pm
index 3858fcf27d..92e223caed 100644
--- a/perl/Git/SVN/Log.pm
+++ b/perl/Git/SVN/Log.pm
@@ -1,6 +1,6 @@
 package Git::SVN::Log;
 use strict;
-use warnings;
+use warnings FATAL => qw(all);
 use Git::SVN::Utils qw(fatal);
 use Git qw(command
            command_oneline

but:

  - we'd need to do that in each .pm file, as well as git-svn.perl

  - I wonder if it's suitable for production use (i.e., would it become
    annoying when a newer version of perl issues a harmless warning;
    right now that's a minor inconvenience, but aborting the whole
    program might be a show-stopper).

It would be nice if we could crank up the severity just while running
the tests, but I don't think there's an easy built-in way to do that.
This seems to work:

  use warnings ($ENV{GIT_PERL_STRICT} ? qw(FATAL all) : ());

though I'm honestly surprised it does (because "use" is generally
resolved at read/compile time. I guess perl is smart enough to run
that code snippet at that point.

-Peff
