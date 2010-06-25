From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: [PATCH 1/2] git submodule: ignore dirty submodules for summary and
 status
Date: Fri, 25 Jun 2010 16:56:02 +0200
Message-ID: <4C24C382.6030900@web.de>
References: <4C24C34B.20403@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Johan Herland <johan@herland.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Andy Parkins <andyparkins@gmail.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Jun 25 16:56:55 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OSAKs-000430-GY
	for gcvg-git-2@lo.gmane.org; Fri, 25 Jun 2010 16:56:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756385Ab0FYO4n (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Jun 2010 10:56:43 -0400
Received: from fmmailgate02.web.de ([217.72.192.227]:40386 "EHLO
	fmmailgate02.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756342Ab0FYO4m (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Jun 2010 10:56:42 -0400
Received: from smtp08.web.de  ( [172.20.5.216])
	by fmmailgate02.web.de (Postfix) with ESMTP id 50FDC1690333E;
	Fri, 25 Jun 2010 16:56:03 +0200 (CEST)
Received: from [80.128.126.113] (helo=[192.168.178.26])
	by smtp08.web.de with asmtp (WEB.DE 4.110 #4)
	id 1OSAK3-0008Oi-00; Fri, 25 Jun 2010 16:56:03 +0200
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de; rv:1.9.1.9) Gecko/20100317 Thunderbird/3.0.4
In-Reply-To: <4C24C34B.20403@web.de>
X-Sender: Jens.Lehmann@web.de
X-Provags-ID: V01U2FsdGVkX19bvYySDeEjovjJomt0Q3NC/w6iJjKz/XmfVQjh
	huzI1ASTiIJ/UyIaw1wZsEgtCgIg3rVnYIzIAWnkVG2Iagu30I
	TRCl97w+qZhdA7zV9WjQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149690>

The summary and status commands only care about submodule commits, so it is
rather pointless that they check for dirty work trees. This saves the time
needed to scan the submodules work tree. Even "git status" profits from these
savings when the status.submodulesummary config option is set, as this lead to
traversing the submodule work trees twice, once for status and once again for
the submodule summary. And if the submodule was just dirty, submodule summary
produced rather meaningless output anyway:

 * sub 1234567...1234567 (0):

Signed-off-by: Jens Lehmann <Jens.Lehmann@web.de>
---
 git-submodule.sh |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/git-submodule.sh b/git-submodule.sh
index 8c562a7..d9950c2 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -580,7 +580,7 @@ cmd_summary() {

 	cd_to_toplevel
 	# Get modified modules cared by user
-	modules=$(git $diff_cmd $cached --raw $head -- "$@" |
+	modules=$(git $diff_cmd $cached --ignore-submodules=dirty --raw $head -- "$@" |
 		sane_egrep '^:([0-7]* )?160000' |
 		while read mod_src mod_dst sha1_src sha1_dst status name
 		do
@@ -594,7 +594,7 @@ cmd_summary() {

 	test -z "$modules" && return

-	git $diff_cmd $cached --raw $head -- $modules |
+	git $diff_cmd $cached --ignore-submodules=dirty --raw $head -- $modules |
 	sane_egrep '^:([0-7]* )?160000' |
 	cut -c2- |
 	while read mod_src mod_dst sha1_src sha1_dst status name
@@ -760,7 +760,7 @@ cmd_status()
 			continue;
 		fi
 		set_name_rev "$path" "$sha1"
-		if git diff-files --quiet -- "$path"
+		if git diff-files --ignore-submodules=dirty --quiet -- "$path"
 		then
 			say " $sha1 $displaypath$revname"
 		else
-- 
1.7.1.757.g0ad3c.dirty
