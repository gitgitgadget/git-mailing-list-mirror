Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BE5DF20179
	for <e@80x24.org>; Sun,  3 Jul 2016 06:56:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751889AbcGCGzA (ORCPT <rfc822;e@80x24.org>);
	Sun, 3 Jul 2016 02:55:00 -0400
Received: from ns1.signalpunk.com ([74.86.59.106]:48316 "EHLO
	ns1.signalpunk.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750801AbcGCGzA (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Jul 2016 02:55:00 -0400
X-Greylist: delayed 316 seconds by postgrey-1.27 at vger.kernel.org; Sun, 03 Jul 2016 02:55:00 EDT
Received: from [192.168.1.3] (ns1.signalpunk.com [74.86.59.106])
	(Authenticated sender: clayne)
	by ns1.signalpunk.com (Postfix) with ESMTPSA id 5FFCD58210520;
	Sun,  3 Jul 2016 06:49:40 +0000 (GMT)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH] git-svn: clone: Fail on missing url argument
From:	Christopher Layne <clayne@anodized.com>
In-Reply-To: <20160703061553.GA20458@dcvr.yhbt.net>
Date:	Sat, 2 Jul 2016 23:49:38 -0700
Cc:	git@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <6A207591-312F-4C62-8C69-2742E44146F4@anodized.com>
References: <20160703053923.GA12956@ns1.signalpunk.com> <20160703061553.GA20458@dcvr.yhbt.net>
To:	Eric Wong <e@80x24.org>
X-Mailer: Apple Mail (2.3124)
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org


> On Jul 2, 2016, at 2315 PT, Eric Wong <e@80x24.org> wrote:
>> sub cmd_clone {
>> 	my ($url, $path) = @_;
>> -	if (!defined $path &&
>> +	if (!$url) {
>> +		die "SVN repository location required ",
>> +		    "as a command-line argument\n";
> 
> "as a command-line argument" seems like an unnecessary phrase,
> but I see we use it elsewhere; so it's fine here.
> 
> I might be tempted to queue up a separate patch
> to eliminate this extra statement from the rest of git-svn,
> though.  Not sure if others feel the same way.

I basically went with the same logic/error message that cmd_init()
was using a couple of lines down in an attempt to stay consistent:

 527 sub cmd_init {
 528         if (defined $_stdlayout) {
 529                 $_trunk = 'trunk' if (!defined $_trunk);
 530                 @_tags = 'tags' if (! @_tags);
 531                 @_branches = 'branches' if (! @_branches);
 532         }
 533         if (defined $_trunk || @_branches || @_tags) {
 534                 return cmd_multi_init(@_);
 535         }
 536         my $url = shift or die "SVN repository location required ",
 537                                "as a command-line argument\n";
 538         $url = canonicalize_url($url);
 539         init_subdir(@_);
 540         do_git_init_db();
 541 
 542         if ($Git::SVN::_minimize_url eq 'unset') {
 543                 $Git::SVN::_minimize_url = 0;
 544         }
 545 
 546         Git::SVN->init($url);
 547 }

-cl
