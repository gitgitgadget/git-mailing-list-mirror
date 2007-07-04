From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] gitweb: prefer git_get_project_owner() over get_file_owner()
Date: Tue, 03 Jul 2007 22:10:42 -0700
Message-ID: <7vzm2ckb3h.fsf@assigned-by-dhcp.cox.net>
References: <11834862893846-git-send-email-vmiklos@frugalware.org>
	<20070703221122.GI32766@genesis.frugalware.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Petr Baudis <pasky@suse.cz>,
	Jakub Narebski <jnareb@gmail.com>,
	Luben Tuikov <ltuikov@yahoo.com>
To: Miklos Vajna <vmiklos@frugalware.org>
X-From: git-owner@vger.kernel.org Wed Jul 04 07:11:17 2007
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I5x92-0001Ir-OT
	for gcvg-git@gmane.org; Wed, 04 Jul 2007 07:11:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754545AbXGDFK5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 4 Jul 2007 01:10:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753727AbXGDFKz
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Jul 2007 01:10:55 -0400
Received: from fed1rmmtao104.cox.net ([68.230.241.42]:52905 "EHLO
	fed1rmmtao104.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753327AbXGDFKp (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Jul 2007 01:10:45 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao104.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070704051046.TVLM1257.fed1rmmtao104.cox.net@fed1rmimpo01.cox.net>;
          Wed, 4 Jul 2007 01:10:46 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id KHAk1X00A1kojtg0000000; Wed, 04 Jul 2007 01:10:45 -0400
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51567>

Miklos Vajna <vmiklos@frugalware.org> writes:

> This way if $projects_list exists, it'll be used, otherwise get_file_owner()
> will be used as before.
>
> Signed-off-by: Miklos Vajna <vmiklos@frugalware.org>

The patch looks good to me.

HOWEVER.

It strikes me that repeated call to git_get_project_owner()
would be way too inefficient.  Not caller's fault.

How about doing something like this on top of your patch?

 gitweb/gitweb.perl |   28 ++++++++++++++++++++--------
 1 files changed, 20 insertions(+), 8 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index dbfb044..f114585 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -1465,12 +1465,12 @@ sub git_get_projects_list {
 	return @list;
 }
 
-sub git_get_project_owner {
-	my $project = shift;
-	my $owner;
+our $gitweb_project_owner = undef;
+sub git_get_project_list_from_file {
 
-	return undef unless $project;
+	return if (defined $gitweb_project_owner);
 
+	$gitweb_project_owner = {};
 	# read from file (url-encoded):
 	# 'git%2Fgit.git Linus+Torvalds'
 	# 'libs%2Fklibc%2Fklibc.git H.+Peter+Anvin'
@@ -1482,13 +1482,25 @@ sub git_get_project_owner {
 			my ($pr, $ow) = split ' ', $line;
 			$pr = unescape($pr);
 			$ow = unescape($ow);
-			if ($pr eq $project) {
-				$owner = to_utf8($ow);
-				last;
-			}
+			$gitweb_project_owner->{$project} = to_utf8($ow);
 		}
 		close $fd;
 	}
+}
+
+sub git_get_project_owner {
+	my $project = shift;
+	my $owner;
+
+	return undef unless $project;
+
+	if (!defined $gitweb_project_owner) {
+		git_get_project_list_from_file();
+	}
+
+	if (exists $gitweb_project_owner->{$project}) {
+		$owner = $gitweb_project_owner->{$project};
+	}
 	if (!defined $owner) {
 		$owner = get_file_owner("$projectroot/$project");
 	}
