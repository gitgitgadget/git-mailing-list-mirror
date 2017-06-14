Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E523E1FA7B
	for <e@80x24.org>; Wed, 14 Jun 2017 05:30:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752602AbdFNFaV (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Jun 2017 01:30:21 -0400
Received: from cloud.peff.net ([104.130.231.41]:39689 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750751AbdFNFaV (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Jun 2017 01:30:21 -0400
Received: (qmail 31285 invoked by uid 109); 14 Jun 2017 05:30:21 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 14 Jun 2017 05:30:21 +0000
Received: (qmail 8313 invoked by uid 111); 14 Jun 2017 05:30:22 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 14 Jun 2017 01:30:22 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 14 Jun 2017 01:30:18 -0400
Date:   Wed, 14 Jun 2017 01:30:18 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?Q?=C3=98yvind_A=2E?= Holm <sunny@sunbase.org>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Git mailing list <git@vger.kernel.org>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] configure.ac: loosen FREAD_READS_DIRECTORIES test program
Message-ID: <20170614053018.pbeftfyz2md4o73h@sigill.intra.peff.net>
References: <20170614011514.sh4euddp44hjbu4u@sunbase.org>
 <20170614012535.GU133952@aiede.mtv.corp.google.com>
 <20170614021739.erkdifufziwiqjxp@sunbase.org>
 <20170614050215.c32crnjifah6cxae@sigill.intra.peff.net>
 <20170614051544.cz2zvnkc4mlysz7h@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20170614051544.cz2zvnkc4mlysz7h@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jun 14, 2017 at 01:15:44AM -0400, Jeff King wrote:

> > I couldn't reproduce either with my usual build, but I don't usually use
> > autoconf. Running:
> > 
> >   make configure
> >   ./configure
> >   make
> >   (cd t && ./t1308-*)
> > 
> > does fail for me. The problem is that the generated config.mak.autogen
> > sets the wrong value for FREAD_READS_DIRECTORIES (and overrides the
> > default entry for Linux from config.mak.uname. So the configure script
> > needs to be fixed.
> 
> Actually, I'm not sure if configure.ac is wrong, or the new uses of
> FREAD_READS_DIRECTORIES. Because the test configure.ac actually checks:

Poking around more, I think the best thing is to just update the
configure script. The rationale is below.

-- >8 --
Subject: [PATCH] configure.ac: loosen FREAD_READS_DIRECTORIES test program

We added an FREAD_READS_DIRECTORIES Makefile knob long ago
in cba22528f (Add compat/fopen.c which returns NULL on
attempt to open directory, 2008-02-08) to handle systems
where reading from a directory returned garbage. This works
by catching the problem at the fopen() stage and returning
NULL.

More recently, we found that there is a class of systems
(including Linux) where fopen() succeeds but fread() fails.
Since the solution is the same (having fopen return NULL),
they use the same Makefile knob as of e2d90fd1c
(config.mak.uname: set FREAD_READS_DIRECTORIES for Linux and
FreeBSD, 2017-05-03).

This works fine except for one thing: the autoconf test in
configure.ac to set FREAD_READS_DIRECTORIES actually checks
whether fread succeeds. Which means that on Linux systems,
the knob isn't set (and we even override the config.mak.uname
default). t1308 catches the failure.

We can fix this by tweaking the autoconf test to cover both
cases. In theory we might care about the distinction between
the traditional "fread reads directories" case and the new
"fopen opens directories". But since our solution catches
the problem at the fopen stage either way, we don't actually
need to know the difference. The "fopen" case is a superset.

This does mean the FREAD_READS_DIRECTORIES name is slightly
misleading. Probably FOPEN_OPENS_DIRECTORIES would be more
accurate. But it would be disruptive to simply change the
name (people's existing build configs would fail), and it's
not worth the complexity of handling both. Let's just add a
comment in the knob description.

Reported-by: Øyvind A. Holm <sunny@sunbase.org>
Signed-off-by: Jeff King <peff@peff.net>
---
 Makefile     | 3 ++-
 configure.ac | 4 ++--
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/Makefile b/Makefile
index 7c621f7f7..33b888730 100644
--- a/Makefile
+++ b/Makefile
@@ -19,7 +19,8 @@ all::
 # have been written to the final string if enough space had been available.
 #
 # Define FREAD_READS_DIRECTORIES if you are on a system which succeeds
-# when attempting to read from an fopen'ed directory.
+# when attempting to read from an fopen'ed directory (or even to fopen
+# it at all).
 #
 # Define NO_OPENSSL environment variable if you do not have OpenSSL.
 # This also implies BLK_SHA1.
diff --git a/configure.ac b/configure.ac
index deeb968da..602383ed1 100644
--- a/configure.ac
+++ b/configure.ac
@@ -869,9 +869,9 @@ AC_CACHE_CHECK([whether system succeeds to read fopen'ed directory],
 [
 AC_RUN_IFELSE(
 	[AC_LANG_PROGRAM([AC_INCLUDES_DEFAULT],
-		[[char c;
+		[[
 		FILE *f = fopen(".", "r");
-		return f && fread(&c, 1, 1, f)]])],
+		return f)]])],
 	[ac_cv_fread_reads_directories=no],
 	[ac_cv_fread_reads_directories=yes])
 ])
-- 
2.13.1.766.g6bea926c5

