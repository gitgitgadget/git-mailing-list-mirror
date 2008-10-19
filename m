From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH/RFR&A] gitweb: Better processing format string in custom
 links in navbar
Date: Sun, 19 Oct 2008 00:07:12 -0700
Message-ID: <7vzll16p27.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Petr Baudis <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Sun Oct 19 09:08:32 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KrSOu-00011H-53
	for gcvg-git-2@gmane.org; Sun, 19 Oct 2008 09:08:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751193AbYJSHHX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 19 Oct 2008 03:07:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751192AbYJSHHW
	(ORCPT <rfc822;git-outgoing>); Sun, 19 Oct 2008 03:07:22 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:45497 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751156AbYJSHHU (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 19 Oct 2008 03:07:20 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 6292B8CC75;
	Sun, 19 Oct 2008 03:07:19 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 7D9208CC74; Sun, 19 Oct 2008 03:07:14 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 919C617E-9DAC-11DD-9C9B-4F5276724C3F-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98597>

I was not around when this was posted and discussed; Shawn's note says
this is waiting for "some sort of response from Pasky", hence this request
for review and ack.  It still is parked in 'pu'.

-- >8 --

Make processing format string in custom links in action bar ('actions'
feature) more robust.  Now there would be no problems if one of
expanded values (for example project name, of project filename)
contains '%'; additionally format string supports '%' escaping by
doubling, i.e. '%%' expands to '%'.

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 gitweb/gitweb.perl |   19 ++++++++++++-------
 1 files changed, 12 insertions(+), 7 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 1116800..cc6edbe 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -290,10 +290,10 @@ our %feature = (
 
 	# The 'default' value consists of a list of triplets in the form
 	# (label, link, position) where position is the label after which
-	# to inster the link and link is a format string where %n expands
+	# to insert the link and link is a format string where %n expands
 	# to the project name, %f to the project path within the filesystem,
 	# %h to the current hash (h gitweb parameter) and %b to the current
-	# hash base (hb gitweb parameter).
+	# hash base (hb gitweb parameter); %% expands to %.
 
 	# To enable system wide have in $GITWEB_CONFIG e.g.
 	# $feature{'actions'}{'default'} = [('graphiclog',
@@ -2866,14 +2866,19 @@ sub git_print_page_nav {
 	$arg{'tree'}{'hash_base'} = $treebase if defined $treebase;
 
 	my @actions = gitweb_check_feature('actions');
+	my %repl = (
+		'%' => '%',
+		'n' => $project,         # project name
+		'f' => $git_dir,         # project path within filesystem
+		'h' => $treehead || '',  # current hash ('h' parameter)
+		'b' => $treebase || '',  # hash base ('hb' parameter)
+	);
 	while (@actions) {
-		my ($label, $link, $pos) = (shift(@actions), shift(@actions), shift(@actions));
+		my ($label, $link, $pos) = splice(@actions,0,3);
+		# insert
 		@navs = map { $_ eq $pos ? ($_, $label) : $_ } @navs;
 		# munch munch
-		$link =~ s#%n#$project#g;
-		$link =~ s#%f#$git_dir#g;
-		$treehead ? $link =~ s#%h#$treehead#g : $link =~ s#%h##g;
-		$treebase ? $link =~ s#%b#$treebase#g : $link =~ s#%b##g;
+		$link =~ s/%([%nfhb])/$repl{$1}/g;
 		$arg{$label}{'_href'} = $link;
 	}
 
-- 
1.6.0.2.767.g8f0e
