From: Jakub Narebski <jnareb@gmail.com>
Subject: [RFC/PATCH] gitweb: Extend project_index file format by project description
Date: Sat, 21 Jun 2008 15:40:57 +0200
Message-ID: <200806211540.58929.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Cc: Lea Wiemann <lewiemann@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jun 21 15:42:10 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KA3M0-0002KC-8b
	for gcvg-git-2@gmane.org; Sat, 21 Jun 2008 15:42:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751084AbYFUNlM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 21 Jun 2008 09:41:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751001AbYFUNlL
	(ORCPT <rfc822;git-outgoing>); Sat, 21 Jun 2008 09:41:11 -0400
Received: from ug-out-1314.google.com ([66.249.92.173]:54165 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750773AbYFUNlJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Jun 2008 09:41:09 -0400
Received: by ug-out-1314.google.com with SMTP id h2so167891ugf.16
        for <git@vger.kernel.org>; Sat, 21 Jun 2008 06:41:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        bh=YPL1lmN1y3snFfl5yJLQNZb2x91Wd/freXx6bVtf4CU=;
        b=rLxUH7w5U1+GEbnJ6wU4yhj4g2NWsuIavh3pLF+0Pk4sOv2Q4daq5TdiVdAMs82JlX
         YjYm343JrlIrejwd363AmEbxYaFX63TzixDJmUGRiIXZIeeMEODLp/2ZLVp1QLRrdyqf
         GXuQe4uZSmfs9uns9QvGPhx4dTD1x6nc/asbE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        b=F6lJOHsFZsLmy/OFLEnN63/AOsNTcBKvbpJLr4XS5giHyIRk9mrho4jYrpDdQDZqJW
         UONG6htqqdS+wLyCj8SjU0/qA0cbQN85XCPSxDoqICT4gzpvN++tzWEst4WYz+y4Qzel
         Hj92vA0aF+jObJgpj777TCWLhPy131AdXuxQQ=
Received: by 10.210.105.20 with SMTP id d20mr4108497ebc.146.1214055667640;
        Sat, 21 Jun 2008 06:41:07 -0700 (PDT)
Received: from ?192.168.1.11? ( [83.8.245.230])
        by mx.google.com with ESMTPS id y34sm4702788iky.10.2008.06.21.06.41.03
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 21 Jun 2008 06:41:05 -0700 (PDT)
User-Agent: KMail/1.9.3
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85708>

Change format of $projects_list file from
  <URI-encoded path> SPC <URI-encoded owner> LF
to
  <URI-encoded path> SPC \
  <URI-encoded owner> [SPC <URI-encoded description>] LF
with optional project description.  Please remember that only single
line of repository (project) description is supported.  Note that SPC
can be replaced by any whitespace character.

This change required modifying git_get_projects_list() subroutine
(part when $projects_list is a file, and not a directory to be
scanned), and git_get_project_description() subroutine.

The 'project_index' action now creates projects list index file in the
new format, with project description.  Also, it now does only minimal
level of escaping / encoding.


While at it, add some comments describing changes and changed
subroutines.  Update and extend information about $projects_list
format in gitweb/README and in gitweb/INSTALL.

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
This is an RFC mainly because I don't know if it wouldn't conflict
with Lea Wiemann work on adding caching support to gitweb; if it would,
I'll send separately the parts that enhance documentation (modified
of course to not include new feature).

The goal is to first, improve performance; and second, to be possible
to have single place for all info (well, amost all info) needed to
generate projects list.

I plan to submit to contrib small Perl script which would generate
projects list given (as argument) $projectroot, with minimal
dependencies, and minimal footprint.  The question is how to name
it...

 gitweb/INSTALL     |   10 +++++--
 gitweb/README      |   50 +++++++++++++++++++++++++++++++----
 gitweb/gitweb.perl |   74 ++++++++++++++++++++++++++++++++++++++++++---------
 3 files changed, 112 insertions(+), 22 deletions(-)

diff --git a/gitweb/INSTALL b/gitweb/INSTALL
index f7194db..7e25a7f 100644
--- a/gitweb/INSTALL
+++ b/gitweb/INSTALL
@@ -140,9 +140,13 @@ Gitweb repositories
 
   Each line of the projects list file should consist of the url-encoded path
   to the project repository database (relative to projectroot), followed
-  by the url-encoded project owner on the same line (separated by a space).
-  Spaces in both project path and project owner have to be encoded as either
-  '%20' or '+'.
+  by the url-encoded project owner on the same line (separated by a space),
+  and optionally followed by the url-encoded project description (separated
+  by space).  Spaces in project path, project owner and project description
+  have to be encoded as either '%20' or '+'.  Other whitespace (separator),
+  plus sign '+' (used as replacement for spaces), and percent sign '%' (used
+  for encoding / escaping) have to be url-encoded, i.e. replaced by '%'
+  followed by two-digit character number in octal.
 
   You can generate the projects list index file using the project_index
   action (the 'TXT' link on projects list page) directly from gitweb.
diff --git a/gitweb/README b/gitweb/README
index 356ab7b..a32a177 100644
--- a/gitweb/README
+++ b/gitweb/README
@@ -157,9 +157,12 @@ not include variables usually directly set during build):
  * $projects_list
    Source of projects list, either directory to scan, or text file
    with list of repositories (in the "<URI-encoded repository path> SPC
-   <URI-encoded repository owner>" format).  Set to $GITWEB_LIST
-   during installation.  If empty, $projectroot is used to scan for
-   repositories.
+   <URI-encoded repository owner>" line format, or optionally with
+   project description in "<URI-encoded repository path> SPC
+   <URI-encoded repository owner> SPC <URI-encoded description>";
+   actually there can be any sequence of whitespace in place of SPC).
+   Set to $GITWEB_LIST during installation.  If empty, $projectroot is
+   used to scan for repositories.
  * $my_url, $my_uri
    URL and absolute URL of gitweb script; you might need to set those
    variables if you are using 'pathinfo' feature: see also below.
@@ -214,6 +217,40 @@ not include variables usually directly set during build):
    ('-M'); set it to ('-C') or ('-C', '-C') to also detect copies, or
    set it to () if you don't want to have renames detection.
 
+
+Projects list file format
+~~~~~~~~~~~~~~~~~~~~~~~~~
+
+Instead of having gitweb find repositories by scanning filesystem starting
+from $projectroot (or $projects_list, if it points to directory), you can
+provide list of projects by setting $projects_list to a text file with list
+of projects (and some additional info).  This file uses the following
+format:
+
+One record (for project / repository) per line, whitespace separated fields;
+does not support (at least for now) lines continuation (newline escaping).
+Leading and trailing whitespace are ignored, any run of whitespace can be
+used as field separator (rules for Perl's "split(' ', $line)".  Keyed by
+the first field, which is project name, i.e. path to repository GIT_DIR
+relative to $projectroot.  Fields use modified URI encoding, defined in
+RFC 3986, section 2.1 (Percent-Encoding), or rather "Query string encoding"
+(see http://en.wikipedia.org/wiki/Query_string#URL_encoding), the difference
+being that SPC (' ') can be encoded as '+' (and therefore '+' has to be also
+percent-encoded).  Reserved characters are: '%' (used for encoding), '+'
+(can be used to encode SPACE), all whitespace characters as defined in Perl,
+including SPC, TAB and LF, (used to separate fields in a record).
+
+Currently list of fields is
+ * <repository path>  - path to repository GIT_DIR, relative to $projectroot
+ * <repository owner> - displayed as repository owner, preferably full name,
+                        or email, or both
+ * [<description>]    - one line repository description, OPTIONAL
+
+You can additionally use $projects_list file together with to limit which
+repositories are visible, and together with $strict_export to limit access
+to repositories (see "Gitweb repositories" section in gitweb/INSTALL).
+
+
 Per-repository gitweb configuration
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
@@ -225,8 +262,8 @@ You can use the following files in repository:
  * README.html
    A .html file (HTML fragment) which is included on the gitweb project
    summary page inside <div> block element. You can use it for longer
-   description of a project, to provide links for example to projects
-   homepage, etc.
+   description of a project, to provide links (for example to project's
+   homepage), etc.
  * description (or gitweb.description)
    Short (shortened by default to 25 characters in the projects list page)
    single line description of a project (of a repository). Plain text file;
@@ -243,7 +280,8 @@ You can use the following files in repository:
  * gitweb.owner
    You can use the gitweb.owner repository configuration variable to set
    repository's owner. It is displayed in the project list and summary
-   page. If it's not set, filesystem directory's owner is used.
+   page. If it's not set, filesystem directory's owner is used
+   (via GECOS field / real name field from getpwiud(3)).
  * various gitweb.* config variables (in config)
    Read description of %feature hash for detailed list, and some
    descriptions.
diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 9c0dfbd..58144e7 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -1710,13 +1710,44 @@ sub git_get_path_by_hash {
 ## ......................................................................
 ## git utility functions, directly accessing git repository
 
+# this is helper function for git_get_project_description()
+sub git_get_project_description_from_list {
+	my $path = shift;
+
+	open(my $fd, $projects_list)
+		or return;
+	while (my $line = <$fd>) {
+		chomp $line;
+		my ($proj, undef, $descr) = split ' ', $line;
+		$proj = unescape($proj);
+		$descr = unescape($descr);
+		if ($proj eq $path) {
+			close $fd;
+			return $descr;
+		}
+	}
+	close $fd;
+	return;
+}
+
+# sources for project description are
+#  * project_list, if $project_list is a file, and it uses new format:
+#    <encoded path> SPC <encoded owner> SPC <encoded description> LF
+#  * $GIT_DIR/description file in project repository, if it exists
+#  * gitweb.description configuration variable for a project
 sub git_get_project_description {
 	my $path = shift;
+	my $descr;
+
+	if (-f $projects_list) {
+		$descr = git_get_project_description_from_list($path);
+		return $descr if (defined $descr); # try other sources if needed
+	}
 
 	$git_dir = "$projectroot/$path";
 	open my $fd, "$git_dir/description"
 		or return git_get_project_config('description');
-	my $descr = <$fd>;
+	$descr = <$fd>;
 	close $fd;
 	if (defined $descr) {
 		chomp $descr;
@@ -1782,20 +1813,25 @@ sub git_get_projects_list {
 		}, "$dir");
 
 	} elsif (-f $projects_list) {
-		# read from file(url-encoded):
+		# read from file (whitespace separated, url-encoded):
 		# 'git%2Fgit.git Linus+Torvalds'
 		# 'libs%2Fklibc%2Fklibc.git H.+Peter+Anvin'
 		# 'linux%2Fhotplug%2Fudev.git Greg+Kroah-Hartman'
+		# optionally with description
+		# 'git/git.git Junio+C+Hamano The+core+git+plumbing'
+		# 'libs/klibc/klibc.git H.+Peter+Anvin klibc+main+development+tree'
+		# 'linux/hotplug/udev.git Kay+Sievers udev+development+tree'
 		my %paths;
 		open my ($fd), $projects_list or return;
 	PROJECT:
 		while (my $line = <$fd>) {
 			chomp $line;
-			my ($path, $owner) = split ' ', $line;
+			my ($path, $owner, $descr) = split ' ', $line;
 			$path = unescape($path);
 			$owner = unescape($owner);
+			$descr = unescape($descr);
 			if (!defined $path) {
-				next;
+				next PROJECT;
 			}
 			if ($filter ne '') {
 				# looking for forks;
@@ -1826,9 +1862,14 @@ sub git_get_projects_list {
 			}
 			if (check_export_ok("$projectroot/$path")) {
 				my $pr = {
-					path => $path,
+					path =>  to_utf8($path),
 					owner => to_utf8($owner),
 				};
+				if (defined $descr) {
+					$descr = to_utf8($descr);
+					$pr->{'descr_long'} = $descr;
+					$pr->{'descr'} = chop_str($descr, $projects_list_description_width, 5);
+				}
 				push @list, $pr;
 				(my $forks_path = $path) =~ s/\.git$//;
 				$paths{$forks_path}++;
@@ -3981,21 +4022,28 @@ sub git_project_index {
 	print $cgi->header(
 		-type => 'text/plain',
 		-charset => 'utf-8',
-		-content_disposition => 'inline; filename="index.aux"');
+		-content_disposition => 'inline; filename="projects_index.aux"');
 
 	foreach my $pr (@projects) {
 		if (!exists $pr->{'owner'}) {
 			$pr->{'owner'} = git_get_project_owner("$pr->{'path'}");
+			$pr->{'owner'} = to_utf8($pr->{'owner'});
+		}
+		if (!exists $pr->{'descr_long'}) {
+			$pr->{'descr_long'} = git_get_project_description($pr->{'path'}) || "";
+			$pr->{'descr_long'} = to_utf8($pr->{'descr_long'});
 		}
 
-		my ($path, $owner) = ($pr->{'path'}, $pr->{'owner'});
-		# quote as in CGI::Util::encode, but keep the slash, and use '+' for ' '
-		$path  =~ s/([^a-zA-Z0-9_.\-\/ ])/sprintf("%%%02X", ord($1))/eg;
-		$owner =~ s/([^a-zA-Z0-9_.\-\/ ])/sprintf("%%%02X", ord($1))/eg;
-		$path  =~ s/ /\+/g;
-		$owner =~ s/ /\+/g;
+		my @pr_info = 
+			($pr->{'path'}, $pr->{'owner'}, $pr->{'descr_long'});
+		foreach (@pr_info) {
+			# quote only minimal set, only what has to be quoted
+			s/([+%])/sprintf("%%%02X", ord($1))/eg;
+			s/ /\+/g;
+			s/([[:space:]])/sprintf("%%%02X", ord($1))/eg;
+		}
 
-		print "$path $owner\n";
+		print join(' ', @pr_info)."\n";
 	}
 }
 
-- 
1.5.6
