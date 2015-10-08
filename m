From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH 2/2] pull --rebase: reinstate helpful message on abort
Date: Thu, 08 Oct 2015 22:35:30 +0200
Organization: gmx
Message-ID: <47e66f159e8929879f22504a180330e3fa020ee9.1444336120.git.johannes.schindelin@gmx.de>
References: <cover.1444336120.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Brendan Forster <shiftkey@github.com>, git@vger.kernel.org
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Thu Oct 08 22:35:44 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZkHud-0005Yb-FR
	for gcvg-git-2@plane.gmane.org; Thu, 08 Oct 2015 22:35:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758465AbbJHUff (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Oct 2015 16:35:35 -0400
Received: from mout.gmx.net ([212.227.17.22]:58872 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758460AbbJHUff (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Oct 2015 16:35:35 -0400
Received: from dscho.org ([87.106.4.80]) by mail.gmx.com (mrgmx102) with
 ESMTPSA (Nemesis) id 0Mg0IT-1ZwZzq0m2P-00NRwh; Thu, 08 Oct 2015 22:35:31
 +0200
In-Reply-To: <cover.1444336120.git.johannes.schindelin@gmx.de>
X-Sender: johannes.schindelin@gmx.de
User-Agent: Roundcube Webmail/1.1.2
X-Provags-ID: V03:K0:KSn5OhDcIJP1FOtHGdQb4zWe8AcA66oHii6522PPGJGrLiaEFv1
 dLSgkEoJQLqKHpA5hlj8NABzEo9vgIw3IbtKvcgcHofHAPNVqotSIPGVLnZ3jTsnHLMZiFe
 fV60MA2w4qbuvgV6hMenh7MmRNAgeQtXhIcmlLF9ZLEcZBROSJ1Tr7wbQbUllJ9nKBNDJue
 80PeLXeJEdrT2syWOnE5Q==
X-UI-Out-Filterresults: notjunk:1;V01:K0:p9k+LzzYsyQ=:a8Asb+sNkfggX7V3S+PS4Y
 kI5uz5OUwUt/yxxbBDQMI53W74ecjdw0JS7Ojwji06gHA3F9dO2Kt6Id+0pztk+S004m57Dif
 xuDuj3AkjlT33WyXQJCWNFk4qSNik9JtOl5MZwLdCOFglutcOxCAwVh5EadrGXp6D98fHhjpM
 0u+o9qjTQ24FmeJHTpkjPs/GcIIYzrabHGdGCBKKfmrWQ+IGDLb8tV4m8hR90YbFa4+oKTzV4
 yJiawDK7WaMsr8HXV8U+llebttNIJpxV8KZUezgFnzLpoXmlUKXBPewpDW7YlkPdHukzsNRp2
 My3lm4/PF90dKK7N0LPBYMQfNl6/I3zLBqZP5QxEk4vB1GMfAohDTsSNm1mwbcHJXu8cYOy2S
 ZhQ9F6GB16+KtYdUFvS0Bb4Qdd20ij2vBaMYacUfWQiOFgjfGiInqNl1z1EbCRS6JhoEWNCrw
 25UlFTB22+luF0LVhzuspYBlj7cwp2cXOSwzo+tFdEVg7cagYuEr5AXLchtzYh4UY84SpBHp5
 XhNjVELubvNJhj+Y2gy+DCcp4GkR/WHt2GfaG4EPNtK9ZucMU2F5N16B09G1cho8jpD/RSmtT
 rwrxGTW0vjI/C31PkwEXV8/Qm788KZgRcxzGHwCp36b6ytaKmORyC63kjcU9kIdt8roYIiOmy
 Y8CWfTj7m1d99xqiNaH+3EuBrWD6J/NmdTIotc9pYWSgA9OjiGpMIxgfYoEz0quX1wwlH0jnc
 dGYVBS9JixkkoORj/Sfc5YZ7rUcQ8GW5lc3pMwDLW7hNJtYaUQokacxkBELoAuPBKkraUEs6 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279277>

When calling `git pull --rebase`, things can go wrong. In such a case,
we want to tell the user about the most common ways out of this fix:

	Patch failed at [...]
	[...]

	When you have resolved this problem, run "git rebase
	--continue". If you prefer to skip this patch, run "git rebase
	--skip" instead. To check out the original branch and stop
	rebasing, run "git rebase --abort".

However, with the switch to the builtin `git-am` we call the merge
recursive function directly, which usually die()s in case of an
error. Not what we want.

So let's set the newly-introduced `gentle` flag to get a chance to
print the helpful advice.

Reported by Brendan Forster.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 builtin/am.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/builtin/am.c b/builtin/am.c
index 4f77e07..c472937 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -1653,6 +1653,7 @@ static int fall_back_threeway(const struct am_state *state, const char *index_pa
 
 	init_merge_options(&o);
 
+	o.gentle = 1;
 	o.branch1 = "HEAD";
 	his_tree_name = xstrfmt("%.*s", linelen(state->msg), state->msg);
 	o.branch2 = his_tree_name;
-- 
2.6.1.windows.1
