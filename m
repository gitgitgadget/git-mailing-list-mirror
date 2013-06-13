From: benoit.person@ensimag.fr
Subject: [PATCH/RFC 4/4] git-mw: Adding preview tool in git-mw.perl
Date: Thu, 13 Jun 2013 12:07:19 +0200
Message-ID: <1371118039-18925-5-git-send-email-benoit.person@ensimag.fr>
References: <1371118039-18925-1-git-send-email-benoit.person@ensimag.fr>
Cc: Celestin Matte <celestin.matte@ensimag.fr>,
	Jeff King <peff@peff.net>,
	Matthieu Moy <matthieu.moy@grenoble-inp.fr>,
	Benoit Person <benoit.person@ensimag.fr>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 13 12:08:02 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Un4Rh-0007zb-Bq
	for gcvg-git-2@plane.gmane.org; Thu, 13 Jun 2013 12:07:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758546Ab3FMKHx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Jun 2013 06:07:53 -0400
Received: from mx2.imag.fr ([129.88.30.17]:48816 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758520Ab3FMKHv (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Jun 2013 06:07:51 -0400
Received: from ensimag.imag.fr (ensimag.imag.fr [195.221.228.12])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id r5DA7ji7018204
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 13 Jun 2013 12:07:45 +0200
Received: from ensibm.imag.fr (ensibm.imag.fr [195.221.228.8])
	by ensimag.imag.fr (8.13.8/8.13.8/ImagV2.1.r_ens) with ESMTP id r5DA7kBO011025;
	Thu, 13 Jun 2013 12:07:46 +0200
Received: from localhost.localdomain (ensibm [195.221.228.8])
	by ensibm.imag.fr (8.13.8/8.13.8/ImagV2.1.sb_ens.pm) with ESMTP id r5DA7Wae026514;
	Thu, 13 Jun 2013 12:07:46 +0200
X-Mailer: git-send-email 1.8.3.GIT
In-Reply-To: <1371118039-18925-1-git-send-email-benoit.person@ensimag.fr>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Thu, 13 Jun 2013 12:07:45 +0200 (CEST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227715>

From: Benoit Person <benoit.person@ensimag.fr>

This final commit adds the preview subcommand to git mw. It works as such:
1- Find the remote name of the current branch's upstream and check if it's a
mediawiki one.
1b- If it's not found or if it's not a mediawiki one. It will list all the
mediawiki remotes configured and ask the user to replay the command with the
--remote option set.
2- Parse the content of the local file (or blob) (given as argument) using
the distant mediawiki's API
3- Retrieve the current page on the distant mediawiki
4- Replaces all content in that page with the newly parsed one
5- Convert relative links into absolute
6- Save the result on disk

The command accepts those options:
  --autoload | -a tries to launch the newly generated file in the user's
                  default browser (using git web--browse)
  --remote | -r provides a way to select the distant mediawiki in which
                the user wants to preview his file (or blob)
  --output | -o enables the user to choose the output filename. Default
                output filename is based on the input filename in which
                the extension '.mw' is replaced with '.html'
  --blob | -b tells the script that the last argument is a blob and not
              a filename

Signed-off-by: Benoit Person <benoit.person@ensimag.fr>
Signed-off-by: Matthieu Moy <matthieu.moy@grenoble-inp.fr>

---
 contrib/mw-to-git/git-mw.perl | 203 +++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 202 insertions(+), 1 deletion(-)

diff --git a/contrib/mw-to-git/git-mw.perl b/contrib/mw-to-git/git-mw.perl
index a2f0aa1..79c6cd0 100644
--- a/contrib/mw-to-git/git-mw.perl
+++ b/contrib/mw-to-git/git-mw.perl
@@ -12,10 +12,37 @@ use strict;
 use warnings;
 
 use Getopt::Long;
+use URI::URL qw(url);
+use IO::File;
+use LWP::Simple;
+use HTML::TreeBuilder;
+
+use Git;
+use MediaWiki::API;
+use GitMediawiki qw(smudge_filename connect_maybe);
+
+#preview parameters
+my $file_name;
+my $remote_name = '';
+my $preview_file_name = '';
+my $autoload = 0;
+my $blob = 0;
+sub file {
+	$file_name = shift;
+	return $file_name;
+}
 
 my %commands = (
 	'help' =>
-		[\&help, {}, \&help]
+		[\&help, {}, \&help],
+	'preview' =>
+		[\&preview, {
+			'<>' => \&file,
+			'output|o=s' => \$preview_file_name,
+			'remote|r=s' => \$remote_name,
+			'autoload|a' => \$autoload,
+			'blob|b' => \$blob
+		}, \&preview_help]
 );
 
 # Search for sub-command
@@ -33,6 +60,179 @@ GetOptions( %{$cmd->[1]},
 # Launch command
 &{$cmd->[0]};
 
+############################# Preview Functions ################################
+
+sub preview_help {
+	print <<'END';
+usage: git mw preview [--remote|-r <remote name>] [--autoload|-a]
+                      [--output|-o <output filename>] <filename>
+
+    -r, --remote    Specify which mediawiki should be used
+    -o, --output    Name of the output file
+    -a, --autoload  Autoload the page in your default web browser
+END
+	exit;
+}
+
+sub preview {
+	my $wiki;
+	my ($remote_url, $wiki_page_name);
+	my ($content, $content_tree, $template, $html_tree, $mw_content_text);
+	my $file_content;
+
+	# file_name argumeent is mandatory
+	if (! defined $file_name) {
+		die "File not set, see `git mw help` \n";
+	}
+
+	if ($blob) { # blob mode
+		$blob = $file_name;
+		if ($blob =~ /(.+):(.+)/) {
+			$file_name = $2;
+		}
+	} else { # file mode
+		if (! -e $file_name) {
+			die "File $file_name does not exists \n";
+		}
+	}
+
+	# Default preview_file_name is file_name with .html ext
+	if ($preview_file_name eq '') {
+		$preview_file_name = $file_name;
+		$preview_file_name =~ s/\.[^.]+$/.html/;
+	}
+
+	# Transform file_name into a mediawiki page name
+	$wiki_page_name = smudge_filename($file_name);
+	$wiki_page_name =~ s/\.[^.]+$//;
+
+	if ($remote_name eq '') {
+		# Search current branch upstream branch remote
+		$remote_name = git_cmd_try {
+			my $current_branch = 
+				Git::command_oneline('symbolic-ref', '--short', 'HEAD');
+			Git::config("branch.$current_branch.remote") }
+			"%s failed w/ code %d";
+
+		if ($remote_name) {
+			$remote_url = mediawiki_remote_url_maybe($remote_name);
+		}
+
+		# Search all possibles mediawiki remotes
+		if (! $remote_url) {
+			my @remotes = git_cmd_try {
+				Git::command('remote'); }
+				"%s failed w/ code%d";
+
+			my @valid_remotes = ();
+			foreach my $remote (@remotes) {
+				$remote_url = mediawiki_remote_url_maybe($remote);
+				if ($remote_url) {
+					push(@valid_remotes, $remote);
+				}
+			}
+
+			if ($#valid_remotes == 0) {
+				print "Can not find any mediawiki remote in this repo. \n";
+				exit 1;
+			} else {
+				print "There are multiple mediawiki remotes, which of:\n";
+				foreach my $remote (@remotes) {
+					print "\t$remote\n";
+				}
+				print "do you want ? Use the -r option to specify the remote\n";
+			}
+
+			exit 0;
+		}
+	} else {
+		# Check remote name
+		my @remotes = git_cmd_try {
+			Git::command('remote') }
+			"%s failed w/ code %d";
+		grep { $_ eq $remote_name } @remotes
+			or die "$remote_name is not a remote";
+	
+		# Find remote url
+		$remote_url = mediawiki_remote_url_maybe($remote_name);
+		if (! $remote_url) {
+			die "the remote you selected is not a mediawiki remote";
+		}
+	}
+
+	# Create and connect to the wiki if necessary
+	$wiki = connect_maybe($wiki, $remote_name, $remote_url);
+
+	# Read file content
+	if ($blob) {
+		$file_content = git_cmd_try {
+			Git::command('cat-file', 'blob', $blob); }
+			"%s failed w/ code %d";
+	} else {
+		open my $read_fh, "<", $file_name
+			or die "could not open $file_name: $!";
+		$file_content = do { local $/ = undef; <$read_fh> };
+		close $read_fh;
+	}
+
+	# Load template page
+	$template = get("$remote_url/index.php?title=$wiki_page_name")
+		or die "You need to create $wiki_page_name before previewing it";
+	$html_tree = HTML::TreeBuilder->new;
+	$html_tree->parse($template);
+
+	# Load new content
+	$content = $wiki->api({
+		action => 'parse',
+		text => $file_content,
+		title => $wiki_page_name
+	}) or die 'No response from distant mediawiki';
+	$content = $content->{'parse'}->{'text'}->{'*'};
+	$content_tree = HTML::TreeBuilder->new;
+	$content_tree->parse($content);
+
+	# Replace old content with new one
+	$mw_content_text = $html_tree->look_down('id', 'mw-content-text');
+	$mw_content_text->delete_content();
+	$mw_content_text->push_content($content_tree);
+
+	# Transform relative links into absolute ones
+	for (@{ $html_tree->extract_links() }) {
+		my ($link, $element, $attr) = @$_;
+		my $url = url($link)->canonical;
+		$element->attr($attr, URI->new_abs($url, $remote_url));
+	}
+
+	# Save the preview file
+	my $save_fh = IO::File->new($preview_file_name, 'w')
+		or die "Could not open: $!";
+	$save_fh->print($html_tree->as_HTML);
+
+	# Auto-loading in browser
+	if ($autoload) {
+		system('git', 'web--browse', $preview_file_name);
+	} else {
+		print "preview file saved as: $preview_file_name\n";
+	}
+
+	exit;
+}
+
+sub mediawiki_remote_url_maybe {
+	my $remote = shift;
+
+	# Find remote url
+	my $remote_url = git_cmd_try {
+		Git::config("remote.$remote.url") }
+		"%s failed w/ code %d";
+	if ($remote_url =~ s/mediawiki::(.*)/$1/) {
+		return url($remote_url)->canonical;
+	} else {
+		return undef;
+	}
+
+}
+
 ############################## Help Functions ##################################
 
 sub help {
@@ -41,6 +241,7 @@ usage: git mw <command> <args>
 
 git mw commands are:
     Help        Display help information about git mw
+    Preview 	Parse and render local file into HTML
 END
 	exit;
 }
\ No newline at end of file
-- 
1.8.3.GIT
