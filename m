Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BCCC71F424
	for <e@80x24.org>; Thu, 19 Apr 2018 10:39:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751695AbeDSKjw (ORCPT <rfc822;e@80x24.org>);
        Thu, 19 Apr 2018 06:39:52 -0400
Received: from zucker2.schokokeks.org ([178.63.68.90]:50777 "EHLO
        zucker2.schokokeks.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751136AbeDSKjv (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Apr 2018 06:39:51 -0400
X-Greylist: delayed 301 seconds by postgrey-1.27 at vger.kernel.org; Thu, 19 Apr 2018 06:39:51 EDT
Received: from localhost (localhost [::1])
  (AUTH: PLAIN simon@ruderich.org, TLS: TLSv1/SSLv3,256bits,ECDHE-RSA-AES256-GCM-SHA384)
  by zucker.schokokeks.org with ESMTPSA; Thu, 19 Apr 2018 12:35:06 +0200
  id 000000000000010F.000000005AD870DA.00002DC2
Date:   Thu, 19 Apr 2018 12:34:47 +0200
From:   Simon Ruderich <simon@ruderich.org>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: Silly "git gc" UI issue.
Message-ID: <20180419103447.GA19591@ruderich.org>
References: <CA+55aFxSZLuk++Dz6SonD+JhbbSDt9G9VcBx5f1CV=6nJC9hvg@mail.gmail.com>
 <xmqqr2ncezdc.fsf@gitster-ct.c.googlers.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
In-Reply-To: <xmqqr2ncezdc.fsf@gitster-ct.c.googlers.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Apr 19, 2018 at 10:52:47AM +0900, Junio C Hamano wrote:
> It turns out that prune silently goes away given a bad expiry
>
>     $ git prune --expire=nyah ; echo $?
>     129

I noticed that git log --since/--after/--before/--until have a
similar behavior and ignore date parsing errors in those options
completely. Is this expected or should we warn the user with
something like the following?

diff --git a/revision.c b/revision.c
index 4e0e193e57..e5ba6c7dfc 100644
--- a/revision.c
+++ b/revision.c
@@ -1794,19 +1794,31 @@ static int handle_revision_opt(struct rev_info *revs, int argc, const char **arg
 		revs->max_age = atoi(optarg);
 		return argcount;
 	} else if ((argcount = parse_long_opt("since", argv, &optarg))) {
-		revs->max_age = approxidate(optarg);
+		int err = 0;
+		revs->max_age = approxidate_careful(optarg, &err);
+		if (err)
+			return error("--since: invalid time '%s'", optarg);
 		return argcount;
 	} else if ((argcount = parse_long_opt("after", argv, &optarg))) {
-		revs->max_age = approxidate(optarg);
+		int err = 0;
+		revs->max_age = approxidate_careful(optarg, &err);
+		if (err)
+			return error("--after: invalid time '%s'", optarg);
 		return argcount;
 	} else if ((argcount = parse_long_opt("min-age", argv, &optarg))) {
 		revs->min_age = atoi(optarg);
 		return argcount;
 	} else if ((argcount = parse_long_opt("before", argv, &optarg))) {
-		revs->min_age = approxidate(optarg);
+		int err = 0;
+		revs->min_age = approxidate_careful(optarg, &err);
+		if (err)
+			return error("--before: invalid time '%s'", optarg);
 		return argcount;
 	} else if ((argcount = parse_long_opt("until", argv, &optarg))) {
-		revs->min_age = approxidate(optarg);
+		int err = 0;
+		revs->min_age = approxidate_careful(optarg, &err);
+		if (err)
+			return error("--until: invalid time '%s'");
 		return argcount;
 	} else if (!strcmp(arg, "--first-parent")) {
 		revs->first_parent_only = 1;

Regards
Simon
-- 
+ privacy is necessary
+ using gnupg http://gnupg.org
+ public key id: 0x92FEFDB7E44C32F9
