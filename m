From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH da/difftool-mergtool-refactor] Makefile: fix permissions of
 mergetools/ checked out with permissive umask
Date: Sun, 9 Oct 2011 04:17:07 -0500
Message-ID: <20111009091617.GA29150@elie.hsd1.il.comcast.net>
References: <1313652227-48545-1-git-send-email-davvid@gmail.com>
 <1313652227-48545-4-git-send-email-davvid@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Tanguy Ortolo <tanguy+debian@ortolo.eu>,
	Charles Bailey <charles@hashpling.org>,
	Sebastian Schuberth <sschuberth@gmail.com>
To: David Aguilar <davvid@gmail.com>
X-From: git-owner@vger.kernel.org Sun Oct 09 11:17:33 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RCpVf-0005dv-Lw
	for gcvg-git-2@lo.gmane.org; Sun, 09 Oct 2011 11:17:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752072Ab1JIJRW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Oct 2011 05:17:22 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:42171 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752046Ab1JIJRV (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Oct 2011 05:17:21 -0400
Received: by iakk32 with SMTP id k32so6165121iak.19
        for <git@vger.kernel.org>; Sun, 09 Oct 2011 02:17:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=XP5ZnK7V03nrRKT8SxXEkGGlHKTa9OeHHNp3qT5Jh8E=;
        b=tX6Oilvph/TXj6ZUj3FksmDCrN0h3+Yg3nhiz0tIJeChsHmCskbQwEdMLpAp9UCx7x
         7wI75CDLRBl2HXp+vWsRBx6zOIWvBIWsIGatum22lBiBELcvrUYg6tOvcwk6byr5h6Lw
         IBnOhr5Q8BCc37H2QsZB2A7NZclnfXkDb3474=
Received: by 10.231.6.102 with SMTP id 38mr248188iby.62.1318151840628;
        Sun, 09 Oct 2011 02:17:20 -0700 (PDT)
Received: from elie.hsd1.il.comcast.net (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id g16sm36531247ibs.8.2011.10.09.02.17.18
        (version=SSLv3 cipher=OTHER);
        Sun, 09 Oct 2011 02:17:20 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1313652227-48545-4-git-send-email-davvid@gmail.com>
User-Agent: Mutt/1.5.21+46 (b01d63af6fea) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183191>

Ever since mergetool--lib was split into multiple files in
v1.7.7-rc0~3^2~1 (2011-08-18), the Makefile takes care to reset umask
and use tar --no-owner when installing merge tool definitions to
$(gitexecdir)/mergetools/.  Unfortunately it does not take into
account the possibility that the permission bits of the files being
copied might already be wrong.

Rather than fixing the "tar" incantation and making it even more
complicated, let's just use the "install" utility.  This only means
losing the ability to install executables and subdirectories of
mergetools/, which wasn't used.

Noticed by installing from a copy of git checked out with umask 002.
Compare v1.6.0.3~81^2 (Fix permission bits on sources checked out with
an overtight umask, 2008-08-21).

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
David Aguilar wrote:

> +++ b/Makefile
[...]
> @@ -2266,6 +2274,9 @@ install: all
>  	$(INSTALL) -m 644 $(SCRIPT_LIB) '$(DESTDIR_SQ)$(gitexec_instdir_SQ)'
>  	$(INSTALL) $(install_bindir_programs) '$(DESTDIR_SQ)$(bindir_SQ)'
>  	$(MAKE) -C templates DESTDIR='$(DESTDIR_SQ)' install
> +	$(INSTALL) -d -m 755 '$(DESTDIR_SQ)$(mergetools_instdir_SQ)'
> +	(cd mergetools && $(TAR) cf - .) | \
> +	(cd '$(DESTDIR_SQ)$(mergetools_instdir_SQ)' && umask 022 && $(TAR) xof -)

Last month I tried this out and found that, strangely, my files under
/usr/lib/git-core/mergetools/ had the g+w bit set.  Leading me to
wonder: does the "umask" here have any effect at all?

Since debian/rules install is run as root, the default is for tar to
act as thought --preserve-permissions were passed, so the umask when
running "tar" is not relevant.  Luckily I think "tar" is overkill
here, anyway.

Thoughts?  Sorry to have taken so long to send this out.

 Makefile |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/Makefile b/Makefile
index 1e91b19c..e27755e7 100644
--- a/Makefile
+++ b/Makefile
@@ -2275,8 +2275,7 @@ install: all
 	$(INSTALL) $(install_bindir_programs) '$(DESTDIR_SQ)$(bindir_SQ)'
 	$(MAKE) -C templates DESTDIR='$(DESTDIR_SQ)' install
 	$(INSTALL) -d -m 755 '$(DESTDIR_SQ)$(mergetools_instdir_SQ)'
-	(cd mergetools && $(TAR) cf - .) | \
-	(cd '$(DESTDIR_SQ)$(mergetools_instdir_SQ)' && umask 022 && $(TAR) xof -)
+	$(INSTALL) -m 644 mergetools/* '$(DESTDIR_SQ)$(mergetools_instdir_SQ)'
 ifndef NO_PERL
 	$(MAKE) -C perl prefix='$(prefix_SQ)' DESTDIR='$(DESTDIR_SQ)' install
 	$(MAKE) -C gitweb install
-- 
1.7.7.rc1
