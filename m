Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E80BF2035F
	for <e@80x24.org>; Tue, 25 Oct 2016 21:24:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753415AbcJYVX7 (ORCPT <rfc822;e@80x24.org>);
        Tue, 25 Oct 2016 17:23:59 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:37528 "EHLO dcvr.yhbt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751741AbcJYVX6 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Oct 2016 17:23:58 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
        by dcvr.yhbt.net (Postfix) with ESMTP id BCAF32035F;
        Tue, 25 Oct 2016 21:23:57 +0000 (UTC)
Date:   Tue, 25 Oct 2016 21:23:57 +0000
From:   Eric Wong <e@80x24.org>
To:     Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:     git@vger.kernel.org, Gavin Lambert <github@mirality.co.nz>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-svn: do not reuse caches memoized for a different
 architecture
Message-ID: <20161025212357.GA8683@starla>
References: <653aa0cd566a2486bbc38cfd82ddfcfdfe48271c.1477398004.git.johannes.schindelin@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <653aa0cd566a2486bbc38cfd82ddfcfdfe48271c.1477398004.git.johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <johannes.schindelin@gmx.de> wrote:
> +++ b/perl/Git/SVN.pm
> @@ -1658,6 +1658,11 @@ sub tie_for_persistent_memoization {
>  	if ($memo_backend > 0) {
>  		tie %$hash => 'Git::SVN::Memoize::YAML', "$path.yaml";
>  	} else {
> +		# first verify that any existing file can actually be loaded
> +		# (it may have been saved by an incompatible version)
> +		if (-e "$path.db") {
> +			unlink "$path.db" unless eval { retrieve("$path.db"); 1 };
> +		}

That retrieve() call is unlikely to work without "use Storable"
to import it into the current package.

I also favor setting "$path.db" once to detect typos and avoid
going over 80 columns.  Additionally, having error-checking for
unlink might be useful.

So perhaps squashing this on top:

diff --git a/perl/Git/SVN.pm b/perl/Git/SVN.pm
index 025c894..b3c1460 100644
--- a/perl/Git/SVN.pm
+++ b/perl/Git/SVN.pm
@@ -1660,10 +1660,15 @@ sub tie_for_persistent_memoization {
 	} else {
 		# first verify that any existing file can actually be loaded
 		# (it may have been saved by an incompatible version)
-		if (-e "$path.db") {
-			unlink "$path.db" unless eval { retrieve("$path.db"); 1 };
+		my $db = "$path.db";
+		if (-e $db) {
+			use Storable qw(retrieve);
+
+			if (!eval { retrieve($db); 1 }) {
+				unlink $db or die "unlink $db failed: $!";
+			}
 		}
-		tie %$hash => 'Memoize::Storable', "$path.db", 'nstore';
+		tie %$hash => 'Memoize::Storable', $db, 'nstore';
 	}
 }
 

Thoughts?  Thanks.
