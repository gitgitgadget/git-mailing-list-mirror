From: Lea Wiemann <lewiemann@gmail.com>
Subject: [PATCH v4] perl/Git.pm: add get_hash method
Date: Mon,  2 Jun 2008 01:09:44 +0200
Message-ID: <1212361784-20409-1-git-send-email-LeWiemann@gmail.com>
References: <1212290243-19393-2-git-send-email-LeWiemann@gmail.com>
Cc: Lea Wiemann <LeWiemann@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 02 01:11:15 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K2whm-0004CF-TS
	for gcvg-git-2@gmane.org; Mon, 02 Jun 2008 01:11:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753772AbYFAXJu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 1 Jun 2008 19:09:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752498AbYFAXJu
	(ORCPT <rfc822;git-outgoing>); Sun, 1 Jun 2008 19:09:50 -0400
Received: from fg-out-1718.google.com ([72.14.220.159]:28627 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752487AbYFAXJt (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 1 Jun 2008 19:09:49 -0400
Received: by fg-out-1718.google.com with SMTP id 19so594841fgg.17
        for <git@vger.kernel.org>; Sun, 01 Jun 2008 16:09:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:to:cc:subject:date:message-id:x-mailer:in-reply-to:references:from;
        bh=W5On5kSiGKWYfEtEWj/6FURGl5n3GR4Wsu4qSk8Z6aE=;
        b=YVcDFNq85SRJWaGMZ32iRqyofQQqiXZW9f66aAA3cRlDWIzs57DJWRjbb6mo7n/JvnCYSlasByraTCBrQrx8z0mLbClZBMkY4VYRJr9t06WGPDRsq/Wewco/u80kgOX3UFkBNqo7uaHUg8EwDd23zD6xuipzeN3Iq8OJuMla+cs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=to:cc:subject:date:message-id:x-mailer:in-reply-to:references:from;
        b=WEMTH7GzbJX0vWpcKa44254Y2sF6pRnNo99pwEJsgzCyc3s3BxQ8C/O4872P+8iu4wUfWjrpbWnYp7vHVS7TNCaER16xXEWEf34YO3Z77pWTof2fj9k1xf6XBOzxxHphTJtT7zijzglLq+/0bH9hfPclSFaH0fGfQsn4lB9DLe0=
Received: by 10.86.82.6 with SMTP id f6mr432592fgb.73.1212361787704;
        Sun, 01 Jun 2008 16:09:47 -0700 (PDT)
Received: from fly ( [91.33.205.25])
        by mx.google.com with ESMTPS id l19sm3373933fgb.7.2008.06.01.16.09.45
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 01 Jun 2008 16:09:45 -0700 (PDT)
Received: from lea by fly with local (Exim 4.69)
	(envelope-from <LeWiemann@gmail.com>)
	id 1K2wgK-0005KA-3K; Mon, 02 Jun 2008 01:09:44 +0200
X-Mailer: git-send-email 1.5.5.GIT
In-Reply-To: <1212290243-19393-2-git-send-email-LeWiemann@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83477>

The get_hash method takes a "revision" (as described in git-rev-parse
--help) and returns the SHA1 hash of the commit, tree, file, or tag
object it refers to.

Signed-off-by: Lea Wiemann <LeWiemann@gmail.com>
---
Changes since v3: Renamed parse_rev to get_hash, improved
documentation to point out that the parameter can refer to file, tree
and tag object as well, and added example in "Synopsis" section.

 perl/Git.pm |   45 +++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 45 insertions(+), 0 deletions(-)

diff --git a/perl/Git.pm b/perl/Git.pm
index 97e61ef..f2e9e29 100644
--- a/perl/Git.pm
+++ b/perl/Git.pm
@@ -43,6 +43,9 @@ $VERSION = '0.01';
   my $tempfile = tempfile();
   my $size = $repo->cat_blob($sha1, $tempfile);
 
+  my $head_commit_sha1 = $repo->get_hash('HEAD');  # see git-rev-parse --help
+  my $file_blob_sha1   = $repo->get_hash('HEAD:path/file.txt');
+
 =cut
 
 
@@ -716,6 +719,48 @@ sub ident_person {
 	return "$ident[0] <$ident[1]>";
 }
 
+=item get_hash ( REVISION )
+
+Look up the object referred to by C<REVISION> and return its SHA1
+hash, or return undef if the lookup failed.  When passed a SHA1 hash,
+always return it even if it doesn't exist in the repository.
+
+Note that C<REVISION> can refer to a commit, file, tree, or tag
+object!  See git rev-parse --help, section "Specifying Revisions", for
+valid formats of the C<REVISION> parameter.
+
+=cut
+
+sub get_hash {
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
+		"get_hash: unexpected output for \"$rev_name\": $hash")
+	    if defined $hash and $hash !~ /^([0-9a-fA-F]{40})$/;
+	return $hash;
+}
 
 =item hash_object ( TYPE, FILENAME )
 
-- 
1.5.5.GIT
