From: Lea Wiemann <lewiemann@gmail.com>
Subject: [PATCH] perl/Git.pm: add parse_rev method
Date: Fri, 30 May 2008 22:27:50 +0200
Message-ID: <1212179270-26170-1-git-send-email-LeWiemann@gmail.com>
References: <20080530095047.GD18781@machine.or.cz>
Cc: Lea Wiemann <LeWiemann@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 30 22:29:09 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K2BDL-0002Cx-3x
	for gcvg-git-2@gmane.org; Fri, 30 May 2008 22:28:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753012AbYE3U1t (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 May 2008 16:27:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752465AbYE3U1t
	(ORCPT <rfc822;git-outgoing>); Fri, 30 May 2008 16:27:49 -0400
Received: from fg-out-1718.google.com ([72.14.220.152]:1319 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752653AbYE3U1s (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 May 2008 16:27:48 -0400
Received: by fg-out-1718.google.com with SMTP id 19so190300fgg.17
        for <git@vger.kernel.org>; Fri, 30 May 2008 13:27:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:to:cc:subject:date:message-id:x-mailer:in-reply-to:references:from;
        bh=5JEe1BtG0wrv8X3LPNZR1V8HXo7i2EEgC1dTMpWRmN4=;
        b=tPFKe1CD5a3UuBee9ruAmjIPjMAXq8wSmLus4VqmQADcLCZUURCg6SpqL8k+ukGox4RFI4nhNTil6lZax9LZzG1hMh6BHo7vaPTXYXaONYrMIscQzszWdyDZPJp4CYAO6TBMHDAorL/bYfMHXUtPmbqdLPeM9sSC2U6snFJV8AM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=to:cc:subject:date:message-id:x-mailer:in-reply-to:references:from;
        b=maB/ionfGIoKcGVEW0w8D/oZ/p/MILtbj/tnt5xCkCWcIRBTgpd27JqvOR3wVAHTeuNCNJfYVZI6yzi6CBKWtmz+9D3/YNCtioBeY+xd5h8uYA9Fl0m1xyt0OUqDey9arEGLRIgh91aaYRD8Ild+1mEXr8NzC7iL6BHV6/0zDxE=
Received: by 10.86.28.2 with SMTP id b2mr2064477fgb.78.1212179264623;
        Fri, 30 May 2008 13:27:44 -0700 (PDT)
Received: from fly ( [91.33.213.54])
        by mx.google.com with ESMTPS id 4sm1130614fge.5.2008.05.30.13.27.42
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 30 May 2008 13:27:44 -0700 (PDT)
Received: from lea by fly with local (Exim 4.69)
	(envelope-from <LeWiemann@gmail.com>)
	id 1K2BCY-0006p7-LL; Fri, 30 May 2008 22:27:50 +0200
X-Mailer: git-send-email 1.5.5.GIT
In-Reply-To: <20080530095047.GD18781@machine.or.cz>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83326>

The parse_rev method takes a revision name and returns a SHA1 hash,
like the git-rev-parse command.

Signed-off-by: Lea Wiemann <LeWiemann@gmail.com>
---
Hi Petr,

This patch incorporates all your suggestions.  Thanks for your help on
IRC!

 perl/Git.pm |   38 ++++++++++++++++++++++++++++++++++++++
 1 files changed, 38 insertions(+), 0 deletions(-)

diff --git a/perl/Git.pm b/perl/Git.pm
index d05b633..4bc3604 100644
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
+    # We could allow for a list of revisions here.
+    my ($self, $rev_name) = @_;
+
+    my $hash;
+    try {
+        # The --quiet --verify options cause git-rev-parse to fail
+        # with exit status 1 (instead of 128) if the given revision
+        # name is not found, which enables us to distinguish not-found
+        # from serious errors.  The --default option works around
+        # git-rev-parse's lack of support for getopt style "--"
+        # separators (it would fail for tags named "--foo" without
+        # it).
+        $hash = $self->command_oneline("rev-parse", "--verify", "--quiet",
+                                       "--default", $rev_name);
+    } catch Git::Error::Command with {
+        my $E = shift;
+        if ($E->value() == 1) {
+            # Revision name not found.
+            $hash = undef;
+        } else {
+            throw $E;
+        }
+    };
+    # Guard against unexpected output.
+    throw Error::Simple(
+        "parse_rev: unexpected output for \"$rev_name\": $hash")
+        if defined $hash and $hash !~ /^([0-9a-fA-F]{40})$/;
+    return $hash;
+}
 
 =item hash_object ( TYPE, FILENAME )
 
-- 
1.5.5.GIT
