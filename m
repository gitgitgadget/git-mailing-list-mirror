From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH/RFC v2] git svn: work around SVN 1.7 mishandling of
 svn:special changes
Date: Tue, 9 Oct 2012 03:12:39 -0700
Message-ID: <20121009101239.GA28120@elie.Belkin>
References: <1343468872-72133-1-git-send-email-schwern@pobox.com>
 <1343468872-72133-8-git-send-email-schwern@pobox.com>
 <20121006192455.GA14969@elie.Belkin>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Michael G. Schwern" <schwern@pobox.com>, git@vger.kernel.org,
	gitster@pobox.com, robbat2@gentoo.org, bwalton@artsci.utoronto.ca
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Tue Oct 09 12:13:00 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TLWo7-0007Qh-Ig
	for gcvg-git-2@plane.gmane.org; Tue, 09 Oct 2012 12:12:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755095Ab2JIKMt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Oct 2012 06:12:49 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:59930 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751089Ab2JIKMr (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Oct 2012 06:12:47 -0400
Received: by mail-pb0-f46.google.com with SMTP id rr4so4979865pbb.19
        for <git@vger.kernel.org>; Tue, 09 Oct 2012 03:12:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=UlY2zhrZxGmIWX+eZQ7qWb+8PYTWdVrXr/derUup5Ow=;
        b=vj2LjyXUxYWvtrRG2iHc5+dimoRBiUn0hDeWU1n/0UrmQjPz7Xo31rQadFFgUUTqno
         zsfaynEMysJegsaOSGsYhMayEdxGHPizWXLyKymOlPgvUqejH+0g0pHRl2EF/Y2WKrl+
         oyeeFLNMEx3uSlOicCu0P9CSufLn5eWBoxLMSlbx2FdxYqHUgrSsmK7Kw2F7BuY1AbUu
         nPqZuA09zwSG7pSF31GGbgApZnTTI1AvNYWMW1649CYBvNzOp8mbphujs3cP8zPMFOBy
         F4IWF4j76JzWaJuxQRYE6Kb6YBuOJzVGZwbK7b52g68m0mWX5ZdnB69ZsLebLedSPuCx
         KG5Q==
Received: by 10.68.232.71 with SMTP id tm7mr62241542pbc.118.1349777567397;
        Tue, 09 Oct 2012 03:12:47 -0700 (PDT)
Received: from elie.Belkin (c-67-180-61-129.hsd1.ca.comcast.net. [67.180.61.129])
        by mx.google.com with ESMTPS id j9sm11254858paw.2.2012.10.09.03.12.45
        (version=SSLv3 cipher=OTHER);
        Tue, 09 Oct 2012 03:12:46 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20121006192455.GA14969@elie.Belkin>
User-Agent: Mutt/1.5.21+51 (9e756d1adb76) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207315>

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
Jonathan Nieder wrote:

> Revisions prepared with ordinary svn commands ("svn add" and not "svn
> propset") don't trip this because they represent filetype changes
> using a replace operation [...]
>                                                        Perhaps "git
> svn" should mimic that,

... and here's what that looks like.  I like this more than ignoring
the problem in tests, and I suppose something like this is necessary
regardless of how quickly issue 4091 is fixed for compatibility with
the broken versions of svn.

It would be nice if the patch could be more concise, though.  What do
you think?

 git-svn.perl |   25 ++++++++++++++++++++++++-
 1 file changed, 24 insertions(+), 1 deletion(-)

diff --git a/git-svn.perl b/git-svn.perl
index 9d57aa0c..40ccdd50 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -5439,7 +5439,30 @@ sub M {
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
1.7.10.4
