From: Alexander Kuleshov <kuleshovmail@gmail.com>
Subject: [PATCH] git-add--interactive: return from list_and_choose if there is zero candidates
Date: Thu, 22 Jan 2015 14:39:44 +0600
Message-ID: <1421915984-31207-1-git-send-email-kuleshovmail@gmail.com>
Cc: git@vger.kernel.org, Alexander Kuleshov <kuleshovmail@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jan 22 09:40:04 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YEDJ4-0006Dl-J7
	for gcvg-git-2@plane.gmane.org; Thu, 22 Jan 2015 09:40:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753434AbbAVIj5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Jan 2015 03:39:57 -0500
Received: from mail-lb0-f176.google.com ([209.85.217.176]:65007 "EHLO
	mail-lb0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751236AbbAVIjy (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Jan 2015 03:39:54 -0500
Received: by mail-lb0-f176.google.com with SMTP id z12so298364lbi.7
        for <git@vger.kernel.org>; Thu, 22 Jan 2015 00:39:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=epvT17MYkUcsP/O+fsWCxVyxEyc/9wH9PzzHzJ4CLDE=;
        b=QWovULF9p0FDadzI/0opPs68kmdSSIC+cwRZowhaRXmEV5sc0TwVtzJ6Zoxjr6Ly6j
         7+HLjsoKH4KWT0bzBwQRswEOXHyuYcmSMwyjcegUNJgPgA9izgSz3g64kXgiL6iN5XMq
         iLnxPx5dv66ZbtGHGjIIpxFWFzKGLTJ0qXeDF11FLXKuNr9WVu+nGsfPBMjmBm65ck42
         FwmLhFTxR/KXDyZwfvRvmPohYoCfOoae9psA8E/Sp+lmZ8hJeT5FM99v2WJA6Y2hX5mJ
         1VIvy5REzXWSacbaC1zwWX+eh4PVeidI7oS4viXZjlZcfvBGWvMBF3XXId9zAHYtxU95
         lgfg==
X-Received: by 10.112.132.2 with SMTP id oq2mr244048lbb.11.1421915992579;
        Thu, 22 Jan 2015 00:39:52 -0800 (PST)
Received: from localhost.localdomain ([5.251.234.181])
        by mx.google.com with ESMTPSA id f4sm818156lam.30.2015.01.22.00.39.50
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 22 Jan 2015 00:39:51 -0800 (PST)
X-Mailer: git-send-email 2.3.0.rc1.247.gb53aa6f.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262810>

This patch introduce the check in list_and_choose() routine for the list. If
list is empty just return.

It can be useful for example if user selects 'add untracked' and there are no
untracked files, "Add untracked>>" opens. But it does not make sense in this
case, because there are no untracked files.

Signed-off-by: Alexander Kuleshov <kuleshovmail@gmail.com>
---
 git-add--interactive.perl | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/git-add--interactive.perl b/git-add--interactive.perl
index 94b988c..85b2fe7 100755
--- a/git-add--interactive.perl
+++ b/git-add--interactive.perl
@@ -519,6 +519,9 @@ sub error_msg {
 sub list_and_choose {
 	my ($opts, @stuff) = @_;
 	my (@chosen, @return);
+	if (!@stuff) {
+	    return @return;
+	}
 	my $i;
 	my @prefixes = find_unique_prefixes(@stuff) unless $opts->{LIST_ONLY};
 
@@ -729,6 +732,8 @@ sub add_untracked_cmd {
 	if (@add) {
 		system(qw(git update-index --add --), @add);
 		say_n_paths('added', @add);
+	} else {
+		print "No untracked files.\n";
 	}
 	print "\n";
 }
-- 
2.3.0.rc1.247.gb53aa6f.dirty
