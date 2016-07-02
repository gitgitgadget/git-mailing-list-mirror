Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B16911F744
	for <e@80x24.org>; Sat,  2 Jul 2016 10:42:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751923AbcGBKm5 (ORCPT <rfc822;e@80x24.org>);
	Sat, 2 Jul 2016 06:42:57 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:51342 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751869AbcGBKm4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 2 Jul 2016 06:42:56 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2E6111F744;
	Sat,  2 Jul 2016 10:33:18 +0000 (UTC)
Date:	Sat, 2 Jul 2016 10:33:18 +0000
From:	Eric Wong <e@80x24.org>
To:	Christian Couder <christian.couder@gmail.com>,
	Jacob Godserv <jacobgodserv@gmail.com>
Cc:	Christian Couder <chriscool@tuxfamily.org>, git@vger.kernel.org
Subject: [PATCH] git-svn: warn instead of dying when commit data is missing
Message-ID: <20160702103317.GA6120@dcvr.yhbt.net>
References: <CALi1mtc8zmOzk-qv4XAg6N=ENasnMAENdJSLHK7EcpxRUk1nTw@mail.gmail.com>
 <CALi1mtdtNF_GtzyPTbfb7N51wwxsFY7zm8hsgwxr3tHcZZboyg@mail.gmail.com>
 <20160624193548.GA22070@dcvr.yhbt.net>
 <CALi1mtc6Byb39kbAv16vmkUVu3JDdGG4-yVrLroDVraPDxGFng@mail.gmail.com>
 <20160624200603.GA28498@dcvr.yhbt.net>
 <CAP8UFD0+vG3i26=w7WqjYcpOLj+V6X35_W6DAiMmTpiC2kxRWA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAP8UFD0+vG3i26=w7WqjYcpOLj+V6X35_W6DAiMmTpiC2kxRWA@mail.gmail.com>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Christian Couder <christian.couder@gmail.com> wrote:
> On Fri, Jun 24, 2016 at 10:06 PM, Eric Wong <e@80x24.org> wrote:
> > Jacob Godserv <jacobgodserv@gmail.com> wrote:
> >> > Christian (Cc-ed) also noticed the problem a few weeks ago
> >> > and took a more drastic approach by having git-svn die
> >> > instead of warning:
> >> > http://mid.gmane.org/1462604323-18545-1-git-send-email-chriscool@tuxfamily.org
> >> > which landed as commit 523a33ca17c76bee007d7394fb3930266c577c02
> >> > in git.git: https://bogomips.org/mirrors/git.git/patch?id=523a33ca17c7
> >> >
> >> > Is dying here too drastic and maybe warn is preferable?
> >>
> >> In my opinion this is too drastic. It keeps me from storing
> >> git-specific data on a git-svn mirror.
> >
> > I tend to agree, but will wait to see what Christian thinks.
> 
> Yeah a warning is probably enough.

OK, patch below.

> Another possibility would be to default to an error that tells people
> about a configuration variable that could let them decide depending on
> their workflow if this should be an error, a warning or just be
> ignored.

I think that's too much.  I'm not a fan of having too many
configuration variables to throw on users.

------8<------
Subject: [PATCH] git-svn: warn instead of dying when commit data is missing

It is possible to have refs globbed by git-svn which stores data
purely in git; gently skip those instead of dying and assuming
user error.

ref: http://mid.gmane.org/CALi1mtdtNF_GtzyPTbfb7N51wwxsFY7zm8hsgwxr3tHcZZboyg@mail.gmail.com

Suggested-by: Jacob Godserv <jacobgodserv@gmail.com>
Cc: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Eric Wong <e@80x24.org>
---
 perl/Git/SVN.pm | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/perl/Git/SVN.pm b/perl/Git/SVN.pm
index bee1e7d..018beb8 100644
--- a/perl/Git/SVN.pm
+++ b/perl/Git/SVN.pm
@@ -97,8 +97,12 @@ sub resolve_local_globs {
 				    "existing: $existing\n",
 				    " globbed: $refname\n";
 			}
-			my $u = (::cmt_metadata("$refname"))[0] or die
-			    "$refname: no associated commit metadata\n";
+			my $u = (::cmt_metadata("$refname"))[0];
+			if (!defined($u)) {
+				warn
+"W: $refname: no associated commit metadata from SVN, skipping\n";
+				next;
+			}
 			$u =~ s!^\Q$url\E(/|$)!! or die
 			  "$refname: '$url' not found in '$u'\n";
 			if ($pathname ne $u) {
-- 
EW
