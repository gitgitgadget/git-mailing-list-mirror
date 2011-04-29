From: Jakub Narebski <jnareb@gmail.com>
Subject: =?UTF-8?q?=5BPATCH=202/6=5D=20gitweb=3A=20Change=20the=20way=20=22content=20tags=22=20=28=27ctags=27=29=20are=20handled?=
Date: Fri, 29 Apr 2011 19:51:57 +0200
Message-ID: <1304099521-27617-3-git-send-email-jnareb@gmail.com>
References: <1304099521-27617-1-git-send-email-jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: John 'Warthog9' Hawley <warthog9@eaglescrag.net>,
	John 'Warthog9' Hawley <warthog9@kernel.org>,
	Uwe Kleine-Koenig <u.kleine-koenig@pengutronix.de>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Petr Baudis <pasky@suse.cz>, Sebastien Cevey <seb@cine7.net>,
	Jakub Narebski <jnareb@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 29 19:52:53 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QFrs3-0001Q3-Ca
	for gcvg-git-2@lo.gmane.org; Fri, 29 Apr 2011 19:52:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760760Ab1D2Rw3 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 29 Apr 2011 13:52:29 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:38549 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757894Ab1D2Rw1 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Apr 2011 13:52:27 -0400
Received: by fxm17 with SMTP id 17so2635577fxm.19
        for <git@vger.kernel.org>; Fri, 29 Apr 2011 10:52:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references:mime-version:content-type
         :content-transfer-encoding;
        bh=24G3MkHRPQe+h0gi9aXLDf5Wfy8bLLqqIvuhYobUNR0=;
        b=RRtz4XT3Vsrf7jtAqvPOKy5QNJGuj5CUMDPoDwjoduaeyaifBSBmQ6tezCCaKfnl/g
         SHHibTufbwtWKf/RVXKWrqclAhwGZAhr2Er7ZR/yp7umimtoBAc1lTMpDTSf8V0RyJPV
         f0wQVFPUQMxgz7+3vndBbhs5fwOEi3sbXUqwg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=CKPdTIO/jqKP8U6c2W3Lcj15IMRHA0Js3RC9RUis98mc/KBy3XPqhobrocQz9XV1E9
         EXuVj5AkM25AfqK5qt+Xk/xcNhlqbmCm7BXTipXgGx84l9znhyyDFopCH9Luhuz2PGE2
         vmiVBcHfqfXXVGYoRjTAG29BvH1EBHZUfWDeA=
Received: by 10.223.17.68 with SMTP id r4mr337733faa.62.1304099546009;
        Fri, 29 Apr 2011 10:52:26 -0700 (PDT)
Received: from localhost.localdomain (abvr62.neoplus.adsl.tpnet.pl [83.8.215.62])
        by mx.google.com with ESMTPS id n26sm962346fam.37.2011.04.29.10.52.23
        (version=SSLv3 cipher=OTHER);
        Fri, 29 Apr 2011 10:52:24 -0700 (PDT)
X-Mailer: git-send-email 1.7.3
In-Reply-To: <1304099521-27617-1-git-send-email-jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172479>

The major change is removing the ability to edit content tags (ctags)
in a web browser.

The interface was created by gitweb, while actual editing of tags was
to be done by external script; the API was not defined, and neither
was provided example implementation.  Such split is also a bit fragile
- interface and implementation have to be kept in sync.  Gitweb
provided only ability to add tags; you could not edit tags nor delete
them.


=46ormat of ctags is now described in the comment above git_get_project=
_ctags
subroutine.  Gitweb now is more robust with respect to original ctags
format; it also accepts two new formats: $GIT_DIR/ctags file, with one
content tag per line, and multi-value `gitweb.ctag' config variable.

Gathering all ctags of all project is now put in git_gather_all_ctags
subroutine, making git_project_list_body more clear.

git_populate_project_tagcloud subroutine now generates data used for
tag cloud, including generation of ctag link, also in the case
HTML::TagCloud module is unavailable.  Links are now generated using
href() subroutine - this is more robust, as ctags might contain '?',
';' and '=3D' special characters that need to be escaped in query param=
=2E
Shown tags are HTML-escaped.

The generation of tag cloud in git_show_project_tagcloud in the case
when HTML::TagCloud is not available is now changed slightly.

The 'content tags' field on project summary page is made more in line
with other fields in "projects_list" table.  Because one cannot now
add new tags from web interface, this field is no longer displayed
when there are no content tags for given project.

Ctags-issue-Reported-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutr=
onix.de>
Ctags-issue-Reported-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
This patch was originally sent to git mailing list in

  [RFC/PATCH] gitweb: Change the way "content tags" ('ctags') are handl=
ed
  http://thread.gmane.org/gmane.linux.debian.devel.bugs.general/802865/=
focus=3D168599

as part of

  gitweb: cloud tags feature produces malformed XML for errors
  http://thread.gmane.org/gmane.linux.debian.devel.bugs.general/802865/=
focus=3D168266

thread, crossposted to git mailing list.


Hardening parsing of ctags files, so that gitweb does not crash on
malformed entries, but just ignores them, sort of fixes original issue
reported in

  Bug#616005: libhtml-tagcloud-perl breaks gitweb
  http://thread.gmane.org/gmane.linux.debian.devel.bugs.general/802865/
  http://bugs.debian.org/616005

by Uwe Kleine-K=C3=B6nig and crossposted to git mailing list by Jonatha=
n
Nieder.

I say "sort of fixes" because this patch doesn't attempt to solve
deeper fundamental problem with error / exception handling in gitweb
after some data was already sent to a browser.

Note also that the bug was caused by mishandling (incorrectly
generating) underdocumented then 'ctags' feature.

 gitweb/gitweb.perl |  141 +++++++++++++++++++++++++++++++++++---------=
-------
 1 files changed, 97 insertions(+), 44 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 014b33b..60cb772 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -412,20 +412,23 @@ our %feature =3D (
 		'override' =3D> 0,
 		'default' =3D> []},
=20
-	# Allow gitweb scan project content tags described in ctags/
-	# of project repository, and display the popular Web 2.0-ish
-	# "tag cloud" near the project list. Note that this is something
-	# COMPLETELY different from the normal Git tags.
+	# Allow gitweb scan project content tags of project repository,
+	# and display the popular Web 2.0-ish "tag cloud" near the projects
+	# list.  Note that this is something COMPLETELY different from the
+	# normal Git tags.
=20
 	# gitweb by itself can show existing tags, but it does not handle
-	# tagging itself; you need an external application for that.
-	# For an example script, check Girocco's cgi/tagproj.cgi.
+	# tagging itself; you need to do it externally, outside gitweb.
+	# The format is described in git_get_project_ctags() subroutine.
 	# You may want to install the HTML::TagCloud Perl module to get
 	# a pretty tag cloud instead of just a list of tags.
=20
 	# To enable system wide have in $GITWEB_CONFIG
-	# $feature{'ctags'}{'default'} =3D ['path_to_tag_script'];
+	# $feature{'ctags'}{'default'} =3D [1];
 	# Project specific override is not supported.
+
+	# In the future whether ctags editing is enabled might depend
+	# on the value, but using 1 should always mean no editing of ctags.
 	'ctags' =3D> {
 		'override' =3D> 0,
 		'default' =3D> [0]},
@@ -703,6 +706,7 @@ our @cgi_param_mapping =3D (
 	snapshot_format =3D> "sf",
 	extra_options =3D> "opt",
 	search_use_regexp =3D> "sr",
+	ctag =3D> "by_tag",
 	# this must be last entry (for manipulation from JavaScript)
 	javascript =3D> "js"
 );
@@ -2572,23 +2576,66 @@ sub git_get_project_description {
 	return $descr;
 }
=20
+# supported formats:
+# * $GIT_DIR/ctags/<tagname> file (in 'ctags' subdirectory)
+#   - if its contents is a number, use it as tag weight,
+#   - otherwise add a tag with weight 1
+# * $GIT_DIR/ctags file, each line is a tag (with weight 1)
+#   the same value multiple times increases tag weight
+# * `gitweb.ctag' multi-valued repo config variable
 sub git_get_project_ctags {
-	my $path =3D shift;
+	my $project =3D shift;
 	my $ctags =3D {};
=20
-	$git_dir =3D "$projectroot/$path";
-	opendir my $dh, "$git_dir/ctags"
-		or return $ctags;
-	foreach (grep { -f $_ } map { "$git_dir/ctags/$_" } readdir($dh)) {
-		open my $ct, '<', $_ or next;
-		my $val =3D <$ct>;
-		chomp $val;
-		close $ct;
-		my $ctag =3D $_; $ctag =3D~ s#.*/##;
-		$ctags->{$ctag} =3D $val;
+	$git_dir =3D "$projectroot/$project";
+	if (opendir my $dh, "$git_dir/ctags") {
+		my @files =3D grep { -f $_ } map { "$git_dir/ctags/$_" } readdir($dh=
);
+		foreach my $tagfile (@files) {
+			open my $ct, '<', $tagfile
+				or next;
+			my $val =3D <$ct>;
+			chomp $val if $val;
+			close $ct;
+
+			(my $ctag =3D $tagfile) =3D~ s#.*/##;
+			if ($val =3D~ /\d+/) {
+				$ctags->{$ctag} =3D $val;
+			} else {
+				$ctags->{$ctag} =3D 1;
+			}
+		}
+		closedir $dh;
+
+	} elsif (open my $fh, '<', "$git_dir/ctags") {
+		while (my $line =3D <$fh>) {
+			chomp $line;
+			$ctags->{$line}++ if $line;
+		}
+		close $fh;
+
+	} else {
+		my $taglist =3D config_to_multi(git_get_project_config('ctag'));
+		foreach my $tag (@$taglist) {
+			$ctags->{$tag}++;
+		}
 	}
-	closedir $dh;
-	$ctags;
+
+	return $ctags;
+}
+
+# return hash, where keys are content tags ('ctags'),
+# and values are sum of weights of given tag in every project
+sub git_gather_all_ctags {
+	my $projects =3D shift;
+	my $ctags =3D {};
+
+	foreach my $p (@$projects) {
+		foreach my $ct (keys %{$p->{'ctags'}}) {
+			$ctags->{$ct} +=3D $p->{'ctags'}->{$ct};
+		}
+	}
+
+	return $ctags;
 }
=20
 sub git_populate_project_tagcloud {
@@ -2608,31 +2655,41 @@ sub git_populate_project_tagcloud {
 	my $cloud;
 	if (eval { require HTML::TagCloud; 1; }) {
 		$cloud =3D HTML::TagCloud->new;
-		foreach (sort keys %ctags_lc) {
+		foreach my $ctag (sort keys %ctags_lc) {
 			# Pad the title with spaces so that the cloud looks
 			# less crammed.
-			my $title =3D $ctags_lc{$_}->{topname};
+			my $title =3D esc_html($ctags_lc{$ctag}->{topname});
 			$title =3D~ s/ /&nbsp;/g;
 			$title =3D~ s/^/&nbsp;/g;
 			$title =3D~ s/$/&nbsp;/g;
-			$cloud->add($title, $home_link."?by_tag=3D".$_, $ctags_lc{$_}->{cou=
nt});
+			$cloud->add($title, href(project=3D>undef, ctag=3D>$ctag),
+			            $ctags_lc{$ctag}->{count});
 		}
 	} else {
-		$cloud =3D \%ctags_lc;
+		$cloud =3D {};
+		foreach my $ctag (keys %ctags_lc) {
+			my $title =3D $ctags_lc{$ctag}->{topname};
+			$cloud->{$ctag}{count} =3D $ctags_lc{$ctag}->{count};
+			$cloud->{$ctag}{ctag} =3D
+				$cgi->a({-href=3D>href(project=3D>undef, ctag=3D>$ctag)},
+			          esc_html($title, -nbsp=3D>1));
+		}
 	}
-	$cloud;
+	return $cloud;
 }
=20
 sub git_show_project_tagcloud {
 	my ($cloud, $count) =3D @_;
-	print STDERR ref($cloud)."..\n";
 	if (ref $cloud eq 'HTML::TagCloud') {
 		return $cloud->html_and_css($count);
 	} else {
-		my @tags =3D sort { $cloud->{$a}->{count} <=3D> $cloud->{$b}->{count=
} } keys %$cloud;
-		return '<p align=3D"center">' . join (', ', map {
-			$cgi->a({-href=3D>"$home_link?by_tag=3D$_"}, $cloud->{$_}->{topname=
})
-		} splice(@tags, 0, $count)) . '</p>';
+		my @tags =3D sort { $cloud->{$a}->{'count'} <=3D> $cloud->{$b}->{'co=
unt'} } keys %$cloud;
+		return
+			'<div id=3D"htmltagcloud"'.($project ? '' : ' align=3D"center"').'>=
' .
+			join (', ', map {
+				$cloud->{$_}->{'ctag'}
+			} splice(@tags, 0, $count)) .
+			'</div>';
 	}
 }
=20
@@ -4920,13 +4977,8 @@ sub git_project_list_body {
 	@projects =3D sort_projects_list(\@projects, $order);
=20
 	if ($show_ctags) {
-		my %ctags;
-		foreach my $p (@projects) {
-			foreach my $ct (keys %{$p->{'ctags'}}) {
-				$ctags{$ct} +=3D $p->{'ctags'}->{$ct};
-			}
-		}
-		my $cloud =3D git_populate_project_tagcloud(\%ctags);
+		my $ctags =3D git_gather_all_ctags(\@projects);
+		my $cloud =3D git_populate_project_tagcloud($ctags);
 		print git_show_project_tagcloud($cloud, 64);
 	}
=20
@@ -5521,13 +5573,14 @@ sub git_summary {
 	my $show_ctags =3D gitweb_check_feature('ctags');
 	if ($show_ctags) {
 		my $ctags =3D git_get_project_ctags($project);
-		my $cloud =3D git_populate_project_tagcloud($ctags);
-		print "<tr id=3D\"metadata_ctags\"><td>Content tags:<br />";
-		print "</td>\n<td>" unless %$ctags;
-		print "<form action=3D\"$show_ctags\" method=3D\"post\"><input type=3D=
\"hidden\" name=3D\"p\" value=3D\"$project\" />Add: <input type=3D\"tex=
t\" name=3D\"t\" size=3D\"8\" /></form>";
-		print "</td>\n<td>" if %$ctags;
-		print git_show_project_tagcloud($cloud, 48);
-		print "</td></tr>";
+		if (%$ctags) {
+			# without ability to add tags, don't show if there are none
+			my $cloud =3D git_populate_project_tagcloud($ctags);
+			print "<tr id=3D\"metadata_ctags\">" .
+			      "<td>content tags</td>" .
+			      "<td>".git_show_project_tagcloud($cloud, 48)."</td>" .
+			      "</tr>\n";
+		}
 	}
=20
 	print "</table>\n";
--=20
1.7.3
