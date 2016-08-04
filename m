Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4298920226
	for <e@80x24.org>; Thu,  4 Aug 2016 11:36:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758121AbcHDLf5 (ORCPT <rfc822;e@80x24.org>);
	Thu, 4 Aug 2016 07:35:57 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:46208 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751024AbcHDLf4 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Aug 2016 07:35:56 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id F074320226;
	Thu,  4 Aug 2016 11:34:10 +0000 (UTC)
Date:	Thu, 4 Aug 2016 11:34:10 +0000
From:	Eric Wong <e@80x24.org>
To:	Jeff King <peff@peff.net>
Cc:	Junio C Hamano <gitster@pobox.com>,
	"Kyle J. McKay" <mackyle@gmail.com>, git@vger.kernel.org,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	Jakub =?utf-8?B?TmFyxJlic2tp?= <jnareb@gmail.com>
Subject: Re: [PATCH v3] pager: move pager-specific setup into the build
Message-ID: <20160804113410.GA13908@starla>
References: <20160801214937.4752-1-e@80x24.org>
 <20160801214937.4752-2-e@80x24.org>
 <20160803161911.dxucq7f2pvnoovoc@sigill.intra.peff.net>
 <xmqq4m718tay.fsf@gitster.mtv.corp.google.com>
 <20160803210821.GA17510@whir>
 <xmqqziot7dv6.fsf@gitster.mtv.corp.google.com>
 <20160804034301.GA31427@starla>
 <20160804053405.ifjjryejgbwkkatt@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20160804053405.ifjjryejgbwkkatt@sigill.intra.peff.net>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Jeff King <peff@peff.net> wrote:
> On Thu, Aug 04, 2016 at 03:43:01AM +0000, Eric Wong wrote:
> 
> > +PAGER_ENV_CQ = "$(subst ",\",$(subst \,\\,$(PAGER_ENV)))"
> > +PAGER_ENV_CQ_SQ = $(subst ','\'',$(PAGER_ENV_CQ))
> > +BASIC_CFLAGS += -DPAGER_ENV='$(PAGER_ENV_CQ_SQ)'
> 
> Here we set up CQ_SQ, but there is no PAGER_ENV_SQ.
> 
> And then...

> > @@ -1766,6 +1782,7 @@ sed -e '1s|#!.*/sh|#!$(SHELL_PATH_SQ)|' \
> >      -e 's|@@GITWEBDIR@@|$(gitwebdir_SQ)|g' \
> >      -e 's|@@PERL@@|$(PERL_PATH_SQ)|g' \
> >      -e 's|@@SANE_TEXT_GREP@@|$(SANE_TEXT_GREP)|g' \
> > +    -e 's|@@PAGER_ENV@@|$(PAGER_ENV_SQ)|g' \
> >      $@.sh >$@+
> >  endef
> 
> Here we depend on writing PAGER_ENV_SQ, which will be blank (and
> git-sh-setup is broken as a result).

Good catch!  And the reason we didn't notice git-sh-setup is
broken is nobody uses git_pager in-tree from that, anymore.
However, I suspect we'll have to support it indefinitely due to
custom scripts and contrib/examples.

Made the following change for v4:

diff --git a/Makefile b/Makefile
index 0b36b5e..fc9b017 100644
--- a/Makefile
+++ b/Makefile
@@ -1641,6 +1641,7 @@ ifdef DEFAULT_HELP_FORMAT
 BASIC_CFLAGS += -DDEFAULT_HELP_FORMAT='"$(DEFAULT_HELP_FORMAT)"'
 endif
 
+PAGER_ENV_SQ = $(subst ','\'',$(PAGER_ENV))
 PAGER_ENV_CQ = "$(subst ",\",$(subst \,\\,$(PAGER_ENV)))"
 PAGER_ENV_CQ_SQ = $(subst ','\'',$(PAGER_ENV_CQ))
 BASIC_CFLAGS += -DPAGER_ENV='$(PAGER_ENV_CQ_SQ)'
diff --git a/t/t7006-pager.sh b/t/t7006-pager.sh
index e4fc5c8..c8dc665 100755
--- a/t/t7006-pager.sh
+++ b/t/t7006-pager.sh
@@ -49,6 +49,19 @@ test_expect_success TTY 'LESS and LV envvars are set for pagination' '
 	grep ^LV= pager-env.out
 '
 
+test_expect_success !MINGW,TTY 'LESS and LV envvars set by git-sh-setup' '
+	(
+		sane_unset LESS LV &&
+		PAGER="env >pager-env.out; wc" &&
+		export PAGER &&
+		PATH="$(git --exec-path):$PATH" &&
+		export PATH &&
+		test_terminal sh -c ". git-sh-setup && git_pager"
+	) &&
+	grep ^LESS= pager-env.out &&
+	grep ^LV= pager-env.out
+'
+
 test_expect_success TTY 'some commands do not use a pager' '
 	rm -f paginated.out &&
 	test_terminal git rev-list HEAD &&

> > --- a/config.mak.uname
> > +++ b/config.mak.uname
> > @@ -209,6 +209,7 @@ ifeq ($(uname_S),FreeBSD)
> >  	HAVE_PATHS_H = YesPlease
> >  	GMTIME_UNRELIABLE_ERRORS = UnfortunatelyYes
> >  	HAVE_BSD_SYSCTL = YesPlease
> > +	PAGER_ENV = LESS=FRX LV=-c MORE=FRX
> >  endif
> 
> Is it worth setting up PAGER_ENV's default values before including
> config.mak.*, and then using "+=" here? That avoids this line getting
> out of sync with the usual defaults.

Good point, but it makes ordering problematic for folks
who want to override it config.mak or command-line.

We may have to do something like we do for BASIC_CFLAGS and
such, but I'm not sure it's worth the effort when somebody
doesn't wants a different value for one of the flags.

> > +static void setup_pager_env(struct argv_array *env)
> > +{
> 
> I know you said you don't like string parsing in C. Here is a patch (on
> top of yours) that converts the parsing to shell, and generates a
> pre-built array-of-struct (this is similar to the big series I posted
> long ago, but just touching this one spot, not invading the whole
> Makefile). Feel free to ignore it as over-engineered, but I thought I'd
> throw it out there in case it appeals.

Yeah, but I'd rather not introduce more complexity into the
build process, either (unless it's a performance-sensitive part,
which this is not).  Also, while my original 2/2 to make it
configurable at runtime was discarded, I wouldn't rule out
somebody making a compelling case for it and it would be
an easier change from the parse-at-runtime code.
