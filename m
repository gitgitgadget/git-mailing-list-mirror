From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: [PATCH 2/2] git-remote-mediawiki: allow page names with a ':'
Date: Tue, 17 Jul 2012 16:06:00 +0200
Message-ID: <1342533960-22123-3-git-send-email-Matthieu.Moy@imag.fr>
References: <1342468002-31818-1-git-send-email-Matthieu.Moy@imag.fr>
 <1342533960-22123-1-git-send-email-Matthieu.Moy@imag.fr>
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Tue Jul 17 16:10:06 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sr8TV-00069k-Oy
	for gcvg-git-2@plane.gmane.org; Tue, 17 Jul 2012 16:10:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754316Ab2GQOJu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Jul 2012 10:09:50 -0400
Received: from mx2.imag.fr ([129.88.30.17]:57635 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752035Ab2GQOJq (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Jul 2012 10:09:46 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id q6HE4G5m025602
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Tue, 17 Jul 2012 16:04:16 +0200
Received: from bauges.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.72)
	(envelope-from <moy@imag.fr>)
	id 1Sr8Pf-0006cc-Q9; Tue, 17 Jul 2012 16:06:07 +0200
Received: from moy by bauges.imag.fr with local (Exim 4.72)
	(envelope-from <moy@imag.fr>)
	id 1Sr8Pf-0006I7-O6; Tue, 17 Jul 2012 16:06:07 +0200
X-Mailer: git-send-email 1.7.11.2.258.g5ff3cdf.dirty
In-Reply-To: <1342533960-22123-1-git-send-email-Matthieu.Moy@imag.fr>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Tue, 17 Jul 2012 16:04:16 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: q6HE4G5m025602
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
MailScanner-NULL-Check: 1343138658.41123@ZJCpQUkC1ai/K2u1fDQDcg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201605>

Traditionnally, pages named Foo:Bar are page 'Bar' in namespace 'Foo'.
However, it is also possible to call a page Foo:Bar if 'Foo' is not a
namespace. In this case, the actual name of the page is 'Foo:Bar', in the
main namespace. Since we can't tell with only the filename, query the
wiki for a namespace 'Foo' in these cases, but deal with the case where
no such namespace is found.

Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
---
 contrib/mw-to-git/git-remote-mediawiki      | 49 +++++++++++++++++++----------
 contrib/mw-to-git/t/t9362-mw-to-git-utf8.sh | 20 ++++++++++++
 2 files changed, 53 insertions(+), 16 deletions(-)

diff --git a/contrib/mw-to-git/git-remote-mediawiki b/contrib/mw-to-git/git-remote-mediawiki
index d6be188..47d4878 100755
--- a/contrib/mw-to-git/git-remote-mediawiki
+++ b/contrib/mw-to-git/git-remote-mediawiki
@@ -955,8 +955,11 @@ sub mw_import_revids {
 		# Differentiates classic pages and media files.
 		my ($namespace, $filename) = $page_title =~ /^([^:]*):(.*)$/;
 		my %mediafile;
-		if ($namespace && get_mw_namespace_id($namespace) == get_mw_namespace_id("File")) {
-			%mediafile = get_mw_mediafile_for_page_revision($filename, $rev->{timestamp});
+		if ($namespace) {
+			my $id = get_mw_namespace_id($namespace);
+			if ($id && $id == get_mw_namespace_id("File")) {
+				%mediafile = get_mw_mediafile_for_page_revision($filename, $rev->{timestamp});
+			}
 		}
 		# If this is a revision of the media page for new version
 		# of a file do one common commit for both file and media page.
@@ -1306,7 +1309,11 @@ sub get_mw_namespace_id {
 		chomp(@temp);
 		foreach my $ns (@temp) {
 			my ($n, $id) = split(/:/, $ns);
-			$namespace_id{$n} = $id;
+			if ($id eq 'notANameSpace') {
+				$namespace_id{$n} = {is_namespace => 0};
+			} else {
+				$namespace_id{$n} = {is_namespace => 1, id => $id};
+			}
 			$cached_mw_namespace_id{$n} = 1;
 		}
 	}
@@ -1324,28 +1331,38 @@ sub get_mw_namespace_id {
 
 	        while (my ($id, $ns) = each(%{$result->{query}->{namespaces}})) {
 	                if (defined($ns->{id}) && defined($ns->{canonical})) {
-				$namespace_id{$ns->{canonical}} = $ns->{id};
+				$namespace_id{$ns->{canonical}} = {is_namespace => 1, id => $ns->{id}};
 				if ($ns->{'*'}) {
 					# alias (e.g. french Fichier: as alias for canonical File:)
-					$namespace_id{$ns->{'*'}} = $ns->{id};
+					$namespace_id{$ns->{'*'}} = {is_namespace => 1, id => $ns->{id}};
 				}
 			}
 	        }
 	}
 
-	my $id = $namespace_id{$name};
+	my $ns = $namespace_id{$name};
+	my $id;
 
-	if (defined $id) {
-		# Store explicitely requested namespaces on disk
-		if (!exists $cached_mw_namespace_id{$name}) {
-			run_git("config --add remote.". $remotename
-				.".namespaceCache \"". $name .":". $id ."\"");
-			$cached_mw_namespace_id{$name} = 1;
-		}
-		return $id;
-	} else {
-		die "No such namespace $name on MediaWiki.";
+	unless (defined $ns) {
+		print STDERR "No such namespace $name on MediaWiki.\n";
+		$ns = {is_namespace => 0};
+		$namespace_id{$name} = $ns;
+	}
+
+	if ($ns->{is_namespace}) {
+		$id = $ns->{id};
+	}
+
+	# Store "notANameSpace" as special value for inexisting namespaces
+	my $store_id = ($id || 'notANameSpace');
+
+	# Store explicitely requested namespaces on disk
+	if (!exists $cached_mw_namespace_id{$name}) {
+		run_git("config --add remote.". $remotename
+			.".namespaceCache \"". $name .":". $store_id ."\"");
+		$cached_mw_namespace_id{$name} = 1;
 	}
+	return $id;
 }
 
 sub get_mw_namespace_id_for_page {
diff --git a/contrib/mw-to-git/t/t9362-mw-to-git-utf8.sh b/contrib/mw-to-git/t/t9362-mw-to-git-utf8.sh
index 8635878..246d47d 100755
--- a/contrib/mw-to-git/t/t9362-mw-to-git-utf8.sh
+++ b/contrib/mw-to-git/t/t9362-mw-to-git-utf8.sh
@@ -169,6 +169,26 @@ test_expect_failure 'special character at the begining of file name from mw to g
 	test_path_is_file mw_dir_11/[char_2
 '
 
+test_expect_success 'Pull page with title containing ":" other than namespace separator' '
+	wiki_editpage Foo:Bar content false &&
+	(
+		cd mw_dir_11 &&
+		git pull
+	) &&
+	test_path_is_file mw_dir_11/Foo:Bar.mw
+'
+
+test_expect_success 'Push page with title containing ":" other than namespace separator' '
+	(
+		cd mw_dir_11 &&
+		echo content >NotANameSpace:Page.mw &&
+		git add NotANameSpace:Page.mw &&
+		git commit -m "add page with colon" &&
+		git push
+	) &&
+	wiki_page_exist NotANameSpace:Page
+'
+
 test_expect_success 'test of correct formating for file name from mw to git' '
 	wiki_reset &&
 	git clone mediawiki::'"$WIKI_URL"' mw_dir_12 &&
-- 
1.7.11.2.258.g5ff3cdf.dirty
