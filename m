From: "Bernhard R. Link" <brl+git@mail.brlink.eu>
Subject: [PATCH v6 2/6] gitweb: prepare git_get_projects_list for use outside
 'forks'.
Date: Mon, 30 Jan 2012 21:06:38 +0100
Message-ID: <20120130200638.GC2584@server.brlink.eu>
References: <20120128165606.GA6770@server.brlink.eu>
 <20120130095252.GA6183@server.brlink.eu>
 <20120130114557.GB9267@server.brlink.eu>
 <201201301657.12944.jnareb@gmail.com>
 <20120130200355.GA2584@server.brlink.eu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jan 30 21:06:32 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RrxUf-0002t3-7c
	for gcvg-git-2@plane.gmane.org; Mon, 30 Jan 2012 21:06:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752347Ab2A3UGV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Jan 2012 15:06:21 -0500
Received: from server.brlink.eu ([78.46.187.186]:54109 "EHLO server.brlink.eu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752028Ab2A3UGU (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Jan 2012 15:06:20 -0500
Received: from mfs.mathematik.uni-freiburg.de ([132.230.30.170] helo=client.brlink.eu)
	by server.brlink.eu with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.72)
	(envelope-from <brl@mail.brlink.eu>)
	id 1RrxUZ-0005vU-Ga; Mon, 30 Jan 2012 21:06:19 +0100
Received: from brl by client.brlink.eu with local (Exim 4.77)
	(envelope-from <brl@mail.brlink.eu>)
	id 1RrxUs-0001Bm-DN; Mon, 30 Jan 2012 21:06:38 +0100
Content-Disposition: inline
In-Reply-To: <20120130200355.GA2584@server.brlink.eu>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189411>

Use of the filter option of git_get_projects_list is currently limited
to forks. It currently assumes the project belonging to the filter
directory was already validated to be visible in the project list.

To make it more generic add an optional argument to denote visibility
verification is still needed.

If there is a projects list file (GITWEB_LIST) only projects from
this list are returned anyway, so no more checks needed.

If there is no projects list file and the caller requests strict
checking (GITWEB_STRICT_EXPORT), do not jump directly to the
given directory but instead do a normal search and filter the
results instead.

The only effect of GITWEB_STRICT_EXPORT without GITWEB_LIST is to make
sure no project can be viewed without also be found starting from
project root. git_get_projects_list without this patch does not enforce
this but all callers only call it with a filter already checked this
way. With this parameter a caller can request this check if the filter
cannot be checked this way.

Signed-off-by: Bernhard R. Link <brlink@debian.org>
---

Changes to v5:
	- split first patch in two as suggested by Jakub Narebski
	- replace "and not" with the more common "&& !"
---
 gitweb/gitweb.perl |    7 ++++++-
 1 files changed, 6 insertions(+), 1 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 0ee3290..9a296e2 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -2829,6 +2829,7 @@ sub git_get_project_url_list {
 
 sub git_get_projects_list {
 	my $filter = shift || '';
+	my $paranoid = shift;
 	my @list;
 
 	if (-d $projects_list) {
@@ -2839,7 +2840,7 @@ sub git_get_projects_list {
 		my $pfxlen = length("$dir");
 		my $pfxdepth = ($dir =~ tr!/!!);
 		# when filtering, search only given subdirectory
-		if ($filter) {
+		if ($filter && !$paranoid) {
 			$dir .= "/$filter";
 			$dir =~ s!/+$!!;
 		}
@@ -2864,6 +2865,10 @@ sub git_get_projects_list {
 				}
 
 				my $path = substr($File::Find::name, $pfxlen + 1);
+				# paranoidly only filter here
+				if ($paranoid && $filter && $path !~ m!^\Q$filter\E/!) {
+					next;
+				}
 				# we check related file in $projectroot
 				if (check_export_ok("$projectroot/$path")) {
 					push @list, { path => $path };
-- 
1.7.8.3
