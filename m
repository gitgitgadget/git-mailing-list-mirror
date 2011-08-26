From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: [PATCH 2/2] Add a remote helper to interact with mediawiki (fetch & push)
Date: Fri, 26 Aug 2011 19:11:29 +0200
Message-ID: <1314378689-8997-2-git-send-email-Matthieu.Moy@imag.fr>
References: <1314378689-8997-1-git-send-email-Matthieu.Moy@imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeremie Nikaes <jeremie.nikaes@ensimag.imag.fr>,
	Arnaud Lacurie <arnaud.lacurie@ensimag.imag.fr>,
	Claire Fousse <claire.fousse@ensimag.imag.fr>,
	David Amouyal <david.amouyal@ensimag.imag.fr>,
	Matthieu Moy <matthieu.moy@grenoble-inp.fr>,
	=?UTF-8?q?Sylvain=20Boulm=C3=A9?= <sylvain.boulme@imag.fr>,
	Matthieu Moy <Matthieu.Moy@imag.fr>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Fri Aug 26 19:12:03 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qwzwo-0007mL-04
	for gcvg-git-2@lo.gmane.org; Fri, 26 Aug 2011 19:12:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753157Ab1HZRL4 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 26 Aug 2011 13:11:56 -0400
Received: from mx1.imag.fr ([129.88.30.5]:60794 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752300Ab1HZRLz (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Aug 2011 13:11:55 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id p7QHBQpJ007295
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Fri, 26 Aug 2011 19:11:26 +0200
Received: from bauges.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.69)
	(envelope-from <moy@imag.fr>)
	id 1Qwzwc-0002Xi-1a; Fri, 26 Aug 2011 19:11:50 +0200
Received: from moy by bauges.imag.fr with local (Exim 4.72)
	(envelope-from <moy@imag.fr>)
	id 1Qwzwb-0002aR-W4; Fri, 26 Aug 2011 19:11:49 +0200
X-Mailer: git-send-email 1.7.6.585.g5929f.dirty
In-Reply-To: <1314378689-8997-1-git-send-email-Matthieu.Moy@imag.fr>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Fri, 26 Aug 2011 19:11:27 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: p7QHBQpJ007295
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
MailScanner-NULL-Check: 1314983487.66171@PklGbZuHsXkWIRqk5w8uWw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180181>

=46rom: Jeremie Nikaes <jeremie.nikaes@ensimag.imag.fr>

Implement a gate between git and mediawiki, allowing git users to push
and pull objects from mediawiki just as one would do with a classic git
repository thanks to remote-helpers.

The following packages need to be installed (available on common
repositories):

     libmediawiki-api-perl
     libdatetime-format-iso8601-perl

Use remote helpers in order to be as transparent as possible to the git
user.

Download Mediawiki revisions through the Mediawiki API and then
fast-import into git.

Mediawiki revision number and git commits are linked thanks to notes
bound to commits.

The import part is done on a refs/mediawiki/<remote> branch before
coming to refs/remote/origin/master (Huge thanks to Jonathan Nieder
for his help)

We use UTF-8 everywhere: use encoding 'utf8'; does most of the job, but
we also read the output of Git commands in UTF-8 with the small helper
run_git, and write to the console (STDERR) in UTF-8. This allows a
seamless use of non-ascii characters in page titles, but hasn't been
tested on non-UTF-8 systems. In particular, UTF-8 encoding for filename=
s
could raise problems if different file systems handle UTF-8 filenames
differently. A uri_escape of mediawiki filenames could be imaginable, a=
nd
is still to be discussed further.

Partial cloning is supported using one of:

git clone -c remote.origin.pages=3D'A_Page  Another_Page' mediawiki::ht=
tp://wikiurl

git clone -c remote.origin.categories=3D'Some_Category' mediawiki::http=
://wikiurl

git clone -c remote.origin.shallow=3D'True' mediawiki::http://wikiurl

Thanks to notes metadata, it is possible to compare remote and local la=
st
mediawiki revision to warn non-fast forward pushes and "everything
up-to-date" case.

When allowed, push looks for each commit between remotes/origin/master
and HEAD, catches every blob related to these commit and push them in
chronological order. To do so, it uses git rev-list --children HEAD and
travels the tree from remotes/origin/master to HEAD through children. I=
n
other words :

	* Shortest path from remotes/origin/master to HEAD
	* For each commit encountered, push blobs related to this commit

Signed-off-by: J=C3=A9r=C3=A9mie Nikaes <jeremie.nikaes@ensimag.imag.fr=
>
Signed-off-by: Arnaud Lacurie <arnaud.lacurie@ensimag.imag.fr>
Signed-off-by: Claire Fousse <claire.fousse@ensimag.imag.fr>
Signed-off-by: David Amouyal <david.amouyal@ensimag.imag.fr>
Signed-off-by: Matthieu Moy <matthieu.moy@grenoble-inp.fr>
Signed-off-by: Sylvain Boulm=C3=A9 <sylvain.boulme@imag.fr>
Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
---
This is a resurection of an old patch serie.

The previous round was here:

  http://thread.gmane.org/gmane.comp.version-control.git/175523

Maintaining two separate patches for import/export was getting
painful, so I've merged them into a single patch.

Git-Mediawiki is originally a student project, and since the students
didn't have time to finish the work this summer, I've taken time to
do some cleanup and testing.

In short, the changes since v3 are:

* Adapt to newer Git, which seem to require a "done" command at the
  end of the fast-import stream. I don't understand why this is
  needed, since fast-import is called without the --done flag by
  remote-helpers, but if I don't do this, "git fetch" doesn't
  terminate and keeps waiting ...

* Allow importing just a category

* Support shallow clone and fetch (for fetch, this means fetch just
  the last revision each time).

* Basic support for authentication (with password cleartext in
  .git/config :-( ).

* Support pushing to a new wiki (i.e. not the one you've cloned to).

* Accented characters in filenames now displayed correctly on the
  terminal.

* Support page deletion (by replacing the page content with
  [[Category:Deleted]]).

* Support creation of empty files

* Support forbidden characters {}[]| in filenames

* Support partial clone with more than 50 pages

I'd like to get this merged in contrib/, so that the code be in a
safe place, where other people can take care of it too. I'll probably
offer a student project "improve Git-Mediawiki" to my students next
June.

 contrib/mw-to-git/git-remote-mediawiki     |  722 ++++++++++++++++++++=
++++++++
 contrib/mw-to-git/git-remote-mediawiki.txt |    7 +
 2 files changed, 729 insertions(+), 0 deletions(-)
 create mode 100755 contrib/mw-to-git/git-remote-mediawiki
 create mode 100644 contrib/mw-to-git/git-remote-mediawiki.txt

diff --git a/contrib/mw-to-git/git-remote-mediawiki b/contrib/mw-to-git=
/git-remote-mediawiki
new file mode 100755
index 0000000..62c6794
--- /dev/null
+++ b/contrib/mw-to-git/git-remote-mediawiki
@@ -0,0 +1,722 @@
+#! /usr/bin/perl
+
+# Copyright (C) 2011
+#     J=C3=A9r=C3=A9mie Nikaes <jeremie.nikaes@ensimag.imag.fr>
+#     Arnaud Lacurie <arnaud.lacurie@ensimag.imag.fr>
+#     Claire Fousse <claire.fousse@ensimag.imag.fr>
+#     David Amouyal <david.amouyal@ensimag.imag.fr>
+#     Matthieu Moy <matthieu.moy@grenoble-inp.fr>
+# License: GPL v2 or later
+
+# Gateway between Git and MediaWiki.
+#   https://github.com/Bibzball/Git-Mediawiki/wiki
+#
+# Known limitations:
+#
+# - Only wiki pages are managed, no support for [[File:...]]
+#   attachments.
+#
+# - Poor performance in the best case: it takes forever to check
+#   whether we're up-to-date (on fetch or push) or to fetch a few
+#   revisions from a large wiki, because we use exclusively a
+#   page-based synchronization. We could switch to a wiki-wide
+#   synchronization when the synchronization involves few revisions
+#   but the wiki is large.
+#
+# - Git renames could be turned into MediaWiki renames (see TODO
+#   below)
+#
+# - login/password support requires the user to write the password
+#   cleartext in a file (see TODO below).
+#
+# - No way to import "one page, and all pages included in it"
+#
+# - Multiple remote MediaWikis have not been very well tested.
+
+use strict;
+use MediaWiki::API;
+use DateTime::Format::ISO8601;
+use encoding 'utf8';
+
+# use encoding 'utf8' doesn't change STDERROR
+# but we're going to output UTF-8 filenames to STDERR
+binmode STDERR, ":utf8";
+
+use URI::Escape;
+use warnings;
+
+# Mediawiki filenames can contain forward slashes. This variable decid=
es by which pattern they should be replaced
+use constant SLASH_REPLACEMENT =3D> "%2F";
+
+# It's not always possible to delete pages (may require some
+# priviledges). Deleted pages are replaced with this content.
+use constant DELETED_CONTENT =3D> "[[Category:Deleted]]\n";
+
+# It's not possible to create empty pages. New empty files in Git are
+# sent with this content instead.
+use constant EMPTY_CONTENT =3D> "<!-- empty page -->\n";
+
+# used to reflect file creation or deletion in diff.
+use constant NULL_SHA1 =3D> "0000000000000000000000000000000000000000"=
;
+
+my $remotename =3D $ARGV[0];
+my $url =3D $ARGV[1];
+
+# Accept both space-separated and multiple keys in config file.
+# Spaces should be written as _ anyway because we'll use chomp.
+my @tracked_pages =3D split(/[ \n]/, run_git("config --get-all remote.=
". $remotename .".pages"));
+chomp(@tracked_pages);
+
+# Just like @tracked_pages, but for MediaWiki categories.
+my @tracked_categories =3D split(/[ \n]/, run_git("config --get-all re=
mote.". $remotename .".categories"));
+chomp(@tracked_categories);
+
+my $wiki_login =3D run_git("config --get remote.". $remotename .".mwLo=
gin");
+# TODO: ideally, this should be able to read from keyboard, but we're
+# inside a remote helper, so our stdin is connect to git, not to a
+# terminal.
+my $wiki_passwd =3D run_git("config --get remote.". $remotename .".mwP=
assword");
+chomp ($wiki_login);
+chomp ($wiki_passwd);
+
+# Import only last revisions (both for clone and fetch)
+my $shallow_import =3D run_git("config --get --bool remote.". $remoten=
ame .".shallow");
+chomp($shallow_import);
+$shallow_import =3D ($shallow_import eq "true");
+
+my $wiki_name =3D $url;
+$wiki_name =3D~ s/[^\/]*:\/\///;
+
+my $import_started;
+
+# Commands parser
+my $entry;
+my @cmd;
+while (<STDIN>) {
+	chomp;
+	@cmd =3D split(/ /);
+	if (defined($cmd[0])) {
+		# Line not blank
+		if ($cmd[0] eq "capabilities") {
+			die("Too many arguments for capabilities") unless (!defined($cmd[1]=
));
+			mw_capabilities();
+		} elsif ($cmd[0] eq "list") {
+			die("Too many arguments for list") unless (!defined($cmd[2]));
+			mw_list($cmd[1]);
+		} elsif ($cmd[0] eq "import") {
+			die("Invalid arguments for import") unless ($cmd[1] ne "" && !defin=
ed($cmd[2]));
+			mw_import($cmd[1]);
+		} elsif ($cmd[0] eq "option") {
+			die("Too many arguments for option") unless ($cmd[1] ne "" && $cmd[=
2] ne "" && !defined($cmd[3]));
+			mw_option($cmd[1],$cmd[2]);
+		} elsif ($cmd[0] eq "push") {
+			# Check the pattern <src>:<dst>
+			my @pushargs =3D split(/:/,$cmd[1]);
+			die("Invalid arguments for push") unless ($pushargs[1] ne "" && !de=
fined($pushargs[2]));
+			mw_push($pushargs[0],$pushargs[1]);
+		} else {
+			print STDERR "Unknown command. Aborting...\n";
+			last;
+		}
+	} else {
+		# blank line: we should terminate
+		last;
+	}
+
+	BEGIN { $| =3D 1 } # flush STDOUT, to make sure the previous
+			 # command is fully processed.
+}
+# End of input
+if ($import_started) {
+	# Terminate the fast-import stream properly.
+	# Git requires one "done" command, and only
+	# one This is OK since we only have one
+	# branch, so import will be called only once
+	# (plus once for HEAD, for which we won't
+	# reach this point).
+	print STDOUT "done\n";
+}
+BEGIN { $| =3D 1 };
+if (!eof(STDIN)) {
+	# Wait for Git to terminate. If we don't, git fetch
+	# (transport-helper.c's sendline function) will try to write
+	# to our stdin, which will be closed, and git fetch will be
+	# killed. That's probably a bug in transport-helper.c, but in
+	# the meantime ...
+	sleep .1;
+};
+
+########################## Functions ##############################
+
+# MediaWiki API instance, created lazily.
+my $mediawiki;
+
+sub mw_connect_maybe {
+	if ($mediawiki) {
+	    return;
+	}
+	$mediawiki =3D MediaWiki::API->new;
+	$mediawiki->{config}->{api_url} =3D "$url/api.php";
+	if ($wiki_login) {
+		if (!$mediawiki->login({
+			lgname =3D> $wiki_login,
+			lgpassword =3D> $wiki_passwd,
+		})) {
+			print STDERR "Failed to log in mediawiki user \"$wiki_login\" on $u=
rl\n";
+			print STDERR "(error " .
+			    $mediawiki->{error}->{code} . ': ' .
+			    $mediawiki->{error}->{details} . ")\n";
+			exit 1;
+		} else {
+			print STDERR "Logged in with user \"$wiki_login\".\n";
+		}
+	}
+}
+
+sub get_mw_first_pages {
+	my $some_pages =3D shift;
+	my @some_pages =3D @{$some_pages};
+
+	my $pages =3D shift;
+
+	# pattern 'page1|page2|...' required by the API
+	my $titles =3D join('|', @some_pages);
+
+	my $mw_pages =3D $mediawiki->api({
+		action =3D> 'query',
+		titles =3D> $titles,
+	});
+	if (!defined($mw_pages)) {
+		print STDERR "fatal: could not query the list of wiki pages.\n";
+		print STDERR "fatal: '$url' does not appear to be a mediawiki\n";
+		print STDERR "fatal: make sure '$url/api.php' is a valid page.\n";
+		exit 1;
+	}
+	while (my ($id, $page) =3D each (%{$mw_pages->{query}->{pages}})) {
+		if ($id < 0) {
+			print STDERR "Warning: page $page->{title} not found on wiki\n";
+		} else {
+			$pages->{$page->{title}} =3D $page;
+		}
+	}
+}
+
+sub get_mw_pages {
+	mw_connect_maybe();
+
+	my %pages; # hash on page titles to avoid duplicates
+	my $user_defined;
+	if (@tracked_pages) {
+		$user_defined =3D 1;
+		# The user provided a list of pages titles, but we
+		# still need to query the API to get the page IDs.
+
+		my @some_pages =3D @tracked_pages;
+		while (@some_pages) {
+			my $last =3D 50;
+			if ($#some_pages < $last) {
+				$last =3D $#some_pages;
+			}
+			my @slice =3D @some_pages[0..$last];
+			get_mw_first_pages(\@slice, \%pages);
+			@some_pages =3D @some_pages[51..$#some_pages];
+		}
+	}
+	if (@tracked_categories) {
+		$user_defined =3D 1;
+		foreach my $category (@tracked_categories) {
+			if (index($category, ':') < 0) {
+				# Mediawiki requires the Category
+				# prefix, but let's not force the user
+				# to specify it.
+				$category =3D "Category:" . $category;
+			}
+			my $mw_pages =3D $mediawiki->list ( {
+				action =3D> 'query',
+				list =3D> 'categorymembers',
+				cmtitle =3D> $category,
+				cmlimit =3D> 'max' } )
+			    || die $mediawiki->{error}->{code} . ': ' . $mediawiki->{error}=
->{details};
+			foreach my $page (@{$mw_pages}) {
+				$pages{$page->{title}} =3D $page;
+			}
+		}
+	}
+	if (!$user_defined) {
+		# No user-provided list, get the list of pages from
+		# the API.
+		my $mw_pages =3D $mediawiki->list({
+			action =3D> 'query',
+			list =3D> 'allpages',
+			aplimit =3D> 500,
+		});
+		if (!defined($mw_pages)) {
+			print STDERR "fatal: could not get the list of wiki pages.\n";
+			print STDERR "fatal: '$url' does not appear to be a mediawiki\n";
+			print STDERR "fatal: make sure '$url/api.php' is a valid page.\n";
+			exit 1;
+		}
+		foreach my $page (@{$mw_pages}) {
+			$pages{$page->{title}} =3D $page;
+		}
+	}
+	return values(%pages);
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
+	my $note =3D run_git("notes --ref=3D$remotename/mediawiki show refs/m=
ediawiki/$remotename/master 2>/dev/null");
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
umber";
+	}
+	return $lastrevision_number;
+}
+
+sub get_last_remote_revision {
+	mw_connect_maybe();
+
+	my @pages =3D get_mw_pages();
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
+
+		my $lastrev =3D pop(@{$result->{query}->{pages}->{$id}->{revisions}}=
);
+
+		$max_rev_num =3D ($lastrev->{revid} > $max_rev_num ? $lastrev->{revi=
d} : $max_rev_num);
+	}
+
+	print STDERR "Last remote revision found is $max_rev_num.\n";
+	return $max_rev_num;
+}
+
+# Clean content before sending it to MediaWiki
+sub mediawiki_clean {
+	my $string =3D shift;
+	my $page_created =3D shift;
+	# Mediawiki does not allow blank space at the end of a page and ends =
with a single \n.
+	# This function right trims a string and adds a \n at the end to foll=
ow this rule
+	$string =3D~ s/\s+$//;
+	if ($string eq "" && $page_created) {
+		# Creating empty pages is forbidden.
+		$string =3D EMPTY_CONTENT;
+	}
+	return $string."\n";
+}
+
+# Filter applied on MediaWiki data before adding them to Git
+sub mediawiki_smudge {
+	my $string =3D shift;
+	if ($string eq EMPTY_CONTENT) {
+		$string =3D "";
+	}
+	# This \n is important. This is due to mediawiki's way to handle end =
of files.
+	return $string."\n";
+}
+
+sub mediawiki_clean_filename {
+	my $filename =3D shift;
+	$filename =3D~ s/@{[SLASH_REPLACEMENT]}/\//g;
+	# [, ], |, {, and } are forbidden by MediaWiki, even URL-encoded.
+	# Do a variant of URL-encoding, i.e. looks like URL-encoding,
+	# but with _ added to prevent MediaWiki from thinking this is
+	# an actual special character.
+	$filename =3D~ s/[\[\]\{\}\|]/sprintf("_%%_%x", ord($&))/ge;
+	# If we use the uri escape before
+	# we should unescape here, before anything
+
+	return $filename;
+}
+
+sub mediawiki_smudge_filename {
+	my $filename =3D shift;
+	$filename =3D~ s/\//@{[SLASH_REPLACEMENT]}/g;
+	$filename =3D~ s/ /_/g;
+	# Decode forbidden characters encoded in mediawiki_clean_filename
+	$filename =3D~ s/_%_([0-9a-fA-F][0-9a-fA-F])/sprintf("%c", hex($1))/g=
e;
+	return $filename;
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
+	print STDOUT "push\n";
+	print STDOUT "\n";
+}
+
+sub mw_list {
+	# MediaWiki do not have branches, we consider one branch arbitrarily
+	# called master, and HEAD pointing to it.
+	print STDOUT "? refs/heads/master\n";
+	print STDOUT "\@refs/heads/master HEAD\n";
+	print STDOUT "\n";
+}
+
+sub mw_option {
+	print STDERR "remote-helper command 'option $_[0]' not yet implemente=
d\n";
+	print STDOUT "unsupported\n";
+}
+
+sub fetch_mw_revisions_for_page {
+	my $page =3D shift;
+	my $id =3D shift;
+	my $fetch_from =3D shift;
+	my @page_revs =3D ();
+	my $query =3D {
+		action =3D> 'query',
+		prop =3D> 'revisions',
+		rvprop =3D> 'ids',
+		rvdir =3D> 'newer',
+		rvstartid =3D> $fetch_from,
+		rvlimit =3D> 500,
+		pageids =3D> $id,
+	};
+
+	my $revnum =3D 0;
+	# Get 500 revisions at a time due to the mediawiki api limit
+	while (1) {
+		my $result =3D $mediawiki->api($query);
+
+		# Parse each of those 500 revisions
+		foreach my $revision (@{$result->{query}->{pages}->{$id}->{revisions=
}}) {
+			my $page_rev_ids;
+			$page_rev_ids->{pageid} =3D $page->{pageid};
+			$page_rev_ids->{revid} =3D $revision->{revid};
+			push (@page_revs, $page_rev_ids);
+			$revnum++;
+		}
+		last unless $result->{'query-continue'};
+		$query->{rvstartid} =3D $result->{'query-continue'}->{revisions}->{r=
vstartid};
+	}
+	if ($shallow_import && @page_revs) {
+		print STDERR "  Found 1 revision (shallow import).\n";
+		@page_revs =3D sort {$b->{revid} <=3D> $a->{revid}} (@page_revs);
+		return $page_revs[0];
+	}
+	print STDERR "  Found ", $revnum, " revision(s).\n";
+	return @page_revs;
+}
+
+sub fetch_mw_revisions {
+	my $pages =3D shift; my @pages =3D @{$pages};
+	my $fetch_from =3D shift;
+
+	my @revisions =3D ();
+	my $n =3D 1;
+	foreach my $page (@pages) {
+		my $id =3D $page->{pageid};
+
+		print STDERR "page $n/", scalar(@pages), ": ". $page->{title} ."\n";
+		$n++;
+		my @page_revs =3D fetch_mw_revisions_for_page($page, $id, $fetch_fro=
m);
+		@revisions =3D (@page_revs, @revisions);
+	}
+
+	return ($n, @revisions);
+}
+
+sub import_file_revision {
+	my $commit =3D shift;
+	my %commit =3D %{$commit};
+	my $full_import =3D shift;
+	my $n =3D shift;
+
+	my $title =3D $commit{title};
+	my $comment =3D $commit{comment};
+	my $content =3D $commit{content};
+	my $author =3D $commit{author};
+	my $date =3D $commit{date};
+
+	print STDOUT "commit refs/mediawiki/$remotename/master\n";
+	print STDOUT "mark :$n\n";
+	print STDOUT "committer $author <$author\@$wiki_name> ", $date->epoch=
, " +0000\n";
+	literal_data($comment);
+
+	# If it's not a clone, we need to know where to start from
+	if (!$full_import && $n =3D=3D 1) {
+		print STDOUT "from refs/mediawiki/$remotename/master^0\n";
+	}
+	if ($content ne DELETED_CONTENT) {
+		print STDOUT "M 644 inline $title.mw\n";
+		literal_data($content);
+		print STDOUT "\n\n";
+	} else {
+		print STDOUT "D $title.mw\n";
+	}
+
+	# mediawiki revision number in the git note
+	if ($full_import && $n =3D=3D 1) {
+		print STDOUT "reset refs/notes/$remotename/mediawiki\n";
+	}
+	print STDOUT "commit refs/notes/$remotename/mediawiki\n";
+	print STDOUT "committer $author <$author\@$wiki_name> ", $date->epoch=
, " +0000\n";
+	literal_data("note added by git-mediawiki");
+	if (!$full_import && $n =3D=3D 1) {
+		print STDOUT "from refs/notes/$remotename/mediawiki^0\n";
+	}
+	print STDOUT "N inline :$n\n";
+	literal_data("mediawiki_revision: " . $commit{mw_revision});
+	print STDOUT "\n\n";
+}
+
+sub mw_import {
+	$import_started =3D 1;
+	my $ref =3D shift;
+	# the remote helper will call "import HEAD" and
+	# "import refs/heads/master"
+	# Since HEAD is a symbolic ref to master (by convention,
+	# followed by the output of the command "list" that we gave),
+	# we don't need to do anything in this case.
+	if ($ref eq "HEAD") {
+		return;
+	}
+
+	mw_connect_maybe();
+
+	my @pages =3D get_mw_pages();
+
+	print STDERR "Searching revisions...\n";
+	my $last_local =3D get_last_local_revision();
+	my $fetch_from =3D $last_local + 1;
+	if ($fetch_from =3D=3D 1) {
+		print STDERR ", fetching from beginning.\n";
+	} else {
+		print STDERR ", fetching from here.\n";
+	}
+	my ($n, @revisions) =3D fetch_mw_revisions(\@pages, $fetch_from);
+
+	# Creation of the fast-import stream
+	print STDERR "Fetching & writing export data...\n";
+
+	$n =3D 0;
+	my $last_timestamp =3D 0; # Placeholer in case $rev->timestamp is und=
efined
+
+	foreach my $pagerevid (sort {$a->{revid} <=3D> $b->{revid}} @revision=
s) {
+		# fetch the content of the pages
+		my $query =3D {
+			action =3D> 'query',
+			prop =3D> 'revisions',
+			rvprop =3D> 'content|timestamp|comment|user|ids',
+			revids =3D> $pagerevid->{revid},
+		};
+
+		my $result =3D $mediawiki->api($query);
+
+		my $rev =3D pop(@{$result->{query}->{pages}->{$pagerevid->{pageid}}-=
>{revisions}});
+
+		$n++;
+
+		my %commit;
+		$commit{author} =3D $rev->{user} || 'Anonymous';
+		$commit{comment} =3D $rev->{comment} || '*Empty MediaWiki Message*';
+		$commit{title} =3D mediawiki_smudge_filename(
+			$result->{query}->{pages}->{$pagerevid->{pageid}}->{title}
+		    );
+		$commit{mw_revision} =3D $pagerevid->{revid};
+		$commit{content} =3D mediawiki_smudge($rev->{'*'});
+
+		if (!defined($rev->{timestamp})) {
+			$last_timestamp++;
+		} else {
+			$last_timestamp =3D $rev->{timestamp};
+		}
+		$commit{date} =3D DateTime::Format::ISO8601->parse_datetime($last_ti=
mestamp);
+
+		print STDERR "$n/", scalar(@revisions), ": Revision #$pagerevid->{re=
vid} of $commit{title}\n";
+
+		import_file_revision(\%commit, ($fetch_from =3D=3D 1), $n);
+	}
+
+	if ($fetch_from =3D=3D 1) {
+		if ($n !=3D 0) {
+			print STDOUT "reset $ref\n";
+			print STDOUT "from :$n\n";
+		} else {
+			print STDERR "You appear to have cloned an empty mediawiki\n";
+			# Something has to be done remote-helper side. If nothing is done, =
an error is
+			# thrown saying that HEAD is refering to unknown object 00000000000=
00000000
+		}
+	}
+}
+
+sub error_non_fast_forward {
+	# Native git-push would show this after the summary.
+	# We can't ask it to display it cleanly, so print it
+	# ourselves before.
+	print STDERR "To prevent you from losing history, non-fast-forward up=
dates were rejected\n";
+	print STDERR "Merge the remote changes (e.g. 'git pull') before pushi=
ng again. See the\n";
+	print STDERR "'Note about fast-forwards' section of 'git push --help'=
 for details.\n";
+
+	print STDOUT "error $_[0] \"non-fast-forward\"\n";
+	print STDOUT "\n";
+}
+
+sub mw_push_file {
+	my $diff_info =3D shift;
+	# $diff_info contains a string in this format:
+	# 100644 100644 <sha1_of_blob_before_commit> <sha1_of_blob_now> <stat=
us>
+	my @diff_info_split =3D split(/[ \t]/, $diff_info);
+
+	# Filename, including .mw extension
+	my $complete_file_name =3D shift;
+	# Commit message
+	my $summary =3D shift;
+
+	my $new_sha1 =3D $diff_info_split[3];
+	my $old_sha1 =3D $diff_info_split[2];
+	my $page_created =3D ($old_sha1 eq NULL_SHA1);
+	my $page_deleted =3D ($new_sha1 eq NULL_SHA1);
+	$complete_file_name =3D mediawiki_clean_filename($complete_file_name)=
;
+
+	if (substr($complete_file_name,-3) eq ".mw"){
+		my $title =3D substr($complete_file_name,0,-3);
+
+		my $file_content;
+		if ($page_deleted) {
+			# Deleting a page usually requires
+			# special priviledges. A common
+			# convention is to replace the page
+			# with this content instead:
+			$file_content =3D DELETED_CONTENT;
+		} else {
+			$file_content =3D run_git("cat-file -p $new_sha1");
+		}
+
+		mw_connect_maybe();
+
+		my $result =3D $mediawiki->edit( {
+			action =3D> 'edit',
+			summary =3D> $summary,
+			title =3D> $title,
+			text =3D> mediawiki_clean($file_content, $page_created),
+				  }, {
+					  skip_encoding =3D> 1 # Helps with names with accentuated charac=
ters
+				  }) || die 'Fatal: Error ' .
+				  $mediawiki->{error}->{code} .
+				  ' from mediwiki: ' . $mediawiki->{error}->{details};
+		print STDERR "Pushed file : $new_sha1 - $title\n";
+	} else {
+		print STDERR "$complete_file_name not a mediawiki file (Not pushable=
 on this version).\n"
+	}
+}
+
+sub mw_push {
+	my $last_local_revid =3D get_last_local_revision();
+	print STDERR ".\n"; # Finish sentence started by get_last_local_revis=
ion()
+	my $last_remote_revid =3D get_last_remote_revision();
+
+	# Get sha1 of commit pointed by local HEAD
+	my $HEAD_sha1 =3D run_git("rev-parse $_[0] 2>/dev/null"); chomp($HEAD=
_sha1);
+	# Get sha1 of commit pointed by remotes/$remotename/master
+	my $remoteorigin_sha1 =3D run_git("rev-parse refs/remotes/$remotename=
/master 2>/dev/null");
+	chomp($remoteorigin_sha1);
+
+	if ($last_local_revid > 0 &&
+	    $last_local_revid < $last_remote_revid){
+		return error_non_fast_forward($_[0]);
+	}
+
+	if ($HEAD_sha1 eq $remoteorigin_sha1) {
+		print STDOUT "\n";
+		return;
+	}
+
+	# Get every commit in between HEAD and refs/remotes/origin/master,
+	# including HEAD and refs/remotes/origin/master
+	my @commit_pairs =3D ();
+	if ($last_local_revid > 0) {
+		my $parsed_sha1 =3D $remoteorigin_sha1;
+		# Find a path from last MediaWiki commit to pushed commit
+		while ($parsed_sha1 ne $HEAD_sha1) {
+			my @commit_info =3D  grep(/^$parsed_sha1/, split(/\n/, run_git("rev=
-list --children $_[0]")));
+			if (!@commit_info) {
+				return error_non_fast_forward($_[0]);
+			}
+			my @commit_info_split =3D split(/ |\n/, $commit_info[0]);
+			# $commit_info_split[1] is the sha1 of the commit to export
+			# $commit_info_split[0] is the sha1 of its direct child
+			push (@commit_pairs, \@commit_info_split);
+			$parsed_sha1 =3D $commit_info_split[1];
+		}
+	} else {
+		# No remote mediawiki revision. Export the whole
+		# history (linearized with --first-parent)
+		print STDERR "Warning: no common ancestor, pushing complete history\=
n";
+		my $history =3D run_git("rev-list --first-parent --children $_[0]");
+		my @history =3D split('\n', $history);
+		@history =3D @history[1..$#history];
+		foreach my $line (reverse @history) {
+			my @commit_info_split =3D split(/ |\n/, $line);
+			push (@commit_pairs, \@commit_info_split);
+		}
+	}
+
+	foreach my $commit_info_split (@commit_pairs) {
+		my $sha1_child =3D @{$commit_info_split}[0];
+		my $sha1_commit =3D @{$commit_info_split}[1];
+		my $diff_infos =3D run_git("diff-tree -r --raw -z $sha1_child $sha1_=
commit");
+		# TODO: we could detect rename, and encode them with a #redirect on =
the wiki.
+		# TODO: for now, it's just a delete+add
+		my @diff_info_list =3D split(/\0/, $diff_infos);
+		# Keep the first line of the commit message as mediawiki comment for=
 the revision
+		my $commit_msg =3D (split(/\n/, run_git("show --pretty=3Dformat:\"%s=
\" $sha1_commit")))[0];
+		chomp($commit_msg);
+		# Push every blob
+		while (@diff_info_list) {
+			# git diff-tree -z gives an output like
+			# <metadata>\0<filename1>\0
+			# <metadata>\0<filename2>\0
+			# and we've split on \0.
+			my $info =3D shift(@diff_info_list);
+			my $file =3D shift(@diff_info_list);
+			mw_push_file($info, $file, $commit_msg);
+		}
+	}
+
+	print STDOUT "ok $_[1]\n";
+	print STDOUT "\n";
+
+	print STDERR "Just pushed some revisions to MediaWiki.\n";
+	print STDERR "The pushed revisions now have to be re-imported, and yo=
ur current branch\n";
+	print STDERR "needs to be updated with these re-imported commits. You=
 can do this with\n";
+	print STDERR "\n";
+	print STDERR "  git pull --rebase\n";
+	print STDERR "\n";
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
1.7.6.585.g5929f.dirty
