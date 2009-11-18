From: "Marcel M. Cary" <marcel@oak.homeunix.org>
Subject: [RFC PATCH 3/6] gitweb: Allow finer-grained override controls for committags
Date: Tue, 17 Nov 2009 22:22:27 -0800
Message-ID: <1258525350-5528-4-git-send-email-marcel@oak.homeunix.org>
References: <200906221318.19598.jnareb@gmail.com>
 <1258525350-5528-1-git-send-email-marcel@oak.homeunix.org>
 <1258525350-5528-2-git-send-email-marcel@oak.homeunix.org>
 <1258525350-5528-3-git-send-email-marcel@oak.homeunix.org>
Cc: Petr Baudis <pasky@suse.cz>,
	Giuseppe Bilotta <giuseppe.bilotta@gmail.com>,
	Francis Galiegue <fge@one2team.net>,
	"Marcel M. Cary" <marcel@oak.homeunix.org>
To: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 18 07:23:06 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NAdwX-0001Od-Dx
	for gcvg-git-2@lo.gmane.org; Wed, 18 Nov 2009 07:23:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753783AbZKRGWg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Nov 2009 01:22:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753729AbZKRGWg
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Nov 2009 01:22:36 -0500
Received: from smtp126.sbc.mail.sp1.yahoo.com ([69.147.65.185]:38076 "HELO
	smtp126.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1753572AbZKRGWf (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 18 Nov 2009 01:22:35 -0500
Received: (qmail 9455 invoked from network); 18 Nov 2009 06:22:41 -0000
Received: from adsl-76-246-148-73.dsl.pltn13.sbcglobal.net (marcel@76.246.148.73 with plain)
        by smtp126.sbc.mail.sp1.yahoo.com with SMTP; 17 Nov 2009 22:22:40 -0800 PST
X-Yahoo-SMTP: WxgK_ZmswBCwjfqSjWfXdnSm2tyuJVtcxuu8Nw--
X-YMail-OSG: SOOHxEkVM1m4W7mpzBzjmZps_Qir5W.ZQx6gZv_3IlmcyZNmqayrQ7lBCF3UNBHqowTF0JzkU5pz9JD0pjlxrciuYgs6EvZYylrewMXdh5Z.tjM3Wl75kK4vw2ZVT0jRaXEtkpm1TqHRAT4nAC7FJtsjtF9yAzPE02Tzi._utPapWJJ3G98pLr5IyAPmvsTskGC1Ipbgfw6XcsVJVHhWy2YYmepM2oDvUW7vXRFivVSwPvSiLbtc1v49jVeyqL4r4pHiQlzMmc8Bkww2k4Muwcy6IgfmHVrgoENhLpsByiytpuy8
X-Yahoo-Newman-Property: ymail-3
Received: from polliwog.home.org ([192.168.0.18] helo=localhost.localdomain)
	by ordinateur.home.org with esmtp (Exim 4.63)
	(envelope-from <marcel@oak.homeunix.org>)
	id 1NAdvz-0004p6-I0; Tue, 17 Nov 2009 22:22:31 -0800
X-Mailer: git-send-email 1.6.2
In-Reply-To: <1258525350-5528-3-git-send-email-marcel@oak.homeunix.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133139>

Currently, a site administrator must choose between allowing all or
none of a committag's options to be overridden in the project config.
However, a site admin may wish to permit specifying a bugzilla URL
without risking a maliciously resource hungry regular expression.

Allow the site admin to specify which committag parameters may be
overridden.  Preserve the behavior of the original 0 and 1 override
specifications.

Signed-off-by: Marcel M. Cary <marcel@oak.homeunix.org>
---
 gitweb/INSTALL               |    8 +++++++-
 gitweb/gitweb.perl           |   24 ++++++++++++++++++------
 t/t9502-gitweb-committags.sh |   13 +++++++++++++
 3 files changed, 38 insertions(+), 7 deletions(-)

diff --git a/gitweb/INSTALL b/gitweb/INSTALL
index 9081ed8..15c0128 100644
--- a/gitweb/INSTALL
+++ b/gitweb/INSTALL
@@ -133,9 +133,15 @@ adding the following lines to your $GITWEB_CONFIG:
 	$known_snapshot_formats{'tgz'}{'compressor'} = ['gzip','-6'];
 
 To add a committag to the default list of commit tags, for example to
-enable hyperlinking of bug numbers to a bug tracker for all projects:
+enable hyperlinking of bug numbers to a bug tracker for all projects, while
+allowing each project to choose only the base URL for its bug tracker:
 
 	push @{$feature{'committags'}{'default'}}, 'bugzilla';
+	$committags{"bugzilla"}{"override"} = ["url"];
+
+And then let each project configure its bug tracker URL:
+
+	git config gitweb.committag.bugzilla.url 'http://bts.example.com?bug='
 
 
 Gitweb repositories
diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 032b1c5..8f4480e 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -225,11 +225,13 @@ our %avatar_size = (
 # will not be processed further.
 #
 # For any committag, set the 'override' key to 1 to allow individual
-# projects to override entries in the 'options' hash for that tag.
-# For example, to match only commit hashes given in lowercase in one
-# project, add this to the $GITWEB_CONFIG:
+# projects to override any entry in the 'options' hash for that tag.
+# Leave 'override' as 0 to disallow all overriding of all entries.
+# Set 'override' to an array of 'option' key names to allow overriding
+# specific keys.  For example, to match only commit hashes given in
+# lowercase in one project, add this to the $GITWEB_CONFIG:
 #
-#     $committags{'sha1'}{'override'} = 1;
+#     $committags{'sha1'}{'override'} = 1;   # or ["pattern"]
 #
 # And in the project's config:
 #
@@ -237,7 +239,8 @@ our %avatar_size = (
 #
 # Some committags have additional options whose interpretation depends
 # on the implementation of the 'sub' key.  The hyperlink_committag
-# value appends the first captured group to the 'url' option.
+# value appends the first captured group to the 'url' option, for example.
+#
 our %committags = (
 	# Link Git-style hashes to this gitweb
 	'sha1' => {
@@ -1029,8 +1032,17 @@ sub gitweb_load_project_committags {
 		$project_config{$ctname}{$option} = $raw_config{$key};
 	}
 	foreach my $ctname (keys(%committags)) {
-		next if (!$committags{$ctname}{'override'});
+		my $override = $committags{$ctname}{'override'};
+		next if (!$override);
+		my $override_keys = undef;
+		if (ref($override) eq "ARRAY") {
+			$override_keys = {};
+			foreach my $optname (@$override) {
+				$override_keys->{$optname} = 1;
+			}
+		}
 		foreach my $optname (keys %{$project_config{$ctname}}) {
+			next if ($override_keys && !$override_keys->{$optname});
 			$committags{$ctname}{'options'}{$optname} =
 				$project_config{$ctname}{$optname};
 		}
diff --git a/t/t9502-gitweb-committags.sh b/t/t9502-gitweb-committags.sh
index 718e763..e13ac47 100755
--- a/t/t9502-gitweb-committags.sh
+++ b/t/t9502-gitweb-committags.sh
@@ -68,6 +68,19 @@ test_expect_success 'bugzilla: url overridden but not permitted' '
 test_debug 'cat gitweb.log'
 test_debug 'grep 1234 gitweb.output'
 
+echo '$committags{"bugzilla"}{"override"} = ["url"];' >> gitweb_config.perl
+git config gitweb.committag.bugzilla.url 'http://bts.example.com?bug='
+git config gitweb.committag.bugzilla.pattern 'slow DoS regex'
+test_expect_success 'bugzilla: url overridden but regex not permitted' '
+	gitweb_run "p=.git;a=commit;h=HEAD" &&
+	grep -F -q \
+		"Fixes&nbsp;bug&nbsp;<a class=\"text\" href=\"http://bts.example.com?bug=1234\">1234</a>&nbsp;involving" \
+		gitweb.output
+'
+test_debug 'cat gitweb.log'
+test_debug 'grep 1234 gitweb.output'
+git config --unset gitweb.committag.bugzilla.pattern
+
 echo '$committags{"bugzilla"}{"override"} = 1;' >> gitweb_config.perl
 test_expect_success 'bugzilla: url overridden' '
 	gitweb_run "p=.git;a=commit;h=HEAD" &&
-- 
1.6.4.4
