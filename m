From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-svn.perl: Strip ChangeLog bits.
Date: Sat, 02 Aug 2008 14:13:03 -0700
Message-ID: <7v4p63dstc.fsf@gitster.siamese.dyndns.org>
References: <1217684549.8296.10.camel@heerbeest>
 <20080802172742.GT32184@machine.or.cz>
 <7vfxpnnwt5.fsf@gitster.siamese.dyndns.org>
 <1217701021.8296.35.camel@heerbeest>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Petr Baudis <pasky@suse.cz>, git@vger.kernel.org
To: Jan Nieuwenhuizen <janneke-list@xs4all.nl>
X-From: git-owner@vger.kernel.org Sat Aug 02 23:14:16 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KPOQY-0002lT-SH
	for gcvg-git-2@gmane.org; Sat, 02 Aug 2008 23:14:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751652AbYHBVNM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 2 Aug 2008 17:13:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751824AbYHBVNM
	(ORCPT <rfc822;git-outgoing>); Sat, 2 Aug 2008 17:13:12 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:50377 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751627AbYHBVNL (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 2 Aug 2008 17:13:11 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id DB97C462D7;
	Sat,  2 Aug 2008 17:13:09 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id A3EC5462D6; Sat,  2 Aug 2008 17:13:05 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: CF0BC02A-60D7-11DD-96AA-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91183>

Jan Nieuwenhuizen <janneke-list@xs4all.nl> writes:

> On za, 2008-08-02 at 10:36 -0700, Junio C Hamano wrote:
>
>> >   You forgot to document your option. (And possibly write a testcase.)
>> 
>> I am not sure if this is generic enough to be in git-svn.perl itself, or
>> perhaps there should be a hook make_log_entry() would call in the form of
>> some Perl scriptlet given by the user to munge $log_entry{log}, which
>> would be very specific to each project.
>
> If you're not sure, please make up your mind.

That's something you would say when I cannot decide the color of
bikeshed.  I do not think your change falls into that category.

We could add an ad-hoc preprocessing option like this, and keep adding
more for different patterns, and at certain point we may be fed up with
millions of such options and try to introduce a more generic mechanism.
While doing so, the resulting code needs to support the ad-hoc ones that
are added earlier, forever.

We've done that in the past with other commands (cc-suppression scheme in
send-email comes to mind).  It was very unpleasant.

> ...  Doing this in a single
> regexp is a bit tricky and asking a user to write a perl snippet is even
> worse, imho.

What you are saying is that a built-in one, no matter what, won't be
sufficient for many projects.  Unless a user writes Perl snippet to match
his project's needs, the noise at the beginning of the log won't be
stripped for him.

That's fine.  I do not expect a single built-in transformation would fit
everybody's needs.  I am not asking for miracles.

But you could at least keep the door open for people who are _willing_ to
write such transformation for their projects, right?

For one thing, your --cut-changelog-bits has one fixed pattern.  Later
people either have to come up with different option, or modify your
pattern (potentially breaking your project).  Neither is good.

Perhaps doing something like this a (admittedly slightly) better option?
It allows you to choose from a canned set, or give a series of s///
rewriting rules (or whatever you would want to have in the custom function)..

---

 git-svn.perl |   34 +++++++++++++++++++++++++++++++++-
 1 files changed, 33 insertions(+), 1 deletions(-)

diff --git a/git-svn.perl b/git-svn.perl
index cf6dbbc..eaf6a56 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -66,7 +66,7 @@ my ($_stdin, $_help, $_edit,
 	$_version, $_fetch_all, $_no_rebase,
 	$_merge, $_strategy, $_dry_run, $_local,
 	$_prefix, $_no_checkout, $_url, $_verbose,
-	$_git_format);
+	$_git_format, $_clean_changelog, $_clean_log_message);
 $Git::SVN::_follow_parent = 1;
 my %remote_opts = ( 'username=s' => \$Git::SVN::Prompt::_username,
                     'config-dir=s' => \$Git::SVN::Ra::config_dir,
@@ -109,9 +109,11 @@ my %cmd = (
 	fetch => [ \&cmd_fetch, "Download new revisions from SVN",
 			{ 'revision|r=s' => \$_revision,
 			  'fetch-all|all' => \$_fetch_all,
+			  'clean-changelog=s' => \$_clean_changelog,
 			   %fc_opts } ],
 	clone => [ \&cmd_clone, "Initialize and fetch revisions",
 			{ 'revision|r=s' => \$_revision,
+			  'clean-changelog=s' => \$_clean_changelog,
 			   %fc_opts, %init_opts } ],
 	init => [ \&cmd_init, "Initialize a repo for tracking" .
 			  " (requires URL argument)",
@@ -238,6 +240,33 @@ my $rv = GetOptions(%opts, 'help|H|h' => \$_help, 'version|V' => \$_version,
                        $Git::SVN::default_repo_id = $_[1] });
 exit 1 if (!$rv && $cmd && $cmd ne 'log');
 
+my %canned_changelog_cleaner =
+(
+ 'ooo' => sub {
+	 local ($_) = @_;
+	 s/(^|\n)\s*((\n|\s)*(199[0-9]|20[0-1][0-9])(-[0-9]{2}){2}\s+.*<.*>\s*\n\s+)?/$1/g;
+	 s/(^|\n)\* /\n$1/g;
+	 s/^[\n\s]*//;
+	 s/\n\s*/ /g if length ($_) < 81;
+	 "\n";
+ }
+);
+
+if (defined $_clean_changelog) {
+	if (exists $canned_changelog_cleaner{$_clean_changelog}) {
+		$_clean_log_message = $canned_changelog_cleaner{$_clean_changelog};
+	} elsif ($_clean_changelog ne '') {
+		$_clean_log_message = eval "
+			sub { local(\$_) = \@_; $_clean_changelog; return \$_; }
+		";
+		if ($@) {
+			die "$!: $_clean_changelog";
+		}
+	} else {
+		die "$_clean_changelog: unknown way to clean log message";
+	}
+}
+
 usage(0) if $_help;
 version() if $_version;
 usage(1) unless defined $cmd;
@@ -2463,6 +2492,9 @@ sub make_log_entry {
 	close $un or croak $!;
 
 	$log_entry{date} = parse_svn_date($log_entry{date});
+	if ($_clean_log_message) {
+		$log_entry{log} = $_clean_log_message->($log_entry{log});
+	}
 	$log_entry{log} .= "\n";
 	my $author = $log_entry{author} = check_author($log_entry{author});
 	my ($name, $email) = defined $::users{$author} ? @{$::users{$author}}
