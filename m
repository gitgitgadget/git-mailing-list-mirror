From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH v3 2/2] pack-objects: do not get distracted by broken symrefs
Date: Tue, 06 Oct 2015 15:59:11 +0200
Organization: gmx
Message-ID: <f04229b0881eb7518a306ae07fe11ffc9589b1f1.1444139796.git.johannes.schindelin@gmx.de>
References: <xmqqr3lnuzqu.fsf@gitster.mtv.corp.google.com>
 <cover.1444139796.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Oct 06 15:59:28 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZjSm3-0003ng-Ud
	for gcvg-git-2@plane.gmane.org; Tue, 06 Oct 2015 15:59:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752666AbbJFN7S (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Oct 2015 09:59:18 -0400
Received: from mout.gmx.net ([212.227.17.21]:61449 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752575AbbJFN7S (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Oct 2015 09:59:18 -0400
Received: from dscho.org ([87.106.4.80]) by mail.gmx.com (mrgmx103) with
 ESMTPSA (Nemesis) id 0Ma2Lr-1a3ThO1G4V-00LjpV; Tue, 06 Oct 2015 15:59:13
 +0200
In-Reply-To: <cover.1444139796.git.johannes.schindelin@gmx.de>
X-Sender: johannes.schindelin@gmx.de
User-Agent: Roundcube Webmail/1.1.2
X-Provags-ID: V03:K0:IHaDPz6xQno/QT6Audl7DF6vpHKqNiE1vVg+lobUh736NNkTiSM
 lT/pa3GDxci7nxIyUhggYFmfSjZJ30HZJxwDFuNEYZElGQvpHWr7dSLrYPM9jzc8pGFQvEL
 O1+J1NttMxsiakBamrA2jyB8JIieEZn1Vob7SlWqAVbe4udmSe0YF8RMzJQhDczUXFLky67
 Mclx4vdyPU/0oU1SeAJZw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:qXPMDXhB36E=:AC8ITpmfbSEe+IuTgH2O5o
 ngMo0WB+5I+2N6dQ8f9IVrF756wexheemfHfAk7pa4XRcMFlsw1wzVJgNA6RVPI2qSqNNw/rj
 03RhnH1TA9YpzY/Tvw3j1v7Ow/yHRvoLEEQ6cRx6PiIcW/Es5jo9Q5U+OQPTxTPhwJXzRZ0JB
 hPRDYHIxLrnX+HYG1zn3BvxbYkelzlIu4t2NTlMZXAutK+TInj5Z5xV+BNIKyiphHXeJ0Ri6W
 6SwiPZ1qdhqWaJ7Fqu/6Uo+bK3AEPPMGuLgzUTQLiK7xuRdpH2B1YPWjAOw1xQ9BseOOKzkrl
 nTEDmhhK8OSL96/9qoPfDGUVW7hADmFMGJpvqWWOhoiEhfzRcntJCA2dB4zWEQnQ23yVwVfQM
 U01Pga0+LysQdWpBdqebWxG5oOMHpxhOGSVCnv3wCmZS7x49mOZr+SZBSNmRItJdyMHpfIyuc
 aEwZjnlidzW2NqJX3C/zzx1IA+4xsLHH001CbUlab/gFa5VTixzOxxbAbxZBGpT/0TC9bRiOm
 48sxjhPE1QgQtv7ZB96RyFmX5fbRAK2UnR54GUits6a5tKJfqBLL/LrP2p5XOsdy9NrcxYsxu
 edLLFnFRb2j+bFGxYNz0Q97v2Ac9GGrWtiKa4pBbqFxFQNSIurbTfojmBIwQG1htKfoEI9RIa
 jb7GJkxDyl7QNQH2t68vpB/2H5Cz3Ef5c17/5YZdxSSg6RwP9UJJQXL2xZEB1MxLyTuLm/idY
 bfpCKTAcs5nZu+7DuHVPxzmZeyHTPeO9oMAQ42DAb6xCP6+Haym6kS5Xl4mK084umaRAIKiX 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279145>

It is quite possible for, say, a remote HEAD to become broken, e.g.
when the default branch was renamed.

We should still be able to pack our objects when such a thing happens;
simply ignore broken symrefs (because they cannot matter for the packing
process anyway).

This fixes https://github.com/git-for-windows/git/issues/423

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 reachable.c   | 8 +++++++-
 t/t6500-gc.sh | 2 +-
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/reachable.c b/reachable.c
index 9cff25b..43616d4 100644
--- a/reachable.c
+++ b/reachable.c
@@ -25,9 +25,15 @@ static void update_progress(struct connectivity_progress *cp)
 static int add_one_ref(const char *path, const struct object_id *oid,
 		       int flag, void *cb_data)
 {
-	struct object *object = parse_object_or_die(oid->hash, path);
 	struct rev_info *revs = (struct rev_info *)cb_data;
+	struct object *object;
 
+	if ((flag & REF_ISSYMREF) && (flag & REF_ISBROKEN)) {
+		warning("symbolic ref is dangling: %s", path);
+		return 0;
+	}
+
+	object = parse_object_or_die(oid->hash, path);
 	add_pending_object(revs, object, "");
 
 	return 0;
diff --git a/t/t6500-gc.sh b/t/t6500-gc.sh
index 9a3a285..5d7d414 100755
--- a/t/t6500-gc.sh
+++ b/t/t6500-gc.sh
@@ -30,7 +30,7 @@ test_expect_success 'gc -h with invalid configuration' '
 	test_i18ngrep "[Uu]sage" broken/usage
 '
 
-test_expect_failure 'gc removes broken refs/remotes/<name>/HEAD' '
+test_expect_success 'gc is not aborted due to a stale symref' '
 	git init remote &&
 	(
 		cd remote &&
-- 
2.6.1.windows.1
