From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH] clone --dissociate: avoid locking pack files
Date: Mon, 28 Sep 2015 21:44:57 +0200
Organization: gmx
Message-ID: <682991036f1e8e974ed8ecd7d20dbcc6fb86c344.1443469464.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Sep 28 21:45:11 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZgeMI-0005g3-Nk
	for gcvg-git-2@plane.gmane.org; Mon, 28 Sep 2015 21:45:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751610AbbI1TpE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Sep 2015 15:45:04 -0400
Received: from mout.gmx.net ([212.227.17.22]:61434 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751297AbbI1TpC (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Sep 2015 15:45:02 -0400
Received: from dscho.org ([87.106.4.80]) by mail.gmx.com (mrgmx102) with
 ESMTPSA (Nemesis) id 0LrIPo-1af6gw3xs4-013A3u; Mon, 28 Sep 2015 21:44:58
 +0200
X-Sender: johannes.schindelin@gmx.de
User-Agent: Roundcube Webmail/1.1.2
X-Provags-ID: V03:K0:fgzdUX+d1DclTLvRFjTCXYAO3ZOzMi1U/uzdd4lQ5pnzx31Zv/y
 A/jZPfw4j0r+Dja7gdpwRo4fc4/ioa8OU1oCxDhH2JC7JGVpjo0dOi2u5wYaMlysjY0zc+p
 4F5iS2IfljvH9Wbvnr9o257HqbOb3OB+jisY/PBZuGWV64/BzbtNs7QJjc/iSTu9uHVS2vh
 iWfYtDYb1Gx/VU4ATz8ZA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:ynak8780L6A=:CKqrf2ZsEx432skalxYfGV
 3qQCQ9bPj4LIaAmpnxnRWI/GSQzRu1i66wnH5M8687GXsqL9VTEMPr5dYz6lhBcXmZym/98qO
 WleWZxKDt0Dda4Ozku4+g8KHEOz6dJR5h/1ebBl0w4USJI7L+PIuTqf0mIviCqyKa9P4cQdR/
 cyQZns10cVgIoaLvcfH0xIzAY7kRsRSO1Ddip4Mm0HlkjfXlLEY4umoRg0AlHSHwQxc2Fvsu8
 +gO9G+bshmp+dTY7cv+UcxOvOK1eZM85eg+Y6LMn2wJHG9Ull1En3zSUuquoJbCVMyoyNpbN4
 1XjxKRc0ZizFDvqOlgi11ko4pV1B/mrgvMkldpNNESXUtTVlmgEJ5VboicUUPaCqpvwi0YLff
 pPVnE8Tl4TVy9GjP/yaeW90anygldqczRu4Zp03j/cf64OByj3nXuK3M0pfk5g/9smJCAOY/5
 fmN84JTiXtp0mr07VOm9qV1DTA2bkMtmpPfzDfy3nm/pIY3YOWm/ZQwD7w1mIB57uMIbXXkt4
 jRhrD2261q7cfg7cfOmmFWMqrR3x1LHW8ZtLjRXnq/ilZRyBjh3P/gNhCBUGcP24Gn0nShRI8
 0dfKw6ZrUjB6GFL6AwYP3tHVHj0Oa8XEXS1DXffUDCdQVK8EVnLuydbKjkFBypseuRDPThCPQ
 k624gitXO0jmYgtWY2hjHWOtWsLOMHqL0VE3APRsjPaaAWFHVRvtYF1RBpjO4icuziP4qMAwG
 WB0CbwUfHzkfRZ2P2Qn5jsXSdj5XwutwcOzOzw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278746>

When `git clone` is asked to dissociate the repository from the
reference repository whose objects were used, it is quite possible that
the pack files need to be repacked. In that case, the pack files need to
be deleted that were originally hard-links to the reference repository's
pack files.

On platforms where a file cannot be deleted if another process still
holds a handle on it, we therefore need to take pains to release all
pack files and indexes before dissociating.

This fixes https://github.com/git-for-windows/git/issues/446

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 builtin/clone.c            |  9 ++++++++-
 t/t5700-clone-reference.sh | 21 +++++++++++++++++++++
 2 files changed, 29 insertions(+), 1 deletion(-)

diff --git a/builtin/clone.c b/builtin/clone.c
index 578da85..223adc4 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -1064,8 +1064,15 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 	transport_unlock_pack(transport);
 	transport_disconnect(transport);
 
-	if (option_dissociate)
+	if (option_dissociate) {
+		struct packed_git *p;
+
+		for (p = packed_git; p; p = p->next) {
+			close_pack_windows(p);
+			close_pack_index(p);
+		}
 		dissociate_from_references();
+	}
 
 	junk_mode = JUNK_LEAVE_REPO;
 	err = checkout();
diff --git a/t/t5700-clone-reference.sh b/t/t5700-clone-reference.sh
index ef1779f..2250ef4 100755
--- a/t/t5700-clone-reference.sh
+++ b/t/t5700-clone-reference.sh
@@ -188,5 +188,26 @@ test_expect_success 'clone and dissociate from reference' '
 	test_must_fail git -C R fsck &&
 	git -C S fsck
 '
+test_expect_success 'clone, dissociate from partial reference and repack' '
+	rm -fr P Q R &&
+	git init P &&
+	(
+		cd P &&
+		test_commit one &&
+		git repack &&
+		test_commit two &&
+		git repack
+	) &&
+	git clone --bare P Q &&
+	(
+		cd P &&
+		git checkout -b second &&
+		test_commit three &&
+		git repack
+	) &&
+	git clone --bare --dissociate --reference=P Q R &&
+	ls R/objects/pack/*.pack >packs.txt &&
+	test_line_count = 1 packs.txt
+'
 
 test_done
-- 
2.5.3.windows.1.3.gc322723
