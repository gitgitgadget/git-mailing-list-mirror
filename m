From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH v3] git svn: work around SVN 1.7 mishandling of svn:special
 changes
Date: Wed, 10 Oct 2012 13:47:33 -0700
Message-ID: <20121010204733.GA4517@elie.Belkin>
References: <1343468872-72133-1-git-send-email-schwern@pobox.com>
 <1343468872-72133-8-git-send-email-schwern@pobox.com>
 <20121006192455.GA14969@elie.Belkin>
 <20121009101239.GA28120@elie.Belkin>
 <20121010201125.GA30952@dcvr.yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Michael G. Schwern" <schwern@pobox.com>, git@vger.kernel.org,
	gitster@pobox.com, robbat2@gentoo.org, bwalton@artsci.utoronto.ca
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Wed Oct 10 22:47:53 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TM3C4-0002iA-AG
	for gcvg-git-2@plane.gmane.org; Wed, 10 Oct 2012 22:47:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755159Ab2JJUrm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Oct 2012 16:47:42 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:58204 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752933Ab2JJUrl (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Oct 2012 16:47:41 -0400
Received: by mail-pb0-f46.google.com with SMTP id rr4so1111543pbb.19
        for <git@vger.kernel.org>; Wed, 10 Oct 2012 13:47:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=6nWRQcjNVmtnPahS1u8xZwa2IjpJZ+hs6prEFV03F9I=;
        b=pYmN1PjVBNSs+GhNZB84cHFkthXmz6aVMBsdYmJrih9d/kx4ownLw5Cc8xlVRryBYA
         RO8+rSCDpPXuQFjEMQuYYe0ZRdlKhJWkMFiVPCfi967zzXdAWlhboPB1O6Dz1KDuzsE1
         TvbBRTrLnjO6mZ6W3uJ4y5jJIClSEJRPGzs43pIgB012YzNngsUzbsW7z03phfNEalsJ
         mtMx/03GGu3Jr12ZV96+TYi5sDHJnamoVjK75J3nF7L6w/X854ZdHvSWZsaEpkYUTYjV
         rrWjgMxoPmWC6+zdCZrbfmyBsmDfTEjcWPX0mf8r0tXsTsm6MqFeUcacpnaPZ8aF5gbP
         CrvQ==
Received: by 10.68.125.133 with SMTP id mq5mr76978708pbb.138.1349902061102;
        Wed, 10 Oct 2012 13:47:41 -0700 (PDT)
Received: from elie.Belkin (c-67-180-61-129.hsd1.ca.comcast.net. [67.180.61.129])
        by mx.google.com with ESMTPS id tw2sm324939pbc.34.2012.10.10.13.47.39
        (version=SSLv3 cipher=OTHER);
        Wed, 10 Oct 2012 13:47:40 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20121010201125.GA30952@dcvr.yhbt.net>
User-Agent: Mutt/1.5.21+51 (9e756d1adb76) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207440>

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

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
Eric Wong wrote:

> I needed to filter the patch through:
>
>     s,git-svn\.perl,perl/Git/SVN/Editor.pm,g
>
> though...

Yeah, good catch.  Here's a v3 tested against "master".  Unlike in v2,
it remembers to pass the $deletions parameter to D() and A() --- which
shouldn't make a difference because we are not adding a directory, but
it's nice to be consistent to make reading smoother.

 perl/Git/SVN/Editor.pm |   25 ++++++++++++++++++++++++-
 1 file changed, 24 insertions(+), 1 deletion(-)

diff --git a/perl/Git/SVN/Editor.pm b/perl/Git/SVN/Editor.pm
index 755092fd..178920c8 100644
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
+		}, $deletions);
+		$self->A({
+			mode_a => '000000', mode_b => $m->{mode_b},
+			sha1_a => '0' x 40, sha1_b => $m->{sha1_b},
+			chg => 'A', file_b => $m->{file_b}
+		}, $deletions);
+		return;
+	}
+
+	$self->M($m, $deletions);
+}
 
 sub change_file_prop {
 	my ($self, $fbat, $pname, $pval) = @_;
-- 
1.7.10.4
