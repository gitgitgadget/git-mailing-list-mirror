From: Johannes Sixt <j.sixt@viscovery.net>
Subject: [PATCH] git-remote-testgit: avoid process substitution
Date: Thu, 25 Apr 2013 07:56:19 +0200
Message-ID: <5178C583.6000703@viscovery.net>
References: <7vvc7enxco.fsf@alter.siamese.dyndns.org> <7vwqrtgi1r.fsf@alter.siamese.dyndns.org> <51779052.8020507@viscovery.net> <CAMP44s1oX_m0d+2Z3+VkafOhT1bZK_9Z5m1ex456DMdAidEKeg@mail.gmail.com> <5177980A.4090305@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 25 07:56:35 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UVFAY-0004e4-UC
	for gcvg-git-2@plane.gmane.org; Thu, 25 Apr 2013 07:56:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751973Ab3DYF4a (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Apr 2013 01:56:30 -0400
Received: from so.liwest.at ([212.33.55.23]:22790 "EHLO so.liwest.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751063Ab3DYF4a (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Apr 2013 01:56:30 -0400
Received: from [81.10.228.254] (helo=theia.linz.viscovery)
	by so.liwest.at with esmtpa (Exim 4.77)
	(envelope-from <j.sixt@viscovery.net>)
	id 1UVFAJ-0001sD-W9; Thu, 25 Apr 2013 07:56:22 +0200
Received: from [192.168.1.95] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id A069D1660F;
	Thu, 25 Apr 2013 07:56:19 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:17.0) Gecko/20130328 Thunderbird/17.0.5
In-Reply-To: <5177980A.4090305@viscovery.net>
X-Spam-Score: -1.0 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222346>

From: Johannes Sixt <j6t@kdbg.org>

Bash on Windows does not implement process substitution.

Signed-off-by: Johannes Sixt <j6t@kdbg.org>
---
Am 4/24/2013 10:30, schrieb Johannes Sixt:
> Am 4/24/2013 10:04, schrieb Felipe Contreras:
>> On Wed, Apr 24, 2013 at 2:57 AM, Johannes Sixt <j.sixt@viscovery.net> wrote:
>>> Am 4/23/2013 21:31, schrieb Junio C Hamano:
>>>> * fc/transport-helper-error-reporting (2013-04-17) 9 commits
>>>>   (merged to 'next' on 2013-04-22 at 5ba6467)
>>>>  + transport-helper: update remote helper namespace
>>>>  + transport-helper: trivial code shuffle
>>>>  + transport-helper: warn when refspec is not used
>>>>  + transport-helper: clarify pushing without refspecs
>>>>  + transport-helper: update refspec documentation
>>>>  + transport-helper: clarify *:* refspec
>>>>  + transport-helper: improve push messages
>>>>  + transport-helper: mention helper name when it dies
>>>>  + transport-helper: report errors properly
>>>>
>>>>  Update transport helper to report errors and maintain ref hierarchy
>>>>  used to keep track of remote helper state better.
>>>>
>>>>  Will merge to 'master'.
>>>
>>> Please don't, yet. There is a new test case that fails on Windows. I'll
>>> have to figure out a work-around.
>>
>> Which test case? If it it failed, it failed before this series. I
>> don't see how this new series would affect anything.
> 
> The test introduced in the commit at the tip: 'push update refs'.

Here is a fix. It assumes that the list of refs after the import is
a superset of the refs before the import. (Can refs be deleted
via fast-import?)

 git-remote-testgit | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/git-remote-testgit b/git-remote-testgit
index 23c9d40..e99d5fa 100755
--- a/git-remote-testgit
+++ b/git-remote-testgit
@@ -91,13 +91,15 @@ do
 
 		git fast-import "${testgitmarks_args[@]}" --quiet
 
-		after=$(git for-each-ref --format='%(refname) %(objectname)')
-
 		# figure out which refs were updated
-		join -e 0 -o '0 1.2 2.2' -a 2 <(echo "$before") <(echo "$after") |
-		while read ref a b
+		git for-each-ref --format='%(refname) %(objectname)' |
+		while read ref a
 		do
-			test $a == $b && continue
+			case "$before" in
+			*"$ref $a"*)
+				continue
+				;;
+			esac
 			echo "ok $ref"
 		done
 
-- 
1.8.2.388.g36592d7
