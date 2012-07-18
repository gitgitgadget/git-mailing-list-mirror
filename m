From: Stefano Lattarini <stefano.lattarini@gmail.com>
Subject: [PATCH 6/7] build: "make clean" should not remove configure-generated files
Date: Thu, 19 Jul 2012 00:35:01 +0200
Message-ID: <e763e7f466efa34f48589f8353a7316fff469145.1342649928.git.stefano.lattarini@gmail.com>
References: <cover.1342649928.git.stefano.lattarini@gmail.com>
Cc: gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 19 00:35:46 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SrcqM-0005Ub-VG
	for gcvg-git-2@plane.gmane.org; Thu, 19 Jul 2012 00:35:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755075Ab2GRWfh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Jul 2012 18:35:37 -0400
Received: from mail-wg0-f44.google.com ([74.125.82.44]:63398 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754503Ab2GRWfa (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Jul 2012 18:35:30 -0400
Received: by mail-wg0-f44.google.com with SMTP id dr13so1790594wgb.1
        for <git@vger.kernel.org>; Wed, 18 Jul 2012 15:35:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :in-reply-to:references;
        bh=7qNsEonBAKMpaYKSbiNiPR+xJBUAwjjuKyZHMDFtnLs=;
        b=roJ8PrxkSnUoISFG3QAt0ZqXR9cQorR09Rvq9ZwRF7OGtQDSCjNwQ7B+VhJeG+OB2F
         ++4uf4FE5H73Iic0o2q0ZHAQ7YVhm812byhl60HYrlec3pxBwMjgQxhE/ECDnbNxXaMc
         UY/8VRHqRFqNM3nvGvKgD9tCu5FUgzlgx9zOEDvCr4vD+z3/jCrgVMEt/N7O6l5QjsH/
         9jWwO0yNHYokjmXNSYc2Li0HRj6wXZsC1lgkdNL7vCerVsi88MdWEu8uLzpYWpD4SSqm
         aHGkEr+4yb/8vVtBUO1a8bLx01RFjknBJqjbr+jq/ElCaor7mK2ANTARl8V4x7WM4nhk
         xd9g==
Received: by 10.216.122.6 with SMTP id s6mr1613224weh.46.1342650930130;
        Wed, 18 Jul 2012 15:35:30 -0700 (PDT)
Received: from localhost.localdomain (host105-96-dynamic.4-87-r.retail.telecomitalia.it. [87.4.96.105])
        by mx.google.com with ESMTPS id el6sm35011908wib.8.2012.07.18.15.35.28
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 18 Jul 2012 15:35:29 -0700 (PDT)
X-Mailer: git-send-email 1.7.10.2.1067.g553d16e
In-Reply-To: <cover.1342649928.git.stefano.lattarini@gmail.com>
In-Reply-To: <cover.1342649928.git.stefano.lattarini@gmail.com>
References: <cover.1342649928.git.stefano.lattarini@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201703>

Those filed hold variables, settings and information set by the
configuration process run by './configure'; in Autotools-based
build system that kind of stuff should only be removed by
"make distclean".  Having it removed by "make clean" is not only
inconsistent, but causes real confusion for that part of the Git
audience that is used to the Autotools semantics; for example,
an autotools old-timer that has run:

    ./configure --prefix /opt/git

in the past, without running "make distclean" afterwards, would
expect a "make install" issued after a "make clean" to rebuild and
install git in '/opt/git'; but with the current behaviour, the
"make clean" invocation removes (among the other things) the file
'config.mak.autogen', so that the "make install" falls back to the
default prefix of '$HOME', thus installing git in the user's home
directory -- definitely unexpected.

Signed-off-by: Stefano Lattarini <stefano.lattarini@gmail.com>
---
 Makefile | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/Makefile b/Makefile
index 285c660..88a76a3 100644
--- a/Makefile
+++ b/Makefile
@@ -2742,6 +2742,9 @@ dist-doc:
 
 distclean: clean
 	$(RM) configure
+	$(RM) config.log config.status config.cache
+	$(RM) config.mak.autogen config.mak.append
+	$(RM) -r autom4te.cache
 
 profile-clean:
 	$(RM) $(addsuffix *.gcda,$(addprefix $(PROFILE_DIR)/, $(object_dirs)))
@@ -2756,8 +2759,6 @@ clean: profile-clean
 	$(RM) -r $(dep_dirs)
 	$(RM) -r po/build/
 	$(RM) *.spec *.pyc *.pyo */*.pyc */*.pyo common-cmds.h $(ETAGS_TARGET) tags cscope*
-	$(RM) -r autom4te.cache
-	$(RM) config.log config.mak.autogen config.mak.append config.status config.cache
 	$(RM) -r $(GIT_TARNAME) .doc-tmp-dir
 	$(RM) $(GIT_TARNAME).tar.gz git-core_$(GIT_VERSION)-*.tar.gz
 	$(RM) $(htmldocs).tar.gz $(manpages).tar.gz
-- 
1.7.10.2.1067.g553d16e
