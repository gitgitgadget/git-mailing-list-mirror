From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] gitweb: handle non UTF-8 text
Date: Sun, 3 Jun 2007 17:42:44 +0200
Message-ID: <200706031742.45216.jnareb@gmail.com>
References: <1180385254576-git-send-email-mkoegler@auto.tuwien.ac.at> <200706012305.41183.jnareb@gmail.com> <7vvee6nguh.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Martin Koegler <mkoegler@auto.tuwien.ac.at>,
	Petr Baudis <pasky@suse.cz>, git@vger.kernel.org,
	Martin Langhoff <martin@catalyst.net.nz>,
	Martyn Smith <martyn@catalyst.net.nz>,
	Robin Rosenberg <robin.rosenberg.lists@dewire.com>,
	Alexandre Julliard <julliard@winehq.org>
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sun Jun 03 20:01:43 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HuuOY-0006NC-PW
	for gcvg-git@gmane.org; Sun, 03 Jun 2007 20:01:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750811AbXFCSBa (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 3 Jun 2007 14:01:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750816AbXFCSBa
	(ORCPT <rfc822;git-outgoing>); Sun, 3 Jun 2007 14:01:30 -0400
Received: from ug-out-1314.google.com ([66.249.92.169]:47854 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750811AbXFCSB3 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Jun 2007 14:01:29 -0400
Received: by ug-out-1314.google.com with SMTP id j3so572530ugf
        for <git@vger.kernel.org>; Sun, 03 Jun 2007 11:01:28 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-disposition:message-id:content-type:content-transfer-encoding;
        b=ceObTsE5r4o97ptBpDUbkIM9ifrbKcKIj3FlWcf0jjfBUKx0NCXGPmTiVSD/GKeKnYKHUVHhbF7P7nLBriFgamn/HTq1liLfLO8Jp5/irwN0G9pZLgbfQeSOxuYL0Y/VndcFsUTIDp0tSTNCKKww4bRwi/F3R/lkOMtXJmHyxH8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-disposition:message-id:content-type:content-transfer-encoding;
        b=gkrW2iPKObK3Yg/z+usOk22dXzKcp20stHlKHx/qcV9zQyVXZy3rHDGoo2iBrfFs1KBAFxStdPMkoqjIGZUYeEwJNAdbKVmbTP4Exn6YfgzHKABQh9NP6z8tBda+cdsgRHFDrTPe+LrwL4/PAhlKCRYmqub3pqtnovCKACHuSp8=
Received: by 10.66.220.12 with SMTP id s12mr2495951ugg.1180893688430;
        Sun, 03 Jun 2007 11:01:28 -0700 (PDT)
Received: from host-89-229-25-173.torun.mm.pl ( [89.229.25.173])
        by mx.google.com with ESMTP id k57sm914863uga.2007.06.03.11.01.21;
        Sun, 03 Jun 2007 11:01:26 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <7vvee6nguh.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49017>

Alexandre, I hope that the patch attached would solve your problem.

Junio C Hamano wrote:
> Jakub Narebski <jnareb@gmail.com> writes:
> 
>> On Tue, 29 May 2007, Martin Koegler wrote:
>> ...
>>> But I agree, that there should be the possibilty to choose the
>>> fallback encoding.
>>
>> I think for the beginning it would be enough to have
>>
>>   # assume this charset if line contains non-UTF-8 characters
>>   our $fallback_encoding = "latin1";

Added this, with more elaborate comment, just before %feature hash.

>> or something like that (perhaps different wording in the comment,
>> perhaps different name of the variable) in the gitweb.perl for your
>> idea to be accepted.
>>
>> That, and using to_utf8 (as before e3ad95a8) and not my_decode_utf8
>> as subroutine name. If only it would be possible to avoid I think
>> quote costly "eval {....}" invocation...
> 
> Except that I had an impression that block form of "eval" (as
> opposed to "parse and evaluate string" kind) was not costly at
> all.

I have checked the time it took to run the gitweb test (t9500),
and the time to run (user+sys) increased about 1% after this patch,
which is even within range of error I think.
 
> Please make it so.

I have changed the name from my_decode_utf8 to the name used for thin
wrapper before commit e3ad95a8 "gitweb: use decode_utf8 directly", namely
to_utf8, and put it in the place where old to_utf8 subroutine was.

Instead of bit hackish "return $res || decode('latin1', $str);" use
"if (defined $res) { ... } else { ... }"; it avoids calling decode()
unnecessary for '' and '0' strings, which are also false, but do not mean
that decode_utf8 failed.

It uses explicit constant names, Encode::FB_CROAK instead of 1, and
Encode::FB_DEFAULT instead of default undef/0.

It adds very, very basic test: it does check _only_ if there are any
errors or warning which would go to web server log; it does not check
if the output is correct. It uses helper files from other i18n tests.

Added comments.


Still the main change is by Martin Koegler and he should be author of
this commit, I think. I have added S-o-b: by me.

-- >8 --
From: Martin Koegler <mkoegler@auto.tuwien.ac.at>
Subject: [PATCH] gitweb: Handle non UTF-8 text better

gitweb assumes that everything is in UTF-8. If a text contains invalid
UTF-8 character sequences, the text must be in a different encoding.

This commit introduces $fallback_encoding which would be used as input
encoding if gitweb encounters text with is not valid UTF-8.

Add basic test for this in t/t9500-gitweb-standalone-no-errors.sh

Signed-off-by: Martin Koegler <mkoegler@auto.tuwien.ac.at>
Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
 gitweb/gitweb.perl                     |   41 ++++++++++++++++++++++++-------
 t/t9500-gitweb-standalone-no-errors.sh |   28 +++++++++++++++++++++
 2 files changed, 59 insertions(+), 10 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index c3921cb..e92596c 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -94,6 +94,13 @@ our $default_text_plain_charset  = undef;
 # (relative to the current git repository)
 our $mimetypes_file = undef;
 
+# assume this charset if line contains non-UTF-8 characters;
+# it should be valid encoding (see Encoding::Supported(3pm) for list),
+# for which encoding all byte sequences are valid, for example
+# 'iso-8859-1' aka 'latin1' (it is decoded without checking, so it
+# could be even 'utf-8' for the old behavior)
+our $fallback_encoding = 'latin1';
+
 # You define site-wide feature defaults here; override them with
 # $GITWEB_CONFIG as necessary.
 our %feature = (
@@ -602,6 +609,20 @@ sub validate_refname {
 	return $input;
 }
 
+# decode sequences of octets in utf8 into Perl's internal form,
+# which is utf-8 with utf8 flag set if needed.  gitweb writes out
+# in utf-8 thanks to "binmode STDOUT, ':utf8'" at beginning
+sub to_utf8 {
+	my $str = shift;
+	my $res;
+	eval { $res = decode_utf8($str, Encode::FB_CROAK); };
+	if (defined $res) {
+		return $res;
+	} else {
+		return decode($fallback_encoding, $str, Encode::FB_DEFAULT);
+	}
+}
+
 # quote unsafe chars, but keep the slash, even when it's not
 # correct, but quoted slashes look too horrible in bookmarks
 sub esc_param {
@@ -626,7 +647,7 @@ sub esc_html ($;%) {
 	my $str = shift;
 	my %opts = @_;
 
-	$str = decode_utf8($str);
+	$str = to_utf8($str);
 	$str = $cgi->escapeHTML($str);
 	if ($opts{'-nbsp'}) {
 		$str =~ s/ /&nbsp;/g;
@@ -640,7 +661,7 @@ sub esc_path {
 	my $str = shift;
 	my %opts = @_;
 
-	$str = decode_utf8($str);
+	$str = to_utf8($str);
 	$str = $cgi->escapeHTML($str);
 	if ($opts{'-nbsp'}) {
 		$str =~ s/ /&nbsp;/g;
@@ -925,7 +946,7 @@ sub format_subject_html {
 
 	if (length($short) < length($long)) {
 		return $cgi->a({-href => $href, -class => "list subject",
-		                -title => decode_utf8($long)},
+		                -title => to_utf8($long)},
 		       esc_html($short) . $extra);
 	} else {
 		return $cgi->a({-href => $href, -class => "list subject"},
@@ -1239,7 +1260,7 @@ sub git_get_projects_list {
 			if (check_export_ok("$projectroot/$path")) {
 				my $pr = {
 					path => $path,
-					owner => decode_utf8($owner),
+					owner => to_utf8($owner),
 				};
 				push @list, $pr;
 				(my $forks_path = $path) =~ s/\.git$//;
@@ -1269,7 +1290,7 @@ sub git_get_project_owner {
 			$pr = unescape($pr);
 			$ow = unescape($ow);
 			if ($pr eq $project) {
-				$owner = decode_utf8($ow);
+				$owner = to_utf8($ow);
 				last;
 			}
 		}
@@ -1759,7 +1780,7 @@ sub get_file_owner {
 	}
 	my $owner = $gcos;
 	$owner =~ s/[,;].*$//;
-	return decode_utf8($owner);
+	return to_utf8($owner);
 }
 
 ## ......................................................................
@@ -1842,7 +1863,7 @@ sub git_header_html {
 
 	my $title = "$site_name";
 	if (defined $project) {
-		$title .= " - " . decode_utf8($project);
+		$title .= " - " . to_utf8($project);
 		if (defined $action) {
 			$title .= "/$action";
 			if (defined $file_name) {
@@ -2116,7 +2137,7 @@ sub git_print_page_path {
 
 	print "<div class=\"page_path\">";
 	print $cgi->a({-href => href(action=>"tree", hash_base=>$hb),
-	              -title => 'tree root'}, decode_utf8("[$project]"));
+	              -title => 'tree root'}, to_utf8("[$project]"));
 	print " / ";
 	if (defined $name) {
 		my @dirname = split '/', $name;
@@ -2936,7 +2957,7 @@ sub git_project_list_body {
 		($pr->{'age'}, $pr->{'age_string'}) = @aa;
 		if (!defined $pr->{'descr'}) {
 			my $descr = git_get_project_description($pr->{'path'}) || "";
-			$pr->{'descr_long'} = decode_utf8($descr);
+			$pr->{'descr_long'} = to_utf8($descr);
 			$pr->{'descr'} = chop_str($descr, 25, 5);
 		}
 		if (!defined $pr->{'owner'}) {
@@ -3981,7 +4002,7 @@ sub git_snapshot {
 	my $git = git_cmd_str();
 	my $name = $project;
 	$name =~ s/\047/\047\\\047\047/g;
-	my $filename = decode_utf8(basename($project));
+	my $filename = to_utf8(basename($project));
 	my $cmd;
 	if ($suffix eq 'zip') {
 		$filename .= "-$hash.$suffix";
diff --git a/t/t9500-gitweb-standalone-no-errors.sh b/t/t9500-gitweb-standalone-no-errors.sh
index b92ab63..44ae503 100755
--- a/t/t9500-gitweb-standalone-no-errors.sh
+++ b/t/t9500-gitweb-standalone-no-errors.sh
@@ -487,4 +487,32 @@ test_expect_success \
 	'gitweb_run "p=.git;a=atom"'
 test_debug 'cat gitweb.log'
 
+# ----------------------------------------------------------------------
+# encoding/decoding
+
+test_expect_success \
+	'encode(commit): utf8' \
+	'. ../t3901-utf8.txt &&
+	 echo "UTF-8" >> file &&
+	 git add file &&
+	 git commit -F ../t3900/1-UTF-8.txt &&
+	 gitweb_run "p=.git;a=commit"'
+test_debug 'cat gitweb.log'
+
+test_expect_success \
+	'encode(commit): iso-8859-1' \
+	'. ../t3901-8859-1.txt &&
+	 echo "ISO-8859-1" >> file &&
+	 git add file &&
+	 git config i18n.commitencoding ISO-8859-1 &&
+	 git commit -F ../t3900/ISO-8859-1.txt &&
+	 git config --unset i18n.commitencoding &&
+	 gitweb_run "p=.git;a=commit"'
+test_debug 'cat gitweb.log'
+
+test_expect_success \
+	'encode(log): utf-8 and iso-8859-1' \
+	'gitweb_run "p=.git;a=log"'
+test_debug 'cat gitweb.log'
+
 test_done
-- 
1.5.2
