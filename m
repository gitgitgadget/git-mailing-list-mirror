Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A885EC761AF
	for <git@archiver.kernel.org>; Wed,  5 Apr 2023 16:55:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229872AbjDEQz0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 5 Apr 2023 12:55:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233533AbjDEQzW (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Apr 2023 12:55:22 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 744976196
        for <git@vger.kernel.org>; Wed,  5 Apr 2023 09:54:19 -0700 (PDT)
Received: (qmail 4895 invoked by uid 109); 5 Apr 2023 16:54:18 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 05 Apr 2023 16:54:18 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 12921 invoked by uid 111); 5 Apr 2023 16:54:14 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 05 Apr 2023 12:54:14 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 5 Apr 2023 12:54:14 -0400
From:   Jeff King <peff@peff.net>
To:     Patrick Steinhardt <ps@pks.im>
Cc:     Todd Zullinger <tmz@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH] global: resolve Perl executable via PATH
Message-ID: <20230405165414.GA497301@coredump.intra.peff.net>
References: <d9cfad7caf9ff5bf88eb06cf7bb3be5e70e6d96f.1680689378.git.ps@pks.im>
 <ZC2I7CfVzY6Tl7Pk@pobox.com>
 <ZC2LOAwycdaUawxM@ncase>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZC2LOAwycdaUawxM@ncase>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Apr 05, 2023 at 04:52:40PM +0200, Patrick Steinhardt wrote:

> > Is there a reason to not set PERL_PATH, which is the
> > documented method to handle this?  From the Makefike:
> > 
> > # Define PERL_PATH to the path of your Perl binary (usually /usr/bin/perl).
> 
> Setting PERL_PATH helps with a subset of invocations where the Makefile
> either executes Perl directly or where it writes the shebang itself. But
> the majority of scripts I'm touching have `#!/usr/bin/perl` as shebang,
> and that path is not adjusted by setting PERL_PATH.

Which scripts? If I do:

  mkdir /tmp/foo
  ln -s /usr/bin/perl /tmp/foo/my-perl
  make PERL_PATH=/tmp/foo/my-perl prefix=/tmp/foo install

  head -n 1 /tmp/foo/bin/git-cvsserver

Then I see:

  #!/tmp/foo/my-perl

And that is due to this segment in the Makefile:

  $(SCRIPT_PERL_GEN): % : %.perl GIT-PERL-DEFINES GIT-PERL-HEADER GIT-VERSION-FILE
          $(QUIET_GEN) \
          sed -e '1{' \
              -e '        s|#!.*perl|#!$(PERL_PATH_SQ)|' \
              -e '        r GIT-PERL-HEADER' \
              -e '        G' \
              -e '}' \
              -e 's/@@GIT_VERSION@@/$(GIT_VERSION)/g' \
              $< >$@+ && \
          chmod +x $@+ && \
          mv $@+ $@

And that behavior goes all the way back to bc6146d2abc ('build' scripts
before installing., 2005-09-08). If there are some perl scripts we are
"building" outside of this rule, then that is probably a bug.

The only thing I found via:

  find /tmp/foo -type | xargs grep /usr/bin/perl

was a sample hook (which is probably a bug; we do munge the hook scripts
to replace @PERL_PATH@, etc, but I think the Makefile never learned that
the template hook scripts might be something other than shell scripts).

-Peff
