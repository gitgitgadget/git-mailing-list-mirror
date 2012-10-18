From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: What can cause empty GIT_AUTHOR_NAME for 'git filter-branch --tree-filter'
 on Solaris?
Date: Thu, 18 Oct 2012 07:31:35 +0200
Message-ID: <507F9437.2070501@viscovery.net>
References: <1109432467.20121017104729@gmail.com> <507E5CE0.10002@viscovery.net> <1013956402.20121017125847@gmail.com> <20121017220912.GA21742@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Ilya Basin <basinilya@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Oct 18 07:31:53 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TOii0-0004w3-20
	for gcvg-git-2@plane.gmane.org; Thu, 18 Oct 2012 07:31:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754134Ab2JRFbk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Oct 2012 01:31:40 -0400
Received: from so.liwest.at ([212.33.55.24]:37617 "EHLO so.liwest.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754094Ab2JRFbj (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Oct 2012 01:31:39 -0400
Received: from [81.10.228.254] (helo=theia.linz.viscovery)
	by so.liwest.at with esmtpa (Exim 4.77)
	(envelope-from <j.sixt@viscovery.net>)
	id 1TOihj-0007LN-Ta; Thu, 18 Oct 2012 07:31:36 +0200
Received: from [192.168.1.95] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id 8D8481660F;
	Thu, 18 Oct 2012 07:31:35 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:16.0) Gecko/20121010 Thunderbird/16.0.1
In-Reply-To: <20121017220912.GA21742@sigill.intra.peff.net>
X-Enigmail-Version: 1.4.5
X-Spam-Score: -1.0 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207959>

Am 10/18/2012 0:09, schrieb Jeff King:
> -	lid="$(echo "$1" | tr "[A-Z]" "[a-z]")"
> -	uid="$(echo "$1" | tr "[a-z]" "[A-Z]")"
> +	lid="$(echo "$1" | tr ABCDEFGHIJKLMNOPQRSTUVWXYZ abcdefghijklmnopqrstuvwxyz)"
> +	uid="$(echo "$1" | tr abcdefghijklmnopqrstuvwxyz ABCDEFGHIJKLMNOPQRSTUVWXYZ)"
> 
> That seems like crazy overkill, but it at least will let us double-check
> that the tr sequences are the problem.

Right. But we should really be doing something like this instead to save a
few subprocesses.

-- Hannes

diff --git a/git-filter-branch.sh b/git-filter-branch.sh
index 178e453..018e56e 100755
--- a/git-filter-branch.sh
+++ b/git-filter-branch.sh
@@ -68,8 +68,8 @@ eval "$functions"
 # "author" or "committer

 set_ident () {
-	lid="$(echo "$1" | tr "[A-Z]" "[a-z]")"
-	uid="$(echo "$1" | tr "[a-z]" "[A-Z]")"
+	uid=$1
+	lid=$2
 	pick_id_script='
 		/^'$lid' /{
 			s/'\''/'\''\\'\'\''/g
@@ -320,9 +320,9 @@ while read commit parents; do
 	git cat-file commit "$commit" >../commit ||
 		die "Cannot read commit $commit"

-	eval "$(set_ident AUTHOR <../commit)" ||
+	eval "$(set_ident AUTHOR author <../commit)" ||
 		die "setting author failed for commit $commit"
-	eval "$(set_ident COMMITTER <../commit)" ||
+	eval "$(set_ident COMMITTER committer <../commit)" ||
 		die "setting committer failed for commit $commit"
 	eval "$filter_env" < /dev/null ||
 		die "env filter failed: $filter_env"
