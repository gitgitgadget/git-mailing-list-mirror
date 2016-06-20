Return-Path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 174E61FF40
	for <e@80x24.org>; Mon, 20 Jun 2016 21:52:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752441AbcFTVwy (ORCPT <rfc822;e@80x24.org>);
	Mon, 20 Jun 2016 17:52:54 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:39636 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751235AbcFTVwy (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Jun 2016 17:52:54 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8DD691FEAA;
	Mon, 20 Jun 2016 21:52:53 +0000 (UTC)
Date:	Mon, 20 Jun 2016 21:52:53 +0000
From:	Eric Wong <e@80x24.org>
To:	=?utf-8?B?0JDQu9C10LrRgdCw0L3QtNGAINCe0LLRh9C40L3QvdC40LrQvtCy?= 
	<proff@proff.email>
Cc:	git@vger.kernel.org, Jakob Stoklund Olesen <stoklund@2pi.dk>,
	Sam Vilain <sam@vilain.net>,
	Steven Walter <stevenrwalter@gmail.com>,
	Peter Baumann <waste.manager@gmx.de>,
	Andrew Myrick <amyrick@apple.com>,
	Michael Contreras <michael@inetric.com>
Subject: Re: may be bug in svn fetch no-follow-parent
Message-ID: <20160620215253.GA16566@dcvr.yhbt.net>
References: <4094761466408188@web24o.yandex.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4094761466408188@web24o.yandex.ru>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

+Cc: a bunch of folks who may know better how mergeinfo works in git-svn

Александр Овчинников <proff@proff.email> wrote:
> Why git svn fetch try to handle mergeinfo changes when
> no-follow-parent is enabled?

It probably should not...  --no-follow-parent isn't a common
config, though.  Can you try the patch below?

> Git try to follow parents regardless of this option value.
> If branch created without this option then git will follow
> parent succesfully
> If branch created with this option then git try to follow and
> fail with "cannot find common ancestor" error
> If branch does not exists (ignored) then git try to follow and
> fail with "couldn't find revmap" error. It is very long
> operation

Do you have an example repo you could share with us?

Thanks.

I still don't think I've encountered a repo which uses
mergeinfo myself.
Hopefully the following patch works for you:

---------8<--------
Subject: [PATCH] git-svn: skip mergeinfo with --no-follow-parent

For repositories without parent following enabled, computing
mergeinfo can be expensive and pointless.

Note: Only tested on existing test cases.
---
 perl/Git/SVN.pm | 25 ++++++++++++++++---------
 1 file changed, 16 insertions(+), 9 deletions(-)

diff --git a/perl/Git/SVN.pm b/perl/Git/SVN.pm
index d94d01c..bee1e7d 100644
--- a/perl/Git/SVN.pm
+++ b/perl/Git/SVN.pm
@@ -1905,15 +1905,22 @@ sub make_log_entry {
 
 	my @parents = @$parents;
 	my $props = $ed->{dir_prop}{$self->path};
-	if ( $props->{"svk:merge"} ) {
-		$self->find_extra_svk_parents($props->{"svk:merge"}, \@parents);
-	}
-	if ( $props->{"svn:mergeinfo"} ) {
-		my $mi_changes = $self->mergeinfo_changes
-			($parent_path, $parent_rev,
-			 $self->path, $rev,
-			 $props->{"svn:mergeinfo"});
-		$self->find_extra_svn_parents($mi_changes, \@parents);
+	if ($self->follow_parent) {
+		my $tickets = $props->{"svk:merge"};
+		if ($tickets) {
+			$self->find_extra_svk_parents($tickets, \@parents);
+		}
+
+		my $mergeinfo_prop = $props->{"svn:mergeinfo"};
+		if ($mergeinfo_prop) {
+			my $mi_changes = $self->mergeinfo_changes(
+						$parent_path,
+						$parent_rev,
+						$self->path,
+						$rev,
+						$mergeinfo_prop);
+			$self->find_extra_svn_parents($mi_changes, \@parents);
+		}
 	}
 
 	open my $un, '>>', "$self->{dir}/unhandled.log" or croak $!;
-- 
EW
