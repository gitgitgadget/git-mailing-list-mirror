From: benoit.person@ensimag.fr
Subject: [PATCH/RFC] git-remote-mediawiki: new tool to preview local changes without pushing
Date: Fri,  7 Jun 2013 23:50:31 +0200
Message-ID: <1370641831-9115-1-git-send-email-benoit.person@ensimag.fr>
Cc: celestin.matte@ensimag.fr,
	Benoit Person <benoit.person@ensimag.fr>,
	Matthieu Moy <matthieu.moy@grenoble-inp.fr>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 07 23:51:26 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ul4ZB-0006bB-2H
	for gcvg-git-2@plane.gmane.org; Fri, 07 Jun 2013 23:51:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755962Ab3FGVvV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Jun 2013 17:51:21 -0400
Received: from mx2.imag.fr ([129.88.30.17]:35914 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753181Ab3FGVvT (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Jun 2013 17:51:19 -0400
Received: from ensimag.imag.fr (ensimag.imag.fr [195.221.228.12])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id r57LpCtd004305
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 7 Jun 2013 23:51:12 +0200
Received: from ensibm.imag.fr (ensibm.imag.fr [195.221.228.8])
	by ensimag.imag.fr (8.13.8/8.13.8/ImagV2.1.r_ens) with ESMTP id r57LpFx9029734;
	Fri, 7 Jun 2013 23:51:15 +0200
Received: from localhost.localdomain (ensibm [195.221.228.8])
	by ensibm.imag.fr (8.13.8/8.13.8/ImagV2.1.sb_ens.pm) with ESMTP id r57LpFcH029950;
	Fri, 7 Jun 2013 23:51:15 +0200
X-Mailer: git-send-email 1.8.3.rc3.7.gc2f33ed.dirty
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Fri, 07 Jun 2013 23:51:12 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: r57LpCtd004305
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: benoit.person@ensimag.fr
MailScanner-NULL-Check: 1371246674.65323@uRLG0ONcegmG8sjtBQNarg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226740>

From: Benoit Person <benoit.person@ensimag.fr>

The #7 issue on git-mediawiki's issue tracker [1] states that the ability to
preview content without pushing would be a nice thing to have.

This commit is a first attempt to achieve it. It adds a new git command,
named `git mw`. This command accepts the subcommands `help` and `preview`
for now.

The default behaviour for the `preview` subcommand is:
1- Find the remote name of the current branch's upstream and check if it's a
wiki one with its url (ie: mediawiki://)
2- Parse the content of the local file (given as argument) using the distant
wiki's API.
3- Retrieve the current page on the distant mediawiki.
4- Merge those those contents.
5- Convert relative links to absolute ones.
6- Save the result on disk.

The command also accepts argument for more controls:
  --autoload | -a tries to launch the newly generated file in the user's 
                  default browser
  --remote | -r provides a way to select the distant mediawiki in which the 
                user wants to preview his file.
  --output | -o enables the user to choose the output filename. Default output 
                filename is based on the input filename in which the extension
                `.mw` is replaced with `.html`.

It works but a couple of points trouble me: 
1-  I had to copy two functions from `git-remote-mediawiki.perl`, I don't 
    really know how we could "factorize" those things ? I don't think it makes 
    much sense to create a package just for them ?
2-  The current behavior is to crash if the current branch do not have an
    upstream branch on a valid mediawiki remote. To find that specific remote, 
    it runs `git rev-parse --symbolic-full-name @{upstream}` which will return 
    something like `/refs/remotes/$remote_name/master`.
  2a-  maybe there is a better way to find that remote name ?
  2b-  would it be useful to add a fallback if that search fails ? searching 
       for a valid mediawiki remote url in all the remotes returned by 
       `git remote` for instance ?
3-  The current idea of merging the content of the mediawiki's current page 
    with new content fails when the page is a local creation. (Hence the 
    error message when we get a bad result from the `get` call l.129). I 
    thought about two ways to overcome this:
  3a-  Use the wiki's homepage for the template.
  3b-  A two-step process:
       - first we create a general template (based on the wiki's homepage) 
         with a specific flag at the content position. This step is done only 
         if that template do not exists locally.
       - replace the specific flag with the newly parsed content.
       The downfall of those two "solutions" is on links like 'talk', 
       'view source' etc ... those will need to be updated to. And evven then, 
       it will still fails for page created only locally.
4-  In the Makefile, there is certainly a more "Makefily" way to do it but I 
    had no luck finding it and still preserving the factorization for the 
    `build`, `install` and `clean` target. I ended up with something like this:

    build: $(BUILD_SCRIPTS)
    $(BUILD_SCRIPTS):
        $(MAKE) -C $(GIT_ROOT_DIR) SCRIPT_PERL=$@ \
                build-perl-script

    install: ...
    clean: ...

    but clearly, for only two scripts, it's more a refucktoring than a 
    refactoring :/ .

[1] https://github.com/moy/Git-Mediawiki/issues/7


Signed-off-by: Benoit Person <benoit.person@ensimag.fr>
Signed-off-by: Matthieu Moy <matthieu.moy@grenoble-inp.fr>

---
 contrib/mw-to-git/Makefile    |   4 +
 contrib/mw-to-git/git-mw.perl | 249 ++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 253 insertions(+)
 create mode 100644 contrib/mw-to-git/git-mw.perl

diff --git a/contrib/mw-to-git/Makefile b/contrib/mw-to-git/Makefile
index f149719..0cba1e3 100644
--- a/contrib/mw-to-git/Makefile
+++ b/contrib/mw-to-git/Makefile
@@ -5,13 +5,17 @@
 ## Build git-remote-mediawiki
 
 SCRIPT_PERL=git-remote-mediawiki.perl
+SCRIPT_PERL_MW=git-mw.perl
 GIT_ROOT_DIR=../..
 HERE=contrib/mw-to-git/
 
 SCRIPT_PERL_FULL=$(patsubst %,$(HERE)/%,$(SCRIPT_PERL))
+SCRIPT_PERL_MW_FULL=$(patsubst %,$(HERE)/%,$(SCRIPT_PERL_MW))
 
 all: build
 
 build install clean:
 	$(MAKE) -C $(GIT_ROOT_DIR) SCRIPT_PERL=$(SCRIPT_PERL_FULL) \
                 $@-perl-script
+	$(MAKE) -C $(GIT_ROOT_DIR) SCRIPT_PERL=$(SCRIPT_PERL_MW_FULL) \
+                $@-perl-script
\ No newline at end of file
diff --git a/contrib/mw-to-git/git-mw.perl b/contrib/mw-to-git/git-mw.perl
new file mode 100644
index 0000000..a92c459
--- /dev/null
+++ b/contrib/mw-to-git/git-mw.perl
@@ -0,0 +1,249 @@
+#! /usr/bin/perl
+
+# Copyright (C) 2013
+#     Benoit Person <benoit.person@ensimag.imag.fr>
+#     Celestin Matte <celestin.matte@ensimag.imag.fr>
+# License: GPL v2 or later
+
+# Tools attached to git-remote-mediawiki (help, preview ...)
+# Documentation & bugtracker: https://github.com/moy/Git-Mediawiki/
+
+use strict;
+use warnings;
+
+use Git;
+use MediaWiki::API;
+
+use Getopt::Long;
+use HTML::TreeBuilder;
+use URI::URL qw(url);
+use IO::File;
+use LWP::Simple;
+use Carp;
+use Readonly;
+
+# Constants
+# Mediawiki filenames can contain forward slashes. This variable decides by which pattern they should be replaced
+Readonly::scalar $SLASH_REPLACEMENT => "%2F";
+
+# Vars
+my $file_name;
+my $wiki;
+my $remote_url;
+
+my $remote_name = '';
+my $preview_file_name = '';
+my $autoload = 0;
+
+my %commands = (
+	'help' =>
+		[\&help, {}, \&help_help],
+	'preview' =>
+		[\&preview, {
+			'<>' => \&file,
+			'output|o=s' => \$preview_file_name,
+			'remote|r=s' => \$remote_name,
+			'autoload|a' => \$autoload
+		}, \&preview_help]
+);
+
+sub file {
+	$file_name = shift;
+	return $file_name;
+}
+
+# Search for sub-command
+my $cmd = $commands{'help'};
+for (my $i = 0; $i < @ARGV; $i++) {
+	if (defined $commands{$ARGV[$i]}) {
+		$cmd = $commands{$ARGV[$i]};
+		splice @ARGV, $i, 1;
+		last;
+	}
+};
+GetOptions( %{$cmd->[1]},
+	'help|h' => \&{$cmd->[2]});
+
+# Launch command
+&{$cmd->[0]};
+
+######################## Sub-Commands #############################
+sub preview {
+	my $wiki_page_name;
+	my ($content, $content_tree, $template, $html_tree, $mw_content_text);
+
+	# file_name argumeent is mandatory
+	if (! defined $file_name) {
+		croak "File not set, see `git mw help` \n";
+	}
+
+	if (! -e $file_name) {
+		croak "File $file_name does not exist \n";
+	}
+
+	# Default preview_file_name is file_name with .html ext
+	if ($preview_file_name eq '') {
+		$preview_file_name = $file_name;
+		$preview_file_name =~ s/\.[^.]+$/.html/;
+	}
+
+	# Transform file_name into a mediawiki page name
+	$wiki_page_name = mediawiki_smudge_filename($file_name);
+	$wiki_page_name =~ s/\.[^.]+$//;
+
+	# Find or verify remote name
+	if ($remote_name eq '') {
+		$remote_name = git_cmd_try {
+			Git::command_oneline('rev-parse', '--symbolic-full-name', '@{upstream}') }
+			"%s failed w/ code %d";
+		$remote_name =~ s/refs\/remotes\/(.+)\/(.+)/$1/
+			or croak "Could not find remote name";
+	} else {
+		my @remotes = git_cmd_try {
+			Git::command('remote') }
+			"%s failed w/ code %d";
+		grep { $_ eq $remote_name } @remotes
+			or croak "$remote_name is not a remote";
+	}
+
+	# Find remote url
+	$remote_url = git_cmd_try {
+		Git::config("remote.$remote_name.url") }
+		"%s failed w/ code %d";
+	$remote_url =~ s/mediawiki::(.*)/$1/
+		or croak "Current remote is not a mediawiki";
+	$remote_url = url($remote_url)->canonical;
+
+	# Create and connect to the wiki if necessary
+	$wiki = MediaWiki::API->new;
+	$wiki->{config}->{api_url} = "$remote_url/api.php";
+	mw_connect_maybe();
+
+	# Read file content
+	open my $fh, "<", $file_name
+		or croak "could not open $file_name: $!";
+	my $document = do { local $/ = undef; <$fh> };
+	close $fh;
+
+	# Load template page
+	$template = get("$remote_url/index.php?title=$wiki_page_name")
+		or croak "You need to create $wiki_page_name before previewing it";
+	$html_tree = HTML::TreeBuilder->new;
+	$html_tree->parse($template);
+
+	# Load new content
+	$content = $wiki->api({
+		action => 'parse',
+		text => $document,
+		title => $wiki_page_name
+	}) or croak 'No response from distant mediawiki';
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
+	$fh = IO::File->new($preview_file_name, O_WRONLY|O_CREAT)
+		or croak "Could not open: $!";
+	$fh->print($html_tree->as_HTML);
+
+	# Auto-loading in browser
+	if ($autoload) {
+		open(my $browser, "-|:encoding(UTF-8)", "xdg-open ".$preview_file_name);
+		my $res = do { local $/ = undef; <$browser> };
+		close($browser);
+	} else {
+		print "preview file saved as: $preview_file_name\n";
+	}
+
+	exit;
+}
+
+######################## Help Functions ###########################
+
+sub help {
+	print <<'END';
+usage: git mw <command> <args>
+
+git mw commands are:
+    Help        Display help information about git mw
+    preview     Render a local file into an HTML file
+END
+	exit;
+}
+
+sub help_help {
+	print <<'END';
+usage: git mw help
+END
+	exit;
+}
+
+sub preview_help {
+	print <<'END';
+usage: git mw preview [--remote|-r <remote name>] [--autoload|-a]
+                      [--output|-o <output filename>] <filename>
+
+    -r, --remote    Specify which mediawiki should be used
+    -o, --output    Name of the output file
+    -a, --autoload  Try to autoload the page in the default browser
+END
+	exit;
+}
+
+########################## Functions ##############################
+
+sub mediawiki_smudge_filename {
+	my $filename = shift;
+	$filename =~ s/\//@{[$SLASH_REPLACEMENT]}/gx;
+	$filename =~ s/ /_/g;
+	# Decode forbidden characters encoded in mediawiki_clean_filename
+	$filename =~ s/_%_([0-9a-fA-F][0-9a-fA-F])/sprintf("%c", hex($1))/gex;
+	return $filename;
+}
+
+sub mw_connect_maybe {
+	my ($wiki_login, $wiki_password, $wiki_domain);
+
+	git_cmd_try {
+		$wiki_login = Git::config("remote.$remote_name.mwLogin");
+		$wiki_password = Git::config("remote.$remote_name.mwPassword");
+		$wiki_domain = Git::config("remote.$remote_name.mwDomain");}
+		"%s failed w/ code %d";
+
+	if ($wiki_login) {
+		my %credential = (
+			'url' => $remote_url,
+			'username' => $wiki_login,
+			'password' => $wiki_password);
+		Git::credential(\%credential);
+		my $request = {
+			lgname => $credential{username},
+			lgpassword => $credential{password},
+			lgdomain => $wiki_domain};
+		if ($wiki->login($request)) {
+			Git::credential(\%credential, 'approve');
+			print STDERR "Logged in mediawiki user \"$credential{username}\".\n";
+		} else {
+			print STDERR "Failed to log in mediawiki user \"$credential{username}\" on $remote_url\n";
+			print STDERR "  (error " .
+				$wiki->{error}->{code} . ': ' .
+				$wiki->{error}->{details} . ")\n";
+			Git::credential(\%credential, 'reject');
+			exit 1;
+		}
+	}
+
+	return;
+}
\ No newline at end of file
-- 
1.8.3.rc3.7.gc2f33ed.dirty
