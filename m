From: "Ramsay Jones" <ramsay@ramsay1.demon.co.uk>
Subject: [PATCH 10/10] Fix perl scripts to work with version 5.005_03.
Date: Wed, 2 Aug 2006 02:03:49 +0100
Message-ID: <00c601c6b5cf$83a627c0$c47eedc1@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_00C7_01C6B5D7.E56A8FC0"
X-From: git-owner@vger.kernel.org Wed Aug 02 03:03:43 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G859C-00074N-Qo
	for gcvg-git@gmane.org; Wed, 02 Aug 2006 03:03:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750920AbWHBBDi (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 1 Aug 2006 21:03:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750921AbWHBBDi
	(ORCPT <rfc822;git-outgoing>); Tue, 1 Aug 2006 21:03:38 -0400
Received: from anchor-post-35.mail.demon.net ([194.217.242.85]:4106 "EHLO
	anchor-post-35.mail.demon.net") by vger.kernel.org with ESMTP
	id S1750919AbWHBBDh (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Aug 2006 21:03:37 -0400
Received: from ramsay1.demon.co.uk ([193.237.126.196])
	by anchor-post-35.mail.demon.net with smtp (Exim 4.42)
	id 1G8590-000C1I-JD
	for git@vger.kernel.org; Wed, 02 Aug 2006 01:03:36 +0000
To: <git@vger.kernel.org>
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook 8.5, Build 4.71.2173.0
X-MimeOLE: Produced By Microsoft MimeOLE V4.72.2106.4
Importance: Normal
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24628>

This is a multi-part message in MIME format.

------=_NextPart_000_00C7_01C6B5D7.E56A8FC0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit

In order to make git work on an ancient Linux (Mandrake 7.0) we
need to make the perl scripts work with verion 5.005_03.

The changes include:

  - comment out the "use warnings" pragma
  - open has only two arguments; eg. `open FH, "<$file"` rather
    than `open FH, '<', $file`
  - replace "our" with "my" in the declaration of global (package)
    variables.
  - replace the use of some indirect file-handles with regular
    file-handles.

Note that only those perl scripts which are exercised by the test
suite or that I have called directly have been modified.

Signed-off-by: Ramsay Allan Jones <ramsay@ramsay1.demon.co.uk>
---
 Documentation/build-docdep.perl |    2 +-
 git-annotate.perl               |   25 ++++++++++++-------------
 git-clone.sh                    |    6 +++---
 git-mv.perl                     |    4 ++--
 git-send-email.perl             |   27 +++++++++++++--------------
 git-shortlog.perl               |    2 +-
 6 files changed, 32 insertions(+), 34 deletions(-)

diff --git a/Documentation/build-docdep.perl
b/Documentation/build-docdep.perl
index 489389c..cd40f56 100755
--- a/Documentation/build-docdep.perl
+++ b/Documentation/build-docdep.perl
@@ -4,7 +4,7 @@ my %include = ();
 my %included = ();

 for my $text (<*.txt>) {
-    open I, '<', $text || die "cannot read: $text";
+    open I, "<$text" || die "cannot read: $text";
     while (<I>) {
 	if (/^include::/) {
 	    chomp;
diff --git a/git-annotate.perl b/git-annotate.perl
index a6a7a48..629f480 100755
--- a/git-annotate.perl
+++ b/git-annotate.perl
@@ -6,7 +6,7 @@ #
 # This file is licensed under the GPL v2, or a later version
 # at the discretion of Linus Torvalds.

-use warnings;
+#use warnings;
 use strict;
 use Getopt::Long;
 use POSIX qw(strftime gmtime);
@@ -29,7 +29,7 @@ sub usage() {
 	exit(1);
 }

-our ($help, $longrev, $rename, $rawtime, $starting_rev, $rev_file) = (0, 0,
1);
+my ($help, $longrev, $rename, $rawtime, $starting_rev, $rev_file) = (0, 0,
1);

 my $rc = GetOptions(	"long|l" => \$longrev,
 			"time|t" => \$rawtime,
@@ -52,12 +52,12 @@ my @stack = (
 	},
 );

-our @filelines = ();
+my @filelines = ();

 if (defined $starting_rev) {
 	@filelines = git_cat_file($starting_rev, $filename);
 } else {
-	open(F,"<",$filename)
+	open(F,"<$filename")
 		or die "Failed to open filename: $!";

 	while(<F>) {
@@ -68,9 +68,9 @@ if (defined $starting_rev) {

 }

-our %revs;
-our @revqueue;
-our $head;
+my %revs;
+my @revqueue;
+my $head;

 my $revsprocessed = 0;
 while (my $bound = pop @stack) {
@@ -436,14 +436,13 @@ sub format_date {
 # Copied from git-send-email.perl - We need a Git.pm module..
 sub gitvar {
     my ($var) = @_;
-    my $fh;
-    my $pid = open($fh, '-|');
+    my $pid = open(FH, '-|');
     die "$!" unless defined $pid;
     if (!$pid) {
 	exec('git-var', $var) or die "$!";
     }
-    my ($val) = <$fh>;
-    close $fh or die "$!";
+    my ($val) = <FH>;
+    close FH or die "$!";
     chomp($val);
     return $val;
 }
@@ -471,7 +470,7 @@ sub open_pipe_activestate {
 sub open_pipe_normal {
 	my (@execlist) = @_;

-	my $pid = open my $kid, "-|";
+	my $pid = open KID, "-|";
 	defined $pid or die "Cannot fork: $!";

 	unless ($pid) {
@@ -479,7 +478,7 @@ sub open_pipe_normal {
 		die "Cannot exec @execlist: $!";
 	}

-	return $kid;
+	return *KID;
 }

 package Git::ActiveStatePipe;
diff --git a/git-clone.sh b/git-clone.sh
index 47bd8e7..430c892 100755
--- a/git-clone.sh
+++ b/git-clone.sh
@@ -71,17 +71,17 @@ sub store {
 	my ($sha1, $name, $top) = @_;
 	$name = "$git_dir/refs/$top/$name";
 	mkpath(dirname($name));
-	open O, ">", "$name";
+	open O, ">$name";
 	print O "$sha1\n";
 	close O;
 }

-open FH, "<", "$git_dir/CLONE_HEAD";
+open FH, "<$git_dir/CLONE_HEAD";
 while (<FH>) {
 	my ($sha1, $name) = /^([0-9a-f]{40})\s(.*)$/;
 	next if ($name =~ /\^\173/);
 	if ($name eq "HEAD") {
-		open O, ">", "$git_dir/REMOTE_HEAD";
+		open O, ">$git_dir/REMOTE_HEAD";
 		print O "$sha1\n";
 		close O;
 		next;
diff --git a/git-mv.perl b/git-mv.perl
index 75aa8fe..7aceeb8 100755
--- a/git-mv.perl
+++ b/git-mv.perl
@@ -7,7 +7,7 @@ # This file is licensed under the GPL v2
 # at the discretion of Linus Torvalds.


-use warnings;
+#use warnings;
 use strict;
 use Getopt::Std;

@@ -19,7 +19,7 @@ EOT
 	exit(1);
 }

-our ($opt_n, $opt_f, $opt_h, $opt_k, $opt_v);
+my ($opt_n, $opt_f, $opt_h, $opt_k, $opt_v);
 getopts("hnfkv") || usage;
 usage() if $opt_h;
 @ARGV >= 1 or usage;
diff --git a/git-send-email.perl b/git-send-email.perl
index c5d9e73..e670f28 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -17,7 +17,7 @@ #    and second line is the subject of t
 #

 use strict;
-use warnings;
+#use warnings;
 use Term::ReadLine;
 use Getopt::Long;
 use Data::Dumper;
@@ -83,14 +83,13 @@ # Now, let's fill any that aren't set in

 sub gitvar {
     my ($var) = @_;
-    my $fh;
-    my $pid = open($fh, '-|');
+    my $pid = open(FH, '-|');
     die "$!" unless defined $pid;
     if (!$pid) {
 	exec('git-var', $var) or die "$!";
     }
-    my ($val) = <$fh>;
-    close $fh or die "$!";
+    my ($val) = <FH>;
+    close FH or die "$!";
     chomp($val);
     return $val;
 }
@@ -134,7 +133,7 @@ my %parse_alias = (

 if (@alias_files && defined $parse_alias{$aliasfiletype}) {
 	foreach my $file (@alias_files) {
-		open my $fh, '<', $file or die "opening $file: $!\n";
+		open my $fh, "<$file" or die "opening $file: $!\n";
 		$parse_alias{$aliasfiletype}->($fh);
 		close $fh;
 	}
@@ -209,7 +208,7 @@ if (!$smtp_server) {
 if ($compose) {
 	# Note that this does not need to be secure, but we will make a small
 	# effort to have it be unique
-	open(C,">",$compose_filename)
+	open(C,">$compose_filename")
 		or die "Failed to open for writing $compose_filename: $!";
 	print C "From $from # This line is ignored.\n";
 	printf C "Subject: %s\n\n", $initial_subject;
@@ -226,10 +225,10 @@ EOT
 	$editor = 'vi' unless defined $editor;
 	system($editor, $compose_filename);

-	open(C2,">",$compose_filename . ".final")
+	open(C2,">$compose_filename" . ".final")
 		or die "Failed to open $compose_filename.final : " . $!;

-	open(C,"<",$compose_filename)
+	open(C,"<$compose_filename")
 		or die "Failed to open $compose_filename : " . $!;

 	while(<C>) {
@@ -322,7 +321,7 @@ EOT
 }

 # Variables we set as part of the loop over files
-our ($message_id, $cc, %mail, $subject, $reply_to, $references, $message);
+my ($message_id, $cc, %mail, $subject, $reply_to, $references, $message);

 sub extract_valid_address {
 	my $address = shift;
@@ -396,15 +395,15 @@ X-Mailer: git-send-email $gitversion
 	}

 	if ($smtp_server =~ m#^/#) {
-		my $pid = open my $sm, '|-';
+		my $pid = open SM, '|-';
 		defined $pid or die $!;
 		if (!$pid) {
 			exec($smtp_server,'-i',
 			     map { extract_valid_address($_) }
 			     @recipients) or die $!;
 		}
-		print $sm "$header\n$message";
-		close $sm or die $?;
+		print SM "$header\n$message";
+		close SM or die $?;
 	} else {
 		require Net::SMTP;
 		$smtp ||= Net::SMTP->new( $smtp_server );
@@ -440,7 +439,7 @@ make_message_id();
 $subject = $initial_subject;

 foreach my $t (@files) {
-	open(F,"<",$t) or die "can't open file $t";
+	open(F,"<$t") or die "can't open file $t";

 	my $author_not_sender = undef;
 	@cc = @initial_cc;
diff --git a/git-shortlog.perl b/git-shortlog.perl
index 0b14f83..57604dd 100755
--- a/git-shortlog.perl
+++ b/git-shortlog.perl
@@ -128,7 +128,7 @@ sub setup_mailmap {
 	read_mailmap(\*DATA, \%mailmap);
 	if (-f '.mailmap') {
 		my $fh = undef;
-		open $fh, '<', '.mailmap';
+		open $fh, '<.mailmap';
 		read_mailmap($fh, \%mailmap);
 		close $fh;
 	}
--
1.4.1

------=_NextPart_000_00C7_01C6B5D7.E56A8FC0
Content-Type: text/plain;
	name="P0010.TXT"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
	filename="P0010.TXT"

RnJvbSBiOTRkY2FjOTRmNzBjYzY3N2Q0ZDI2YWFhYjQ3YTNlOWVlY2NjYmEyIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBSYW1zYXkgQWxsYW4gSm9uZXMgPHJhbXNheUByYW1zYXkxLmRl
bW9uLmNvLnVrPgpEYXRlOiBTdW4sIDMwIEp1bCAyMDA2IDIzOjEzOjE0ICswMTAwClN1YmplY3Q6
IFtQQVRDSCAxMC8xMF0gRml4IHBlcmwgc2NyaXB0cyB0byB3b3JrIHdpdGggdmVyc2lvbiA1LjAw
NV8wMy4KCkluIG9yZGVyIHRvIG1ha2UgZ2l0IHdvcmsgb24gYW4gYW5jaWVudCBMaW51eCAoTWFu
ZHJha2UgNy4wKSB3ZQpuZWVkIHRvIG1ha2UgdGhlIHBlcmwgc2NyaXB0cyB3b3JrIHdpdGggdmVy
aW9uIDUuMDA1XzAzLgoKVGhlIGNoYW5nZXMgaW5jbHVkZToKCiAgLSBjb21tZW50IG91dCB0aGUg
InVzZSB3YXJuaW5ncyIgcHJhZ21hCiAgLSBvcGVuIGhhcyBvbmx5IHR3byBhcmd1bWVudHM7IGVn
LiBgb3BlbiBGSCwgIjwkZmlsZSJgIHJhdGhlcgogICAgdGhhbiBgb3BlbiBGSCwgJzwnLCAkZmls
ZWAKICAtIHJlcGxhY2UgIm91ciIgd2l0aCAibXkiIGluIHRoZSBkZWNsYXJhdGlvbiBvZiBnbG9i
YWwgKHBhY2thZ2UpCiAgICB2YXJpYWJsZXMuCiAgLSByZXBsYWNlIHRoZSB1c2Ugb2Ygc29tZSBp
bmRpcmVjdCBmaWxlLWhhbmRsZXMgd2l0aCByZWd1bGFyCiAgICBmaWxlLWhhbmRsZXMuCgpOb3Rl
IHRoYXQgb25seSB0aG9zZSBwZXJsIHNjcmlwdHMgd2hpY2ggYXJlIGV4ZXJjaXNlZCBieSB0aGUg
dGVzdApzdWl0ZSBvciB0aGF0IEkgaGF2ZSBjYWxsZWQgZGlyZWN0bHkgaGF2ZSBiZWVuIG1vZGlm
aWVkLgoKU2lnbmVkLW9mZi1ieTogUmFtc2F5IEFsbGFuIEpvbmVzIDxyYW1zYXlAcmFtc2F5MS5k
ZW1vbi5jby51az4KLS0tCiBEb2N1bWVudGF0aW9uL2J1aWxkLWRvY2RlcC5wZXJsIHwgICAgMiAr
LQogZ2l0LWFubm90YXRlLnBlcmwgICAgICAgICAgICAgICB8ICAgMjUgKysrKysrKysrKysrLS0t
LS0tLS0tLS0tLQogZ2l0LWNsb25lLnNoICAgICAgICAgICAgICAgICAgICB8ICAgIDYgKysrLS0t
CiBnaXQtbXYucGVybCAgICAgICAgICAgICAgICAgICAgIHwgICAgNCArKy0tCiBnaXQtc2VuZC1l
bWFpbC5wZXJsICAgICAgICAgICAgIHwgICAyNyArKysrKysrKysrKysrLS0tLS0tLS0tLS0tLS0K
IGdpdC1zaG9ydGxvZy5wZXJsICAgICAgICAgICAgICAgfCAgICAyICstCiA2IGZpbGVzIGNoYW5n
ZWQsIDMyIGluc2VydGlvbnMoKyksIDM0IGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL0RvY3Vt
ZW50YXRpb24vYnVpbGQtZG9jZGVwLnBlcmwgYi9Eb2N1bWVudGF0aW9uL2J1aWxkLWRvY2RlcC5w
ZXJsCmluZGV4IDQ4OTM4OWMuLmNkNDBmNTYgMTAwNzU1Ci0tLSBhL0RvY3VtZW50YXRpb24vYnVp
bGQtZG9jZGVwLnBlcmwKKysrIGIvRG9jdW1lbnRhdGlvbi9idWlsZC1kb2NkZXAucGVybApAQCAt
NCw3ICs0LDcgQEAgbXkgJWluY2x1ZGUgPSAoKTsKIG15ICVpbmNsdWRlZCA9ICgpOwogCiBmb3Ig
bXkgJHRleHQgKDwqLnR4dD4pIHsKLSAgICBvcGVuIEksICc8JywgJHRleHQgfHwgZGllICJjYW5u
b3QgcmVhZDogJHRleHQiOworICAgIG9wZW4gSSwgIjwkdGV4dCIgfHwgZGllICJjYW5ub3QgcmVh
ZDogJHRleHQiOwogICAgIHdoaWxlICg8ST4pIHsKIAlpZiAoL15pbmNsdWRlOjovKSB7CiAJICAg
IGNob21wOwpkaWZmIC0tZ2l0IGEvZ2l0LWFubm90YXRlLnBlcmwgYi9naXQtYW5ub3RhdGUucGVy
bAppbmRleCBhNmE3YTQ4Li42MjlmNDgwIDEwMDc1NQotLS0gYS9naXQtYW5ub3RhdGUucGVybAor
KysgYi9naXQtYW5ub3RhdGUucGVybApAQCAtNiw3ICs2LDcgQEAgIwogIyBUaGlzIGZpbGUgaXMg
bGljZW5zZWQgdW5kZXIgdGhlIEdQTCB2Miwgb3IgYSBsYXRlciB2ZXJzaW9uCiAjIGF0IHRoZSBk
aXNjcmV0aW9uIG9mIExpbnVzIFRvcnZhbGRzLgogCi11c2Ugd2FybmluZ3M7CisjdXNlIHdhcm5p
bmdzOwogdXNlIHN0cmljdDsKIHVzZSBHZXRvcHQ6Okxvbmc7CiB1c2UgUE9TSVggcXcoc3RyZnRp
bWUgZ210aW1lKTsKQEAgLTI5LDcgKzI5LDcgQEAgc3ViIHVzYWdlKCkgewogCWV4aXQoMSk7CiB9
CiAKLW91ciAoJGhlbHAsICRsb25ncmV2LCAkcmVuYW1lLCAkcmF3dGltZSwgJHN0YXJ0aW5nX3Jl
diwgJHJldl9maWxlKSA9ICgwLCAwLCAxKTsKK215ICgkaGVscCwgJGxvbmdyZXYsICRyZW5hbWUs
ICRyYXd0aW1lLCAkc3RhcnRpbmdfcmV2LCAkcmV2X2ZpbGUpID0gKDAsIDAsIDEpOwogCiBteSAk
cmMgPSBHZXRPcHRpb25zKAkibG9uZ3xsIiA9PiBcJGxvbmdyZXYsCiAJCQkidGltZXx0IiA9PiBc
JHJhd3RpbWUsCkBAIC01MiwxMiArNTIsMTIgQEAgbXkgQHN0YWNrID0gKAogCX0sCiApOwogCi1v
dXIgQGZpbGVsaW5lcyA9ICgpOworbXkgQGZpbGVsaW5lcyA9ICgpOwogCiBpZiAoZGVmaW5lZCAk
c3RhcnRpbmdfcmV2KSB7CiAJQGZpbGVsaW5lcyA9IGdpdF9jYXRfZmlsZSgkc3RhcnRpbmdfcmV2
LCAkZmlsZW5hbWUpOwogfSBlbHNlIHsKLQlvcGVuKEYsIjwiLCRmaWxlbmFtZSkKKwlvcGVuKEYs
IjwkZmlsZW5hbWUiKQogCQlvciBkaWUgIkZhaWxlZCB0byBvcGVuIGZpbGVuYW1lOiAkISI7CiAK
IAl3aGlsZSg8Rj4pIHsKQEAgLTY4LDkgKzY4LDkgQEAgaWYgKGRlZmluZWQgJHN0YXJ0aW5nX3Jl
dikgewogCiB9CiAKLW91ciAlcmV2czsKLW91ciBAcmV2cXVldWU7Ci1vdXIgJGhlYWQ7CitteSAl
cmV2czsKK215IEByZXZxdWV1ZTsKK215ICRoZWFkOwogCiBteSAkcmV2c3Byb2Nlc3NlZCA9IDA7
CiB3aGlsZSAobXkgJGJvdW5kID0gcG9wIEBzdGFjaykgewpAQCAtNDM2LDE0ICs0MzYsMTMgQEAg
c3ViIGZvcm1hdF9kYXRlIHsKICMgQ29waWVkIGZyb20gZ2l0LXNlbmQtZW1haWwucGVybCAtIFdl
IG5lZWQgYSBHaXQucG0gbW9kdWxlLi4KIHN1YiBnaXR2YXIgewogICAgIG15ICgkdmFyKSA9IEBf
OwotICAgIG15ICRmaDsKLSAgICBteSAkcGlkID0gb3BlbigkZmgsICctfCcpOworICAgIG15ICRw
aWQgPSBvcGVuKEZILCAnLXwnKTsKICAgICBkaWUgIiQhIiB1bmxlc3MgZGVmaW5lZCAkcGlkOwog
ICAgIGlmICghJHBpZCkgewogCWV4ZWMoJ2dpdC12YXInLCAkdmFyKSBvciBkaWUgIiQhIjsKICAg
ICB9Ci0gICAgbXkgKCR2YWwpID0gPCRmaD47Ci0gICAgY2xvc2UgJGZoIG9yIGRpZSAiJCEiOwor
ICAgIG15ICgkdmFsKSA9IDxGSD47CisgICAgY2xvc2UgRkggb3IgZGllICIkISI7CiAgICAgY2hv
bXAoJHZhbCk7CiAgICAgcmV0dXJuICR2YWw7CiB9CkBAIC00NzEsNyArNDcwLDcgQEAgc3ViIG9w
ZW5fcGlwZV9hY3RpdmVzdGF0ZSB7CiBzdWIgb3Blbl9waXBlX25vcm1hbCB7CiAJbXkgKEBleGVj
bGlzdCkgPSBAXzsKIAotCW15ICRwaWQgPSBvcGVuIG15ICRraWQsICItfCI7CisJbXkgJHBpZCA9
IG9wZW4gS0lELCAiLXwiOwogCWRlZmluZWQgJHBpZCBvciBkaWUgIkNhbm5vdCBmb3JrOiAkISI7
CiAKIAl1bmxlc3MgKCRwaWQpIHsKQEAgLTQ3OSw3ICs0NzgsNyBAQCBzdWIgb3Blbl9waXBlX25v
cm1hbCB7CiAJCWRpZSAiQ2Fubm90IGV4ZWMgQGV4ZWNsaXN0OiAkISI7CiAJfQogCi0JcmV0dXJu
ICRraWQ7CisJcmV0dXJuICpLSUQ7CiB9CiAKIHBhY2thZ2UgR2l0OjpBY3RpdmVTdGF0ZVBpcGU7
CmRpZmYgLS1naXQgYS9naXQtY2xvbmUuc2ggYi9naXQtY2xvbmUuc2gKaW5kZXggNDdiZDhlNy4u
NDMwYzg5MiAxMDA3NTUKLS0tIGEvZ2l0LWNsb25lLnNoCisrKyBiL2dpdC1jbG9uZS5zaApAQCAt
NzEsMTcgKzcxLDE3IEBAIHN1YiBzdG9yZSB7CiAJbXkgKCRzaGExLCAkbmFtZSwgJHRvcCkgPSBA
XzsKIAkkbmFtZSA9ICIkZ2l0X2Rpci9yZWZzLyR0b3AvJG5hbWUiOwogCW1rcGF0aChkaXJuYW1l
KCRuYW1lKSk7Ci0Jb3BlbiBPLCAiPiIsICIkbmFtZSI7CisJb3BlbiBPLCAiPiRuYW1lIjsKIAlw
cmludCBPICIkc2hhMVxuIjsKIAljbG9zZSBPOwogfQogCi1vcGVuIEZILCAiPCIsICIkZ2l0X2Rp
ci9DTE9ORV9IRUFEIjsKK29wZW4gRkgsICI8JGdpdF9kaXIvQ0xPTkVfSEVBRCI7CiB3aGlsZSAo
PEZIPikgewogCW15ICgkc2hhMSwgJG5hbWUpID0gL14oWzAtOWEtZl17NDB9KVxzKC4qKSQvOwog
CW5leHQgaWYgKCRuYW1lID1+IC9cXlwxNzMvKTsKIAlpZiAoJG5hbWUgZXEgIkhFQUQiKSB7Ci0J
CW9wZW4gTywgIj4iLCAiJGdpdF9kaXIvUkVNT1RFX0hFQUQiOworCQlvcGVuIE8sICI+JGdpdF9k
aXIvUkVNT1RFX0hFQUQiOwogCQlwcmludCBPICIkc2hhMVxuIjsKIAkJY2xvc2UgTzsKIAkJbmV4
dDsKZGlmZiAtLWdpdCBhL2dpdC1tdi5wZXJsIGIvZ2l0LW12LnBlcmwKaW5kZXggNzVhYThmZS4u
N2FjZWViOCAxMDA3NTUKLS0tIGEvZ2l0LW12LnBlcmwKKysrIGIvZ2l0LW12LnBlcmwKQEAgLTcs
NyArNyw3IEBAICMgVGhpcyBmaWxlIGlzIGxpY2Vuc2VkIHVuZGVyIHRoZSBHUEwgdjIKICMgYXQg
dGhlIGRpc2NyZXRpb24gb2YgTGludXMgVG9ydmFsZHMuCiAKIAotdXNlIHdhcm5pbmdzOworI3Vz
ZSB3YXJuaW5nczsKIHVzZSBzdHJpY3Q7CiB1c2UgR2V0b3B0OjpTdGQ7CiAKQEAgLTE5LDcgKzE5
LDcgQEAgRU9UCiAJZXhpdCgxKTsKIH0KIAotb3VyICgkb3B0X24sICRvcHRfZiwgJG9wdF9oLCAk
b3B0X2ssICRvcHRfdik7CitteSAoJG9wdF9uLCAkb3B0X2YsICRvcHRfaCwgJG9wdF9rLCAkb3B0
X3YpOwogZ2V0b3B0cygiaG5ma3YiKSB8fCB1c2FnZTsKIHVzYWdlKCkgaWYgJG9wdF9oOwogQEFS
R1YgPj0gMSBvciB1c2FnZTsKZGlmZiAtLWdpdCBhL2dpdC1zZW5kLWVtYWlsLnBlcmwgYi9naXQt
c2VuZC1lbWFpbC5wZXJsCmluZGV4IGM1ZDllNzMuLmU2NzBmMjggMTAwNzU1Ci0tLSBhL2dpdC1z
ZW5kLWVtYWlsLnBlcmwKKysrIGIvZ2l0LXNlbmQtZW1haWwucGVybApAQCAtMTcsNyArMTcsNyBA
QCAjICAgIGFuZCBzZWNvbmQgbGluZSBpcyB0aGUgc3ViamVjdCBvZiB0CiAjCiAKIHVzZSBzdHJp
Y3Q7Ci11c2Ugd2FybmluZ3M7CisjdXNlIHdhcm5pbmdzOwogdXNlIFRlcm06OlJlYWRMaW5lOwog
dXNlIEdldG9wdDo6TG9uZzsKIHVzZSBEYXRhOjpEdW1wZXI7CkBAIC04MywxNCArODMsMTMgQEAg
IyBOb3csIGxldCdzIGZpbGwgYW55IHRoYXQgYXJlbid0IHNldCBpbgogCiBzdWIgZ2l0dmFyIHsK
ICAgICBteSAoJHZhcikgPSBAXzsKLSAgICBteSAkZmg7Ci0gICAgbXkgJHBpZCA9IG9wZW4oJGZo
LCAnLXwnKTsKKyAgICBteSAkcGlkID0gb3BlbihGSCwgJy18Jyk7CiAgICAgZGllICIkISIgdW5s
ZXNzIGRlZmluZWQgJHBpZDsKICAgICBpZiAoISRwaWQpIHsKIAlleGVjKCdnaXQtdmFyJywgJHZh
cikgb3IgZGllICIkISI7CiAgICAgfQotICAgIG15ICgkdmFsKSA9IDwkZmg+OwotICAgIGNsb3Nl
ICRmaCBvciBkaWUgIiQhIjsKKyAgICBteSAoJHZhbCkgPSA8Rkg+OworICAgIGNsb3NlIEZIIG9y
IGRpZSAiJCEiOwogICAgIGNob21wKCR2YWwpOwogICAgIHJldHVybiAkdmFsOwogfQpAQCAtMTM0
LDcgKzEzMyw3IEBAIG15ICVwYXJzZV9hbGlhcyA9ICgKIAogaWYgKEBhbGlhc19maWxlcyAmJiBk
ZWZpbmVkICRwYXJzZV9hbGlhc3skYWxpYXNmaWxldHlwZX0pIHsKIAlmb3JlYWNoIG15ICRmaWxl
IChAYWxpYXNfZmlsZXMpIHsKLQkJb3BlbiBteSAkZmgsICc8JywgJGZpbGUgb3IgZGllICJvcGVu
aW5nICRmaWxlOiAkIVxuIjsKKwkJb3BlbiBteSAkZmgsICI8JGZpbGUiIG9yIGRpZSAib3Blbmlu
ZyAkZmlsZTogJCFcbiI7CiAJCSRwYXJzZV9hbGlhc3skYWxpYXNmaWxldHlwZX0tPigkZmgpOwog
CQljbG9zZSAkZmg7CiAJfQpAQCAtMjA5LDcgKzIwOCw3IEBAIGlmICghJHNtdHBfc2VydmVyKSB7
CiBpZiAoJGNvbXBvc2UpIHsKIAkjIE5vdGUgdGhhdCB0aGlzIGRvZXMgbm90IG5lZWQgdG8gYmUg
c2VjdXJlLCBidXQgd2Ugd2lsbCBtYWtlIGEgc21hbGwKIAkjIGVmZm9ydCB0byBoYXZlIGl0IGJl
IHVuaXF1ZQotCW9wZW4oQywiPiIsJGNvbXBvc2VfZmlsZW5hbWUpCisJb3BlbihDLCI+JGNvbXBv
c2VfZmlsZW5hbWUiKQogCQlvciBkaWUgIkZhaWxlZCB0byBvcGVuIGZvciB3cml0aW5nICRjb21w
b3NlX2ZpbGVuYW1lOiAkISI7CiAJcHJpbnQgQyAiRnJvbSAkZnJvbSAjIFRoaXMgbGluZSBpcyBp
Z25vcmVkLlxuIjsKIAlwcmludGYgQyAiU3ViamVjdDogJXNcblxuIiwgJGluaXRpYWxfc3ViamVj
dDsKQEAgLTIyNiwxMCArMjI1LDEwIEBAIEVPVAogCSRlZGl0b3IgPSAndmknIHVubGVzcyBkZWZp
bmVkICRlZGl0b3I7CiAJc3lzdGVtKCRlZGl0b3IsICRjb21wb3NlX2ZpbGVuYW1lKTsKIAotCW9w
ZW4oQzIsIj4iLCRjb21wb3NlX2ZpbGVuYW1lIC4gIi5maW5hbCIpCisJb3BlbihDMiwiPiRjb21w
b3NlX2ZpbGVuYW1lIiAuICIuZmluYWwiKQogCQlvciBkaWUgIkZhaWxlZCB0byBvcGVuICRjb21w
b3NlX2ZpbGVuYW1lLmZpbmFsIDogIiAuICQhOwogCi0Jb3BlbihDLCI8IiwkY29tcG9zZV9maWxl
bmFtZSkKKwlvcGVuKEMsIjwkY29tcG9zZV9maWxlbmFtZSIpCiAJCW9yIGRpZSAiRmFpbGVkIHRv
IG9wZW4gJGNvbXBvc2VfZmlsZW5hbWUgOiAiIC4gJCE7CiAKIAl3aGlsZSg8Qz4pIHsKQEAgLTMy
Miw3ICszMjEsNyBAQCBFT1QKIH0KIAogIyBWYXJpYWJsZXMgd2Ugc2V0IGFzIHBhcnQgb2YgdGhl
IGxvb3Agb3ZlciBmaWxlcwotb3VyICgkbWVzc2FnZV9pZCwgJGNjLCAlbWFpbCwgJHN1YmplY3Qs
ICRyZXBseV90bywgJHJlZmVyZW5jZXMsICRtZXNzYWdlKTsKK215ICgkbWVzc2FnZV9pZCwgJGNj
LCAlbWFpbCwgJHN1YmplY3QsICRyZXBseV90bywgJHJlZmVyZW5jZXMsICRtZXNzYWdlKTsKIAog
c3ViIGV4dHJhY3RfdmFsaWRfYWRkcmVzcyB7CiAJbXkgJGFkZHJlc3MgPSBzaGlmdDsKQEAgLTM5
NiwxNSArMzk1LDE1IEBAIFgtTWFpbGVyOiBnaXQtc2VuZC1lbWFpbCAkZ2l0dmVyc2lvbgogCX0K
IAogCWlmICgkc210cF9zZXJ2ZXIgPX4gbSNeLyMpIHsKLQkJbXkgJHBpZCA9IG9wZW4gbXkgJHNt
LCAnfC0nOworCQlteSAkcGlkID0gb3BlbiBTTSwgJ3wtJzsKIAkJZGVmaW5lZCAkcGlkIG9yIGRp
ZSAkITsKIAkJaWYgKCEkcGlkKSB7CiAJCQlleGVjKCRzbXRwX3NlcnZlciwnLWknLAogCQkJICAg
ICBtYXAgeyBleHRyYWN0X3ZhbGlkX2FkZHJlc3MoJF8pIH0KIAkJCSAgICAgQHJlY2lwaWVudHMp
IG9yIGRpZSAkITsKIAkJfQotCQlwcmludCAkc20gIiRoZWFkZXJcbiRtZXNzYWdlIjsKLQkJY2xv
c2UgJHNtIG9yIGRpZSAkPzsKKwkJcHJpbnQgU00gIiRoZWFkZXJcbiRtZXNzYWdlIjsKKwkJY2xv
c2UgU00gb3IgZGllICQ/OwogCX0gZWxzZSB7CiAJCXJlcXVpcmUgTmV0OjpTTVRQOwogCQkkc210
cCB8fD0gTmV0OjpTTVRQLT5uZXcoICRzbXRwX3NlcnZlciApOwpAQCAtNDQwLDcgKzQzOSw3IEBA
IG1ha2VfbWVzc2FnZV9pZCgpOwogJHN1YmplY3QgPSAkaW5pdGlhbF9zdWJqZWN0OwogCiBmb3Jl
YWNoIG15ICR0IChAZmlsZXMpIHsKLQlvcGVuKEYsIjwiLCR0KSBvciBkaWUgImNhbid0IG9wZW4g
ZmlsZSAkdCI7CisJb3BlbihGLCI8JHQiKSBvciBkaWUgImNhbid0IG9wZW4gZmlsZSAkdCI7CiAK
IAlteSAkYXV0aG9yX25vdF9zZW5kZXIgPSB1bmRlZjsKIAlAY2MgPSBAaW5pdGlhbF9jYzsKZGlm
ZiAtLWdpdCBhL2dpdC1zaG9ydGxvZy5wZXJsIGIvZ2l0LXNob3J0bG9nLnBlcmwKaW5kZXggMGIx
NGY4My4uNTc2MDRkZCAxMDA3NTUKLS0tIGEvZ2l0LXNob3J0bG9nLnBlcmwKKysrIGIvZ2l0LXNo
b3J0bG9nLnBlcmwKQEAgLTEyOCw3ICsxMjgsNyBAQCBzdWIgc2V0dXBfbWFpbG1hcCB7CiAJcmVh
ZF9tYWlsbWFwKFwqREFUQSwgXCVtYWlsbWFwKTsKIAlpZiAoLWYgJy5tYWlsbWFwJykgewogCQlt
eSAkZmggPSB1bmRlZjsKLQkJb3BlbiAkZmgsICc8JywgJy5tYWlsbWFwJzsKKwkJb3BlbiAkZmgs
ICc8Lm1haWxtYXAnOwogCQlyZWFkX21haWxtYXAoJGZoLCBcJW1haWxtYXApOwogCQljbG9zZSAk
Zmg7CiAJfQotLSAKMS40LjEKCg==

------=_NextPart_000_00C7_01C6B5D7.E56A8FC0--
