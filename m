From: benoit.person@ensimag.fr
Subject: [PATCH V3 4/4] git-mw: Add preview subcommand into git mw.
Date: Sun, 16 Jun 2013 04:31:33 +0200
Message-ID: <1371349893-7789-5-git-send-email-benoit.person@ensimag.fr>
References: <1371349893-7789-1-git-send-email-benoit.person@ensimag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Celestin Matte <celestin.matte@ensimag.fr>,
	Matthieu Moy <matthieu.moy@grenoble-inp.fr>,
	Benoit Person <benoit.person@ensimag.fr>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 16 04:32:41 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uo2ll-0007eC-8n
	for gcvg-git-2@plane.gmane.org; Sun, 16 Jun 2013 04:32:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754891Ab3FPCc1 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 15 Jun 2013 22:32:27 -0400
Received: from mx2.imag.fr ([129.88.30.17]:54766 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754850Ab3FPCcU (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 Jun 2013 22:32:20 -0400
Received: from ensimag.imag.fr (ensimag.imag.fr [195.221.228.12])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id r5G2WIxq009903
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sun, 16 Jun 2013 04:32:18 +0200
Received: from ensibm.imag.fr (ensibm.imag.fr [195.221.228.8])
	by ensimag.imag.fr (8.13.8/8.13.8/ImagV2.1.r_ens) with ESMTP id r5G2WI9k013562;
	Sun, 16 Jun 2013 04:32:18 +0200
Received: from localhost.localdomain (ensibm [195.221.228.8])
	by ensibm.imag.fr (8.13.8/8.13.8/ImagV2.1.sb_ens.pm) with ESMTP id r5G2W1eM020162;
	Sun, 16 Jun 2013 04:32:18 +0200
X-Mailer: git-send-email 1.8.3.GIT
In-Reply-To: <1371349893-7789-1-git-send-email-benoit.person@ensimag.fr>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Sun, 16 Jun 2013 04:32:18 +0200 (CEST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227986>

=46rom: Benoit Person <benoit.person@ensimag.fr>

Add the subcommand to 'git-mw.perl'.
Add a new constant in GitMediawiki.pm 'HTTP_CODE_PAGE_NOT_FOUND'.

Signed-off-by: Benoit Person <benoit.person@ensimag.fr>
Signed-off-by: Matthieu Moy <matthieu.moy@grenoble-inp.fr>

---

changes from V2:
  - Remove the --blob option, distinction between files and blobs is no=
w=20
    automatic.
  - Add a --verbose option to output more information on what's going o=
n.
  - Rewrote the doc and the commit message.
  - Rewrote of the template retrieving code (see 'get_template' sub).
  - Use a configuration variable to define the content ID search in the
    template. Default value set as 'bodyContent' since it seems more st=
andard
    than 'mw-content-text'.
  - Final content is now saved as utf-8 to solve encoding issues.
  - Perlcritic changes:
    - All 'print's specify their output streams.
    --> Same useless warnings left in git-remote-mediawiki.perl after c=
=C3=A9lestin's=20
        work and git-mw.perl after this patch :) .

 contrib/mw-to-git/GitMediawiki.pm |   3 +-
 contrib/mw-to-git/git-mw.perl     | 303 ++++++++++++++++++++++++++++++=
+++++++-
 2 files changed, 304 insertions(+), 2 deletions(-)

diff --git a/contrib/mw-to-git/GitMediawiki.pm b/contrib/mw-to-git/GitM=
ediawiki.pm
index beae6d0..d1f2c41 100644
--- a/contrib/mw-to-git/GitMediawiki.pm
+++ b/contrib/mw-to-git/GitMediawiki.pm
@@ -19,7 +19,7 @@ require Exporter;
=20
 # Methods which can be called as standalone functions as well:
 @EXPORT_OK =3D qw(clean_filename smudge_filename connect_maybe
-				EMPTY HTTP_CODE_OK);
+				EMPTY HTTP_CODE_OK HTTP_CODE_PAGE_NOT_FOUND);
 }
=20
 # Mediawiki filenames can contain forward slashes. This variable decid=
es by which pattern they should be replaced
@@ -30,6 +30,7 @@ use constant EMPTY =3D> q{};
=20
 # HTTP codes
 use constant HTTP_CODE_OK =3D> 200;
+use constant HTTP_CODE_PAGE_NOT_FOUND =3D> 404;
=20
 sub clean_filename {
 	my $filename =3D shift;
diff --git a/contrib/mw-to-git/git-mw.perl b/contrib/mw-to-git/git-mw.p=
erl
index 320c00e..0b83108 100644
--- a/contrib/mw-to-git/git-mw.perl
+++ b/contrib/mw-to-git/git-mw.perl
@@ -12,10 +12,41 @@ use strict;
 use warnings;
=20
 use Getopt::Long;
+use URI::URL qw(url);
+use LWP::UserAgent;
+use HTML::TreeBuilder;
+
+use Git;
+use MediaWiki::API;
+use GitMediawiki qw(smudge_filename connect_maybe
+					EMPTY HTTP_CODE_PAGE_NOT_FOUND);
+
+# By default, use UTF-8 to communicate with Git and the user
+binmode STDERR, ':encoding(UTF-8)';
+binmode STDOUT, ':encoding(UTF-8)';
+
+#preview parameters
+my $file_name =3D EMPTY;
+my $remote_name =3D EMPTY;
+my $preview_file_name =3D EMPTY;
+my $autoload =3D 0;
+my $verbose =3D 0;
+sub file {
+	$file_name =3D shift;
+	return $file_name;
+}
=20
 my %commands =3D (
 	'help' =3D>
-		[\&help, {}, \&help]
+		[\&help, {}, \&help],
+	'preview' =3D>
+		[\&preview, {
+			'<>' =3D> \&file,
+			'output|o=3Ds' =3D> \$preview_file_name,
+			'remote|r=3Ds' =3D> \$remote_name,
+			'autoload|a' =3D> \$autoload,
+			'verbose|v'  =3D> \$verbose
+		}, \&preview_help]
 );
=20
 # Search for sub-command
@@ -33,6 +64,275 @@ GetOptions( %{$cmd->[1]},
 # Launch command
 &{$cmd->[0]};
=20
+############################# Preview Functions ######################=
##########
+
+# @TODO : add documentation for verbose option
+sub preview_help {
+	print {*STDOUT} <<'END';
+USAGE: git mw preview [--remote|-r <remote name>] [--autoload|-a]
+                      [--output|-o <output filename>] [--verbose|-v]
+                      <blob> | <filename>
+
+DESCRIPTION:
+Preview is an utiliy to preview local content of a mediawiki repo as i=
f it was
+pushed on the remote.
+
+For that, preview searches for the remote name of the current branch's=
 upstream
+if --remote is not set. If that remote is not found or if it is not a =
mediawiki,
+it lists all mediawiki remotes configured and asks you to replay your =
command
+with the --remote option set properly.
+
+Then, it searches for a file named 'filename'. If it's not found in th=
e current
+dir, it will assume it's a blob.
+
+The content retrieved in the file (or in the blob) will then be parsed=
 by the
+distant mediawiki and combined with a template retrieved from the medi=
awiki.
+
+Finally, preview will save the HTML result in a file. and autoload it =
in your
+default web browser if the option --autoload is present.
+
+OPTIONS:
+	-r <remote name>, --remote <remote name>
+		If the remote is a mediawiki, the template and the parse engine used=
 for
+		the preview will be those of that remote.
+		If not, a list of valid remotes will be shown.
+
+	-a, --autoload
+		Try to load the HTML output in a new tab (or new window) of your def=
ault
+		web browser.
+
+	-o <output filename>, --output <output filename>
+		Change the HTML output filename. Default filename is based on the in=
put
+		filename with its extension replaced by '.html'.
+
+	-v, --verbose
+		Show more information on what's going on under the hood.
+END
+	exit;
+}
+
+sub preview {
+	my $wiki;
+	my ($remote_url, $wiki_page_name);
+	my ($content, $content_tree, $template, $html_tree, $mw_content_text)=
;
+	my $file_content;
+	my $template_content_id =3D 'bodyContent';
+
+	# file_name argumeent is mandatory
+	if (!defined $file_name) {
+		die "File not set, see `git mw help` \n";
+	}
+
+	v_print("### SELECTING REMOTE ###\n");
+
+	if ($remote_name eq EMPTY) {
+		# Search current branch upstream branch remote
+		my $current_branch =3D git_cmd_try {
+			Git::command_oneline('symbolic-ref', '--short', 'HEAD') }
+			"%s failed w/ code %d";
+		$remote_name =3D Git::config("branch.${current_branch}.remote");
+
+		if ($remote_name) {
+			$remote_url =3D mediawiki_remote_url_maybe($remote_name);
+		}
+
+		# Search all possibles mediawiki remotes
+		if (! $remote_url) {
+			my @remotes =3D git_cmd_try {
+				Git::command('remote'); }
+				"%s failed w/ code %d";
+
+			my @valid_remotes =3D ();
+			foreach my $remote (@remotes) {
+				$remote_url =3D mediawiki_remote_url_maybe($remote);
+				if ($remote_url) {
+					push(@valid_remotes, $remote);
+				}
+			}
+
+			if ($#valid_remotes =3D=3D 0) {
+				print {*STDERR} "Can not find any mediawiki remote in this repo. \=
n";
+				exit 1;
+			} else {
+				print {*STDERR} "There are multiple mediawiki remotes, which of:\n=
";
+				foreach my $remote (@remotes) {
+					print {*STDERR} "\t${remote}\n";
+				}
+				print {*STDERR} "do you want ? Use the -r option to specify the re=
mote\n";
+			}
+
+			exit 0;
+		}
+	} else {
+		# Check remote name
+		my @remotes =3D git_cmd_try {
+			Git::command('remote') }
+			"%s failed w/ code %d";
+		my $found_remote =3D 0;
+		foreach my $remote (@remotes) {
+			if ($remote eq $remote_name) {
+				$found_remote =3D 1;
+				last;
+			}
+		}
+		if (!$found_remote) {
+			die "${remote_name} is not a remote\n";
+		}
+
+		# Find remote url
+		$remote_url =3D mediawiki_remote_url_maybe($remote_name);
+		if (! $remote_url) {
+			die "the remote you selected is not a mediawiki remote\n";
+		}
+	}
+	v_print("selected remote:\n\tname: ${remote_name}\n\turl: ${remote_ur=
l}\n");
+
+	# Create and connect to the wiki if necessary
+	$wiki =3D connect_maybe($wiki, $remote_name, $remote_url);
+
+	# Read file content
+	if (! -e $file_name) {
+		$file_content =3D git_cmd_try {
+			Git::command('cat-file', 'blob', $file_name); }
+			"%s failed w/ code %d";
+
+		if ($file_name =3D~ /(.+):(.+)/) {
+			$file_name =3D $2;
+		}
+	} else {
+		open my $read_fh, "<", $file_name
+			or die "could not open ${file_name}: $!\n";
+		$file_content =3D do { local $/ =3D undef; <$read_fh> };
+		close $read_fh
+			or die "unable to close: $!\n";
+	}
+
+	# Transform file_name into a mediawiki page name
+	$wiki_page_name =3D smudge_filename($file_name);
+	$wiki_page_name =3D~ s/\.[^.]+$//;
+
+	# Default preview_file_name is file_name with .html ext
+	if ($preview_file_name eq EMPTY) {
+		$preview_file_name =3D $file_name;
+		$preview_file_name =3D~ s/\.[^.]+$/.html/;
+	}
+
+	v_print("### Retrieving template\n");
+	$template =3D get_template($remote_url, $wiki_page_name);
+
+	v_print("### Parsing & merging contents\n");
+	# Parsing template page
+	$html_tree =3D HTML::TreeBuilder->new;
+	$html_tree->parse($template);
+
+	# Load new content
+	$content =3D $wiki->api({
+		action =3D> 'parse',
+		text =3D> $file_content,
+		title =3D> $wiki_page_name
+	}, {
+		skip_encoding =3D> 1
+	}) or die "No response from distant mediawiki\n";
+	$content =3D $content->{'parse'}->{'text'}->{'*'};
+	$content_tree =3D HTML::TreeBuilder->new;
+	$content_tree->parse($content);
+
+	# Replace old content with new one
+	$template_content_id =3D Git::config('mediawiki.IDContent')
+		|| $template_content_id;
+	v_print("Using '${template_content_id}' as the content ID\n");
+	$mw_content_text =3D $html_tree->look_down('id', $template_content_id=
);
+	if (!defined $mw_content_text) {
+		print {*STDERR} <<"CONFIG";
+Could not combine the new parsed content with the template. You might =
want to
+configure `mediawiki.IDContent` in your config:
+	git config --add mediawiki.IDContent <your_template_content_element_i=
d>
+CONFIG
+	}
+	$mw_content_text->delete_content();
+	$mw_content_text->push_content($content_tree);
+
+	# Transform relative links into absolute ones
+	for (@{ $html_tree->extract_links() }) {
+		my ($link, $element, $attr) =3D @{ $_ };
+		my $url =3D url($link)->canonical;
+		$element->attr($attr, URI->new_abs($url, $remote_url));
+	}
+
+	# Save the preview file
+	open(my $save_fh, '>:encoding(UTF-8)', $preview_file_name)
+		or die "Could not open: $!\n";
+	print {$save_fh} $html_tree->as_HTML;
+	close($save_fh)
+		or die "Could not close: $!\n";
+
+	# Auto-loading in browser
+	v_print("### Results\n");
+	if ($autoload) {
+		v_print("Launching browser w/ file: ${preview_file_name}");
+		system('git', 'web--browse', $preview_file_name);
+	} else {
+		print {*STDERR} "Preview file saved as: ${preview_file_name}\n";
+	}
+
+	exit;
+}
+
+sub mediawiki_remote_url_maybe {
+	my $remote =3D shift;
+
+	# Find remote url
+	my $remote_url =3D Git::config("remote.${remote}.url");
+	if ($remote_url =3D~ s/mediawiki::(.*)/$1/) {
+		return url($remote_url)->canonical;
+	}
+
+	return;
+}
+
+sub get_template {
+	my $url =3D shift;
+	my $page_name =3D shift;
+	my ($req, $res, $code, $url_after);
+
+	$req =3D LWP::UserAgent->new;
+	if ($verbose) {
+		$req->show_progress(1);
+	}
+
+	$res =3D $req->get("${url}/index.php?title=3D${page_name}");
+	if (!$res->is_success) {
+		$code =3D $res->code;
+		$url_after =3D $res->request()->uri(); # resolve all redirections
+		if ($code =3D=3D HTTP_CODE_PAGE_NOT_FOUND) {
+			if ($verbose) {
+				print {*STDERR} <<"WARNING";
+Warning: Failed to retrieve '$page_name'. Create it on the mediawiki i=
f you want
+all the links to work properly.
+Trying to use the mediawiki homepage as a fallback template ...
+WARNING
+			}
+
+			# LWP automatically redirects GET request
+			$res =3D $req->get("${url}/index.php");
+			if (!$res->is_success) {
+				$url_after =3D $res->request()->uri(); # resolve all redirections
+				die "Failed to get homepage @ ${url_after} w/ code ${code}\n";
+			}
+		} else {
+			die "Failed to get '${page_name}' @ ${url_after} w/ code ${code}\n"=
;
+		}
+	}
+
+	return $res->decoded_content;
+}
+
+sub v_print {
+	if ($verbose) {
+		print {*STDERR} @_;
+	}
+}
+
 ############################## Help Functions ########################=
##########
=20
 sub help {
@@ -41,6 +341,7 @@ usage: git mw <command> <args>
=20
 git mw commands are:
     help        Display help information about git mw
+    preview 	Parse and render local file into HTML
 END
 	exit;
 }
\ No newline at end of file
--=20
1.8.3.GIT
