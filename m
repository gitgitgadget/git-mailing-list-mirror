From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v3 5/5] completion: fix completion after 'git --option <TAB>'
Date: Sun, 15 Apr 2012 00:43:04 +0300
Message-ID: <1334439784-6460-6-git-send-email-felipe.contreras@gmail.com>
References: <1334439784-6460-1-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	=?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>,
	Junio C Hamano <gitster@pobox.com>,
	Thomas Rast <trast@student.ethz.ch>, Jeff King <peff@peff.net>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 14 23:44:54 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SJAm5-0002XG-W8
	for gcvg-git-2@plane.gmane.org; Sat, 14 Apr 2012 23:44:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756372Ab2DNVot convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 14 Apr 2012 17:44:49 -0400
Received: from mail-lpp01m010-f46.google.com ([209.85.215.46]:56990 "EHLO
	mail-lpp01m010-f46.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756357Ab2DNVos (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 14 Apr 2012 17:44:48 -0400
Received: by mail-lpp01m010-f46.google.com with SMTP id j13so3144617lah.19
        for <git@vger.kernel.org>; Sat, 14 Apr 2012 14:44:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=nH4aT3QHNf9/fSPJbpT1jbHD3txX4QCGl2EOlzCpzzQ=;
        b=OEV25+XlnuK+lSFY9uDeCW0g8E2QTdIFKDpilYdY4UNeLdXKZwbbiI+faypbFSi5rp
         9GdNg3BqQGCRI+cuT2qiR5ZH0AC01LwBdixynDFXeQ6pBxB4vhwuB3PgaCvmse2CRnpP
         JtyJKjZCf0ukJkVvmZj6ao9WPXz5MCYGFzWAaTIUmT4nPa0gIZMNgVIk1ILAYvV5bA9d
         C/RdY3/10a+INAze3xX69Qp36isQ7K8r8ev+ZrmpiU+Ec9QFxh/CiNPz6zDt/DnDsmhn
         AbJCh5MerLmAalBlj4ATYO87pVEoVt/7+X12I7rYh7cqHOVxOQliPGQzU5WF4GAUNxAp
         1Yhw==
Received: by 10.112.83.4 with SMTP id m4mr734748lby.92.1334439887934;
        Sat, 14 Apr 2012 14:44:47 -0700 (PDT)
Received: from localhost (84-231-107-120.elisa-mobile.fi. [84.231.107.120])
        by mx.google.com with ESMTPS id gw17sm13937194lab.11.2012.04.14.14.44.39
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 14 Apr 2012 14:44:47 -0700 (PDT)
X-Mailer: git-send-email 1.7.10.1.g1f19b8.dirty
In-Reply-To: <1334439784-6460-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195523>

=46rom: SZEDER G=C3=A1bor <szeder@ira.uka.de>

Git's bash completion currently doesn't work when certain git options
are specified, e.g. 'git --no-pager <TAB>' errors out with "error:
invalid key: alias.--no-pager".

The main _git() completion function finds out the git command name by
looping through all the words on the command line and searching for
the first word that is not a known option for the git command.
Unfortunately the list of known git options was not updated in a long
time, and newer options are not skipped but mistaken for a git
command.  Such a misrecognized "command" is then passed to
__git_aliased_command(), which in turn passes it to a 'git config'
query, hence the error.

Currently the following options are misrecognized for a git command:

  -c --no-pager --exec-path --html-path --man-path --info-path
  --no-replace-objects --work-tree=3D --namespace=3D

To fix this we could just update the list of options to be skipped,
but the same issue will likely arise, if the git command learns a new
option in the future.  Therefore, to make it more future proof against
new options, this patch changes that loop to skip all option-looking
words, i.e. words starting with a dash.

We also have to handle the '-c' option specially, because it takes a
configutation parameter in a separate word, which must be skipped,
too.

Signed-off-by: SZEDER G=C3=A1bor <szeder@ira.uka.de>
[added tests]
Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/completion/git-completion.bash |    3 ++-
 t/t9902-completion.sh                  |   17 +++++++++++++++++
 2 files changed, 19 insertions(+), 1 deletion(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completio=
n/git-completion.bash
index 647ee77..192e444 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -2623,8 +2623,9 @@ _git ()
 		case "$i" in
 		--git-dir=3D*) __git_dir=3D"${i#--git-dir=3D}" ;;
 		--bare)      __git_dir=3D"." ;;
-		--version|-p|--paginate) ;;
 		--help) command=3D"help"; break ;;
+		-c) c=3D$((++c)) ;;
+		-*) ;;
 		*) command=3D"$i"; break ;;
 		esac
 		((c++))
diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
index dfef809..ab72378 100755
--- a/t/t9902-completion.sh
+++ b/t/t9902-completion.sh
@@ -138,4 +138,21 @@ test_expect_success 'general options' '
 	test_completion "git --inf" "--info-path " &&
 	test_completion "git --no-r" "--no-replace-objects "
 '
+
+test_expect_success 'general options plus command' '
+	test_completion "git --version check" "checkout " &&
+	test_completion "git --paginate check" "checkout " &&
+	test_completion "git --git-dir=3Dfoo check" "checkout " &&
+	test_completion "git --bare check" "checkout " &&
+	test_completion "git --help des" "describe " &&
+	test_completion "git --exec-path=3Dfoo check" "checkout " &&
+	test_completion "git --html-path check" "checkout " &&
+	test_completion "git --no-pager check" "checkout " &&
+	test_completion "git --work-tree=3Dfoo check" "checkout " &&
+	test_completion "git --namespace=3Dfoo check" "checkout " &&
+	test_completion "git --paginate check" "checkout " &&
+	test_completion "git --info-path check" "checkout " &&
+	test_completion "git --no-replace-objects check" "checkout "
+'
+
 test_done
--=20
1.7.10.1.g1f19b8.dirty
