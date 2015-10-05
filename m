From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH v2 4/4] clone --dissociate: avoid locking pack files
Date: Mon, 05 Oct 2015 22:33:34 +0200
Organization: gmx
Message-ID: <73315ceddd3ee6aa7d1c2f01bd1b64441b42ad22.1444076827.git.johannes.schindelin@gmx.de>
References: <682991036f1e8e974ed8ecd7d20dbcc6fb86c344.1443469464.git.johannes.schindelin@gmx.de>
 <cover.1444076827.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Max Kirillov <max@max630.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Oct 05 22:33:47 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZjCSA-0002Op-SG
	for gcvg-git-2@plane.gmane.org; Mon, 05 Oct 2015 22:33:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752203AbbJEUdk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Oct 2015 16:33:40 -0400
Received: from mout.gmx.net ([212.227.17.21]:49441 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751800AbbJEUdi (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Oct 2015 16:33:38 -0400
Received: from dscho.org ([87.106.4.80]) by mail.gmx.com (mrgmx102) with
 ESMTPSA (Nemesis) id 0MYcJi-1a4axJ0lJS-00VSGU; Mon, 05 Oct 2015 22:33:35
 +0200
In-Reply-To: <cover.1444076827.git.johannes.schindelin@gmx.de>
X-Sender: johannes.schindelin@gmx.de
User-Agent: Roundcube Webmail/1.1.2
X-Provags-ID: V03:K0:EqBP4VFw7w6MJl5rSCp8+LURzYY8lWGZluOCHJzi1Dk6Sa9GgLC
 rXbdSDbGIF9PXqeSsnpnAK68ruJ1hwb3X28dFNQmRZivRXXKU9aZ6sTemBpsbKNcNI63jsT
 TSSHMnEAZ5PqRl0uUWUAAzrtI3ZkdZDew2Y+ZcIZKlt/ioE1eTuVaIw0D19UsoEOiNWtMet
 oxtZyOLYW/FUulM3jP37A==
X-UI-Out-Filterresults: notjunk:1;V01:K0:JlPx7T7KSE8=:xK3+cKwnXF5oNUWlBIFm79
 hJ11JBQNGzr6vSvm5JPmecl78wcxpzLJwkgJ1PFl2B9ZNNvlj8pMp4jr67Zo8246CrdLhPC+d
 XDzZwILiSM8VQtqTxlhVRuAKiGVuaOaIpYcB0yphBl0c95CFitebyPBiP6hx5EKt5HruanEgk
 9RjwEC2u8WUAmCBezpdA3HXBot/HBgCDo+77dYbMnah0ENaq//3x2jIfmqp/ZVY9Ja7Lxaonx
 OvnPEdY+un722puaNl387A/mjUbq/Echp2FJsYeUAVyYdViujyKQPGIz0naTQuPZkCdne5GKv
 GscDTEgOmPk4A7kWn+yRaA2x4c5OB6V6Q/nASvP5vGtg+M8dxeb/xkT8bWkQ5MzsnDQyK6mhi
 IWrPA7jJ5bE+ERVGQCDcguzcGSLWYa/tsNUnmIfyqTBEBH/FHQiedgUla59hQQICGtqWhBfku
 6UzH3ccoLRPIpWVeZAl53aii2k/rZCUF0KiGJyJnXMKiJirujrDaccPCQM8Em3h3fybv7PPqz
 NyVbo+moL1kXzHFpJzY2P5WOrwk/y7uY3xhLe1xRv6jKYhy+lqEYjap6cqHvfp7B5/XtUYWXM
 +q3fCG59/RGk04m3tsJlthjQjeehiYCfh/tfXUcMJByQ9YVlD0eZyQVcmWe2bpTZFM/JsT1hw
 5pDfNun0cArRbkLHsa3ZBpz2xaOnj1211vrmhkn3NOCyDjPm/D/QY9WhbPZWmMp7LXAJ21EQD
 12eHicQ+YTzNM31681YdurvySfgGwWaln91n6qat+dsOQvridiI4JQB0XayKvgJCVL0lmc7J 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279085>

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
2.5.3.windows.1.3.gc322723
