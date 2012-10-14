From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v5 1/3] completion: add new __gitcompadd helper
Date: Sun, 14 Oct 2012 17:52:49 +0200
Message-ID: <1350229971-9343-2-git-send-email-felipe.contreras@gmail.com>
References: <1350229971-9343-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	SZEDER Gabor <szeder@ira.uka.de>,
	Matthieu Moy <matthieu.moy@grenoble-inp.fr>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Oct 14 17:53:23 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TNQV9-0003ne-BT
	for gcvg-git-2@plane.gmane.org; Sun, 14 Oct 2012 17:53:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753759Ab2JNPxB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Oct 2012 11:53:01 -0400
Received: from mail-wg0-f44.google.com ([74.125.82.44]:58167 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753651Ab2JNPxA (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Oct 2012 11:53:00 -0400
Received: by mail-wg0-f44.google.com with SMTP id dr13so3800981wgb.1
        for <git@vger.kernel.org>; Sun, 14 Oct 2012 08:52:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=NtTuEimNZJd5t3rIVN5Dx1Et9e4ZOyK9AUmUAmjj2UE=;
        b=yooRRFgRFdui86lZ1Do/h3UOabQSurA134ycESkvr5dEqXWHyO/vNC1rBngYCLMlFg
         6TUEV6jmNkvrqlALgm3uLTA4mCoTN0Uk2JfBMgzh6wb4yBnzTiTXzCSzHo5+AKwTDUkX
         U6IB1Unf2qeA+07B8DpJEod9VigRVI7eW4aH2A/nsPsl9kMNHoblCRFYBsz2AsJDnZLF
         toTN9iB6iI4GDoMfhcDjw+mQZ4Da87YjcTdfKRJLyWc91iSjExFEzyflUL+oWgyJBh6i
         G3/DlPZmpmKtrclPDJJrmzCgTm+cHzLgCwWU2uFh3qUkI88UY+SESr5S2zPhhBBUPKBI
         Mo+g==
Received: by 10.216.207.28 with SMTP id m28mr5608280weo.52.1350229978737;
        Sun, 14 Oct 2012 08:52:58 -0700 (PDT)
Received: from localhost (ip-109-43-0-56.web.vodafone.de. [109.43.0.56])
        by mx.google.com with ESMTPS id eq2sm10509711wib.1.2012.10.14.08.52.56
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 14 Oct 2012 08:52:57 -0700 (PDT)
X-Mailer: git-send-email 1.7.12.1
In-Reply-To: <1350229971-9343-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207670>

The idea is to never touch the COMPREPLY variable directly.

This allows other completion systems override __gitcompadd, and do
something different instead.

Also, this allows the simplifcation of the completino tests (separate
patch).

There should be no functional changes.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/completion/git-completion.bash | 65 ++++++++++++++++++----------------
 1 file changed, 34 insertions(+), 31 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index d743e56..01325de 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -225,6 +225,11 @@ _get_comp_words_by_ref ()
 fi
 fi
 
+__gitcompadd ()
+{
+	COMPREPLY=($(compgen -W "$1" -P "$2" -S "$4" -- "$3"))
+}
+
 # Generates completion reply with compgen, appending a space to possible
 # completion words, if necessary.
 # It accepts 1 to 4 arguments:
@@ -238,13 +243,11 @@ __gitcomp ()
 
 	case "$cur_" in
 	--*=)
-		COMPREPLY=()
+		__gitcompadd
 		;;
 	*)
 		local IFS=$'\n'
-		COMPREPLY=($(compgen -P "${2-}" \
-			-W "$(__gitcomp_1 "${1-}" "${4-}")" \
-			-- "$cur_"))
+		__gitcompadd "$(__gitcomp_1 "${1-}" "${4-}")" "${2-}" "$cur_" ""
 		;;
 	esac
 }
@@ -261,7 +264,7 @@ __gitcomp ()
 __gitcomp_nl ()
 {
 	local IFS=$'\n'
-	COMPREPLY=($(compgen -P "${2-}" -S "${4- }" -W "$1" -- "${3-$cur}"))
+	__gitcompadd "$1" "${2-}" "${3-$cur}" "${4- }"
 }
 
 __git_heads ()
@@ -486,7 +489,7 @@ __git_complete_remote_or_refspec ()
 			case "$cmd" in
 			push) no_complete_refspec=1 ;;
 			fetch)
-				COMPREPLY=()
+				__gitcompadd
 				return
 				;;
 			*) ;;
@@ -502,7 +505,7 @@ __git_complete_remote_or_refspec ()
 		return
 	fi
 	if [ $no_complete_refspec = 1 ]; then
-		COMPREPLY=()
+		__gitcompadd
 		return
 	fi
 	[ "$remote" = "." ] && remote=
@@ -776,7 +779,7 @@ _git_am ()
 			"
 		return
 	esac
-	COMPREPLY=()
+	__gitcompadd
 }
 
 _git_apply ()
@@ -796,7 +799,7 @@ _git_apply ()
 			"
 		return
 	esac
-	COMPREPLY=()
+	__gitcompadd
 }
 
 _git_add ()
@@ -811,7 +814,7 @@ _git_add ()
 			"
 		return
 	esac
-	COMPREPLY=()
+	__gitcompadd
 }
 
 _git_archive ()
@@ -856,7 +859,7 @@ _git_bisect ()
 		__gitcomp_nl "$(__git_refs)"
 		;;
 	*)
-		COMPREPLY=()
+		__gitcompadd
 		;;
 	esac
 }
@@ -965,7 +968,7 @@ _git_clean ()
 		return
 		;;
 	esac
-	COMPREPLY=()
+	__gitcompadd
 }
 
 _git_clone ()
@@ -989,7 +992,7 @@ _git_clone ()
 		return
 		;;
 	esac
-	COMPREPLY=()
+	__gitcompadd
 }
 
 _git_commit ()
@@ -1023,7 +1026,7 @@ _git_commit ()
 			"
 		return
 	esac
-	COMPREPLY=()
+	__gitcompadd
 }
 
 _git_describe ()
@@ -1154,7 +1157,7 @@ _git_fsck ()
 		return
 		;;
 	esac
-	COMPREPLY=()
+	__gitcompadd
 }
 
 _git_gc ()
@@ -1165,7 +1168,7 @@ _git_gc ()
 		return
 		;;
 	esac
-	COMPREPLY=()
+	__gitcompadd
 }
 
 _git_gitk ()
@@ -1242,7 +1245,7 @@ _git_init ()
 		return
 		;;
 	esac
-	COMPREPLY=()
+	__gitcompadd
 }
 
 _git_ls_files ()
@@ -1261,7 +1264,7 @@ _git_ls_files ()
 		return
 		;;
 	esac
-	COMPREPLY=()
+	__gitcompadd
 }
 
 _git_ls_remote ()
@@ -1377,7 +1380,7 @@ _git_mergetool ()
 		return
 		;;
 	esac
-	COMPREPLY=()
+	__gitcompadd
 }
 
 _git_merge_base ()
@@ -1393,7 +1396,7 @@ _git_mv ()
 		return
 		;;
 	esac
-	COMPREPLY=()
+	__gitcompadd
 }
 
 _git_name_rev ()
@@ -1563,7 +1566,7 @@ _git_send_email ()
 		return
 		;;
 	esac
-	COMPREPLY=()
+	__gitcompadd
 }
 
 _git_stage ()
@@ -1616,7 +1619,7 @@ _git_config ()
 		local remote="${prev#remote.}"
 		remote="${remote%.fetch}"
 		if [ -z "$cur" ]; then
-			COMPREPLY=("refs/heads/")
+			__gitcompadd "refs/heads/"
 			return
 		fi
 		__gitcomp_nl "$(__git_refs_remotes "$remote")"
@@ -1676,7 +1679,7 @@ _git_config ()
 		return
 		;;
 	*.*)
-		COMPREPLY=()
+		__gitcompadd
 		return
 		;;
 	esac
@@ -2056,7 +2059,7 @@ _git_remote ()
 		__gitcomp "$c"
 		;;
 	*)
-		COMPREPLY=()
+		__gitcompadd
 		;;
 	esac
 }
@@ -2100,7 +2103,7 @@ _git_rm ()
 		return
 		;;
 	esac
-	COMPREPLY=()
+	__gitcompadd
 }
 
 _git_shortlog ()
@@ -2170,7 +2173,7 @@ _git_stash ()
 			if [ -z "$(__git_find_on_cmdline "$save_opts")" ]; then
 				__gitcomp "$subcommands"
 			else
-				COMPREPLY=()
+				__gitcompadd
 			fi
 			;;
 		esac
@@ -2183,14 +2186,14 @@ _git_stash ()
 			__gitcomp "--index --quiet"
 			;;
 		show,--*|drop,--*|branch,--*)
-			COMPREPLY=()
+			__gitcompadd
 			;;
 		show,*|apply,*|drop,*|pop,*|branch,*)
 			__gitcomp_nl "$(git --git-dir="$(__gitdir)" stash list \
 					| sed -n -e 's/:.*//p')"
 			;;
 		*)
-			COMPREPLY=()
+			__gitcompadd
 			;;
 		esac
 	fi
@@ -2307,7 +2310,7 @@ _git_svn ()
 			__gitcomp "--revision= --parent"
 			;;
 		*)
-			COMPREPLY=()
+			__gitcompadd
 			;;
 		esac
 	fi
@@ -2332,13 +2335,13 @@ _git_tag ()
 
 	case "$prev" in
 	-m|-F)
-		COMPREPLY=()
+		__gitcompadd
 		;;
 	-*|tag)
 		if [ $f = 1 ]; then
 			__gitcomp_nl "$(__git_tags)"
 		else
-			COMPREPLY=()
+			__gitcompadd
 		fi
 		;;
 	*)
-- 
1.7.12.1
