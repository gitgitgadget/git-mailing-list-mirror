From: Lea Wiemann <lewiemann@gmail.com>
Subject: [PATCH v3] perl/Git.pm: add parse_rev method
Date: Sun,  1 Jun 2008 05:17:22 +0200
Message-ID: <1212290243-19393-1-git-send-email-LeWiemann@gmail.com>
References: <1212241932-28605-1-git-send-email-LeWiemann@gmail.com>
Cc: Lea Wiemann <LeWiemann@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 01 05:18:03 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K2e55-000593-BB
	for gcvg-git-2@gmane.org; Sun, 01 Jun 2008 05:18:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754875AbYFADRJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 31 May 2008 23:17:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755284AbYFADRJ
	(ORCPT <rfc822;git-outgoing>); Sat, 31 May 2008 23:17:09 -0400
Received: from fg-out-1718.google.com ([72.14.220.156]:37296 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753658AbYFADRH (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 31 May 2008 23:17:07 -0400
Received: by fg-out-1718.google.com with SMTP id 19so426589fgg.17
        for <git@vger.kernel.org>; Sat, 31 May 2008 20:17:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:to:cc:subject:date:message-id:x-mailer:in-reply-to:references:from;
        bh=PlDqEFxZ4zi1lcyARTqgNwrWaLi3PVIEVmZzveec8i4=;
        b=fb07FwtGn2DWe6Dk6tlyqlsPKFPPx6bzeuJfEuBk3OzBdN1O/EyFHdsIBIWF7DGhPDPvUeJjoPONutBicwc4l2INebKsJKxzXK9RRlua9rKSUyx7Zi5SAJGuRhHgMkVt2BH3LsvRT3VuwMUb2j2ohZG6E6O6I+C9ashI71Hk03k=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=to:cc:subject:date:message-id:x-mailer:in-reply-to:references:from;
        b=fpVBm63sk36CRxiMCzSttBlbq/kDiz5pNLByw4EbZ5xLVmWopEs5f8mcN/hw2TSgjt3s2KLjLEs2lnE39umWWbakxnlNLKRa1Ghi1XRGAr9IvE1wxYoD6U8kmXGPQVVSjrK3AapqtoLEmTB7K4NzsIyCQetr1lR8UrEV0h+/ES8=
Received: by 10.86.77.5 with SMTP id z5mr388769fga.13.1212290224346;
        Sat, 31 May 2008 20:17:04 -0700 (PDT)
Received: from fly ( [91.33.240.119])
        by mx.google.com with ESMTPS id d4sm1868770fga.8.2008.05.31.20.17.03
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 31 May 2008 20:17:03 -0700 (PDT)
Received: from lea by fly with local (Exim 4.69)
	(envelope-from <LeWiemann@gmail.com>)
	id 1K2e4R-00054e-EV; Sun, 01 Jun 2008 05:17:23 +0200
X-Mailer: git-send-email 1.5.5.GIT
In-Reply-To: <1212241932-28605-1-git-send-email-LeWiemann@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83423>

The parse_rev method takes a revision name and returns a SHA1 hash,
like the git-rev-parse command.

Signed-off-by: Lea Wiemann <LeWiemann@gmail.com>
---
Changes since PATCH v2: Updated the documentation (found this while
testing).  Here's the diff excerpt from v2 to v3:

 =item parse_rev ( REVISION_NAME )

 Look up the specified revision name and return the SHA1 hash, or
-return undef if the lookup failed.  See git rev-parse --help, section
-"Specifying Revisions".
+return undef if the lookup failed.  When passed a SHA1 hash, always
+return it even if it doesn't exist in the repository.
+
+See git rev-parse --help, section "Specifying Revisions", for valid
+revision name formats.

 perl/Git.pm |   41 +++++++++++++++++++++++++++++++++++++++++
 1 files changed, 41 insertions(+), 0 deletions(-)

diff --git a/perl/Git.pm b/perl/Git.pm
index d05b633..80f7669 100644
--- a/perl/Git.pm
+++ b/perl/Git.pm
@@ -716,6 +716,47 @@ sub ident_person {
 	return "$ident[0] <$ident[1]>";
 }
 
+=item parse_rev ( REVISION_NAME )
+
+Look up the specified revision name and return the SHA1 hash, or
+return undef if the lookup failed.  When passed a SHA1 hash, always
+return it even if it doesn't exist in the repository.
+
+See git rev-parse --help, section "Specifying Revisions", for valid
+revision name formats.
+
+=cut
+
+sub parse_rev {
+	# We could allow for a list of revisions here.
+	my ($self, $rev_name) = @_;
+
+	my $hash;
+	try {
+		# The --quiet --verify options cause git-rev-parse to fail
+		# with exit status 1 (instead of 128) if the given revision
+		# name is not found, which enables us to distinguish not-found
+		# from serious errors.  The --default option works around
+		# git-rev-parse's lack of support for getopt style "--"
+		# separators (it would fail for tags named "--foo" without
+		# it).
+		$hash = $self->command_oneline("rev-parse", "--verify", "--quiet",
+					       "--default", $rev_name);
+	} catch Git::Error::Command with {
+		my $E = shift;
+		if ($E->value() == 1) {
+			# Revision name not found.
+			$hash = undef;
+		} else {
+			throw $E;
+		}
+	};
+	# Guard against unexpected output.
+	throw Error::Simple(
+		"parse_rev: unexpected output for \"$rev_name\": $hash")
+	    if defined $hash and $hash !~ /^([0-9a-fA-F]{40})$/;
+	return $hash;
+}
 
 =item hash_object ( TYPE, FILENAME )
 
-- 
1.5.5.GIT
