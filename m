From: Cord Seele <cowose@googlemail.com>
Subject: [PATCH 1/2] Add Git::config_path()
Date: Fri, 30 Sep 2011 12:52:24 +0200
Message-ID: <1317379945-9355-2-git-send-email-cowose@gmail.com>
References: <vpqty7wk9km.fsf@bauges.imag.fr>
 <1317379945-9355-1-git-send-email-cowose@gmail.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Eric Wong <normalperson@yhbt.net>,
	Cord Seele <cowose@gmail.com>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Fri Sep 30 12:53:22 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R9aiU-0000Gz-Ok
	for gcvg-git-2@lo.gmane.org; Fri, 30 Sep 2011 12:53:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753706Ab1I3KxP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Sep 2011 06:53:15 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:64021 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758218Ab1I3KxO (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Sep 2011 06:53:14 -0400
Received: by mail-fx0-f46.google.com with SMTP id 4so2767989fxe.19
        for <git@vger.kernel.org>; Fri, 30 Sep 2011 03:53:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=cSZSfRyqn9uf9AgmbsBIaxA79ZJhvMcW8cCQfu8k3zs=;
        b=ldJOdWjCIMq0p9e/43/F6/tUEtO/kVarWts/XhFtw4ZqOb9b+/S/q3Evc8ACNaFfuo
         ZRYryFTCVmzWcrUQ6RpBefYAj/6yq6J92DB3ZtpZ3yqkHkbApAA4chg/DwElXFx8NxAQ
         Jq4XVHCFEs1kheduFcaXWk80n02wAKUWFSzM4=
Received: by 10.223.32.140 with SMTP id c12mr6537579fad.9.1317379993423;
        Fri, 30 Sep 2011 03:53:13 -0700 (PDT)
Received: from localhost.localdomain (p4FF1B6BF.dip.t-dialin.net. [79.241.182.191])
        by mx.google.com with ESMTPS id u6sm6209486faf.3.2011.09.30.03.53.12
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 30 Sep 2011 03:53:13 -0700 (PDT)
X-Mailer: git-send-email 1.7.6.4
In-Reply-To: <1317379945-9355-1-git-send-email-cowose@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182479>

Use --path option when calling 'git config' thus allow for pathname
expansion, e.g. a tilde.

Signed-off-by: Cord Seele <cowose@gmail.com>
---
 perl/Git.pm |   32 ++++++++++++++++++++++++++++++++
 1 files changed, 32 insertions(+), 0 deletions(-)

diff --git a/perl/Git.pm b/perl/Git.pm
index a86ab70..c279bfb 100644
--- a/perl/Git.pm
+++ b/perl/Git.pm
@@ -627,6 +627,38 @@ sub config_bool {
 	};
 }
 
+
+=item config_path ( VARIABLE )
+
+Retrieve the path configuration C<VARIABLE>. The return value
+is an expanded path or C<undef> if it's not defined.
+
+This currently wraps command('config') so it is not so fast.
+
+=cut
+
+sub config_path {
+	my ($self, $var) = _maybe_self(@_);
+
+	try {
+		my @cmd = ('config', '--path');
+		unshift @cmd, $self if $self;
+		if (wantarray) {
+			return command(@cmd, '--get-all', $var);
+		} else {
+			return command_oneline(@cmd, '--get', $var);
+		}
+	} catch Git::Error::Command with {
+		my $E = shift;
+		if ($E->value() == 1) {
+			# Key not found.
+			return undef;
+		} else {
+			throw $E;
+		}
+	};
+}
+
 =item config_int ( VARIABLE )
 
 Retrieve the integer configuration C<VARIABLE>. The return value
-- 
1.7.6.4
