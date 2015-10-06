From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH v3 4/4] clone --dissociate: avoid locking pack files
Date: Tue, 06 Oct 2015 15:18:47 +0200
Organization: gmx
Message-ID: <282ac01bc4e83aaa0cee4bd9e6de63d91ca93d30.1444131898.git.johannes.schindelin@gmx.de>
References: <682991036f1e8e974ed8ecd7d20dbcc6fb86c344.1443469464.git.johannes.schindelin@gmx.de>
 <cover.1444131898.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Max Kirillov <max@max630.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Oct 06 15:18:57 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZjS8v-00050C-32
	for gcvg-git-2@plane.gmane.org; Tue, 06 Oct 2015 15:18:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752585AbbJFNSx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Oct 2015 09:18:53 -0400
Received: from mout.gmx.net ([212.227.15.18]:53856 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752365AbbJFNSw (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Oct 2015 09:18:52 -0400
Received: from dscho.org ([87.106.4.80]) by mail.gmx.com (mrgmx003) with
 ESMTPSA (Nemesis) id 0Lw1vh-1ahW693NiH-017pmm; Tue, 06 Oct 2015 15:18:48
 +0200
In-Reply-To: <cover.1444131898.git.johannes.schindelin@gmx.de>
X-Sender: johannes.schindelin@gmx.de
User-Agent: Roundcube Webmail/1.1.2
X-Provags-ID: V03:K0:dpoJ1sZChk8QaQpCnntG8UCWo/GTd5b7uo7bN4i52o64EkQCyg8
 sF9bnE2tkPNd3qsWg8omcQAU6Qxh1Le4grjX4rYCHSQXXj0hY2U/8dDJUBdULjCu09mY5yM
 y/Bzm+oQmuzHqBs7QpGNJM1zsMlSOa6JZvT/7NxmCkdao8BL858G3Jv+l/oqKFb76K2cgfm
 Qxt5Q5LlCxUNL/SA62DRw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:pcYETewj9+Y=:MderuSCRDwMXxNoTKBcaTO
 eI17xUwK6nFZYv5U5cx212LuK5wrIxgdAfmfJ/ppo3tdtw+dhup2r7IRd3p+lPl4uSTIl5ww9
 Tamsdg+IZgCq4ZCJ7T3rmSFrE35LjfOncjf+TUtyIp9cL1C0gMTc/McgCsTfPm7d25RjvuZ7/
 koziZ+Rx5fIkbkcBgmQ2lr5C851Y5WHbDwJMlI+QaGfpu1DtirdeH/F2quqPbA2Xi7DNbtFUy
 p/hAMHngzVbb0pneERWZa0k2Szn4AuOnQKfn7tJsrJvbGW1qFHpPp1MxkhFuXyE2CPNxsc4dE
 HM0d5qyFsU/5XcJ/qST/8X8S8S1qCRDQW2meyS2z8CLP0NH1CJlopuIJZjRfI0UoXliqmqQvK
 XntS6lOTOY85Xzk5deoQFRIxs/SUUHGyItRTL9lGBnsYWFspXIwk/5LTcUDgJOleirFlnydrq
 MAzidg6JJZ67M4HEoBQNsNTEdmSjOh3SV3nXiuOxRUY/AdL8zjRiEUljp5nSzdMhjaBlYaWYI
 pobsPVviSS37938MQwGe0KK6WzDHewO0kP3qIVaoFr51xSsIiTN3nb6H640wbg0EdTkCVXSHF
 P4im3dYpFq3YE7sSDdG2+AAkix3aHHruWr/op129djsexNFdxEkUxUemKuUqfIyr3voaWQzxV
 KSH4iWKczUSka+gajk2z6tkmReGYPjAyX+GagmBPTDBSSBptSZvy5roddPprkFonONk4PfNHa
 KDM64iJrkajdZY6g0JTmd6gXFV3D199gjrStkxmyh78LHYOrnB1zFbkVC4KzHTYufd4nyIvK 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279140>

When `git clone` is asked to dissociate the repository from the
reference repository whose objects were used, it is quite possible that
the pack files need to be repacked. In that case, the pack files need to
be deleted that were originally hard-links to the reference repository's
pack files.

On platforms where a file cannot be deleted if another process still
holds a handle on it, we therefore need to take pains to release all
pack files and indexes before dissociating.

This fixes https://github.com/git-for-windows/git/issues/446

The test case to demonstrate the breakage technically does not need to
be run on Linux or MacOSX. It won't hurt, either, though.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 builtin/clone.c            | 4 +++-
 t/t5700-clone-reference.sh | 2 +-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/builtin/clone.c b/builtin/clone.c
index 578da85..cc896e2 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -1064,8 +1064,10 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 	transport_unlock_pack(transport);
 	transport_disconnect(transport);
 
-	if (option_dissociate)
+	if (option_dissociate) {
+		close_all_packs();
 		dissociate_from_references();
+	}
 
 	junk_mode = JUNK_LEAVE_REPO;
 	err = checkout();
diff --git a/t/t5700-clone-reference.sh b/t/t5700-clone-reference.sh
index f7cec85..2250ef4 100755
--- a/t/t5700-clone-reference.sh
+++ b/t/t5700-clone-reference.sh
@@ -188,7 +188,7 @@ test_expect_success 'clone and dissociate from reference' '
 	test_must_fail git -C R fsck &&
 	git -C S fsck
 '
-test_expect_failure MINGW 'clone, dissociate from partial reference and repack' '
+test_expect_success 'clone, dissociate from partial reference and repack' '
 	rm -fr P Q R &&
 	git init P &&
 	(
-- 
2.6.1.windows.1
