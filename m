Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0E5D020248
	for <e@80x24.org>; Mon, 18 Mar 2019 01:56:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726933AbfCRB4M (ORCPT <rfc822;e@80x24.org>);
        Sun, 17 Mar 2019 21:56:12 -0400
Received: from smtprelay0202.hostedemail.com ([216.40.44.202]:53483 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726828AbfCRB4M (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 17 Mar 2019 21:56:12 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay04.hostedemail.com (Postfix) with ESMTP id CFBE2180A8850;
        Mon, 18 Mar 2019 01:56:10 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: star04_18bf1bf090f44
X-Filterd-Recvd-Size: 3025
Received: from XPS-9350.home (unknown [47.151.153.53])
        (Authenticated sender: joe@perches.com)
        by omf19.hostedemail.com (Postfix) with ESMTPA;
        Mon, 18 Mar 2019 01:56:09 +0000 (UTC)
Message-ID: <604795fe60991f22273cbb652eeeedc17985bc65.camel@perches.com>
Subject: Re: [PATCH] send-email: don't cc *-by lines with '-' prefix
From:   Joe Perches <joe@perches.com>
To:     Rasmus Villemoes <rv@rasmusvillemoes.dk>,
        Baruch Siach <baruch@tkos.co.il>, git@vger.kernel.org
Date:   Sun, 17 Mar 2019 18:56:08 -0700
In-Reply-To: <bc20070b-437a-9875-efd0-b4cad1413233@rasmusvillemoes.dk>
References: <eec56beab016182fb78fbd367fcfa97f2ca6a5ff.1552764410.git.baruch@tkos.co.il>
         <bc20070b-437a-9875-efd0-b4cad1413233@rasmusvillemoes.dk>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.1-1build1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, 2019-03-17 at 20:27 +0100, Rasmus Villemoes wrote:
> On 16/03/2019 20.26, Baruch Siach wrote:
> > Since commit ef0cc1df90f6b ("send-email: also pick up cc addresses from
> > -by trailers") in git version 2.20, git send-email adds to cc list
> > addresses from all *-by lines. As a side effect a line with
> > '-Signed-off-by' is now also added to cc. This makes send-email pick
> > lines from patches that remove patch files from the git repo. This is
> > common in the Buildroot project that often removes (and adds) patch
> > files that have 'Signed-off-by' in their patch description part.
> 
> Yocto/OpenEmbedded and other projects do the same
> 
> > Consider only *-by lines that start with [a-z] (case insensitive) to
> > avoid unrelated addresses in cc.
> 
> While I agree with Joe in principle that we really should not look
> inside the diff part, all lines there start with [ +-], so we wouldn't
> normally pick up anything from that due to the anchoring. Except for the
> misc-by regexp that added hyphens to grab Reported-and-tested-by and
> similar. So this is by far the simplest fix that doesn't hurt the common
> use cases the misc-by handling was added to support, so
> 
> Acked-by: Rasmus Villemoes <rv@rasmusvillemoes.dk>

My preference would be for correctness.
I presume something like this isn't too onerous.
---
 git-send-email.perl | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/git-send-email.perl b/git-send-email.perl
index 8200d58cdc..83b0429576 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -1697,9 +1697,10 @@ sub process_file {
 		}
 	}
 	# Now parse the message body
+	my $in_patch = 0;
 	while(<$fh>) {
 		$message .=  $_;
-		if (/^([a-z-]*-by|Cc): (.*)/i) {
+		if (!$in_patch && /^([a-z-]*-by|Cc): (.*)/i) {
 			chomp;
 			my ($what, $c) = ($1, $2);
 			# strip garbage for the address we'll use:
@@ -1725,6 +1726,8 @@ sub process_file {
 			push @cc, $c;
 			printf(__("(body) Adding cc: %s from line '%s'\n"),
 				$c, $_) unless $quiet;
+		} elsif (/^---/) {
+			$in_patch = 1;
 		}
 	}
 	close $fh;



