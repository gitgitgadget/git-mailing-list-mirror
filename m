Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 14C0F1F454
	for <e@80x24.org>; Sat,  2 Nov 2019 20:14:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726685AbfKBUOh (ORCPT <rfc822;e@80x24.org>);
        Sat, 2 Nov 2019 16:14:37 -0400
Received: from elephants.elehost.com ([216.66.27.132]:34567 "EHLO
        elephants.elehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726523AbfKBUOh (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 2 Nov 2019 16:14:37 -0400
X-Virus-Scanned: amavisd-new at elehost.com
Received: from Madrigal (CPE00fc8d49d843-CM00fc8d49d840.cpe.net.cable.rogers.com [99.229.179.249])
        (authenticated bits=0)
        by elephants.elehost.com (8.15.2/8.15.2) with ESMTPSA id xA2KEJLv073857
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Sat, 2 Nov 2019 16:14:21 -0400 (EDT)
        (envelope-from rsbecker@nexbridge.com)
From:   <rsbecker@nexbridge.com>
To:     "'brian m. carlson'" <sandals@crustytoothpaste.net>,
        <git@vger.kernel.org>
Cc:     "'Junio C Hamano'" <gitster@pobox.com>,
        "'Jeff King'" <peff@peff.net>
References: <20191102192615.10013-1-sandals@crustytoothpaste.net> <20191102192615.10013-4-sandals@crustytoothpaste.net>
In-Reply-To: <20191102192615.10013-4-sandals@crustytoothpaste.net>
Subject: RE: [PATCH v3 3/4] doc: dissuade users from trying to ignore tracked files
Date:   Sat, 2 Nov 2019 16:14:14 -0400
Message-ID: <001501d591ba$1d190060$574b0120$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQIMicffZ8Y2oLnk50uXRkxNxJArcAJnsAwQpvcclFA=
Content-Language: en-ca
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On November 2, 2019 3:26 PM, brian m. carlson wrote:
> It is quite common for users to want to ignore the changes to a file that
Git
> tracks.  Common scenarios for this case are IDE settings and configuration
> files, which should generally not be tracked and possibly generated from
> tracked files using a templating mechanism.
> 
> However, users learn about the assume-unchanged and skip-worktree bits
> and try to use them to do this anyway.  This is problematic, because when
> these bits are set, many operations behave as the user expects, but they
> usually do not help when git checkout needs to replace a file.
> 
> There is no sensible behavior in this case, because sometimes the data is
> precious, such as certain configuration files, and sometimes it is
irrelevant
> data that the user would be happy to discard.
> 
> Since this is not a supported configuration and users are prone to misuse
the
> existing features for unintended purposes, causing general sadness and
> confusion, let's document the existing behavior and the pitfalls in the
> documentation for git update-index so that users know they should explore
> alternate solutions.
> 
> In additon, let's provide a recommended solution to dealing with the
> common case of configuration files, since there are well-known approaches
> used successfully in many environments.

Just noodling about a potential solution. If we assume the use case that
files are modified by an IDE that have no real relevance, but should not
interfere with other git operations including checkout...

What if we introduce something like .gitignore.changes, with the same syntax
as .gitignore. The difference is files listed in this file will not show in
git status (or could show as "changes ignored" with an option to enable
that. The only way to have the changes considered would be git add -f, so
git add . and git commit -a would not pick up the changes. From checkout's
perspective, the file would be considered unmodified so if a change is
incoming for that path, checkout replaces it instead of rejecting the
checkout, otherwise the file is untouched. Pull would act similarly. Branch
switching would be permitted without stashing the files - they would remain
unchanged unless the switch modified the files.

OTOH, this is a change that is most relevant to IDE users, so JGit would
have to implement it as well to really get any real benefit.

This does have some benefit in post-install situations as well as the IDE
use-case, but for that I might want to consider finer granularity, like some
way to identify regions of files being ignored. This being a pretty deep
rabbit hole we'd end up following.

If this idea seems reasonable, it might make a nice small project for
someone, possibly me, if I could unentangle from my current hellish $DAYJOB
project.

Just my few coins of thought.

Randall


