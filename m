From: Lea Wiemann <lewiemann@gmail.com>
Subject: [PATCH] perl/Git.pm: add rev_parse method
Date: Fri, 30 May 2008 06:43:05 +0200
Message-ID: <1212122585-7350-1-git-send-email-LeWiemann@gmail.com>
Cc: Lea Wiemann <LeWiemann@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 30 06:43:56 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K1wT0-0003wj-O1
	for gcvg-git-2@gmane.org; Fri, 30 May 2008 06:43:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751482AbYE3Em6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 May 2008 00:42:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751339AbYE3Em6
	(ORCPT <rfc822;git-outgoing>); Fri, 30 May 2008 00:42:58 -0400
Received: from fg-out-1718.google.com ([72.14.220.154]:30560 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751266AbYE3Em5 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 May 2008 00:42:57 -0400
Received: by fg-out-1718.google.com with SMTP id 19so31783fgg.17
        for <git@vger.kernel.org>; Thu, 29 May 2008 21:42:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:to:cc:subject:date:message-id:x-mailer:from;
        bh=PbXWTZkI9XoocW0rWh0thsBgVfQIdDYvw7uBnd74LJs=;
        b=aqhS1r7Z9bl8Z5syTiA2PwUjk9Smgcc+O+wlCnbfr0GmdAeI+/5kzBVE5ZSpTvk4kJhuKvmkGwFYRyNupppfGGBtPdELJSaMSlZEzhmxHyxdkf115VSe649mU99YDn8b1NMvzVwESbRjrJkjAUd2VgPfP5HAHkieYcRoXyGu/X0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=to:cc:subject:date:message-id:x-mailer:from;
        b=WNaia07WMGD9szYydQH182RWrjsgC+wlS/9fQpSyTJdZ/4JmgfLUQnrnQ1Enj5+RniNUFiVxlV363ZGlpbbNsnSVPqyPDgRrFOs886WsyAIY7vspAFdhy7kFDcmQPcdWpfeOX4u+qvjFw5YGjYuOFUCZETNY5b2smw6uX5EcUS0=
Received: by 10.86.70.8 with SMTP id s8mr40578fga.31.1212122575938;
        Thu, 29 May 2008 21:42:55 -0700 (PDT)
Received: from fly ( [91.33.225.53])
        by mx.google.com with ESMTPS id p38sm241887fke.17.2008.05.29.21.42.55
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 29 May 2008 21:42:55 -0700 (PDT)
Received: from lea by fly with local (Exim 4.69)
	(envelope-from <LeWiemann@gmail.com>)
	id 1K1wSH-0001uu-9c; Fri, 30 May 2008 06:43:05 +0200
X-Mailer: git-send-email 1.5.5.GIT
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83267>

The rev_parse method translates a revision name to a SHA1 hash, like
the git-rev-parse command.

Signed-off-by: Lea Wiemann <LeWiemann@gmail.com>
---

This is part of my work to extend Git.pm to create a usable
repository access abstraction layer for gitweb.

I've tested this method by calling it with a few parameters, but
there's no test suite yet.  I'll probably send a message to the
mailing list about testing Git.pm soon.

This is my first patch to Git.pm, so please let me know if there is
anything wrong with it!

 perl/Git.pm |   22 ++++++++++++++++++++++
 1 files changed, 22 insertions(+), 0 deletions(-)

diff --git a/perl/Git.pm b/perl/Git.pm
index d05b633..9ef8cb0 100644
--- a/perl/Git.pm
+++ b/perl/Git.pm
@@ -716,6 +716,28 @@ sub ident_person {
 	return "$ident[0] <$ident[1]>";
 }
 
+=item rev_parse ( REVISION_NAME )
+
+Look up the specified revision name and return the SHA1 hash, or
+return undef if the lookup failed.  See the git-rev-parse command.
+
+=cut
+
+sub rev_parse {
+    # We could allow for a list of revisions here.
+    my ($self, $rev_name) = @_;
+
+    my $hash;
+    try {
+        # The --default option works around rev-parse's lack of
+        # support for getopt style "--" separators (it would fail for
+        # tags named "--foo" without it).
+        $hash = $self->command_oneline("rev-parse", "--verify", "--default",
+                                       $rev_name);
+    } catch Git::Error::Command with { };
+    return undef unless defined $hash and $hash =~ /^([0-9a-fA-F]{40})$/;
+    $hash;
+}
 
 =item hash_object ( TYPE, FILENAME )
 
-- 
1.5.5.GIT
