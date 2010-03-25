From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 2/2] builtins: setup repository before print unknown command error
Date: Thu, 25 Mar 2010 20:38:15 +0700
Message-ID: <1269524295-24569-2-git-send-email-pclouds@gmail.com>
References: <1269524295-24569-1-git-send-email-pclouds@gmail.com>
Cc: Duy Nguyen <pclouds@gmail.com>
To: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Mar 25 20:38:32 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nussw-0004QK-EQ
	for gcvg-git-2@lo.gmane.org; Thu, 25 Mar 2010 20:38:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754560Ab0CYTi1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Mar 2010 15:38:27 -0400
Received: from mail-fx0-f213.google.com ([209.85.220.213]:42284 "EHLO
	mail-fx0-f213.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754356Ab0CYTiY (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Mar 2010 15:38:24 -0400
Received: by fxm5 with SMTP id 5so1367526fxm.29
        for <git@vger.kernel.org>; Thu, 25 Mar 2010 12:38:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references;
        bh=NtQWetWsD6BVC/11IgvyiwCHLlko7J172g91ULED2co=;
        b=VQUKs5xZwopArT+fE1VCLDAnrm2J4KeYIy6RLPU9YZW+HNtWdBgCbWv/QQzjQqx/6X
         N0lLUCmRbvIYTyL3J/H9QGBzmLvPXdIt9adYF2VnpFGsy2ulRQiJAKl6acK21AvihOlL
         PruEu+QmH8mav6oMqqX4vbcqU+YpWLH9dezk0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=llhnUlkbAtwcrETSsePDOTA1SwoRK5fH6LzhrlA4gIWX20pWicRC5oj2q1Q2Df0pvF
         ew4xlbrgQs+DaZO7GhyU6bW5Zjj1Zpq7TH26AGwLXSCQT0yXMFExTWZwfYj9qD98qD8D
         noSQHuB8Uv28vCSaU0VkBbYVpSV16MhKJbHM8=
Received: by 10.223.4.135 with SMTP id 7mr122086far.42.1269545903077;
        Thu, 25 Mar 2010 12:38:23 -0700 (PDT)
Received: from dektop ([212.247.124.209])
        by mx.google.com with ESMTPS id 9sm211829fks.26.2010.03.25.12.38.21
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 25 Mar 2010 12:38:22 -0700 (PDT)
Received: by dektop (sSMTP sendmail emulation); Thu, 25 Mar 2010 20:38:19 +0700
X-Mailer: git-send-email 1.7.0.rc1.541.g2da82.dirty
In-Reply-To: <1269524295-24569-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143195>

From: Duy Nguyen <pclouds@gmail.com>

help_unknown_cmd() will need to look into repository's config, in
order to collect all possible commands/aliases and give a
suggestion. So, repository must be set up before this function is
called.

As it is now, because
 - alias handling will always be done before help_unknown_cmd()
 - alias handling code will search and set up repository if found
 - alias handline code will not undo repository setup

These ensure that repository will always be set up (or attempted to
set up) before help_unknown_cmd(), so there is no issue. But the setup
dependency here is subtle. It may break some day if someone reorders
the loop, for example.

Make the repository setup explicit, to express it clearer, although
this code will never be run (It does not mean the code is not tested,
I removed alias handling code to reproduce the problem, and this code
helped fix it)

Signed-off-by: Duy Nguyen <pclouds@gmail.com>
---
 git.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/git.c b/git.c
index bd1d4bb..d84996c 100644
--- a/git.c
+++ b/git.c
@@ -547,6 +547,10 @@ int main(int argc, const char **argv)
 			exit(1);
 		}
 		if (!done_help) {
+			if (!startup_info->have_run_setup_gitdir) {
+				int nongit_ok;
+				setup_git_directory_gently(&nongit_ok);
+			}
 			cmd = argv[0] = help_unknown_cmd(cmd);
 			done_help = 1;
 		} else
-- 
1.7.0.rc1.541.g2da82.dirty
