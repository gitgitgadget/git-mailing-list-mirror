From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 1/3] git-remote-mediawiki: honor DESTDIR in "make install"
Date: Mon, 11 Nov 2013 12:45:29 -0800
Message-ID: <20131111204529.GN10302@google.com>
References: <20131109022239.GI10302@google.com>
 <vpqli0xstcw.fsf@anie.imag.fr>
 <20131111204504.GM10302@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Thorsten Glaser <t.glaser@tarent.de>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Mon Nov 11 21:45:42 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VfyMd-0006gU-KD
	for gcvg-git-2@plane.gmane.org; Mon, 11 Nov 2013 21:45:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753040Ab3KKUpf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Nov 2013 15:45:35 -0500
Received: from mail-pd0-f179.google.com ([209.85.192.179]:51892 "EHLO
	mail-pd0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752171Ab3KKUpd (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Nov 2013 15:45:33 -0500
Received: by mail-pd0-f179.google.com with SMTP id y10so5656917pdj.24
        for <git@vger.kernel.org>; Mon, 11 Nov 2013 12:45:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=i5d/doKtKIPTNNogXlJsTcTaLekLOPfq2kakpzDd+Ow=;
        b=U8lmma3fWqwH8X4n+GOC3MAsfRNJbIH0dDdq+iwUk2Z6PvCKUbaIcjRpYIQvRFOZy2
         piTbn0gmeCd7ErgETFZCN6Pjy7IaBVjl/ppMy3dHW3mdtP46d+HJTHi74tlnbR5mUMFy
         FWBHmMGAn065uRCIkiiCN+wciPfRcWj3K1h5eORz0exNDmNGFCjqnbROJ9H2TUYCQyLH
         KNcqWFawrdjjv1qd4Cd6ue3eA87WKxKkuwXDLGukJwKhT9PFDZJu06nBUP9B+DxIUe4q
         Pnc+ElsKhZ1OLCLYiQ+iUq9GGLcZ6a5asL8BQ3vutnDe7G69njI1ptERgvIjhNlx92EK
         CLFQ==
X-Received: by 10.68.253.129 with SMTP id aa1mr3106422pbd.189.1384202732219;
        Mon, 11 Nov 2013 12:45:32 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id xe9sm38336608pab.0.2013.11.11.12.45.31
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 11 Nov 2013 12:45:31 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20131111204504.GM10302@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237647>

So now you can run

	DESTDIR=$(pwd)/tmp make -Ccontrib/mw-to-git install

to install the mediawiki remote helper, git-mw tool, and Git::Mediawiki
perl module under tmp/ as preparation for zipping it up and extracting
on another machine.

While at it, make sure the directory that should contain Git::Mediawiki
exists before putting a file there.  Without this patch, the makefile
uses DESTDIR when installing git-mw and git-remote-mediawiki but not
the perl module, resulting in errors from "make install" if the
$(INSTLIBDIR)/Git directory does not exist:

 install: cannot create regular file \
 '/usr/share/perl/5.18.1/Git/Mediawiki.pm': No such file or directory

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 contrib/mw-to-git/Makefile | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/contrib/mw-to-git/Makefile b/contrib/mw-to-git/Makefile
index c5547f9..ee78fda 100644
--- a/contrib/mw-to-git/Makefile
+++ b/contrib/mw-to-git/Makefile
@@ -30,7 +30,9 @@ test: all
 check: perlcritic test
 
 install_pm:
-	install $(GIT_MEDIAWIKI_PM) $(INSTLIBDIR)/$(GIT_MEDIAWIKI_PM)
+	install -d -m 755 $(DESTDIR)$(INSTLIBDIR)/Git
+	install -m 644 $(GIT_MEDIAWIKI_PM) \
+		$(DESTDIR)$(INSTLIBDIR)/$(GIT_MEDIAWIKI_PM)
 
 build:
 	$(MAKE) -C $(GIT_ROOT_DIR) SCRIPT_PERL="$(SCRIPT_PERL_FULL)" \
-- 
1.8.4.1
