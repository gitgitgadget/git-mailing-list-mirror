From: Thell Fowler <tbfowler4@gmail.com>
Subject: [PATCH] Add --allow-eof-whitelines to git-apply while still doing 
	whitespace trailing-space fixing.
Date: Sat, 1 Aug 2009 11:57:08 -0500
Message-ID: <f002290c0908010957pf14d18dv7c80270eb9af3c8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 01 18:57:20 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MXHtW-0006ry-C4
	for gcvg-git-2@gmane.org; Sat, 01 Aug 2009 18:57:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751382AbZHAQ5L (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 1 Aug 2009 12:57:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751253AbZHAQ5L
	(ORCPT <rfc822;git-outgoing>); Sat, 1 Aug 2009 12:57:11 -0400
Received: from mail-ew0-f214.google.com ([209.85.219.214]:56833 "EHLO
	mail-ew0-f214.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750874AbZHAQ5K (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 1 Aug 2009 12:57:10 -0400
Received: by ewy10 with SMTP id 10so2145402ewy.37
        for <git@vger.kernel.org>; Sat, 01 Aug 2009 09:57:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:content-type:content-transfer-encoding;
        bh=F/lh1CLPJLyhE9emKryWCOdX4m8KQzri/kTrw6zh1Hk=;
        b=mc55SuAhXluQcoA6KhX+IHl6r9HoT0L4TEkqkV/J+Ik6lELxAkb8ihPgGU/zxBMGjg
         BeYcSTXLwsyadDelIQEFYY2JJMi2yi5KVwovETwY6wNnnw+vp7VICXfjBRyIYTOY+ukJ
         nRxMVS1grYzUcCmTowFBrrTj7OFKUVP1Ma1Zc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        b=xmPKhoDwqvpQ2KJ2wVyp6Afy20rPWq243zou/i6bfLw/M3wLHuFsL+zUReRWLmhoMU
         Lx/rEAAK1mbvedds6O3/l/ltFUtTC8sn03VR6r/PEeANBDn9syQ0kmrnz+8oa1LsHcx6
         3lO6vXC4CNpeNkKbIk/+Dlwz8JUIhqmtpXpBk=
Received: by 10.210.34.5 with SMTP id h5mr4812742ebh.71.1249145828735; Sat, 01 
	Aug 2009 09:57:08 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124639>

  - Added --allow-eof-whitelines to git apply to short-circuit removal
of new empty lines when tailing-space is set.
  - Added pass-through to apply from git-am.sh
  - Added pass-through to git-am from git-rebase.sh
  - Added the auto-completion entries.

Signed-off-by: TBFowler <thell@almostautomated.com>
---
 builtin-apply.c                        |    5 ++++-
 contrib/completion/git-completion.bash |    4 ++--
 git-am.sh                              |    3 +++
 git-rebase.sh                          |    3 +++
 4 files changed, 12 insertions(+), 3 deletions(-)

diff --git a/builtin-apply.c b/builtin-apply.c
index dc0ff5e..79be05c 100644
--- a/builtin-apply.c
+++ b/builtin-apply.c
@@ -43,6 +43,7 @@ static int apply = 1;
 static int apply_in_reverse;
 static int apply_with_reject;
 static int apply_verbosely;
+static int keep_new_eof_whitelines;
 static int no_add;
 static const char *fake_ancestor;
 static int line_termination = '\n';
@@ -1996,7 +1997,7 @@ static int apply_one_fragment(struct image *img,
struct fragment *frag,
 				error("invalid start of line: '%c'", first);
 			return -1;
 		}
-		if (added_blank_line)
+		if (added_blank_line && !keep_new_eof_whitelines)
 			new_blank_lines_at_end++;
 		else
 			new_blank_lines_at_end = 0;
@@ -3304,6 +3305,8 @@ int cmd_apply(int argc, const char **argv, const
char *unused_prefix)
 		{ OPTION_CALLBACK, 0, "whitespace", &whitespace_option, "action",
 			"detect new or modified lines that have whitespace errors",
 			0, option_parse_whitespace },
+		OPT_BOOLEAN(0, "allow-eof-whitelines", &keep_new_eof_whitelines,
+			"allow processing of whitespace fix but don't suppress new
whitelines at end of file"),
 		OPT_BOOLEAN('R', "reverse", &apply_in_reverse,
 			"apply the patch in reverse"),
 		OPT_BOOLEAN(0, "unidiff-zero", &unidiff_zero,
diff --git a/contrib/completion/git-completion.bash
b/contrib/completion/git-completion.bash
index 745b5fb..512b14c 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -675,7 +675,7 @@ _git_am ()
 		__gitcomp "
 			--3way --committer-date-is-author-date --ignore-date
 			--interactive --keep --no-utf8 --signoff --utf8
-			--whitespace=
+			--whitespace= --allow-eof-whitelines
 			"
 		return
 	esac
@@ -695,7 +695,7 @@ _git_apply ()
 			--stat --numstat --summary --check --index
 			--cached --index-info --reverse --reject --unidiff-zero
 			--apply --no-add --exclude=
-			--whitespace= --inaccurate-eof --verbose
+			--whitespace= --allow-eof-whitelines --inaccurate-eof --verbose
 			"
 		return
 	esac
diff --git a/git-am.sh b/git-am.sh
index d64d997..5757674 100755
--- a/git-am.sh
+++ b/git-am.sh
@@ -16,6 +16,7 @@ s,signoff       add a Signed-off-by line to the commit message
 u,utf8          recode into utf8 (default)
 k,keep          pass -k flag to git-mailinfo
 whitespace=     pass it through git-apply
+allow-eof-whitelines        pass it through git-apply
 directory=      pass it through git-apply
 C=              pass it through git-apply
 p=              pass it through git-apply
@@ -299,6 +300,8 @@ do
 		shift; resolvemsg=$1 ;;
 	--whitespace|--directory)
 		git_apply_opt="$git_apply_opt $(sq "$1=$2")"; shift ;;
+	--allow-eof-whitelines)
+		git_apply_opt="$git_apply_opt $1" ;;
 	-C|-p)
 		git_apply_opt="$git_apply_opt $(sq "$1$2")"; shift ;;
 	--patch-format)
diff --git a/git-rebase.sh b/git-rebase.sh
index 18bc694..1556224 100755
--- a/git-rebase.sh
+++ b/git-rebase.sh
@@ -333,6 +333,9 @@ do
 			;;
 		esac
 		;;
+	--allow-eof-whitelines)
+		git_am_opt="$git_am_opt $1"
+		;;
 	--committer-date-is-author-date|--ignore-date)
 		git_am_opt="$git_am_opt $1"
 		force_rebase=t
-- 
1.6.4.rc3.dirty
