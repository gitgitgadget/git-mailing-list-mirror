From: David Aguilar <davvid@gmail.com>
Subject: [PATCH] difftool: use perl built-ins when testing for msys
Date: Tue, 24 Mar 2009 23:13:53 -0700
Message-ID: <1237961633-29082-1-git-send-email-davvid@gmail.com>
Cc: git@vger.kernel.org, David Aguilar <davvid@gmail.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Wed Mar 25 07:14:52 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LmMNz-0001p4-Iy
	for gcvg-git-2@gmane.org; Wed, 25 Mar 2009 07:14:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753661AbZCYGNQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Mar 2009 02:13:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753578AbZCYGNQ
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Mar 2009 02:13:16 -0400
Received: from rv-out-0506.google.com ([209.85.198.230]:35780 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753531AbZCYGNP (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Mar 2009 02:13:15 -0400
Received: by rv-out-0506.google.com with SMTP id f9so2681532rvb.1
        for <git@vger.kernel.org>; Tue, 24 Mar 2009 23:13:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=e4NtXQk2LAcEg1/RW1Yd6KXao1HM5t1sokWQBJqLRIE=;
        b=M3m2PwNc5Jh91RDseVIRDGKU/XS1ZwazQTNX+nqi7suHZb5HJtdFVp0blNzGfATcR8
         Gsk1if0gHXKccMfL758La6nUZzQJMS1TMt3RqoC9XYxcUH4tbJuPcyTfy55W7Pzij9aa
         4QRsgFtfAedHIVPbwybjC3UKha9Zsw9L+Vyz0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=Ciy8bIO1zuLmeSjvAjbNTnYmoij0o+u6m9SuOCz0WoYZhDuwbOccVcugLIvKn5Ulkz
         kpPk8KM/8lVOL0ZNKUaRTlTnTBnuDyewWaU0wo5BOtWr+cfHrWIrrKKuvyKHLMBzrWqG
         GVLyrgdVVdE5ctr+TyWHYKBMloEuz8pzsyxIQ=
Received: by 10.114.103.1 with SMTP id a1mr6213143wac.218.1237961593731;
        Tue, 24 Mar 2009 23:13:13 -0700 (PDT)
Received: from localhost (208-106-56-2.static.dsltransport.net [208.106.56.2])
        by mx.google.com with ESMTPS id v32sm7156196wah.17.2009.03.24.23.13.11
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 24 Mar 2009 23:13:12 -0700 (PDT)
X-Mailer: git-send-email 1.6.2.1.303.g63699
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114564>

I don't even know what $COMSPEC means so let's be safe and use the
same perly $^O test add--interactive uses.  While we're at it, make
git-difftool match the prevalent git-perl style.

Signed-off-by: David Aguilar <davvid@gmail.com>
---
 git-difftool.perl |    7 +++++--
 1 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/git-difftool.perl b/git-difftool.perl
index 0deda3a..207dd50 100755
--- a/git-difftool.perl
+++ b/git-difftool.perl
@@ -33,7 +33,10 @@ sub setup_environment
 sub exe
 {
 	my $exe = shift;
-	return defined $ENV{COMSPEC} ? "$exe.exe" : $exe;
+	if ($^O eq 'MSWin32' || $^O eq 'msys') {
+		return "$exe.exe";
+	}
+	return $exe;
 }
 
 sub generate_command
@@ -47,7 +50,7 @@ sub generate_command
 			$skip_next = 0;
 			next;
 		}
-		if ($arg eq '-t' or $arg eq '--tool') {
+		if ($arg eq '-t' || $arg eq '--tool') {
 			usage() if $#ARGV <= $idx;
 			$ENV{GIT_DIFF_TOOL} = $ARGV[$idx + 1];
 			$skip_next = 1;
-- 
1.6.2.1.303.g63699
