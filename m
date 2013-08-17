From: Rasmus Villemoes <rv@rasmusvillemoes.dk>
Subject: [RFC] git-send-email: Cache generated message-ids, use them when prompting
Date: Sat, 17 Aug 2013 00:58:46 +0000
Message-ID: <1376701126-5759-1-git-send-email-rv@rasmusvillemoes.dk>
Cc: git@vger.kernel.org, Rasmus Villemoes <rv@rasmusvillemoes.dk>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Sat Aug 17 02:59:23 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VAUrS-0004bD-9i
	for gcvg-git-2@plane.gmane.org; Sat, 17 Aug 2013 02:59:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753143Ab3HQA7S (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 Aug 2013 20:59:18 -0400
Received: from mail-wi0-f171.google.com ([209.85.212.171]:50249 "EHLO
	mail-wi0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751397Ab3HQA7R (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Aug 2013 20:59:17 -0400
Received: by mail-wi0-f171.google.com with SMTP id hr7so1411514wib.16
        for <git@vger.kernel.org>; Fri, 16 Aug 2013 17:59:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=eQb5gQn3fvoO7Ia3DW6JR8UsZiHRtmQcO1xS4LyFe+o=;
        b=Ytm9457Rse/qi8HBw8a2/I8ji1qx5w62lZq+1hpOoXb4ryb5NYxLslPCLH9PE2gmfO
         dSfm5cEB1NK3YbMV7hVhk67Ei0KSM9KFO8GgZRkQqFf0J+vd/pgC/U3ew/AsNuyufcZP
         otvENOVhxc4uPNG5TBP+36OKbbh5qWP0d2w4+edNdfC+TLVT6FJgFf4dTZYDXpVQdD9y
         P6WeJkOHTbhITMPwj8M4Ml3Z8BBNCvJhiZzrQ1+Fqzy0hQbjvuG9inlG0QUjFkCpb4CO
         kJP503Qoatb3kW0TjFRjwsL98tN4e3vY5geLBzKo+6G9d/Aqm83dpUZiTg4QSmqU8AQs
         7t/w==
X-Gm-Message-State: ALoCoQnk8vn/Zb7NdDOaGI4oBpVq/58uYzixgoOz5Qy4Qdoug1GfB5TpFq/r2HFSuZGpIK6kB64B
X-Received: by 10.180.13.13 with SMTP id d13mr283054wic.34.1376701155676;
        Fri, 16 Aug 2013 17:59:15 -0700 (PDT)
Received: from localhost.localdomain (wildmoose.dk. [83.169.18.19])
        by mx.google.com with ESMTPSA id li9sm399684wic.2.1969.12.31.16.00.00
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 16 Aug 2013 17:59:14 -0700 (PDT)
X-Mailer: git-send-email 1.8.4.rc3.2.gb900fc8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232449>

This is mostly a proof of concept/RFC patch. The idea is for
git-send-email to store the message-ids it generates, along with the
Subject and Date headers of the message. When prompting for which
Message-ID should be used in In-Reply-To, display a list of recent
emails (identifed using the Date/Subject pairs; the message-ids
themselves are not for human consumption). Choosing from that list
will then use the corresponding message-id; otherwise, the behaviour
is as usual.

When composing v2 or v3 of a patch or patch series, this avoids the
need to get one's MUA to display the Message-ID of the earlier email
(which is cumbersome in some MUAs) and then copy-paste that.

If this idea is accepted, I'm certain I'll get to use the feature
immediately, since the patch is not quite ready for inclusion :-)

Signed-off-by: Rasmus Villemoes <rv@rasmusvillemoes.dk>
---
 git-send-email.perl | 101 +++++++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 96 insertions(+), 5 deletions(-)

diff --git a/git-send-email.perl b/git-send-email.perl
index f608d9b..2e3685c 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -26,6 +26,7 @@ use Data::Dumper;
 use Term::ANSIColor;
 use File::Temp qw/ tempdir tempfile /;
 use File::Spec::Functions qw(catfile);
+use Date::Parse;
 use Error qw(:try);
 use Git;
 
@@ -203,6 +204,7 @@ my ($validate, $confirm);
 my (@suppress_cc);
 my ($auto_8bit_encoding);
 my ($compose_encoding);
+my ($msgid_cache_file, $msgid_maxprompt);
 
 my ($debug_net_smtp) = 0;		# Net::SMTP, see send_message()
 
@@ -214,7 +216,7 @@ my %config_bool_settings = (
     "signedoffcc" => [\$signed_off_by_cc, undef],      # Deprecated
     "validate" => [\$validate, 1],
     "multiedit" => [\$multiedit, undef],
-    "annotate" => [\$annotate, undef]
+    "annotate" => [\$annotate, undef],
 );
 
 my %config_settings = (
@@ -237,6 +239,7 @@ my %config_settings = (
     "from" => \$sender,
     "assume8bitencoding" => \$auto_8bit_encoding,
     "composeencoding" => \$compose_encoding,
+    "msgidcachefile" => \$msgid_cache_file,
 );
 
 my %config_path_settings = (
@@ -311,6 +314,7 @@ my $rc = GetOptions("h" => \$help,
 		    "8bit-encoding=s" => \$auto_8bit_encoding,
 		    "compose-encoding=s" => \$compose_encoding,
 		    "force" => \$force,
+		    "msgid-cache-file=s" => \$msgid_cache_file,
 	 );
 
 usage() if $help;
@@ -784,10 +788,31 @@ sub expand_one_alias {
 @bcclist = validate_address_list(sanitize_address_list(@bcclist));
 
 if ($thread && !defined $initial_reply_to) {
-	$initial_reply_to = ask(
-		"Message-ID to be used as In-Reply-To for the first email (if any)? ",
-		default => "",
-		valid_re => qr/\@.*\./, confirm_only => 1);
+	my @choices;
+	if ($msgid_cache_file) {
+		@choices = msgid_cache_getmatches();
+	}
+	if (@choices) {
+		my $prompt = '';
+		my $i = 0;
+		$prompt .= sprintf "(%d) [%s] %s\n", $i++, $_->{date}, $_->{subject}
+		    for (@choices);
+		$prompt .= sprintf "Answer 0-%d to use the Message-ID of one of the above\n", $#choices;
+		$prompt .= "Message-ID to be used as In-Reply-To for the first email (if any)? ";
+		$initial_reply_to = 
+		    ask($prompt,
+			default => "",
+			valid_re => qr/\@.*\.|^[0-9]+$/, confirm_only => 1);
+		if ($initial_reply_to =~ /^[0-9]+$/ && $initial_reply_to < @choices) {
+			$initial_reply_to = $choices[$initial_reply_to]{id};
+		}
+	}
+	else {
+		$initial_reply_to = 
+		    ask("Message-ID to be used as In-Reply-To for the first email (if any)? ",
+			default => "",
+			valid_re => qr/\@.*\./, confirm_only => 1);
+	}
 }
 if (defined $initial_reply_to) {
 	$initial_reply_to =~ s/^\s*<?//;
@@ -1282,6 +1307,8 @@ X-Mailer: git-send-email $gitversion
 		}
 	}
 
+	msgid_cache_this($message_id, $subject, $date) if ($msgid_cache_file && !$dry_run);
+
 	return 1;
 }
 
@@ -1508,6 +1535,8 @@ sub cleanup_compose_files {
 
 $smtp->quit if $smtp;
 
+msgid_cache_write() if $msgid_cache_file;
+
 sub unique_email_list {
 	my %seen;
 	my @emails;
@@ -1556,3 +1585,65 @@ sub body_or_subject_has_nonascii {
 	}
 	return 0;
 }
+
+my @msgid_new_entries;
+
+# For now, use a simple tab-separated format:
+#
+#    $id\t$date\t$subject\n
+sub msgid_cache_read {
+	my $fh;
+	my $line;
+	my @entries;
+	if (not open ($fh, '<', $msgid_cache_file)) {
+		# A non-existing cache file is ok, but should we warn if errno != ENOENT?
+		return ();
+	}
+	while ($line = <$fh>) {
+		chomp($line);
+		my ($id, $date, $subject) = split /\t/, $line;
+		my $epoch = str2time($date);
+		push @entries, {id=>$id, date=>$date, epoch=>$epoch, subject=>$subject};
+	}
+	close($fh);
+	return @entries;
+}
+sub msgid_cache_write {
+	my $fh;
+	if (not open($fh, '>>', $msgid_cache_file)) {
+	    warn "cannot open $msgid_cache_file for appending: $!";
+	    return;
+	}
+	printf $fh "%s\t%s\t%s\n", $_->{id}, $_->{date}, $_->{subject} for (@msgid_new_entries);
+	close($fh);
+}
+# Return an array of cached message-ids, ordered by "relevance". It
+# might make sense to take the Subject of the new mail as an extra
+# argument and do some kind of fuzzy matching against the old
+# subjects, but for now "more relevant" simply means "newer".
+sub msgid_cache_getmatches {
+	my ($maxentries) = @_;
+	$maxentries //= 10;
+	my @list = msgid_cache_read();
+	@list = sort {$b->{epoch} <=> $a->{epoch}} @list;
+	@list = @list[0 .. $maxentries-1] if (@list > $maxentries);
+	return @list;
+}
+
+sub msgid_cache_this {
+	my $msgid = shift;
+	my $subject = shift;
+	my $date = shift;
+	# Make sure there are no tabs which will confuse us, and save
+	# some valuable horizontal real-estate by removing redundant
+	# whitespace.
+	if ($subject) {
+		$subject =~ s/^\s+|\s+$//g;
+		$subject =~ s/\s+/ /g;
+	}
+	# Replace undef or the empty string by an actual string. Nobody uses "0" as the subject...
+	$subject ||= '(none)';
+	$date //= format_2822_time(time());
+	$date =~ s/\s+/ /g;
+	push @msgid_new_entries, {id => $msgid, subject => $subject, date => $date};
+}
-- 
1.8.4.rc3.2.gb900fc8
