From: Jan Nieuwenhuizen <janneke-list@xs4all.nl>
Subject: [PATCH] git-svn.perl: Strip ChangeLog bits.
Date: Sat, 02 Aug 2008 15:42:29 +0200
Organization: lilypond-design.org
Message-ID: <1217684549.8296.10.camel@heerbeest>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 02 16:06:26 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KPHkN-0001UL-PS
	for gcvg-git-2@gmane.org; Sat, 02 Aug 2008 16:06:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751745AbYHBOFL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 2 Aug 2008 10:05:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751965AbYHBOFL
	(ORCPT <rfc822;git-outgoing>); Sat, 2 Aug 2008 10:05:11 -0400
Received: from edu-smtp-02.edutel.nl ([88.159.1.222]:35263 "EHLO
	edu-smtp-02.edutel.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751726AbYHBOFK (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 2 Aug 2008 10:05:10 -0400
X-Greylist: delayed 1357 seconds by postgrey-1.27 at vger.kernel.org; Sat, 02 Aug 2008 10:05:09 EDT
Received: from heerbeest (unknown [88.159.206.46])
	by edu-smtp-02.edutel.nl (Postfix) with ESMTP id 4EFB811E600;
	Sat,  2 Aug 2008 15:42:31 +0200 (CEST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
	by heerbeest (Postfix) with ESMTP id 78C6CDC091;
	Sat,  2 Aug 2008 15:42:30 +0200 (CEST)
X-Mailer: Evolution 2.23.4 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91146>

Some projects write ChangeLog entries and use those for svn
commit messages.  Converting such a repository makes for
a most uninteresting git log --pretty=oneline output.

    482cfc6... 2008-08-01  Kohei Yoshida  <kyoshida@novell.com>
    90c16d7... 2008-08-01  Fong Lin  <pflin@novell.com> 	* patches/dev300/cws-npow
    505fc23... 2008-08-01  Kohei Yoshida  <kyoshida@novell.com>
    4729379... 2008-08-01  Kohei Yoshida  <kyoshida@novell.com>
    9e34b85... 2008-07-31  Kohei Yoshida  <kyoshida@novell.com>
    ee1855a... 2008-07-31  Jan Nieuwenhuizen  <janneke@gnu.org>
    518b921... 2008-07-31  Miklos Vajna  <vmiklos@frugalware.org>

The --cut-changelog-bits fixes this

    44e7784... patches/dev300/apply: added upstream issue numbers to some of my  p
    1a19026... patches/dev300/cws-npower11.diff: Add vba events stuff.
    7422531... patches/test/calc-external-defined-names.diff: more progress; make 
    66c5975... scratch/sc-xlsutil/src/formula.py:
    307fa53... patches/dev300/chart-subtitle-xls-export.diff: preserve the subtitl
    0d127af... patches/dev300/layout-simple-dialogs-toolkit.diff: Remove duplicate
    843d41e... patches/dev300/apply: Remove gcc401-stlport45-include.diff from Fru

partly.  I tried removing the file name bits too, but that makeslog
entries that touch multiple files almost useless.


Signed-off-by: Jan Nieuwenhuizen <Jan Nieuwenhuizen janneke@gnu.org>
---
 git-svn.perl |   11 ++++++++++-
 1 files changed, 10 insertions(+), 1 deletions(-)

diff --git a/git-svn.perl b/git-svn.perl
index cf6dbbc..651739a 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -66,7 +66,7 @@ my ($_stdin, $_help, $_edit,
 	$_version, $_fetch_all, $_no_rebase,
 	$_merge, $_strategy, $_dry_run, $_local,
 	$_prefix, $_no_checkout, $_url, $_verbose,
-	$_git_format);
+	$_git_format, $_cut_changelog_bits);
 $Git::SVN::_follow_parent = 1;
 my %remote_opts = ( 'username=s' => \$Git::SVN::Prompt::_username,
                     'config-dir=s' => \$Git::SVN::Ra::config_dir,
@@ -109,9 +109,11 @@ my %cmd = (
 	fetch => [ \&cmd_fetch, "Download new revisions from SVN",
 			{ 'revision|r=s' => \$_revision,
 			  'fetch-all|all' => \$_fetch_all,
+			  'cut-changelog-bits' => \$_cut_changelog_bits,
 			   %fc_opts } ],
 	clone => [ \&cmd_clone, "Initialize and fetch revisions",
 			{ 'revision|r=s' => \$_revision,
+			  'cut-changelog-bits' => \$_cut_changelog_bits,
 			   %fc_opts, %init_opts } ],
 	init => [ \&cmd_init, "Initialize a repo for tracking" .
 			  " (requires URL argument)",
@@ -2463,6 +2465,13 @@ sub make_log_entry {
 	close $un or croak $!;
 
 	$log_entry{date} = parse_svn_date($log_entry{date});
+	if (defined $_cut_changelog_bits) {
+	    $log_entry{log} =~ s/(^|\n)\s*((\n|\s)*(199[0-9]|
20[0-1][0-9])(-[0-9]{2}){2}\s+.*<.*>\s*\n\s+)?/$1/g;
+	    $log_entry{log} =~ s/(^|\n)\* /\n$1/g;
+	    $log_entry{log} =~ s/^[\n\s]*//;
+	    $log_entry{log} =~ s/\n\s*/ /g if length ($log_entry{log}) < 81;
+	    $log_entry{log} .= "\n";
+	}
 	$log_entry{log} .= "\n";
 	my $author = $log_entry{author} = check_author($log_entry{author});
 	my ($name, $email) = defined $::users{$author} ? @{$::users{$author}}
-- 
1.6.0.rc0.44.g67270


-- 
Jan Nieuwenhuizen <janneke@gnu.org> | GNU LilyPond - The music typesetter
http://www.xs4all.nl/~jantien       | http://www.lilypond.org
