From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] Fix reading of cloud tags
Date: Tue, 14 Oct 2008 21:27:12 -0700
Message-ID: <7v1vyi5vq7.fsf_-_@gitster.siamese.dyndns.org>
References: <7vljws83nd.fsf@gitster.siamese.dyndns.org>
 <20081013234851.GY4856@spearce.org> <20081014000812.GZ4856@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>
To: Petr Baudis <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Wed Oct 15 06:28:43 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kpxzw-0004p1-Tk
	for gcvg-git-2@gmane.org; Wed, 15 Oct 2008 06:28:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750954AbYJOE1X (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Oct 2008 00:27:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750955AbYJOE1X
	(ORCPT <rfc822;git-outgoing>); Wed, 15 Oct 2008 00:27:23 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:64038 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750938AbYJOE1X (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Oct 2008 00:27:23 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 87FDE6F189;
	Wed, 15 Oct 2008 00:27:19 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 3F9DB6F186; Wed, 15 Oct 2008 00:27:15 -0400 (EDT)
In-Reply-To: <20081014000812.GZ4856@spearce.org> (Shawn O. Pearce's message
 of "Mon, 13 Oct 2008 17:08:12 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 8E01C3B2-9A71-11DD-999F-1E1F86D30F62-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98231>

The projectroot path could have SP in it, in which case iterating over
<$git_dir/ctags/*> does not correctly enumerate the cloud tags files at
all.

This can be observed by creating an empty t/trash directory and running
t9500 test.  The $projectroot ends with "trash directory.t9500-gitweb-/"
and <$glob> would give "trash", which can be opened and reading from it
immediately yields undef, which in turn gives an undef value warning to
the standard error stream upon attempt to chomp it.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 gitweb/gitweb.perl |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git c/gitweb/gitweb.perl w/gitweb/gitweb.perl
index 1116800..577c041 100755
--- c/gitweb/gitweb.perl
+++ w/gitweb/gitweb.perl
@@ -1805,7 +1805,8 @@ sub git_get_project_ctags {
 	my $ctags = {};
 
 	$git_dir = "$projectroot/$path";
-	foreach (<$git_dir/ctags/*>) {
+	opendir D, "$git_dir/ctags";
+	foreach (grep { -f $_ } map { "$git_dir/ctags/$_" } readdir(D)) {
 		open CT, $_ or next;
 		my $val = <CT>;
 		chomp $val;
@@ -1813,6 +1814,7 @@ sub git_get_project_ctags {
 		my $ctag = $_; $ctag =~ s#.*/##;
 		$ctags->{$ctag} = $val;
 	}
+	closedir D;
 	$ctags;
 }
 
