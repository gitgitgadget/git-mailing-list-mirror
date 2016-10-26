Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4127D2022A
	for <e@80x24.org>; Wed, 26 Oct 2016 19:10:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932519AbcJZTKZ (ORCPT <rfc822;e@80x24.org>);
        Wed, 26 Oct 2016 15:10:25 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:38826 "EHLO dcvr.yhbt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932366AbcJZTKY (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Oct 2016 15:10:24 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
        by dcvr.yhbt.net (Postfix) with ESMTP id E60182022A;
        Wed, 26 Oct 2016 19:10:23 +0000 (UTC)
Date:   Wed, 26 Oct 2016 19:10:23 +0000
From:   Eric Wong <e@80x24.org>
To:     Tao Peng <pengtao@me.com>
Cc:     git@vger.kernel.org, Vineet Kumar <vineet@doorstop.net>
Subject: Re: A bug with "git svn show-externals"
Message-ID: <20161026191023.GA24666@starla>
References: <B8D25850-A4DE-435C-A856-240D612D59DA@me.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <B8D25850-A4DE-435C-A856-240D612D59DA@me.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Tao Peng <pengtao@me.com> wrote:
> Hi there,
> 
> I met a bug of the "git svn show-externals” command.  If a subdirectory item has a svn:externals property, and the format of the property is “URL first, then the local path”, running "git svn show-externals” command at the root level will result in an unusable output.
> 
> Example:
> $ svn pg svn:externals svn+ssh://src.foo.com/svn/ref/English.lproj/
> svn+ssh://src.foo.com/svn/orig/trunk/Resources/English.lproj/Localizable.strings Localizable.strings

+Cc Vineet who originally implemented this 9 years ago

I've never used externals much, but I guess it's common for
externals to be a full URL and not merely a relative path
to somewhere within the same SVN repo.

> $ git svn show-externals
> # /English.lproj/
> /English.lproj/svn+ssh://src.foo.com/svn/orig/trunk/Resources/English.lproj/Localizable.strings Localizable.strings

> 
> This bug is preventing my script from correctly finishing the svn-to-git repo migration work. Does anyone know a workaround to this bug?

Can you try the following change to ignore path prefixing for
full URLs?

diff --git a/git-svn.perl b/git-svn.perl
index 4d41d22..ced665a 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -1303,7 +1303,9 @@ sub cmd_show_externals {
 		my $s = $props->{'svn:externals'} or return;
 		$s =~ s/[\r\n]+/\n/g;
 		chomp $s;
-		$s =~ s#^#$path#gm;
+		if ($s !~ m#^[a-z\+]+://#i) {
+			$s =~ s#^#$path#gm;
+		}
 		print STDOUT "$s\n";
 	});
 }
