From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: [PATCH] add -p: skip conflicted paths
Date: Wed, 28 Mar 2012 21:18:02 +0200
Message-ID: <1332962282-4040-1-git-send-email-kusmabite@gmail.com>
Cc: gitster@pobox.com, matthieu.moy@grenoble-inp.fr,
	hellmuth@ira.uka.de
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 28 21:18:16 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SCyNr-0007F0-Hy
	for gcvg-git-2@plane.gmane.org; Wed, 28 Mar 2012 21:18:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757585Ab2C1TSK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Mar 2012 15:18:10 -0400
Received: from mail-bk0-f46.google.com ([209.85.214.46]:43687 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755431Ab2C1TSJ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Mar 2012 15:18:09 -0400
Received: by bkcik5 with SMTP id ik5so1272886bkc.19
        for <git@vger.kernel.org>; Wed, 28 Mar 2012 12:18:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=unoEsCVPbeQQvfjgUUaWsf+8DqMyDy7/qq50YO+FaT0=;
        b=cjAfthHrOI8c7fz3cxTYQrFIniHtYDOaozLzNx+85tO1VND/Kgg5iRBB+IydzmeUPa
         1yINolZoztlQharmXjoryED6U+N53+pB+Co0BAPzZssSje0WIgDCpjlEpYsOD3kmf1sO
         T2kTBQPHuI4Jx9N2ui5+SP6XSzFt6TnJifN2kl4KNWCJq+K/eFm1krnNOP8IpLrKuNvS
         StkPYll8YRN3t5zW2MWDeRqDIv2o7AYrcHMI3ixIXg2BtvAoKIxxn5hm1SK/XOwCIBX7
         95DF+nh8/IQTMm8I/kHOUBDYwUrJPAKyR3AWZmkmpjN5gTIKekHhcNNgFC4VtCyHbuj4
         jCQw==
Received: by 10.204.143.151 with SMTP id v23mr12778749bku.63.1332962288141;
        Wed, 28 Mar 2012 12:18:08 -0700 (PDT)
Received: from localhost (cm-84.215.107.111.getinternet.no. [84.215.107.111])
        by mx.google.com with ESMTPS id jr13sm8636871bkb.14.2012.03.28.12.18.05
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 28 Mar 2012 12:18:06 -0700 (PDT)
X-Mailer: git-send-email 1.7.9
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194166>

When performing "git add -p" on a file in a conflicted state, we
currently spew the diff and terminate the process.

This is not very helpful to the user. Change the behaviour to
skipping the file, while outputting a warning.

Signed-off-by: Erik Faye-Lund <kusmabite@gmail.com>
---

OK, here's a quick stab at fixing the "add -p" issue. Note that
I'm not very fluent in Perl, so apologies if this is not up to
standards.

 git-add--interactive.perl |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/git-add--interactive.perl b/git-add--interactive.perl
index 8f0839d..a52507f 100755
--- a/git-add--interactive.perl
+++ b/git-add--interactive.perl
@@ -1259,6 +1259,13 @@ sub patch_update_file {
 	my $quit = 0;
 	my ($ix, $num);
 	my $path = shift;
+
+	# skip conflicted paths
+	if (run_cmd_pipe(qw(git ls-files -u --), $path)) {
+		print colored $error_color, "Warning: $path is in conflicted state, skipping.\n";
+		return 0;
+	}
+
 	my ($head, @hunk) = parse_diff($path);
 	($head, my $mode, my $deletion) = parse_diff_header($head);
 	for (@{$head->{DISPLAY}}) {
-- 
1.7.9
