From: Jeremie Nikaes <jeremie.nikaes@ensimag.imag.fr>
Subject: [PATCHv3 1/2] Add a remote helper to interact with mediawiki, pull & clone handled
Date: Thu,  9 Jun 2011 15:15:59 +0200
Message-ID: <1307625360-10973-1-git-send-email-jeremie.nikaes@ensimag.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeremie Nikaes <jeremie.nikaes@ensimag.imag.fr>,
	Arnaud Lacurie <arnaud.lacurie@ensimag.imag.fr>,
	Claire Fousse <claire.fousse@ensimag.imag.fr>,
	David Amouyal <david.amouyal@ensimag.imag.fr>,
	Matthieu Moy <matthieu.moy@grenoble-inp.fr>,
	=?UTF-8?q?Sylvain=20Boulm=C3=A9?= <sylvain.boulme@imag.fr>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 09 15:17:06 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QUf6b-0008Ao-PL
	for gcvg-git-2@lo.gmane.org; Thu, 09 Jun 2011 15:17:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757768Ab1FINQx convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 9 Jun 2011 09:16:53 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:61039 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757555Ab1FINQw (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Jun 2011 09:16:52 -0400
Received: by wya21 with SMTP id 21so1107059wya.19
        for <git@vger.kernel.org>; Thu, 09 Jun 2011 06:16:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:sender:from:to:cc:subject:date:message-id
         :x-mailer:mime-version:content-type:content-transfer-encoding;
        bh=kTV+BrqchgtANLB+dzMsy/vb9JTt0vr/DqVIs1VahFk=;
        b=ulRpQpYWL/nRaHGgw6gww3mV7ibz5wouNDfFytJecczJzxUxeoru+eyg6Mj/o0kWCf
         JrRIaYUxg3EMoO1gUDmol12tRbg/7MB0qc62XAl7c/H0gggZJleD5l6p4WtrSEH3tKYm
         pIoG7o4eSdr2bzM9HkI1lPLB59evS+/tO8Sp8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        b=LVaXphIK6hn7MXBStxNqOozgWGvKNnKGeQ7AJHSdeD1KP/8W2N36O+lGLPZcQfOpOb
         VhrIYq65vnGYXdRb9MvagvOAMc6ieQ7cMI88XRsqK4lNx0oxR86RkiwQn3lZUX0WlqSa
         vn8iBer3x7PzjsLF9RhWtRz5ahVqnE8K1RhZA=
Received: by 10.227.58.65 with SMTP id f1mr831333wbh.3.1307625410754;
        Thu, 09 Jun 2011 06:16:50 -0700 (PDT)
Received: from localhost.localdomain (227.60.23.93.rev.sfr.net [93.23.60.227])
        by mx.google.com with ESMTPS id e1sm1219942wbh.22.2011.06.09.06.16.48
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 09 Jun 2011 06:16:49 -0700 (PDT)
X-Mailer: git-send-email 1.7.4.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175523>

Implement a gate between git and mediawiki, allowing git users to
push and pull objects from mediawiki just as one would do with a
classic git repository thanks to remote-helpers.

Currently supported commands are :
     git clone mediawiki::http://onewiki.com
     git pull

You need the following packages installed (available on common
repositories):
     libmediawiki-api-perl
     libdatetime-format-iso8601-perl

Use remote helpers in order to be as transparent as possible
to the git user.

Download Mediawiki revisions through the Mediawiki API and then
fast-import into git.

Mediawiki revisions and git commits are linked thanks to notes bound to
commits.

The import part is done on a refs/mediawiki/<remote> branch before
coming to refs/remote/origin/master (Huge thanks to Jonathan Nieder
for his help)

=46or now, the whole wiki is cloned, but it will be possible to clone o=
nly
some pages: the clone is based on a list of pages which is now all
pages.

Code clarified & improved with the help of Jeff King and Junio C Hamano=
=2E

We were not able to reproduce the empty timestamp bug noticed by Jeff
King, thus needing some further testing. A placeholder is still
implemented just in case. Its value is the value of the last valid
timestamp received + 1

With "use encoding 'utf-8'" non-iso characters are now fully supported
in both file content and filename.
A small helper run_git is also added to execute any git command, helpin=
g
to also utf-8 encode results from git commands.
However, utf-8 encoding for filenames could raise problems if different
file systems handle utf-8 filenames differently. A uri_escape of
mediawiki filenames could be imaginable, and is still to be discussed
further.

Partial cloning is supported using the following syntax :
"git clone mediawiki::http://wikiurl##A_Page##Another_Page"
As always, this url is kept in .git/config, helping to always keep
track of these specific pages

Signed-off-by: J=C3=A9r=C3=A9mie Nikaes <jeremie.nikaes@ensimag.imag.fr=
>
Signed-off-by: Arnaud Lacurie <arnaud.lacurie@ensimag.imag.fr>
Signed-off-by: Claire Fousse <claire.fousse@ensimag.imag.fr>
Signed-off-by: David Amouyal <david.amouyal@ensimag.imag.fr>
Signed-off-by: Matthieu Moy <matthieu.moy@grenoble-inp.fr>
Signed-off-by: Sylvain Boulm=C3=A9 <sylvain.boulme@imag.fr>
---
 -- diff with v2
 Added the timestamp placeholder
 Utf8 encoding now properly supported
 Partial cloning functionality added

 contrib/mw-to-git/git-remote-mediawiki     |  322 ++++++++++++++++++++=
++++++++
 contrib/mw-to-git/git-remote-mediawiki.txt |    7 +
 2 files changed, 329 insertions(+), 0 deletions(-)
 create mode 100755 contrib/mw-to-git/git-remote-mediawiki
 create mode 100644 contrib/mw-to-git/git-remote-mediawiki.txt

diff --git a/contrib/mw-to-git/git-remote-mediawiki b/contrib/mw-to-git=
/git-remote-mediawiki
new file mode 100755
index 0000000..176ff09
--- /dev/null
+++ b/contrib/mw-to-git/git-remote-mediawiki
@@ -0,0 +1,322 @@
+#! /usr/bin/perl
+
+use strict;
+use MediaWiki::API;
+use DateTime::Format::ISO8601;
+use encoding 'utf8';
+use URI::Escape;
+use warnings;
+
+# Mediawiki filenames can contain forward slashes. This variable decid=
es by which pattern they should be replaced
+my $slash_replacement =3D "%2F";
+
+my $remotename =3D $ARGV[0];
+# Current syntax to fetch only a set of pages mediawiki::http://mediaw=
ikiurl##A_Page##Another_Page
+my @pages_titles =3D split(/##/,$ARGV[1]);
+my $url =3D shift (@pages_titles);
+
+
+# commands parser
+my $entry;
+my @cmd;
+while (1) {
+	$| =3D 1; #flush STDOUT
+	$entry =3D <STDIN>;
+	chomp($entry);
+	@cmd =3D split(/ /,$entry);
+	if (defined($cmd[0])) {
+		if ($cmd[0] eq "capabilities") {
+			last unless (!defined($cmd[1]));
+			mw_capabilities();
+		} elsif ($cmd[0] eq "list") {
+			last unless (!defined($cmd[2]));
+			mw_list($cmd[1]);
+		} elsif ($cmd[0] eq "import") {
+			last unless ($cmd[1] ne "" && !defined($cmd[2]));
+			mw_import($cmd[1]);
+		} elsif ($cmd[0] eq "option") {
+			last unless ($cmd[1] ne "" && $cmd[2] ne "" && !defined($cmd[3]));
+			mw_option($cmd[1],$cmd[2]);
+		} elsif ($cmd[0] eq "push") {
+			# Check the pattern <src>:<dst>
+			my @pushargs =3D split(/:/,$cmd[1]);
+			last unless ($pushargs[1] ne "" && !defined($pushargs[2]));
+			mw_push($pushargs[0],$pushargs[1]);
+		} else {
+			print STDERR "Unknown capability. Aborting...\n";
+			last;
+		}
+	} else {
+		# End of input
+		last;
+	}
+
+}
+
+########################## Functions ##############################
+sub get_pages{
+	my $mediawiki =3D MediaWiki::API->new;
+	$mediawiki->{config}->{api_url} =3D "$url/api.php";
+
+	my $pages;
+	if (!@pages_titles){
+		$pages =3D $mediawiki->list({
+			action =3D> 'query',
+			list =3D> 'allpages',
+			aplimit =3D> 500,
+		});
+		if (!defined($pages)) {
+			print STDERR "fatal: '$url' does not appear to be a mediawiki\n";
+			print STDERR "fatal: make sure '$url/api.php' is a valid page\n";
+			exit 1;
+		}
+		return @$pages;
+	} else {
+		#the list of titles should follow the pattern 'page1|page2|...'
+		my $titles =3D "";
+		foreach my $title (@pages_titles){
+			$titles.=3D"$title|";
+		}
+		#supress the last | that is add in the foreach
+		chop($titles);
+
+		$pages =3D $mediawiki->api({
+			action =3D> 'query',
+			titles =3D> $titles,
+		});
+		if (!defined($pages)) {
+			print STDERR "fatal: None of the pages exist \n";
+			exit 1;
+		}
+		return values (%{$pages->{query}->{pages}});
+	}
+}
+
+sub run_git {
+	open(my $git, "-|:encoding(UTF-8)", "git " . $_[0]);
+	my $res =3D do { local $/; <$git> };
+	close($git);
+
+	return $res;
+}
+
+
+sub get_last_local_revision {
+	# Get note regarding last mediawiki revision
+	my $note =3D run_git("notes --ref=3Dmediawiki show refs/mediawiki/$re=
motename/master 2>/dev/null");
+	my @note_info =3D split(/ /, $note);
+
+	my $lastrevision_number;
+	if (!(defined($note_info[0]) && $note_info[0] eq "mediawiki_revision:=
")) {
+		print STDERR "No previous mediawiki revision found";
+		$lastrevision_number =3D 0;
+	} else {
+		# Notes are formatted : mediawiki_revision: #number
+		$lastrevision_number =3D $note_info[1];
+		chomp($lastrevision_number);
+		print STDERR "Last local mediawiki revision found is $lastrevision_n=
umber ";
+	}
+	return $lastrevision_number;
+}
+
+sub get_last_remote_revision {
+	my $mediawiki =3D MediaWiki::API->new;
+	$mediawiki->{config}->{api_url} =3D "$url/api.php";
+
+	my @pages =3D get_pages();
+
+	my $max_rev_num =3D 0;
+
+	foreach my $page (@pages) {
+		my $id =3D $page->{pageid};
+
+		my $query =3D {
+			action =3D> 'query',
+			prop =3D> 'revisions',
+			rvprop =3D> 'ids',
+			pageids =3D> $id,
+		};
+
+		my $result =3D $mediawiki->api($query);
+	=09
+		my $lastrev =3D pop(@{$result->{query}->{pages}->{$id}->{revisions}}=
);
+	=09
+		$max_rev_num =3D ($lastrev->{revid} > $max_rev_num ? $lastrev->{revi=
d} : $max_rev_num);
+	}
+
+	print STDERR "Last remote revision found is $max_rev_num\n";
+	return $max_rev_num;
+}
+
+sub literal_data {
+	my ($content) =3D @_;
+	print STDOUT "data ", bytes::length($content), "\n", $content;
+}
+
+sub mw_capabilities {
+	# Revisions are imported to the private namespace
+	# refs/mediawiki/$remotename/ by the helper and fetched into
+	# refs/remotes/$remotename later by fetch.
+	print STDOUT "refspec refs/heads/*:refs/mediawiki/$remotename/*\n";
+	print STDOUT "import\n";
+	print STDOUT "list\n";
+	print STDOUT "option\n";
+	print STDOUT "push\n";
+	print STDOUT "\n";
+}
+
+sub mw_list {
+	# MediaWiki do not have branches, we consider one branch arbitrarily
+	# called master
+	print STDOUT "? refs/heads/master\n";
+	print STDOUT '@'."refs/heads/master HEAD\n";
+	print STDOUT "\n";
+
+}
+
+sub mw_option {
+	print STDOUT "unsupported\n";
+}
+
+sub mw_import {
+	my @wiki_name =3D split(/:\/\//,$url);
+	my $wiki_name =3D $wiki_name[1];
+
+	my $mediawiki =3D MediaWiki::API->new;
+	$mediawiki->{config}->{api_url} =3D "$url/api.php";
+
+	my @pages =3D get_pages();
+
+	my @revisions;
+	print STDERR "Searching revisions...\n";
+	my $fetch_from =3D get_last_local_revision() + 1;
+	if ($fetch_from =3D=3D 1) {
+		print STDERR ", fetching from beginning\n";
+	} else {
+		print STDERR ", fetching from here\n";
+	}
+	my $n =3D 1;
+	foreach my $page (@pages) {
+		my $id =3D $page->{pageid};
+
+		print STDERR "$n/", scalar(@pages), ": ". $page->{title}."\n";
+		$n++;
+
+		my $query =3D {
+			action =3D> 'query',
+			prop =3D> 'revisions',
+			rvprop =3D> 'ids',
+			rvdir =3D> 'newer',
+			rvstartid =3D> $fetch_from,
+			rvlimit =3D> 500,
+			pageids =3D> $id,
+		};
+
+		my $revnum =3D 0;
+		# Get 500 revisions at a time due to the mediawiki api limit
+		while (1) {
+			my $result =3D $mediawiki->api($query);
+
+			# Parse each of those 500 revisions
+			foreach my $revision (@{$result->{query}->{pages}->{$id}->{revision=
s}}) {
+				my $page_rev_ids;
+				$page_rev_ids->{pageid} =3D $page->{pageid};
+				$page_rev_ids->{revid} =3D $revision->{revid};
+				push (@revisions, $page_rev_ids);
+				$revnum++;
+			}
+			last unless $result->{'query-continue'};
+			$query->{rvstartid} =3D $result->{'query-continue'}->{revisions}->{=
rvstartid};
+		}
+		print STDERR "  Found ", $revnum, " revision(s).\n";
+	}
+
+	# Creation of the fast-import stream
+	print STDERR "Fetching & writing export data...\n";
+=09
+	$n =3D 0;
+	my $last_timestamp =3D 0; #Placeholer in case $rev->timestamp is unde=
fined
+
+	foreach my $pagerevids (sort {$a->{revid} <=3D> $b->{revid}} @revisio=
ns) {
+		#fetch the content of the pages
+		my $query =3D {
+			action =3D> 'query',
+			prop =3D> 'revisions',
+			rvprop =3D> 'content|timestamp|comment|user|ids',
+			revids =3D> $pagerevids->{revid},
+		};
+
+		my $result =3D $mediawiki->api($query);
+
+		my $rev =3D pop(@{$result->{query}->{pages}->{$pagerevids->{pageid}}=
->{revisions}});
+
+		$n++;
+		my $user =3D $rev->{user} || 'Anonymous';
+
+		if (!defined($rev->{timestamp})) {
+			$last_timestamp++;
+		} else {
+			$last_timestamp =3D $rev->{timestamp};
+		}
+		my $dt =3D DateTime::Format::ISO8601->parse_datetime($last_timestamp=
);
+
+		my $comment =3D defined $rev->{comment} ? $rev->{comment} : '*Empty =
MediaWiki Message*';
+	=09
+		my $title =3D $result->{query}->{pages}->{$pagerevids->{pageid}}->{t=
itle};
+		$title =3D~ y/ /_/;
+		#$title =3D uri_escape($title); #It would be nice to use uri_escape =
to be cross compatible
+		#on different file systems handling accentuated characters different=
ly
+		$title =3D~ s/\//$slash_replacement/g;
+	=09
+		my $content =3D $rev->{'*'};
+		# This \n is important. This is due to mediawiki's way to handle end=
 of files.
+		$content .=3D "\n";
+
+		print STDERR "$n/", scalar(@revisions), ": Revision #$pagerevids->{r=
evid} of $title\n";
+
+		print STDOUT "commit refs/mediawiki/$remotename/master\n";
+		print STDOUT "mark :$n\n";
+		print STDOUT "committer $user <$user\@$wiki_name> ", $dt->epoch, " +=
0000\n";
+		literal_data($comment);
+		# If it's not a clone, needs to know where to start from
+		if ($fetch_from !=3D 1 && $n =3D=3D 1) {
+			print STDOUT "from refs/mediawiki/$remotename/master^0\n";
+		}
+		print STDOUT "M 644 inline $title.mw\n";
+		literal_data($content);
+		print STDOUT "\n\n";
+
+
+
+
+		# mediawiki revision number in the git note
+		if ($fetch_from =3D=3D 1 && $n =3D=3D 1) {
+			print STDOUT "reset refs/notes/mediawiki\n";
+		}
+		print STDOUT "commit refs/notes/mediawiki\n";
+		print STDOUT "committer $user <$user\@$wiki_name> ", $dt->epoch, " +=
0000\n";
+		literal_data("note added by git-mediawiki");
+		if ($fetch_from !=3D 1 && $n =3D=3D 1) {
+			print STDOUT "from refs/notes/mediawiki^0\n";
+		}
+		print STDOUT "N inline :$n\n";
+		literal_data("mediawiki_revision: " . $pagerevids->{revid});
+		print STDOUT "\n\n";
+	}
+
+	if ($fetch_from =3D=3D 1) {
+		if ($n !=3D 0) {
+			print STDOUT "reset $_[0]\n"; #$_[0] contains refs/heads/master
+			print STDOUT "from :$n\n";
+		} else {
+			print STDERR "You appear to have cloned an empty mediawiki\n";
+			#Something has to be done remote-helper side. If nothing is done, a=
n error is=20
+			#thrown saying that HEAD is refering to unknown object 000000000000=
0000000
+		}
+	}
+
+}
+
+sub mw_push {
+	print STDERR "Push not yet implemented\n";
+}
diff --git a/contrib/mw-to-git/git-remote-mediawiki.txt b/contrib/mw-to=
-git/git-remote-mediawiki.txt
new file mode 100644
index 0000000..4d211f5
--- /dev/null
+++ b/contrib/mw-to-git/git-remote-mediawiki.txt
@@ -0,0 +1,7 @@
+Git-Mediawiki is a project which aims the creation of a gate
+between git and mediawiki, allowing git users to push and pull
+objects from mediawiki just as one would do with a classic git
+repository thanks to remote-helpers.
+
+For more information, visit the wiki at
+https://github.com/Bibzball/Git-Mediawiki/wiki
--=20
1.7.4.1
