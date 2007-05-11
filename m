From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH] gitweb: Avoid "Use of uninitialized value" errors (written to logs)
Date: Sat, 12 May 2007 01:35:29 +0200
Message-ID: <200705120135.30150.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 12 02:29:17 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HmfU1-0002MQ-Lb
	for gcvg-git@gmane.org; Sat, 12 May 2007 02:29:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756451AbXELA3K (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 11 May 2007 20:29:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757310AbXELA3J
	(ORCPT <rfc822;git-outgoing>); Fri, 11 May 2007 20:29:09 -0400
Received: from ug-out-1314.google.com ([66.249.92.173]:35392 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756451AbXELA3I (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 May 2007 20:29:08 -0400
Received: by ug-out-1314.google.com with SMTP id 44so919444uga
        for <git@vger.kernel.org>; Fri, 11 May 2007 17:29:06 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=tmGnufKlUenwGTHNLs3bXua/H1ydiJvvjxjNdMlzkWo7Xr0pTEbYQgvmw5R3I3N7kt8sK8c+p3xKeWf1aB8c1K/lv+yQlO/SEL4xV+UQo9eVD4Ye1E81TxK1LaEGY6DO0zpjxXoPMJjHWn5N9fmeXmJtueG3CSjT9UO/AiTTn5A=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=cjGnXcFCW6fRoKBBNnifaWafjZW5Qv43WjOkg0NFhEgkr17bQbkmDWDqP8jqbJbsPSzBqH2aew7gle+SPhLDPDnpWJdaTUcAybZZ5cpzIC2WaLk6/vyRiXi4wammPPmgmujH+x+Uw5MWrjmgEdXWKCG4kWm+lJpe9vGD8l8ZrLM=
Received: by 10.66.243.4 with SMTP id q4mr3185486ugh.1178929213217;
        Fri, 11 May 2007 17:20:13 -0700 (PDT)
Received: from host-89-229-25-173.torun.mm.pl ( [89.229.25.173])
        by mx.google.com with ESMTP id 20sm6928014uga.2007.05.11.17.20.11;
        Fri, 11 May 2007 17:20:11 -0700 (PDT)
User-Agent: KMail/1.9.3
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47000>

Try to avoid "Use of uninitialized value ..." errors, due to bad
revision, incorrect filename, wrong object id, bad file etc. (wrong
value of 'h', 'hb', 'f', etc. parameters). This avoids polluting web
server errors log.

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
This is a bit of "bandaid" patch, as if possible the callers should
be corrected, and should check if there is something to pass along.

 gitweb/gitweb.perl |    6 +++++-
 1 files changed, 5 insertions(+), 1 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 21864c6..afa0056 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -594,6 +594,9 @@ sub esc_html ($;%) {
 	my $str = shift;
 	my %opts = @_;
 
+	# empty or undefined
+	return $str unless $str;
+
 	$str = decode_utf8($str);
 	$str = $cgi->escapeHTML($str);
 	if ($opts{'-nbsp'}) {
@@ -1059,6 +1062,7 @@ sub git_get_hash_by_path {
 		or die_error(undef, "Open git-ls-tree failed");
 	my $line = <$fd>;
 	close $fd or return undef;
+	$line or return undef;
 
 	#'100644 blob 0fa3f3a66fb6a137f6ec2c19351ed4d807070ffa	panic.c'
 	$line =~ m/^([0-9]+) (.+) ([0-9a-fA-F]{40})\t/;
@@ -1377,7 +1381,7 @@ sub parse_commit_text {
 	pop @commit_lines; # Remove '\0'
 
 	my $header = shift @commit_lines;
-	if (!($header =~ m/^[0-9a-fA-F]{40}/)) {
+	if (!defined $header || $header !~ m/^[0-9a-fA-F]{40}/) {
 		return;
 	}
 	($co{'id'}, my @parents) = split ' ', $header;
-- 
1.5.1.3
