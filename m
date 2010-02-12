From: Erik Faye-Lund <kusmabite@googlemail.com>
Subject: [PATCH 2/2] git-svn: support fetch with autocrlf on
Date: Fri, 12 Feb 2010 18:52:35 +0100
Message-ID: <1265997155-3592-2-git-send-email-kusmabite@gmail.com>
References: <1265997155-3592-1-git-send-email-kusmabite@gmail.com>
Cc: johannes.schindelin@gmx.de, normalperson@yhbt.net,
	Erik Faye-Lund <kusmabite@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 12 18:53:55 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NfziC-0007SZ-Sa
	for gcvg-git-2@lo.gmane.org; Fri, 12 Feb 2010 18:53:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757321Ab0BLRxp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Feb 2010 12:53:45 -0500
Received: from mail-ew0-f228.google.com ([209.85.219.228]:50261 "EHLO
	mail-ew0-f228.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753651Ab0BLRxo (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Feb 2010 12:53:44 -0500
Received: by mail-ew0-f228.google.com with SMTP id 28so1639793ewy.28
        for <git@vger.kernel.org>; Fri, 12 Feb 2010 09:53:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=+7uSg6xo6pI9fTxSNYFG86pNeQmJaxL9Ms5xAJ0cpdg=;
        b=aMu7ApnaxvcBYVYfr+2vyblyzThy+B/Ql3/4Vid5ss9hst0g4wxN2ykWSj3my1mUiE
         EbjS6xDr8DeAVS2vJjkrol5KavD6HMdWkKGTMcbx2a1FuoMUAYoeyR4oHsIR1G82UQux
         xXGJSusjko4eP0HwZB6CxNq3RgUjn3ezmVdMk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=us7b2TLc3I/2OszeFNVI2wvs6KDSGYPA2siq7VgNs+JARicTuKDQDWs+kpuXe3FJmt
         7VV0b/koAQVlRT4XOu5DduoviT2qUA/FpVPeMIWna5TEdcY9J5uB6rvcMr+BdbEc+KfG
         QD4eexUax+COtpzjO0IW6zI5KfXuH7aIe0deI=
Received: by 10.213.37.206 with SMTP id y14mr1270825ebd.4.1265997222951;
        Fri, 12 Feb 2010 09:53:42 -0800 (PST)
Received: from localhost ([77.40.159.131])
        by mx.google.com with ESMTPS id 15sm2472318ewy.12.2010.02.12.09.53.41
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 12 Feb 2010 09:53:42 -0800 (PST)
X-Mailer: git-send-email 1.7.0.rc2
In-Reply-To: <1265997155-3592-1-git-send-email-kusmabite@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139735>

If I enable core.autocrlf and perform a "git svn rebase" that fetches
a change containing CRLFs, the git-svn meta-data gets corrupted.

Commit d3c9634e worked around this by setting core.autocrlf to "false"
in the per-repo config when initing the clone. However if the config
variable was changed, the breakage would still occur. This made it
painful to work with git-svn on repos with mostly checked in LFs on
Windows.

This patch tries to fix the same problem while allowing core.autocrlf
to be enabled, by disabling filters when when hashing.

git-svn is currently the only call-site for hash_and_insert_object
(apart from the test-suite), so changing it should be safe.

Signed-off-by: Erik Faye-Lund <kusmabite@gmail.com>
---

With this patch applied, I guess we can also revert d3c9634e. I didn't
do this in this series, because I'm lazy and selfish and thus only
changed the code I needed to get what I wanted to work ;)

I've been running git-svn with these patches with core.autocrlf enabled
since December, and never seen the breakage that I saw before d3c9634e.

 perl/Git.pm |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/perl/Git.pm b/perl/Git.pm
index e8df55d..2378da4 100644
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
1.7.0.rc2
