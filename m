X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Eric Wong <normalperson@yhbt.net>
Subject: Re: Problems with git-svn authors file
Date: Mon, 11 Dec 2006 20:25:58 -0800
Message-ID: <20061212042558.GA31795@soma>
References: <20061210172604.GA18385@hermes.lan.home.vilz.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Tue, 12 Dec 2006 04:26:12 +0000 (UTC)
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <20061210172604.GA18385@hermes.lan.home.vilz.de>
User-Agent: Mutt/1.5.13 (2006-08-11)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34059>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GtzDV-00075u-6I for gcvg-git@gmane.org; Tue, 12 Dec
 2006 05:26:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1751066AbWLLE0B (ORCPT <rfc822;gcvg-git@m.gmane.org>); Mon, 11 Dec 2006
 23:26:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751070AbWLLE0B
 (ORCPT <rfc822;git-outgoing>); Mon, 11 Dec 2006 23:26:01 -0500
Received: from hand.yhbt.net ([66.150.188.102]:53027 "EHLO hand.yhbt.net"
 rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP id S1751066AbWLLE0A
 (ORCPT <rfc822;git@vger.kernel.org>); Mon, 11 Dec 2006 23:26:00 -0500
Received: from hand.yhbt.net (localhost [127.0.0.1]) by hand.yhbt.net
 (Postfix) with SMTP id C59287DC02A; Mon, 11 Dec 2006 20:25:58 -0800 (PST)
Received: by hand.yhbt.net (sSMTP sendmail emulation); Mon, 11 Dec 2006
 20:25:58 -0800
To: Nicolas Vilz <niv@iaglans.de>
Sender: git-owner@vger.kernel.org

Nicolas Vilz <niv@iaglans.de> wrote:
> hello,
> 
> i tried to use git-svn with author-files and got stuck with following
> error message:
> 
> Use of uninitialized value in hash element at /usr/bin/git-svn line
> 2952.
> Use of uninitialized value in concatenation (.) or string at
> /usr/bin/git-svn line 2953.
> Author:  not defined in .git/info/svn-authors file
> 512 at /usr/bin/git-svn line 457
>         main::fetch_lib() called at /usr/bin/git-svn line 328
>         main::fetch() called at /usr/bin/git-svn line 187

> Am i doing something wrong?

No, this is just a bug in git-svn.

After the following patch, you should be able to use
--------------------------------------------
(no author) = real-name <email address>
--------------------------------------------
in your authors file.

-- 
Eric Wong

From b40e14605809b0b1501002a333fbd680913f127f Mon Sep 17 00:00:00 2001
From: Eric Wong <normalperson@yhbt.net>
Date: Mon, 11 Dec 2006 20:22:29 -0800
Subject: [PATCH] git-svn: correctly handle "(no author)" when using an authors file

The low-level parts of the SVN library return NULL/undef for
author-less revisions, whereas "(no author)" is a (svn) client
convention.

Signed-off-by: Eric Wong <normalperson@yhbt.net>
---
 git-svn.perl |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/git-svn.perl b/git-svn.perl
index 1f8a3b0..17ebb77 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -2948,7 +2948,8 @@ sub libsvn_log_entry {
 	my ($Y,$m,$d,$H,$M,$S) = ($date =~ /^(\d{4})\-(\d\d)\-(\d\d)T
 					 (\d\d)\:(\d\d)\:(\d\d).\d+Z$/x)
 				or die "Unable to parse date: $date\n";
-	if (defined $_authors && ! defined $users{$author}) {
+	if (defined $author && length $author > 0 &&
+	    defined $_authors && ! defined $users{$author}) {
 		die "Author: $author not defined in $_authors file\n";
 	}
 	$msg = '' if ($rev == 0 && !defined $msg);
-- 
