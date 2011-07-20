From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCHv2] Make filter-branch work with many branches
Date: Wed, 20 Jul 2011 18:42:33 +0200
Message-ID: <4E270579.7060309@kdbg.org>
References: <CA809344-F7C2-4A41-B4F7-15B5EEB9B7E2@apple.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Dave Zarzycki <zarzycki@apple.com>
X-From: git-owner@vger.kernel.org Wed Jul 20 18:42:44 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QjZr8-0008AX-Ad
	for gcvg-git-2@lo.gmane.org; Wed, 20 Jul 2011 18:42:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751616Ab1GTQmg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Jul 2011 12:42:36 -0400
Received: from bsmtp4.bon.at ([195.3.86.186]:30191 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751302Ab1GTQmg (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Jul 2011 12:42:36 -0400
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id 9F486130065;
	Wed, 20 Jul 2011 18:42:33 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
	by dx.sixt.local (Postfix) with ESMTP id 2613C19F3B9;
	Wed, 20 Jul 2011 18:42:33 +0200 (CEST)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; de; rv:1.9.2.18) Gecko/20110616 SUSE/3.1.11 Thunderbird/3.1.11
In-Reply-To: <CA809344-F7C2-4A41-B4F7-15B5EEB9B7E2@apple.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177542>

Am 20.07.2011 15:42, schrieb Dave Zarzycki:
> -rev_args=$(git rev-parse --revs-only "$@")
> +rev_parse_args="$@"

This won't do what you expect when "$@" should expand to more than one
word.

I meant something like the following. Warning: Completely untested.

diff --git a/git-filter-branch.sh b/git-filter-branch.sh
index 962a93b..d0a933e 100755
--- a/git-filter-branch.sh
+++ b/git-filter-branch.sh
@@ -274,7 +274,7 @@ else
 	remap_to_ancestor=t
 fi
 
-rev_args=$(git rev-parse --revs-only "$@")
+git rev-parse --revs-only "$@" >../revargs || exit
 
 case "$filter_subdir" in
 "")
@@ -287,7 +287,7 @@ case "$filter_subdir" in
 esac
 
 git rev-list --reverse --topo-order --default HEAD \
-	--parents --simplify-merges $rev_args "$@" > ../revs ||
+	--parents --simplify-merges --stdin "$@" <../revargs >../revs ||
 	die "Could not get the commits"
 commits=$(wc -l <../revs | tr -d " ")
 
