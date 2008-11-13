From: Junio C Hamano <gitster@pobox.com>
Subject: Re* [take 2] git send-email updates
Date: Wed, 12 Nov 2008 16:01:46 -0800
Message-ID: <7vfxlwlcid.fsf_-_@gitster.siamese.dyndns.org>
References: <1225450632-7230-1-git-send-email-madcoder@debian.org>
 <1226361242-2516-1-git-send-email-madcoder@debian.org>
 <7v4p2e0zus.fsf@gitster.siamese.dyndns.org>
 <20081111221351.GE10073@artemis.corp>
 <7vk5b9x0kj.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Pierre Habouzit <madcoder@debian.org>
X-From: git-owner@vger.kernel.org Thu Nov 13 01:03:32 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L0PgJ-0002dZ-0D
	for gcvg-git-2@gmane.org; Thu, 13 Nov 2008 01:03:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752117AbYKMACM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Nov 2008 19:02:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752154AbYKMACK
	(ORCPT <rfc822;git-outgoing>); Wed, 12 Nov 2008 19:02:10 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:50194 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750924AbYKMACJ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Nov 2008 19:02:09 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id E4C05168A1;
	Wed, 12 Nov 2008 19:02:07 -0500 (EST)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 890AD16884; Wed, 12 Nov 2008 19:01:48 -0500 (EST)
In-Reply-To: <7vk5b9x0kj.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's
 message of "Tue, 11 Nov 2008 16:14:20 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 4FEC0194-B116-11DD-9475-C128113D384A-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100838>

Junio C Hamano <gitster@pobox.com> writes:

> Actually, "send-email --format-patch master..fixes Documentation/" may be
> a useful command to send out only documentation fixes.  For such a usage,
> Documentation/ should not be taken as a maildir.  If we would want to
> support such usage (and I'd say why not), a token can fall into one (or
> two) of three categories:
>
>     - can it be a rev?
>
>     - is it a tracked path (either blob or a leading dir)?
>
>     - is it a file/dir that is not tracked?
>
> The first two would be format-patch candidate.  The last one is the
> traditional mail source.  Because the latter two are disjoint set, and
> because it does not matter if you have a tracked file 'master' and a
> branch 'master' in your repo (either will be passed to format-patch
> anyway), the actual disambiguity is reduced, but it still is different
> from what you have in your patch, I suspect.
>
> As to options, how about doing this:
>
>     --no-format-patch means never ever run format-patch, behave exactly as
>     before;
>
>     --format-patch means what you have in your patch.  guess and favor 
>     format-patch parameter when ambiguous;
>
>     without either option, guess and favor mbox/maildir but still run
>     format-patch if remaining parameters and options need to
>     (e.g. "send-email my-cover-letter origin/master..master" will find
>     my-cover-letter which is not tracked and take it as mbox, and grab
>     patches from commits between origin/master..master, and send all of
>     them).

This patch on top of your [2/4] illustrates what I had in mind (it also
removes the "print foo" while at it).

 git-send-email.perl |   35 +++++++++++++++++++++++++++++++----
 1 files changed, 31 insertions(+), 4 deletions(-)

diff --git c/git-send-email.perl w/git-send-email.perl
index 6f5a613..9aa3500 100755
--- c/git-send-email.perl
+++ w/git-send-email.perl
@@ -152,7 +152,7 @@ if ($@) {
 
 # Behavior modification variables
 my ($quiet, $dry_run) = (0, 0);
-my $format_patch;
+my $format_patch = 'unspecified';
 my $compose_filename = $repo->repo_path() . "/.gitsendemail.msg.$$";
 
 # Variables with corresponding config settings
@@ -243,6 +243,15 @@ unless ($rc) {
     usage();
 }
 
+if ($format_patch && $format_patch eq 'unspecified') {
+	# No --format-patch nor --no-format-patch on the command line
+	$format_patch = 0;
+} elsif (!$format_patch) {
+	$format_patch = undef;
+} else {
+	$format_patch = 1;
+}
+
 # Now, let's fill any that aren't set in with defaults:
 
 sub read_config {
@@ -374,11 +383,27 @@ if (@alias_files and $aliasfiletype and defined $parse_alias{$aliasfiletype}) {
 # returns 1 if the conflict must be solved using it as a format-patch argument
 sub check_file_rev_conflict($) {
 	my $f = shift;
+
+	if (!defined $format_patch) {
+		# The command line explicitly forbids acting as a wrapper
+		return 0;
+	}
+
+	# If it is a tracked path it can't be tracking the e-mails you
+	# are going to send out to describe the change to this repository.
+	eval {
+		$repo->command(['ls-files', '--error-unmatch', $f],
+			       { STDERR => 0 });
+	};
+	if (!$@) {
+		return 1;
+	}
+
+	# Can it be interpreted as a rev?
 	try {
 		$repo->command('rev-parse', '--verify', '--quiet', $f);
-		if (defined($format_patch)) {
-			print "foo\n";
-			return $format_patch;
+		if ($format_patch) {
+			return 1;
 		}
 		die(<<EOF);
 File '$f' exists but it could also be the range of commits
@@ -408,6 +433,8 @@ while (my $f = pop @ARGV) {
 		closedir(DH);
 	} elsif ((-f $f or -p $f) and !check_file_rev_conflict($f)) {
 		push @files, $f;
+	} elsif (!defined $format_patch) {
+		die("--no-format-patch was given but $f is not a valid send-email argument");
 	} else {
 		push @rev_list_opts, $f;
 	}
