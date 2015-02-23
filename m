From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH 5/6] t/diff-lib: check exact object names in compare_diff_raw
Date: Mon, 23 Feb 2015 19:14:47 +0100
Message-ID: <54EB6E17.5040102@kdbg.org>
References: <1424043824-25242-1-git-send-email-gitster@pobox.com> <1424043824-25242-6-git-send-email-gitster@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Feb 23 19:15:09 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YPxXA-0000Hj-LW
	for gcvg-git-2@plane.gmane.org; Mon, 23 Feb 2015 19:15:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753093AbbBWSO6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Feb 2015 13:14:58 -0500
Received: from bsmtp7.bon.at ([213.33.87.19]:21267 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753048AbbBWSOx (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Feb 2015 13:14:53 -0500
Received: from dx.site (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTPSA id 3krWkx5Rbjz5tlG;
	Mon, 23 Feb 2015 19:14:49 +0100 (CET)
Received: from [IPv6:::1] (localhost [IPv6:::1])
	by dx.site (Postfix) with ESMTP id 0A8F7519D;
	Mon, 23 Feb 2015 19:14:47 +0100 (CET)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.4.0
In-Reply-To: <1424043824-25242-6-git-send-email-gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264277>

Am 16.02.2015 um 00:43 schrieb Junio C Hamano:
> The "sanitize" helper wanted to strip the similarity and
> dissimilarity scores when making comparison, but it was
> stripping away the object names as well.
> 
> While we do not want to require the exact object names the tests
> expect to be maintained, as it would be seen as an extra burden,
> this would have prevented us catching a silly bug such as showing
> non 0{40} object name on the preimage side of an addition or on the
> postimage side of a deletion, because all [0-9a-f]{40} strings were
> considered equally OK.
> 
> In the longer term, when a test only wants to see the status of the
> change without having to worry about object names, it should be
> rewritten not to inspect the raw format.
> 
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>   t/diff-lib.sh | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/t/diff-lib.sh b/t/diff-lib.sh
> index 75a35fc..c211dc4 100644
> --- a/t/diff-lib.sh
> +++ b/t/diff-lib.sh
> @@ -1,6 +1,6 @@
>   :
>   
> -sanitize_diff_raw='/^:/s/ '"$_x40"' '"$_x40"' \([A-Z]\)[0-9]*	/ X X \1#	/'
> +sanitize_diff_raw='/^:/s/ '"\($_x40\)"' '"\($_x40\)"' \([A-Z]\)[0-9]*	/ \1 \2 \3#	/'
>   compare_diff_raw () {
>       # When heuristics are improved, the score numbers would change.
>       # Ignore them while comparing.
> 

This reveals a minor bug in test_ln_s_add:

---- 8< ----
Subject: [PATCH] test_ln_s_add: refresh stat info of fake symbolic links

We have a helper function test_ln_s_add that inserts a symbolic link
into the index even if the file system does not support symbolic links.
There is a small flaw in the emulation path: the added entry does not
pick up stat information of the fake symbolic link from the file system,
as a consequence, the index is not exactly the same as for the "regular"
path (where symbolic links are available). To fix this, just call
git update-index again.

This flaw was revealed by the earlier change that tightened
compare_diff_raw(), because a test case in t4008 depends on the
correctly updated index.

Signed-off-by: Johannes Sixt <j6t@kdbg.org>
---
 t/test-lib-functions.sh | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
index cb132cf..bd1069b 100644
--- a/t/test-lib-functions.sh
+++ b/t/test-lib-functions.sh
@@ -749,7 +749,9 @@ test_ln_s_add () {
 	else
 		printf '%s' "$1" >"$2" &&
 		ln_s_obj=$(git hash-object -w "$2") &&
-		git update-index --add --cacheinfo 120000 $ln_s_obj "$2"
+		git update-index --add --cacheinfo 120000 $ln_s_obj "$2" &&
+		# pick up stat info from the file
+		git update-index "$2"
 	fi
 }
 
-- 
2.3.0.rc0.21.g454f6cd
