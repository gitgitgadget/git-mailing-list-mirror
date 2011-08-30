From: Ron Panduwana <panduwana@gmail.com>
Subject: [PATCH v2] Make use of git status when autocompleting git add, rm, checkout --, and reset HEAD
Date: Wed, 31 Aug 2011 04:43:03 +0700
Message-ID: <1314740583-14567-1-git-send-email-panduwana@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Junio C Hamano <gitster@pobox.com>,
	Lee Marlow <lee.marlow@gmail.com>,
	Thomas Rast <trast@student.ethz.ch>,
	Ron Panduwana <panduwana@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 30 23:43:25 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QyW5c-0003Jy-66
	for gcvg-git-2@lo.gmane.org; Tue, 30 Aug 2011 23:43:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751265Ab1H3VnT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Aug 2011 17:43:19 -0400
X-Warning: Original message contained 8-bit characters, however during
	   the SMTP transport session the receiving system did not announce
	   capability of receiving 8-bit SMTP (RFC 1651-1653), and as this
	   message does not have MIME headers (RFC 2045-2049) to enable
	   encoding change, we had very little choice.
X-Warning: We ASSUME it is less harmful to add the MIME headers, and
	   convert the text to Quoted-Printable, than not to do so,
	   and to strip the message to 7-bits.. (RFC 1428 Appendix A)
X-Warning: We don't know what character set the user used, thus we had to
	   write these MIME-headers with our local system default value.
Received: from mail-pz0-f42.google.com ([209.85.210.42]:43307 "EHLO
	mail-pz0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751193Ab1H3VnS (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Aug 2011 17:43:18 -0400
Received: by pzk37 with SMTP id 37so148344pzk.1
        for <git@vger.kernel.org>; Tue, 30 Aug 2011 14:43:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=3oi+wP10KaMLt71ofrwLARGEa2j44oqvXuwnSu6Pj7M=;
        b=b4WtOaZjEjTin7dQVn13D7jD8cej6AvUbFWnbZY/Pnz5M5bK7GUR0xukDSN99MpkxX
         Tr96yvlyCavOoTp2ZDjq/o/u/w1DNFZwcJgT97BNRDpdku6qikYsGEBz7FuV06OHofgj
         bJkzH7HJ5g978cHxJztg0mDxT8sOiLMi5nEHg=
Received: by 10.142.49.7 with SMTP id w7mr3357054wfw.88.1314740598314;
        Tue, 30 Aug 2011 14:43:18 -0700 (PDT)
Received: from localhost.localdomain ([180.252.146.75])
        by mx.google.com with ESMTPS id t6sm11430385pbg.4.2011.08.30.14.43.14
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 30 Aug 2011 14:43:16 -0700 (PDT)
X-Mailer: git-send-email 1.7.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180445>

Signed-off-by: Ron Panduwana <panduwana@gmail.com>
---

On Fri, Aug 19, 2011 at 5:10 PM, Thomas Rast <trast@student.ethz.ch> wr=
ote:
> Some thoughts:
>
> * running git-status for . has some issues: it doesn't work in the
> =C2=A0case of
>
> =C2=A0 =C2=A0cd subdir
> =C2=A0 =C2=A0git add ../some/file[TAB]
>
> =C2=A0It's also inefficient if you are at the top level and
>
> =C2=A0 =C2=A0git add path/to/file/a/few/levels/down[TAB]
>
> =C2=A0since it wouldn't actually have to look for untracked files in =
the
> =C2=A0entire repo.

=46ixed by running git-status for $cur if $cur is a directory. Otherwis=
e run on .


> * -uall is not required unless you are looking for untracked files.
> =C2=A0 For the other commands you could speed up completion by passin=
g
> =C2=A0 -uno instead.

=46ixed by adding second parameter to __git_files_having_status


 contrib/completion/git-completion.bash |   84 ++++++++++++++++++++----=
-------
 1 files changed, 54 insertions(+), 30 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completio=
n/git-completion.bash
index 8648a36..9d44501 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1010,6 +1010,16 @@ __git_has_doubledash ()
 	return 1
 }

+# __git_files_having_status requires 2 arguments
+__git_files_having_status ()
+{
+    local dir=3D"."
+    if [ -d "$cur" ]; then
+        dir=3D"$cur"
+    fi
+	echo "$(git status $2 -s "$dir" 2>/dev/null | egrep "^$1" | cut -c4-)=
"
+}
+
 __git_whitespacelist=3D"nowarn warn error error-all fix"

 _git_am ()
@@ -1058,17 +1068,17 @@ _git_apply ()

 _git_add ()
 {
-	__git_has_doubledash && return
-
-	case "$cur" in
-	--*)
-		__gitcomp "
-			--interactive --refresh --patch --update --dry-run
-			--ignore-errors --intent-to-add
-			"
-		return
-	esac
-	COMPREPLY=3D()
+	if ! __git_has_doubledash; then
+		case "$cur" in
+		--*)
+			__gitcomp "
+				--interactive --refresh --patch --update --dry-run
+				--ignore-errors --intent-to-add
+				"
+			return
+		esac
+	fi
+	__gitcomp "$(__git_files_having_status "(.[MAU]|UD|\?\?)" -uall)"
 }

 _git_archive ()
@@ -1171,7 +1181,12 @@ _git_bundle ()

 _git_checkout ()
 {
-	__git_has_doubledash && return
+	if __git_has_doubledash; then
+		if [[ ${words[2]} =3D "--" ]]; then
+			__gitcomp "$(__git_files_having_status ".[MD]" -uno)"
+		fi
+		return
+	fi

 	case "$cur" in
 	--conflict=3D*)
@@ -1469,7 +1484,7 @@ _git_help ()
 	__gitcomp "$__git_all_commands $(__git_aliases)
 		attributes cli core-tutorial cvs-migration
 		diffcore gitk glossary hooks ignore modules
-		namespaces repository-layout tutorial tutorial-2
+		repository-layout tutorial tutorial-2
 		workflows
 		"
 }
@@ -2313,14 +2328,18 @@ _git_replace ()

 _git_reset ()
 {
-	__git_has_doubledash && return
-
-	case "$cur" in
-	--*)
-		__gitcomp "--merge --mixed --hard --soft --patch"
+	if ! __git_has_doubledash; then
+		case "$cur" in
+		--*)
+			__gitcomp "--merge --mixed --hard --soft --patch"
+			return
+			;;
+		esac
+	fi
+	if [[ ${words[2]} =3D "HEAD" ]]; then
+		__gitcomp "$(__git_files_having_status "[ADM]." -uno)"
 		return
-		;;
-	esac
+	fi
 	__gitcomp "$(__git_refs)"
 }

@@ -2337,15 +2356,20 @@ _git_revert ()

 _git_rm ()
 {
-	__git_has_doubledash && return
-
-	case "$cur" in
-	--*)
-		__gitcomp "--cached --dry-run --ignore-unmatch --quiet"
-		return
-		;;
-	esac
-	COMPREPLY=3D()
+	if ! __git_has_doubledash; then
+		case "$cur" in
+		--*)
+			__gitcomp "--cached --dry-run --ignore-unmatch --quiet"
+			return
+			;;
+		esac
+	fi
+	# check if --cached was specified
+	if [ "$(__git_find_on_cmdline "--cached")" ]; then
+		COMPREPLY=3D()
+	else
+		__gitcomp "$(__git_files_having_status "(.D|DU|UA)" -uno)"
+	fi
 }

 _git_shortlog ()
@@ -2640,7 +2664,6 @@ _git ()
 			--exec-path
 			--html-path
 			--work-tree=3D
-			--namespace=3D
 			--help
 			"
 			;;
@@ -2737,3 +2760,4 @@ else
 		shopt "$@"
 	}
 fi
+
--
1.7.1
