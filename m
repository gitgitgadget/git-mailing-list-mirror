From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v4 5/5] completion: fix completion after 'git --option <TAB>'
Date: Sun, 15 Apr 2012 22:44:20 +0300
Message-ID: <1334519060-2348-6-git-send-email-felipe.contreras@gmail.com>
References: <1334519060-2348-1-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	=?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>,
	Junio C Hamano <gitster@pobox.com>,
	Thomas Rast <trast@student.ethz.ch>, Jeff King <peff@peff.net>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 15 21:45:10 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SJVNj-0002WC-Aq
	for gcvg-git-2@plane.gmane.org; Sun, 15 Apr 2012 21:45:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751265Ab2DOTo6 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 15 Apr 2012 15:44:58 -0400
Received: from mail-lpp01m010-f46.google.com ([209.85.215.46]:53524 "EHLO
	mail-lpp01m010-f46.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751052Ab2DOTo5 (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 15 Apr 2012 15:44:57 -0400
Received: by mail-lpp01m010-f46.google.com with SMTP id j13so3492422lah.19
        for <git@vger.kernel.org>; Sun, 15 Apr 2012 12:44:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=kQkxdMmAZkeyh19SuloKWYludWro+WN4C5DOStCim1Y=;
        b=BbHxuvWPCFY01/1tikF2TzPf75U7BoO+OVZPIP+6L542cAnPqSgtNojrkXpvoX1VL0
         DsTEf+wweL4b0Iu2AqOgZISl1J1VUdibgrMhxcYgVGDMGFJAyF7YVb7X6Ek9TLqgWj6E
         WeKThBige0Sb5O0FkeONH1nDSs2qZpM63YGSbgwqn112ATxDWVPjxGFHKj6UvhZHC9yx
         nK3urv/3OrdK9oUoEWUxFLwuJ0vOueR1pZsdBKuCTFfA1Zm0PNyHp6aHQsBZR+rIeGuP
         ZOroIRfI+6WYantV5pRRFs3eF6aANT2Aggu2bzeh21Su3nWhFbZ5kOFIAWLbIZ5ZVCmw
         KAyw==
Received: by 10.152.108.84 with SMTP id hi20mr8132554lab.22.1334519097020;
        Sun, 15 Apr 2012 12:44:57 -0700 (PDT)
Received: from localhost (84-231-107-120.elisa-mobile.fi. [84.231.107.120])
        by mx.google.com with ESMTPS id w10sm21524712lbe.14.2012.04.15.12.44.55
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 15 Apr 2012 12:44:56 -0700 (PDT)
X-Mailer: git-send-email 1.7.10.1.g1f19b8.dirty
In-Reply-To: <1334519060-2348-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195582>

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
index 6486a09..9f56ec7 100755
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
