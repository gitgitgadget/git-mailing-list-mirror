From: Jacob Keller <jacob.e.keller@intel.com>
Subject: [PATCH v6 2/7] submodule: don't pass empty string arguments to submodule--helper clone
Date: Mon, 29 Feb 2016 14:58:30 -0800
Message-ID: <1456786715-24256-3-git-send-email-jacob.e.keller@intel.com>
References: <1456786715-24256-1-git-send-email-jacob.e.keller@intel.com>
Cc: Jeff King <peff@peff.net>,
	Mark Strapetz <marc.strapetz@syntevo.com>,
	Stefan Beller <sbeller@google.com>,
	Junio C Hamano <gitster@pobox.com>,
	Jacob Keller <jacob.keller@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 29 23:59:02 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aaWmJ-0005VE-1Y
	for gcvg-git-2@plane.gmane.org; Mon, 29 Feb 2016 23:58:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752761AbcB2W6x (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Feb 2016 17:58:53 -0500
Received: from mga03.intel.com ([134.134.136.65]:52383 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751342AbcB2W6k (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Feb 2016 17:58:40 -0500
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga103.jf.intel.com with ESMTP; 29 Feb 2016 14:58:38 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.22,521,1449561600"; 
   d="scan'208";a="661447397"
Received: from jekeller-desk.amr.corp.intel.com (HELO jekeller-desk.jekeller.internal) ([134.134.3.65])
  by FMSMGA003.fm.intel.com with ESMTP; 29 Feb 2016 14:58:38 -0800
X-Mailer: git-send-email 2.7.1.429.g45cd78e
In-Reply-To: <1456786715-24256-1-git-send-email-jacob.e.keller@intel.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287932>

From: Jacob Keller <jacob.keller@gmail.com>

When --reference or --depth are unused, the current git-submodule.sh
results in empty "" arguments appended to the end of the argv array
inside git submodule--helper clone. This is not caught because the argc
count is not checked today.

Fix git-submodule.sh to only pass an argument when --reference or
--depth are used, preventing the addition of two empty string arguments
on the tail of the argv array.

Signed-off-by: Jacob Keller <jacob.keller@gmail.com>
---
This is a split of a previous patch as suggested by Junio, to make it
easier to review the changes.

 git-submodule.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/git-submodule.sh b/git-submodule.sh
index 9bc5c5f94d1d..2dd29b3df0e6 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -347,7 +347,7 @@ Use -f if you really want to add it." >&2
 				echo "$(eval_gettext "Reactivating local git directory for submodule '\$sm_name'.")"
 			fi
 		fi
-		git submodule--helper clone ${GIT_QUIET:+--quiet} --prefix "$wt_prefix" --path "$sm_path" --name "$sm_name" --url "$realrepo" "$reference" "$depth" || exit
+		git submodule--helper clone ${GIT_QUIET:+--quiet} --prefix "$wt_prefix" --path "$sm_path" --name "$sm_name" --url "$realrepo" ${reference:+"$reference"} ${depth:+"$depth"} || exit
 		(
 			clear_local_git_env
 			cd "$sm_path" &&
@@ -709,7 +709,7 @@ Maybe you want to use 'update --init'?")"
 
 		if ! test -d "$sm_path"/.git && ! test -f "$sm_path"/.git
 		then
-			git submodule--helper clone ${GIT_QUIET:+--quiet} --prefix "$prefix" --path "$sm_path" --name "$name" --url "$url" "$reference" "$depth" || exit
+			git submodule--helper clone ${GIT_QUIET:+--quiet} --prefix "$prefix" --path "$sm_path" --name "$name" --url "$url" ${reference:+"$reference"} ${depth:+"$depth"} || exit
 			cloned_modules="$cloned_modules;$name"
 			subsha1=
 		else
-- 
2.7.1.429.g45cd78e
