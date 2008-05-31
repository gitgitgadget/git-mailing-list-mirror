From: Lea Wiemann <lewiemann@gmail.com>
Subject: [PATCH v2] perl/Git.pm: add parse_rev method
Date: Sat, 31 May 2008 15:52:12 +0200
Message-ID: <1212241932-28605-1-git-send-email-LeWiemann@gmail.com>
References: <1212122585-7350-1-git-send-email-LeWiemann@gmail.com>
Cc: Lea Wiemann <LeWiemann@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 31 15:53:13 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K2RW5-0006K4-Hu
	for gcvg-git-2@gmane.org; Sat, 31 May 2008 15:53:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752624AbYEaNwM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 31 May 2008 09:52:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752564AbYEaNwM
	(ORCPT <rfc822;git-outgoing>); Sat, 31 May 2008 09:52:12 -0400
Received: from fg-out-1718.google.com ([72.14.220.154]:47422 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752553AbYEaNwL (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 31 May 2008 09:52:11 -0400
Received: by fg-out-1718.google.com with SMTP id 19so319607fgg.17
        for <git@vger.kernel.org>; Sat, 31 May 2008 06:52:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:to:cc:subject:date:message-id:x-mailer:in-reply-to:references:from;
        bh=Z24DpAUaFyHc8YtJBCKV/hBKmQU+k+KYUse2U+HGZLc=;
        b=auhm3VsiTJE+zaoTnlDYqAUrnHsnofTufj8osI/MH67l3kbNXOjlYTzZY/Gk/3wn14ZLlNJZsPxNqTXv/g7OwZXFCC6eTSZrEiV0YRR+K3MjE4tRWXWQkNPR+fwJQbJAzWX5irnUOiRH57mlVNmgSz1woOW9w5b51WGVF7FiI+A=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=to:cc:subject:date:message-id:x-mailer:in-reply-to:references:from;
        b=EKzGhFoGC6Bp3crgXSt3a62VeDowQpLdoFnfme+bb+daUBGStZfCKfVyIHsmNIWnbEJv4O32VykZfXASgrMkXeUQ8Jr+tibSoYolEq96082d9mtjljBbqgBoLbUiKRcAsS4rLhDuF1XyTLFrTpiEBhmDZQeBHu+d4hn1/P52s8g=
Received: by 10.86.77.5 with SMTP id z5mr5900452fga.42.1212241929385;
        Sat, 31 May 2008 06:52:09 -0700 (PDT)
Received: from fly ( [91.33.213.54])
        by mx.google.com with ESMTPS id l19sm1617406fgb.7.2008.05.31.06.52.08
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 31 May 2008 06:52:08 -0700 (PDT)
Received: from lea by fly with local (Exim 4.69)
	(envelope-from <LeWiemann@gmail.com>)
	id 1K2RVF-0007Rl-4F; Sat, 31 May 2008 15:52:13 +0200
X-Mailer: git-send-email 1.5.5.GIT
In-Reply-To: <1212122585-7350-1-git-send-email-LeWiemann@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83384>

The parse_rev method takes a revision name and returns a SHA1 hash,
like the git-rev-parse command.

Signed-off-by: Lea Wiemann <LeWiemann@gmail.com>
---
Use tabs instead of blanks to match the rest of the file.  No changes
apart from that.

 perl/Git.pm |   38 ++++++++++++++++++++++++++++++++++++++
 1 files changed, 38 insertions(+), 0 deletions(-)

diff --git a/perl/Git.pm b/perl/Git.pm
index d05b633..249daad 100644
--- a/perl/Git.pm
+++ b/perl/Git.pm
@@ -716,6 +716,44 @@ sub ident_person {
 	return "$ident[0] <$ident[1]>";
 }
 
+=item parse_rev ( REVISION_NAME )
+
+Look up the specified revision name and return the SHA1 hash, or
+return undef if the lookup failed.  See git rev-parse --help, section
+"Specifying Revisions".
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
