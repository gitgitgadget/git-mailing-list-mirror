Return-Path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3C24020179
	for <e@80x24.org>; Mon, 20 Jun 2016 10:59:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932086AbcFTK7l (ORCPT <rfc822;e@80x24.org>);
	Mon, 20 Jun 2016 06:59:41 -0400
Received: from mout.gmx.net ([212.227.17.22]:64120 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754564AbcFTK7g (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Jun 2016 06:59:36 -0400
Received: from virtualbox ([37.24.143.194]) by mail.gmx.com (mrgmx101) with
 ESMTPSA (Nemesis) id 0LzXTy-1bRRiX19WM-014gcf; Mon, 20 Jun 2016 12:59:11
 +0200
Date:	Mon, 20 Jun 2016 12:55:49 +0200 (CEST)
From:	Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:	git@vger.kernel.org
cc:	Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v2 5/7] format-patch: explicitly switch off color when writing
 to files
In-Reply-To: <cover.1466420060.git.johannes.schindelin@gmx.de>
Message-ID: <2abbf428b42795f930c2338233b71f0f299e1d41.1466420060.git.johannes.schindelin@gmx.de>
References: <cover.1466244194.git.johannes.schindelin@gmx.de> <cover.1466420060.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:XItD81mBy0t62uFRN1n+vyvm/eK3zUE1cSYguyJVwjP0j9sZEv6
 ZBjds3Y1uQfmFakSEF++HAlY+Ce86iSVhTyUVfYSn4uezvjmjAr9ydmfoyBVk/65K1KCHwB
 jtQskBEjBz22+PI+YWLsIZ3ZCcBCszOjpXiF153C2zjEOpcS97MvPKWYKXFBZ3NhZLDlq2b
 wZ2ObQgeS3bz262a4VcIg==
X-UI-Out-Filterresults:	notjunk:1;V01:K0:AI0XucdQmWo=:5cQ8CGvNjhBlcRiAES+X/O
 1yTlR2+1dO8xEKFLPgD1egapmPPiT+o/cpptNzunu0XnmX51RhPySgkemXOV0yrHqxtCapCxh
 cuw8KiG2z+ch/usY2ZpPh+hHD8tjfb6NNQ3abVvvPjhxeN76I36b8WZoH3AizNe8tSWfi3JNc
 JIudILCPp13HPsBhMNOKeMMeVZ9/wJsrUWgLA1HxgMcOYJ4s4MWGDEU7iZk0NEbplWkQANl71
 temoo8BnW0EVD2YilVnNSItBP/PG7pcAJL0JNkE4CQ7mRJvwG/tqQ+5Z4uX0ILpOl1sU+ZAPj
 WE6v93SqIA/2HP/MvTznfC/yqDTukTK42TPT763UgYgw/DIYPMFfXPyLz8g+WzNlOAoZUar7C
 uFsEn0o2vDnu6e6pgO8xOF54aM/A32WnxiwmyBfsp+rcraQTvyXu6/6TuEVy/AUZVuNxqwTT3
 Q3DY2f2Mc5gLh/a4VmaPjYJB7C3N9QXcrGqFzjSXBlXV5RXJdz12FGwJkxOaaMUzxRZSyuKvF
 X912pNZe5Er7WCnrRZs3fqR/kqySnpXT/byZLCghTihUuLVx7svmDrBh55fUMWLupgh3shBuC
 rLXR5wmSUglZpC7AUoxLgcf0X0cNV+shZd+6yP9jaS2472tYo5aoTJFO322nv6wt9z9HU1OJE
 MquuiLty9VL70ZShBkBFheqyI4STR9HCN4PvycPXYhKrNLsPj0mlDYwArlUS4Gc7lPJTWBG4n
 gQycpePxbTF8UeKGvhYlzuwWo08S0YOojI8/0UAguUaFB1Y5YheybNBtSSHEhM6AXSRa9kURP
 KGbCgoE
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

We rely on the auto-detection ("is stdout a terminal?") to determine
whether to use color in the output of format-patch or not. That happens
to work because we freopen() stdout when redirecting the output to files.

However, we are about to fix that work-around, in which case the
auto-detection has no chance to guess whether to use color or not.

But then, we do not need to guess to begin with. We know that we do not
want to use ANSI color sequences in the output files. So let's just be
explicit about our wishes.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 builtin/log.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/builtin/log.c b/builtin/log.c
index 099f4f7..abd889b 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -1569,6 +1569,7 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 		setup_pager();
 
 	if (output_directory) {
+		rev.diffopt.use_color = 0;
 		if (use_stdout)
 			die(_("standard output, or directory, which one?"));
 		if (mkdir(output_directory, 0777) < 0 && errno != EEXIST)
-- 
2.9.0.119.g370c5a9


