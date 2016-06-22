Return-Path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 97528201CE
	for <e@80x24.org>; Wed, 22 Jun 2016 22:58:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752967AbcFVW6n (ORCPT <rfc822;e@80x24.org>);
	Wed, 22 Jun 2016 18:58:43 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:45666 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752452AbcFVW6k (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Jun 2016 18:58:40 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id 106B3201B4;
	Wed, 22 Jun 2016 22:58:40 +0000 (UTC)
Date:	Wed, 22 Jun 2016 22:58:39 +0000
From:	Eric Wong <e@80x24.org>
To:	=?utf-8?B?0JDQu9C10LrRgdCw0L3QtNGAINCe0LLRh9C40L3QvdC40LrQvtCy?= 
	<proff@proff.email>, Junio C Hamano <gitster@pobox.com>
Cc:	"git@vger.kernel.org" <git@vger.kernel.org>,
	Jakob Stoklund Olesen <stoklund@2pi.dk>,
	Sam Vilain <sam@vilain.net>,
	Steven Walter <stevenrwalter@gmail.com>,
	Peter Baumann <waste.manager@gmx.de>,
	Andrew Myrick <amyrick@apple.com>,
	Michael Contreras <michael@inetric.com>
Subject: Re: may be bug in svn fetch no-follow-parent
Message-ID: <20160622225839.GA30828@dcvr.yhbt.net>
References: <4094761466408188@web24o.yandex.ru>
 <20160620215253.GA16566@dcvr.yhbt.net>
 <2518541466501215@web27h.yandex.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2518541466501215@web27h.yandex.ru>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Александр Овчинников <proff@proff.email> wrote:
> Unfortunately this is not open source repository. I agree that it is pointless try to handle mergeinfo (because it always fails).
> Cases when it is expensive:
> 1. delete and restore mergeinfo property
> 2. merge trunk to very old branch
> 3. create, delete, create branch with --no-follow-parent. All records in mergeinfo will be hadled like new.
> 
> I already patched like this and this is helpfull, works fine and fast.

Thanks for the info.  Patch + pull request below for Junio.

> I can share only mergeinfo property

Oops, looks like your zip attachment got flagged as spam for
my mailbox and swallowed by vger.kernel.org :x

---------8<--------
Subject: [PATCH] git-svn: skip mergeinfo handling with --no-follow-parent

For repositories without parent following enabled, finding
git parents through svn:mergeinfo or svk::parents can be
expensive and pointless.

Reported-by: Александр Овчинников <proff@proff.email>
	http://mid.gmane.org/4094761466408188@web24o.yandex.ru

Signed-off-by: Eric Wong <e@80x24.org>
---
  The following changes since commit ab7797dbe95fff38d9265869ea367020046db118:

    Start the post-2.9 cycle (2016-06-20 11:06:49 -0700)

  are available in the git repository at:

    git://bogomips.org/git-svn.git svn-nfp-mergeinfo

  for you to fetch changes up to 6d523a3ab76cfa4ed9ae0ed9da7af43efcff3f07:

    git-svn: skip mergeinfo handling with --no-follow-parent (2016-06-22 22:48:54 +0000)

  ----------------------------------------------------------------
  Eric Wong (1):
        git-svn: skip mergeinfo handling with --no-follow-parent

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
