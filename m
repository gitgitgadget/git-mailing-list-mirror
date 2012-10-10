From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH/RFC v2] git svn: work around SVN 1.7 mishandling of
 svn:special changes
Date: Wed, 10 Oct 2012 20:11:25 +0000
Message-ID: <20121010201125.GA30952@dcvr.yhbt.net>
References: <1343468872-72133-1-git-send-email-schwern@pobox.com>
 <1343468872-72133-8-git-send-email-schwern@pobox.com>
 <20121006192455.GA14969@elie.Belkin>
 <20121009101239.GA28120@elie.Belkin>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Michael G. Schwern" <schwern@pobox.com>, git@vger.kernel.org,
	gitster@pobox.com, robbat2@gentoo.org, bwalton@artsci.utoronto.ca
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Oct 10 22:11:40 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TM2cz-0007QO-QF
	for gcvg-git-2@plane.gmane.org; Wed, 10 Oct 2012 22:11:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753676Ab2JJUL1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Oct 2012 16:11:27 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:49926 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751206Ab2JJUL0 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Oct 2012 16:11:26 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id B96A61F70C;
	Wed, 10 Oct 2012 20:11:25 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <20121009101239.GA28120@elie.Belkin>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207437>

Jonathan Nieder <jrnieder@gmail.com> wrote:
> Jonathan Nieder wrote:
> 
> > Revisions prepared with ordinary svn commands ("svn add" and not "svn
> > propset") don't trip this because they represent filetype changes
> > using a replace operation [...]
> >                                                        Perhaps "git
> > svn" should mimic that,
> 
> ... and here's what that looks like.  I like this more than ignoring
> the problem in tests, and I suppose something like this is necessary
> regardless of how quickly issue 4091 is fixed for compatibility with
> the broken versions of svn.

I prefer this v2 more than ignoring the problem in tests, too.

> It would be nice if the patch could be more concise, though.  What do
> you think?

I think it's fine.

>  git-svn.perl |   25 ++++++++++++++++++++++++-

I needed to filter the patch through:

    s,git-svn\.perl,perl/Git/SVN/Editor.pm,g

though...  Will push the edited version to my master on
git://bogomips.org/git-svn

>From b8c78e2a9d6141589202e98b898f477861fcb111 Mon Sep 17 00:00:00 2001
From: Jonathan Nieder <jrnieder@gmail.com>
Date: Tue, 9 Oct 2012 03:12:39 -0700
Subject: [PATCH] git svn: work around SVN 1.7 mishandling of svn:special
 changes

Subversion represents symlinks as ordinary files with content starting
with "link " and the svn:special property set to "*".  Thus a file can
switch between being a symlink and a non-symlink simply by toggling
its svn:special property, and new checkouts will automatically write a
file of the appropriate type.  Likewise, in subversion 1.6 and older,
running "svn update" would notice changes in filetype and update the
working copy appropriately.

Starting in subversion 1.7 (issue 4091), changes to the svn:special
property trip an assertion instead:

	$ svn up svn-tree
	Updating 'svn-tree':
	svn: E235000: In file 'subversion/libsvn_wc/update_editor.c' \
	line 1583: assertion failed (action == svn_wc_conflict_action_edit \
	|| action == svn_wc_conflict_action_delete || action == \
	svn_wc_conflict_action_replace)

Revisions prepared with ordinary svn commands ("svn add" and not "svn
propset") don't trip this because they represent these filetype
changes using a replace operation, which is approximately equivalent
to removal followed by adding a new file and works fine.  Follow suit.

Noticed using t9100.  After this change, git-svn's file-to-symlink
changes are sent in a format that modern "svn update" can handle and
tests t9100.11-13 pass again.

[ew: s,git-svn\.perl,perl/Git/SVN/Editor.pm,g]

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Eric Wong <normalperson@yhbt.net>
---
 perl/Git/SVN/Editor.pm | 25 ++++++++++++++++++++++++-
 1 file changed, 24 insertions(+), 1 deletion(-)

diff --git a/perl/Git/SVN/Editor.pm b/perl/Git/SVN/Editor.pm
index 755092f..3bbc20a 100644
--- a/perl/Git/SVN/Editor.pm
+++ b/perl/Git/SVN/Editor.pm
@@ -345,7 +345,30 @@ sub M {
 	$self->close_file($fbat,undef,$self->{pool});
 }
 
-sub T { shift->M(@_) }
+sub T {
+	my ($self, $m, $deletions) = @_;
+
+	# Work around subversion issue 4091: toggling the "is a
+	# symlink" property requires removing and re-adding a
+	# file or else "svn up" on affected clients trips an
+	# assertion and aborts.
+	if (($m->{mode_b} =~ /^120/ && $m->{mode_a} !~ /^120/) ||
+	    ($m->{mode_b} !~ /^120/ && $m->{mode_a} =~ /^120/)) {
+		$self->D({
+			mode_a => $m->{mode_a}, mode_b => '000000',
+			sha1_a => $m->{sha1_a}, sha1_b => '0' x 40,
+			chg => 'D', file_b => $m->{file_b}
+		});
+		$self->A({
+			mode_a => '000000', mode_b => $m->{mode_b},
+			sha1_a => '0' x 40, sha1_b => $m->{sha1_b},
+			chg => 'A', file_b => $m->{file_b}
+		});
+		return;
+	}
+
+	$self->M($m, $deletions);
+}
 
 sub change_file_prop {
 	my ($self, $fbat, $pname, $pval) = @_;
-- 
1.8.0.rc0.42.gb8c78e2
