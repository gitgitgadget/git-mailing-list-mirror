Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7C82A1F404
	for <e@80x24.org>; Wed, 21 Feb 2018 23:13:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751000AbeBUXNA (ORCPT <rfc822;e@80x24.org>);
        Wed, 21 Feb 2018 18:13:00 -0500
Received: from titan.plasma.xg8.de ([85.10.203.189]:37622 "EHLO
        titan.PLASMA.Xg8.DE" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750741AbeBUXM7 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Feb 2018 18:12:59 -0500
Received: from titan.PLASMA.Xg8.DE (localhost [127.0.0.1])
        by titan.PLASMA.Xg8.DE (8.15.2/8.15.2) with ESMTPS id w1LNCpjU005448
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 22 Feb 2018 00:12:51 +0100
Received: (from uucp@localhost)
        by titan.PLASMA.Xg8.DE (8.15.2/8.15.2/Submit) with UUCP id w1LNCpSY005447;
        Thu, 22 Feb 2018 00:12:51 +0100
Received: from helen.PLASMA.Xg8.DE (localhost.localdomain [127.0.0.1])
        by helen.PLASMA.Xg8.DE (8.15.2/8.15.2) with ESMTP id w1LNCYMk008891;
        Thu, 22 Feb 2018 00:12:34 +0100
Received: (from rtc@localhost)
        by helen.PLASMA.Xg8.DE (8.15.2/8.15.2/Submit) id w1LNCYEj008890;
        Thu, 22 Feb 2018 00:12:34 +0100
Date:   Thu, 22 Feb 2018 00:12:34 +0100
From:   Peter Backes <rtc@helen.PLASMA.Xg8.DE>
To:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
Cc:     Derek Fawcus <dfawcus+lists-git@employees.org>,
        git@vger.kernel.org, "Theodore Ts'o" <tytso@mit.edu>
Subject: Re: Git should preserve modification times at least on request
Message-ID: <20180221231234.GA8509@helen.PLASMA.Xg8.DE>
References: <20180219212235.GA9891@helen.PLASMA.Xg8.DE>
 <20180221210339.GA43094@accordion.employees.org>
 <87bmgif2pa.fsf@evledraar.gmail.com>
 <20180221221420.GA7743@helen.PLASMA.Xg8.DE>
 <87a7w2ezeq.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87a7w2ezeq.fsf@evledraar.gmail.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Feb 21, 2018 at 11:44:13PM +0100, Ævar Arnfjörð Bjarmason wrote:
> If it were added as a first-level feature to git it would present a lot
> of UX confusion. E.g. you run "git add" and it'll be showing the mtime
> somehow, or you get a formatted patch over E-Mail and it doesn't only
> include the commit time but also times for individual files.

But that's pretty standard. patch format has timestamp fields for 
precisely this purpose:

% echo a > x  
% echo b > y
% diff -u x y
--- x	2018-02-21 23:56:29.574029523 +0100
+++ y	2018-02-21 23:56:31.430003389 +0100
@@ -1 +1 @@
-a
+b

At present, git simply leaves those fields blank...

> The VC systems that had this feature in the past were centralized, so
> they could (in theory anyway) ensure that timestamps were monotonically
> increasing. This won't be the case with git, we have plenty of timestamp
> drift in e.g. linux.git and other git repos.

I don't see where monotonicity would be an issue any more than it is 
for centralized version control systems.

Even in the centralized setting, monotonicity is not guaranteed, since 
you might have local timestamps deviating from the repository; you 
might have added a line, compiled, and removed it again later on, 
without running make again. Now if you checkout changes from the 
repository, and it sets the timestamp, that timestamp might be older 
than before the compile, and the file would not be rebuilt if you run 
make. So you cannot avoid those issues in centralized setttings either.

> So if these mtimes were used by default they'd interact badly with stuff
> like "make" in those cases, because you might check out a modified
> version with a timestamp in the past.

That's very clearly the case, and I have stressed in my initial email 
that I fully agree with the reasoning of the FAQ in this regard. It is, 
however, merely an argument against *restoring* the timestamps *by 
default*, to comply with the principle of least astonishment. It is, by 
itself, not an argument against *storing* the timestamps, let alone 
against restoring them *on request*.

For the initial checkout, it should not even be harmful to restore the 
timestamps by default.

> any case, I just wanted to point out a workaround (but then digressed
> into critiquing the idea above...).

Well, Johannes's proposed solution seems pretty reasonable and 
realistic to me.  Thanks to Phillip's hint about unquote_path() in 
Git.pm it seems I now have all the needed ingredients to implement this 
feature.

Best wishes
Peter

-- 
Peter Backes, rtc@helen.PLASMA.Xg8.DE
