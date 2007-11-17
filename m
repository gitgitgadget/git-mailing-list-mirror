From: Andreas Ericsson <ae@op5.se>
Subject: Re: BUG: git-svn does not escape literal backslashes in author names.
Date: Sun, 18 Nov 2007 00:17:13 +0100
Message-ID: <473F7679.4010901@op5.se>
References: <1213a9470711120628l4ccab632n17635295ec897a2@mail.gmail.com> <20071117204348.GA16333@muzzle>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Adrian Wilkins <adrian.wilkins@gmail.com>, git@vger.kernel.org
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Sun Nov 18 00:17:41 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ItWuy-00048N-EE
	for gcvg-git-2@gmane.org; Sun, 18 Nov 2007 00:17:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753366AbXKQXRT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 17 Nov 2007 18:17:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753335AbXKQXRT
	(ORCPT <rfc822;git-outgoing>); Sat, 17 Nov 2007 18:17:19 -0500
Received: from mail.op5.se ([193.201.96.20]:54930 "EHLO mail.op5.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753298AbXKQXRS (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Nov 2007 18:17:18 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.op5.se (Postfix) with ESMTP id E3D431F0873C;
	Sun, 18 Nov 2007 00:17:16 +0100 (CET)
X-Virus-Scanned: amavisd-new at 
X-Spam-Flag: NO
X-Spam-Score: -2.499
X-Spam-Level: 
X-Spam-Status: No, score=-2.499 tagged_above=-10 required=6.6
	tests=[BAYES_00=-2.599, RDNS_NONE=0.1]
Received: from mail.op5.se ([127.0.0.1])
	by localhost (mail.op5.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id hwDM-rpSjv7j; Sun, 18 Nov 2007 00:17:15 +0100 (CET)
Received: from nox.op5.se (unknown [172.27.78.26])
	by mail.op5.se (Postfix) with ESMTP id 53A8B1F0871B;
	Sun, 18 Nov 2007 00:17:15 +0100 (CET)
User-Agent: Thunderbird 2.0.0.5 (X11/20070727)
In-Reply-To: <20071117204348.GA16333@muzzle>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65318>

Eric Wong wrote:
> Adrian Wilkins <adrian.wilkins@gmail.com> wrote:
> 
>> Can I suggest that you make the authors file compulsory by default as well?
> 
> Not going to happen.  I personally _hate_ having to track down author
> information and make an authors file, and I suspect many others feel the
> same.  I've never used this feature in git-svn on any real repository.
> 

I wholeheartedly agree. One thing that could be improved in this area though
is to do what git-cvsimport does, and stash the authors file in $GIT_DIR and
re-read it on every invocation. I've forgotten to add that -A switch numerous
times when fetching incrementally and it always annoys me enormously.

Something like this, perhaps? It needs checking. My perl is.. well, you can
see for yourselves, and unfortunately I have no possibility to test this
until monday when I'm back on a sane link. It should work as a starting
point though. It applies cleanly on top of current next.

---%<---%<---%<---
From: Andreas Ericsson <ae@op5.se>
Subject: git svn: Cache author info in $GIT_DIR/author-cache

git-cvsimport does it, so it's reasonable that git-svn users
expect the same functionality. It's also damn convenient.

Signed-off-by: Andreas Ericsson <ae@op5.se>
---
 Documentation/git-svn.txt |    3 +++
 git-svn.perl              |   25 +++++++++++++++++++++++--
 2 files changed, 26 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-svn.txt b/Documentation/git-svn.txt
index 488e4b1..446a7d7 100644
--- a/Documentation/git-svn.txt
+++ b/Documentation/git-svn.txt
@@ -276,6 +276,9 @@ committer name that does not exist in the authors-file, git-svn
 will abort operation. The user will then have to add the
 appropriate entry.  Re-running the previous git-svn command
 after the authors-file is modified should continue operation.
+For convenience, this data is saved to $GIT_DIR/author-cache
+each time the '-A' option is provided and read from that same
+file each time git-svn is run.
 
 config key: svn.authorsfile
 
diff --git a/git-svn.perl b/git-svn.perl
index e3e00fd..0a989ed 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -14,6 +14,7 @@ my $cmd_dir_prefix = eval {
        command_oneline([qw/rev-parse --show-prefix/], STDERR => 0)
 } || '';
 
+my $author_cache;
 my $git_dir_user_set = 1 if defined $ENV{GIT_DIR};
 $ENV{GIT_DIR} ||= '.git';
 $Git::SVN::default_repo_id = 'svn';
@@ -203,7 +204,6 @@ exit 1 if (!$rv && $cmd && $cmd ne 'log');
 usage(0) if $_help;
 version() if $_version;
 usage(1) unless defined $cmd;
-load_authors() if $_authors;
 
 # make sure we're always running
 unless ($cmd =~ /(?:clone|init|multi-init)$/) {
@@ -226,6 +226,14 @@ unless ($cmd =~ /(?:clone|init|multi-init)$/) {
                $ENV{GIT_DIR} = $git_dir;
        }
 }
+
+$author_cache = $ENV{GIT_DIR} . "/author-cache";
+load_authors($_authors) if $_authors;
+unless ($cmd =~ /(?:clone|init|multi-init)$/) {
+       -f $author_cache and load_authors($author_cache);
+       write_author_cache();
+}
+
 unless ($cmd =~ /^(?:clone|init|multi-init|commit-diff)$/) {
        Git::SVN::Migration::migration_check();
 }
@@ -297,6 +305,8 @@ sub do_git_init_db {
                command_noisy('config', "$pfx.$i", $icv{$i});
                $set = $i;
        }
+
+       write_author_cache() if %users;
 }
 
 sub init_subdir {
@@ -900,7 +910,8 @@ sub file_to_s {
 
 # '<svn username> = real-name <email address>' mapping based on git-svnimport:
 sub load_authors {
-       open my $authors, '<', $_authors or die "Can't open $_authors $!\n";
+       my ($file) = @_;
+       open my $authors, '<', $file or die "Can't open $file $!\n";
        my $log = $cmd eq 'log';
        while (<$authors>) {
                chomp;
@@ -915,6 +926,16 @@ sub load_authors {
        close $authors or croak $!;
 }
 
+sub write_author_cache {
+       open my $f, '>', $author_cache
+         or die "Can't open author cache $author_cache for writing: $!\n";
+       foreach (keys %users) {
+               print $f "$_=$users{$_}[0] <$users{$_}[1]>\n";
+       }
+
+       close $f or croak $!;
+}
+
 # convert GetOpt::Long specs for use by git-config
 sub read_repo_config {
        return unless -d $ENV{GIT_DIR};
-- 
1.5.3.5.1527.g6161
---%<---%<---%<---

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
