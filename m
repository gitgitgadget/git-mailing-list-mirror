From: Erik Faye-Lund <kusmabite@googlemail.com>
Subject: [PATCH 2/3] git-svn: support fetch with autocrlf on
Date: Wed,  3 Mar 2010 21:10:22 +0100
Message-ID: <1267647023-2604-2-git-send-email-kusmabite@gmail.com>
References: <1267647023-2604-1-git-send-email-kusmabite@gmail.com>
Cc: normalperson@yhbt.net, dpotapov@gmail.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 03 21:11:33 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nmuup-0004RU-9D
	for gcvg-git-2@lo.gmane.org; Wed, 03 Mar 2010 21:11:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756523Ab0CCULY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Mar 2010 15:11:24 -0500
Received: from mail-ew0-f220.google.com ([209.85.219.220]:59172 "EHLO
	mail-ew0-f220.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756513Ab0CCULX (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Mar 2010 15:11:23 -0500
Received: by ewy20 with SMTP id 20so1265376ewy.21
        for <git@vger.kernel.org>; Wed, 03 Mar 2010 12:11:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=rOL5WiNj/aJA1JSb6o0xh62cSAZ8rQ+zqisxXMUinBY=;
        b=GDLd2iyGwMKddfTcd7o2JVmc44J0KjEAD21G2i3PHYt1iPUYfaTTuPVcr7kbfkSIVu
         3F4+fS5pqAwIJu7Wbk43+xG9fa7cfoHg81bYT4dDFomiYUaHujZ0gdD11y2M/IC0iiZ6
         cTnnrrOrUUmxuZl2AuH+SkswsI+VCWLZTXyPo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=ve6y2Ldr6zDM5A8m0oNzpYBxgi8NTOM9izWPfbIWrlr8eXmKXJPyzgEQNNGNFuN16a
         fDG0bSYYE3yS94V02U3IBKLkI/z/5oOpc2zaSCMrl98numaXZCdXuXfMKoOIUR5VC91L
         wVd8dJmKVsbJv5vVC5QlPAh5CLK+P/vy0JuEw=
Received: by 10.213.42.198 with SMTP id t6mr6296657ebe.38.1267647080539;
        Wed, 03 Mar 2010 12:11:20 -0800 (PST)
Received: from localhost (cm-84.215.188.225.getinternet.no [84.215.188.225])
        by mx.google.com with ESMTPS id 16sm3986276ewy.15.2010.03.03.12.11.16
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 03 Mar 2010 12:11:16 -0800 (PST)
X-Mailer: git-send-email 1.7.0.1.141.gc5984a
In-Reply-To: <1267647023-2604-1-git-send-email-kusmabite@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141469>

Before commit d3c9634e, performing a "git svn rebase" that fetched a
change containing CRLFs corrupted the git-svn meta-data. This was
worked around in d3c9634e by setting core.autocrlf to "false" in the
per-repo config when initing the clone. However, if the config
variable was later changed, the corruption would still occur.

This patch tries to fix it while allowing core.autocrlf to be
enabled, by disabling filters when when hashing.

git-svn is currently the only call-site for hash_and_insert_object
(apart from the test-suite), so changing it should be safe.

Signed-off-by: Erik Faye-Lund <kusmabite@gmail.com>
---
 perl/Git.pm |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/perl/Git.pm b/perl/Git.pm
index 970fe43..1926dc9 100644
--- a/perl/Git.pm
+++ b/perl/Git.pm
@@ -842,7 +842,7 @@ sub _open_hash_and_insert_object_if_needed {
 
 	($self->{hash_object_pid}, $self->{hash_object_in},
 	 $self->{hash_object_out}, $self->{hash_object_ctx}) =
-		command_bidi_pipe(qw(hash-object -w --stdin-paths));
+		command_bidi_pipe(qw(hash-object -w --stdin-paths --no-filters));
 }
 
 sub _close_hash_and_insert_object {
-- 
1.7.0.1.141.gc5984a
