From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2] completion: graduate out of contrib
Date: Thu,  8 May 2014 22:53:07 -0500
Message-ID: <1399607587-14127-1-git-send-email-felipe.contreras@gmail.com>
Cc: Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 09 06:04:03 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wic2V-00031P-5U
	for gcvg-git-2@plane.gmane.org; Fri, 09 May 2014 06:04:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750775AbaEIED7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 May 2014 00:03:59 -0400
Received: from mail-yh0-f48.google.com ([209.85.213.48]:44673 "EHLO
	mail-yh0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750712AbaEIED6 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 May 2014 00:03:58 -0400
Received: by mail-yh0-f48.google.com with SMTP id a41so1006414yho.7
        for <git@vger.kernel.org>; Thu, 08 May 2014 21:03:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=kIZm6sXDFoCvuMxlBGMkxF/rgUwpEIH1IXZHvJ1HHUA=;
        b=QxbGZ5MXn9+Nin3xwB0rac2pHE5+yZH8OTUFPjIeRaV/XwXw1MbeVtChsmRa99nq19
         2nBNOMielj/mj9cNaTtfz/qPQwnpcIuGeu4+hQXvHkLqb2GYwH7PbJ963Fn8raupIjMj
         662JBvxcGY0OCbrZI/E1jWc5AIMsfv4scH2PAcmLlOsYWwZKOg0+AHbKusrikwMQL/x2
         uAbME8c9IL8VB09Qak0XIQKtkmhNVK9APpDJKnGHP9Yh5M4gxeS6ecG4p89rfuqf1E2M
         cv6LvhlcPUkPE6At21ZW044XjaTVk0MCh9lj6TUAgtj5f97Bg2VSTHJk/jo9OfpOH8n5
         ApXw==
X-Received: by 10.236.46.225 with SMTP id r61mr10992523yhb.107.1399608238131;
        Thu, 08 May 2014 21:03:58 -0700 (PDT)
Received: from localhost (189-211-224-40.static.axtel.net. [189.211.224.40])
        by mx.google.com with ESMTPSA id t9sm4489571yhg.18.2014.05.08.21.03.53
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 08 May 2014 21:03:56 -0700 (PDT)
X-Mailer: git-send-email 1.9.2+fc1.27.gbce2056
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248511>

These have been stable and widely used for quite a long time, they even
have tests outside of the contrib area, and most distributions ship
them, so they can be considered part of the core already.

We should be consistent and either we move the tests to contrib, or we
move the completions out of contrib.

Let's move them out of contrib and install them by default.

By default bash-completion installs the completions to
$(pkgdatadir)/completions, which is
$(prefix)/share/bash-completion/completions. And since most distributions do
not change this, it is obviously the right default. However,
bash-completion recommends to use pkg-config to find the right location,
so we could use that, but it's much easier to let distributions do it:

  bashcomdir=$pkg-config --variable=completionsdir bash-completion)

By default zsh looks for completions in
$(prefix)/share/zsh/site-functions.

The distributions use these locations to install Git completions:

  ArchLinux: /usr/share/bash-completion/completions/
  Debian: /usr/share/bash-completion/completions/
  Fedora: /etc/bash_completion.d/
  Ubuntu: /usr/share/bash-completion/completions/
  Mint: /usr/share/bash-completion/completions/
  OpenSuse: /etc/bash_completion.d/

However, in both Fedora and OpenSUSE their bash-completion intallations
use /usr/share/bash-completion/completions/ (they don't change the
default). So it  seems to a be a bug from the packager, since they
recommend the bash-completion location[1]

If some weird distribution has a problem with the location, they can
override 'bashcompdir' anyway.

[1] http://article.gmane.org/gmane.linux.redhat.fedora.devel/177405

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 Makefile                                           | 6 ++++++
 {contrib/completion => shared}/git-completion.bash | 0
 {contrib/completion => shared}/git-completion.zsh  | 0
 {contrib/completion => shared}/git-prompt.sh       | 0
 t/t9902-completion.sh                              | 2 +-
 t/t9903-bash-prompt.sh                             | 2 +-
 6 files changed, 8 insertions(+), 2 deletions(-)
 rename {contrib/completion => shared}/git-completion.bash (100%)
 rename {contrib/completion => shared}/git-completion.zsh (100%)
 rename {contrib/completion => shared}/git-prompt.sh (100%)

diff --git a/Makefile b/Makefile
index 52bdc95..2690903 100644
--- a/Makefile
+++ b/Makefile
@@ -379,6 +379,7 @@ gitwebdir = $(sharedir)/gitweb
 localedir = $(sharedir)/locale
 template_dir = share/git-core/templates
 htmldir = $(prefix)/share/doc/git-doc
+bashcompdir = $(sharedir)/bash-completion/completions
 ETC_GITCONFIG = $(sysconfdir)/gitconfig
 ETC_GITATTRIBUTES = $(sysconfdir)/gitattributes
 lib = lib
@@ -1582,6 +1583,8 @@ template_dir_SQ = $(subst ','\'',$(template_dir))
 htmldir_relative_SQ = $(subst ','\'',$(htmldir_relative))
 prefix_SQ = $(subst ','\'',$(prefix))
 gitwebdir_SQ = $(subst ','\'',$(gitwebdir))
+sharedir_SQ = $(subst ','\'',$(sharedir))
+bashcompdir_SQ = $(subst ','\'',$(bashcompdir))
 
 SHELL_PATH_SQ = $(subst ','\'',$(SHELL_PATH))
 PERL_PATH_SQ = $(subst ','\'',$(PERL_PATH))
@@ -2345,6 +2348,9 @@ install: all
 	$(MAKE) -C templates DESTDIR='$(DESTDIR_SQ)' install
 	$(INSTALL) -d -m 755 '$(DESTDIR_SQ)$(mergetools_instdir_SQ)'
 	$(INSTALL) -m 644 mergetools/* '$(DESTDIR_SQ)$(mergetools_instdir_SQ)'
+	$(INSTALL) -D -m 644 shared/git-completion.bash '$(DESTDIR_SQ)$(bashcompdir_SQ)'/git
+	$(INSTALL) -D -m 644 shared/git-prompt.sh '$(DESTDIR_SQ)$(sharedir_SQ)'/git-core/git-prompt.sh
+	$(INSTALL) -D -m 644 shared/git-completion.zsh '$(DESTDIR_SQ)$(sharedir_SQ)'/zsh/site-functions/_git
 ifndef NO_GETTEXT
 	$(INSTALL) -d -m 755 '$(DESTDIR_SQ)$(localedir_SQ)'
 	(cd po/build/locale && $(TAR) cf - .) | \
diff --git a/contrib/completion/git-completion.bash b/shared/git-completion.bash
similarity index 100%
rename from contrib/completion/git-completion.bash
rename to shared/git-completion.bash
diff --git a/contrib/completion/git-completion.zsh b/shared/git-completion.zsh
similarity index 100%
rename from contrib/completion/git-completion.zsh
rename to shared/git-completion.zsh
diff --git a/contrib/completion/git-prompt.sh b/shared/git-prompt.sh
similarity index 100%
rename from contrib/completion/git-prompt.sh
rename to shared/git-prompt.sh
diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
index 2d4beb5..d8674e4 100755
--- a/t/t9902-completion.sh
+++ b/t/t9902-completion.sh
@@ -32,7 +32,7 @@ complete ()
 
 GIT_TESTING_COMMAND_COMPLETION='add checkout check-attr filter-branch ls-files'
 
-. "$GIT_BUILD_DIR/contrib/completion/git-completion.bash"
+. "$GIT_BUILD_DIR/shared/git-completion.bash"
 
 # We don't need this function to actually join words or do anything special.
 # Also, it's cleaner to avoid touching bash's internal completion variables.
diff --git a/t/t9903-bash-prompt.sh b/t/t9903-bash-prompt.sh
index 6efd0d9..59d2cb9 100755
--- a/t/t9903-bash-prompt.sh
+++ b/t/t9903-bash-prompt.sh
@@ -7,7 +7,7 @@ test_description='test git-specific bash prompt functions'
 
 . ./lib-bash.sh
 
-. "$GIT_BUILD_DIR/contrib/completion/git-prompt.sh"
+. "$GIT_BUILD_DIR/shared/git-prompt.sh"
 
 actual="$TRASH_DIRECTORY/actual"
 c_red='\\[\\e[31m\\]'
-- 
1.9.2+fc1.27.gbce2056
