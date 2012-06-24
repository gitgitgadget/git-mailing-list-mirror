From: Marcin Owsiany <marcin@owsiany.pl>
Subject: [PATCH/RFC] git-svn: don't create master if another head exists
Date: Sun, 24 Jun 2012 23:08:35 +0100
Message-ID: <20120624220835.GA4762@beczulka>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Eric Wong <normalperson@yhbt.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 25 00:09:22 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Siuzf-00043j-EI
	for gcvg-git-2@plane.gmane.org; Mon, 25 Jun 2012 00:09:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753800Ab2FXWIl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Jun 2012 18:08:41 -0400
Received: from mail-we0-f174.google.com ([74.125.82.174]:61805 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753340Ab2FXWIk (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Jun 2012 18:08:40 -0400
Received: by weyu7 with SMTP id u7so2388081wey.19
        for <git@vger.kernel.org>; Sun, 24 Jun 2012 15:08:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=date:from:to:cc:subject:message-id:mime-version:content-type
         :content-disposition:user-agent:x-gm-message-state;
        bh=lQ5fpVEEGYBCQgZwD3bg0eTityKHxUPcr+vQHA0Eapc=;
        b=bCeCV4SfhHPsurUiA20idtbXdnhlygNgnlawV4cyUp2Sc0gg3xlpxwtRdPSVsoRxU4
         oo0+eS97FebB/4mXXM3pFNXieXhPgIk8v/QQz5Of5ZfqN3c1MVrJnxYp6KQm9/kRvsZx
         VOVz8+AhiBP9shv6pqOPajc6BihMMVMDsmFNxzxnN5ZVnW8mK0KgnKG2B6BU6/QHv4Dz
         mqqThEror4W7LQw4uEkgk0DAHNC/nMPOIRUmF2Y4LAqAIMgOmpiOdPYFI/BUsoozUy++
         K8AvrXT+zrpuN6pNoVskXmGcjmQm9dQzdJn+bXmj0p328wdx3x6IljnTmWrYzeyz16Sz
         zlqQ==
Received: by 10.180.81.65 with SMTP id y1mr19817720wix.1.1340575719318;
        Sun, 24 Jun 2012 15:08:39 -0700 (PDT)
Received: from beczulka ([89.100.125.149])
        by mx.google.com with ESMTPS id eu4sm5829335wib.2.2012.06.24.15.08.37
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 24 Jun 2012 15:08:38 -0700 (PDT)
Received: from mowsiany by beczulka with local (Exim 4.71)
	(envelope-from <marcin@owsiany.pl>)
	id 1Siuyx-0006cg-O5; Sun, 24 Jun 2012 23:08:35 +0100
Content-Disposition: inline
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Gm-Message-State: ALoCoQlnCM2+9bqDw7OIiAPF49ioUTjEPRNnCfxgCGql/mWUrw4DKauBGnB7LNz43w21lCXHSDQO
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200541>

git-svn insists on creating the "master" head (unless it exists) on every
"fetch". While it is useful that it gets created initially (users expect this
git convention), some users find it annoying that it gets recreated, especially
when they would like the git branch names to follow SVN repository branch
names. More background in
http://thread.gmane.org/gmane.comp.version-control.git/115030

Make git-svn skip the "master" creation if there is another head ref pointing
to the same place. This means "master" does get created on initial "clone" but
does not get recreated once a user deletes it.

Signed-off-by: Marcin Owsiany <marcin@owsiany.pl>
---
 git-svn.perl |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/git-svn.perl b/git-svn.perl
index 0b074c4..90f3d06 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -1613,6 +1613,8 @@ sub post_fetch_checkout {
 	}
 
 	my $valid_head = verify_ref('HEAD^0');
+	my @heads_commits = eval { command(qw(show-ref --heads --hash)) };
+	return if $valid_head and grep { $_ eq $valid_head } @heads_commits;
 	command_noisy(qw(update-ref refs/heads/master), $gs->refname);
 	return if ($valid_head || !verify_ref('HEAD^0'));
 
-- 
1.7.7.3


-- 
Marcin Owsiany <marcin@owsiany.pl>              http://marcin.owsiany.pl/
GnuPG: 2048R/02F946FC  35E9 1344 9F77 5F43 13DD  6423 DBF4 80C6 02F9 46FC

"Every program in development at MIT expands until it can read mail."
                                                              -- Unknown
