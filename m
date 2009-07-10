From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH 1/3] gitweb: Mark boundary commits in 'blame' view
Date: Fri, 10 Jul 2009 23:55:44 +0200
Message-ID: <200907102355.44364.jnareb@gmail.com>
References: <200907102354.43232.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 11 00:01:52 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MPOAA-0003QR-QD
	for gcvg-git-2@gmane.org; Sat, 11 Jul 2009 00:01:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757355AbZGJWBp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 Jul 2009 18:01:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757343AbZGJWBn
	(ORCPT <rfc822;git-outgoing>); Fri, 10 Jul 2009 18:01:43 -0400
Received: from ey-out-1920.google.com ([74.125.78.150]:32669 "EHLO
	ey-out-1920.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757334AbZGJWBl (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Jul 2009 18:01:41 -0400
Received: by ey-out-1920.google.com with SMTP id 3so238072eyh.36
        for <git@vger.kernel.org>; Fri, 10 Jul 2009 15:01:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=rzoyg5Ez8N6Ae7F9Aovvr2MIQpOTThiz/S0mau1n76s=;
        b=nrm8hU6m8YW24NT6Y5s7l3MxeKDBg3h9OngoKDantAmZhOlEijNPp6G/8oCXyqTx0R
         sDZG2P7afjzl6jPLQyPz/JYyKbJ9Uru+8eWc7aGJY4ZGlS1ItGL0AncxGM3Vtjlj61CI
         jjHwBsqxNANCRRkaWiu25i2HZfdLZvSSPpFAg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:references:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :message-id;
        b=YczF1A4x3EUkvxfts2YBdwkDHeJNq+iWBRgEh2w9XDc7cULEbJIsbUDNEiDxFVbCmz
         OH18d9b++Ec5epmkCfAVztqhXjQPqlDmdJYCOFFxD7U4IgB3kPfp+J8GUF3ZCnERh5D9
         Nq/WQOoEH9ahGLfFXaO6Mwcj3LkXSTakDqaZw=
Received: by 10.210.102.12 with SMTP id z12mr2989790ebb.5.1247263299518;
        Fri, 10 Jul 2009 15:01:39 -0700 (PDT)
Received: from ?192.168.1.13? (abwp104.neoplus.adsl.tpnet.pl [83.8.239.104])
        by mx.google.com with ESMTPS id 7sm1977058eyg.59.2009.07.10.15.01.38
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 10 Jul 2009 15:01:39 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <200907102354.43232.jnareb@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123086>

Use "boundary" class to mark boundary commits, which currently results
in using bold weight font for SHA-1 of a commit (to be more exact for
all text in the cell that contains SHA-1 of a commit).

Detecting boundary commits is done by watching for "boundary" header
in "git blame -p" output.  Because this header doesn't carry
additional data the regular expression for blame header fields had to
be adjusted.

With current gitweb API only root (parentless) commits can be boundary
commits.

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
Formatting (styling) of boundary commits is currently very minimal.
I'd like to see what other possible solution would you like to have.

Bikeshedding open!

 gitweb/gitweb.css  |    4 ++++
 gitweb/gitweb.perl |    6 ++++--
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/gitweb/gitweb.css b/gitweb/gitweb.css
index d05bc37..5e2f629 100644
--- a/gitweb/gitweb.css
+++ b/gitweb/gitweb.css
@@ -242,6 +242,10 @@ tr.dark:hover {
 	background-color: #edece6;
 }
 
+tr.boundary td.sha1 {
+	font-weight: bold;
+}
+
 td {
 	padding: 2px 5px;
 	font-size: 100%;
diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 6a1b5b5..fe73c2c 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -4826,7 +4826,7 @@ HTML
 		while ($data = <$fd>) {
 			chomp $data;
 			last if ($data =~ s/^\t//); # contents of line
-			if ($data =~ /^(\S+) (.*)$/) {
+			if ($data =~ /^(\S+)(?: (.*))?$/) {
 				$meta->{$1} = $2;
 			}
 		}
@@ -4838,7 +4838,9 @@ HTML
 		if ($group_size) {
 			$current_color = ($current_color + 1) % $num_colors;
 		}
-		print "<tr id=\"l$lineno\" class=\"$rev_color[$current_color]\">\n";
+		my $tr_class = $rev_color[$current_color];
+		$tr_class .= ' boundary' if (exists $meta->{'boundary'});
+		print "<tr id=\"l$lineno\" class=\"$tr_class\">\n";
 		if ($group_size) {
 			print "<td class=\"sha1\"";
 			print " title=\"". esc_html($author) . ", $date\"";
-- 
1.6.3.3
