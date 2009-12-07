From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: [PATCH] git-gui: Unstaging a partly staged entry didn't update file_states
 correctly
Date: Mon, 07 Dec 2009 21:35:59 +0100
Message-ID: <4B1D672F.3030805@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Mon Dec 07 21:36:14 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NHkJa-0004Jh-7f
	for gcvg-git-2@lo.gmane.org; Mon, 07 Dec 2009 21:36:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935139AbZLGUgD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Dec 2009 15:36:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934943AbZLGUgC
	(ORCPT <rfc822;git-outgoing>); Mon, 7 Dec 2009 15:36:02 -0500
Received: from fmmailgate03.web.de ([217.72.192.234]:51155 "EHLO
	fmmailgate03.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934939AbZLGUgB (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Dec 2009 15:36:01 -0500
Received: from smtp07.web.de (fmsmtp07.dlan.cinetic.de [172.20.5.215])
	by fmmailgate03.web.de (Postfix) with ESMTP id F3AA6137B9DAC;
	Mon,  7 Dec 2009 21:36:05 +0100 (CET)
Received: from [80.128.124.10] (helo=[192.168.178.26])
	by smtp07.web.de with asmtp (WEB.DE 4.110 #314)
	id 1NHkJP-0001wn-00; Mon, 07 Dec 2009 21:36:03 +0100
User-Agent: Thunderbird 2.0.0.23 (X11/20090812)
X-Sender: Jens.Lehmann@web.de
X-Provags-ID: V01U2FsdGVkX1/XZSFXd5N92lC1n+xXfwrGCIuswm7n4nde4TKE
	bO3ldWOJqwvfcmfdLtWLSIpc0z5vDJWb4Bl1LIZnGqJ7Som8xW
	edXHLJ0wiPJwJRc4WrPg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134780>

When unstaging a partly staged file or submodule, the file_states list
was not updated properly (unless unstaged linewise). Its index_info part
did not contain the former head_info as it should have but kept its old
value.

This seems not to have had any bad effects but diminishes the value of
the file_states list for future enhancements.

Signed-off-by: Jens Lehmann <Jens.Lehmann@web.de>
---

I noticed this while whipping up another - soon to be released - patch
where the file_states list is used to access the hash values of staged
and unstaged changes.

AFAICS this buglet did not have negative effects until now because the
index_info hash value is not used.


 git-gui/git-gui.sh |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/git-gui/git-gui.sh b/git-gui/git-gui.sh
index 037a1f2..9495789 100755
--- a/git-gui/git-gui.sh
+++ b/git-gui/git-gui.sh
@@ -1613,6 +1613,9 @@ proc merge_state {path new_state {head_info {}} {index_info {}}} {
 	} elseif {$s0 ne {_} && [string index $state 0] eq {_}
 		&& $head_info eq {}} {
 		set head_info $index_info
+	} elseif {$s0 eq {_} && [string index $state 0] ne {_}} {
+		set index_info $head_info
+		set head_info {}
 	}

 	set file_states($path) [list $s0$s1 $icon \
-- 
1.6.6.rc1.245.gcec33.dirty
