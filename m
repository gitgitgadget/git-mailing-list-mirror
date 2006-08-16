From: Toby White <tow21@cam.ac.uk>
Subject: gitweb / cg-export
Date: Wed, 16 Aug 2006 01:16:29 +0100
Message-ID: <44E263DD.6030305@cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Wed Aug 16 02:16:52 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GD95T-0001fJ-Ud
	for gcvg-git@gmane.org; Wed, 16 Aug 2006 02:16:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750715AbWHPAQo (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 15 Aug 2006 20:16:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750719AbWHPAQo
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Aug 2006 20:16:44 -0400
Received: from ppsw-1.csi.cam.ac.uk ([131.111.8.131]:57482 "EHLO
	ppsw-1.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id S1750715AbWHPAQo (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Aug 2006 20:16:44 -0400
X-Cam-SpamDetails: Not scanned
X-Cam-AntiVirus: No virus found
X-Cam-ScannerInfo: http://www.cam.ac.uk/cs/email/scanner/
Received: from cpc2-cmbg1-0-0-cust798.cmbg.cable.ntl.com ([82.21.107.31]:60624 helo=[192.168.0.100])
	by ppsw-1.csi.cam.ac.uk (smtp.hermes.cam.ac.uk [131.111.8.151]:25)
	with esmtpsa (PLAIN:tow21) (TLSv1:DHE-RSA-AES256-SHA:256)
	id 1GD95L-0003aC-4v (Exim 4.54) for git@vger.kernel.org
	(return-path <tow21@cam.ac.uk>); Wed, 16 Aug 2006 01:16:39 +0100
User-Agent: Thunderbird 1.5.0.5 (Macintosh/20060719)
To: git@vger.kernel.org
X-Enigmail-Version: 0.94.0.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25493>

I was wondering if a feature like the following would be of
use to anyone except me: I'd like to be able to download
the full source of a given tree from gitweb.

Use cases:

a) I'm browsing history through gitweb, find the tree
I'm interested in & want to download the whole tree without
cutting and pasting hashes.

b) I want to be able to quickly let people grab my latest
revision who don't have git installed, without faffing
about creating tarballs & emailing them; I'd like to be
able to paste a URL straight into my IM client.

I've quickly hacked gitweb to do this for me - patch below.

It adds an extra link to the 'commit' page. Next to the link
that would lead you to 'tree', there is 'tar.gz' which simply
returns the tar.gz of the same tree.

The patch is against the version of gitweb currently in
Debian, which is, erm, '264-1', apparently, because that's
what I had to hand.

Anyway. I'm no git expert so perhaps this is a really bad
idea, but I find it useful.

Toby White


--- gitweb.cgi.orig     2006-08-16 01:00:03.000000000 +0100
+++ gitweb.cgi  2006-08-16 00:58:38.000000000 +0100
@@ -180,6 +180,9 @@
 } elsif ($action eq "tree") {
        git_tree();
+       exit;
 } elsif ($action eq "rss") {
        git_rss();
        exit;
@@ -1523,6 +1526,21 @@
        git_footer_html();
 }

+sub git_export {
+       if (!defined $hash) {
+               $hash = git_read_head($project);
+               if (defined $file_name) {
+                       my $base = $hash_base || $hash;
+                       $hash = git_get_hash_by_path($base, $file_name, "tree");
+               }
+               if (!defined $hash_base) {
+                       $hash_base = $hash;
+               }
+       }
+       print $cgi->header(-type=>'application/x-tar',  -Content-Encoding=>'x-gzip', -status=> '200 OK');
+       exec "$gitbin/git-tar-tree $hash $project | gzip -c9" or die_error(undef, "Execute git-tar-tree failed.");
+}
+
 sub git_rss {
        # http://www.notestips.com/80256B3A007F2692/1/NAMO5P9UPQ
        open my $fd, "-|", "$gitbin/git-rev-list --max-count=150 " . git_read_head($project) or die_error(undef, "Open failed.");
@@ -1779,6 +1797,7 @@
              $cgi->a({-href => "$my_uri?" . esc_param("p=$project;a=tree;h=$co{'tree'};hb=$hash"), class => "list"}, $co{'tree'})
.
              "</td>" .
              "<td class=\"link\">" . $cgi->a({-href => "$my_uri?" . esc_param("p=$project;a=tree;h=$co{'tree'};hb=$hash")}, "tree"
) .
+              "|" . $cgi->a({-href => "$my_uri/$project.tar.gz?" . esc_param("p=$project;a=export;h=$co{'tree'};hb=$hash")}, "tar.
gz") .
              "</td>" .
              "</tr>\n";
        my $parents  = $co{'parents'};
