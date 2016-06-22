Return-Path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 575332018C
	for <e@80x24.org>; Wed, 22 Jun 2016 14:41:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752734AbcFVOl2 (ORCPT <rfc822;e@80x24.org>);
	Wed, 22 Jun 2016 10:41:28 -0400
Received: from mout.gmx.net ([212.227.15.18]:62104 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752272AbcFVOl0 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Jun 2016 10:41:26 -0400
Received: from virtualbox ([37.24.143.194]) by mail.gmx.com (mrgmx003) with
 ESMTPSA (Nemesis) id 0LzcIM-1bSI7i3hgo-014nCU; Wed, 22 Jun 2016 16:41:09
 +0200
Date:	Wed, 22 Jun 2016 16:41:07 +0200 (CEST)
From:	Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:	git@vger.kernel.org
cc:	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] diff: let --output=<file> default to --no-color
Message-ID: <100cea0edf4f0986c000eb945a5e5955b8b59787.1466604435.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:ij+XXn+VIqAa/okBKchfj2onbhY14BZxJQwyv2VLiQl17AhlFFs
 jlnf88tKae6nw1gDJ0vonduQTcVVHeIBMu2t58L/N4LJ9bxFCXFhPCPTLzvpWpa+HgAxFUC
 gjfybSEhfddnkQOeG+dxy3BPl2haidZSGEJ3GcOSGopu2mRyghTR5tlOeG0bN3HY68pF0pc
 fPp38Bh199oGKAstBYJXA==
X-UI-Out-Filterresults:	notjunk:1;V01:K0:CAcs8qaYoBQ=:S8wIpVEqMQfyeryIX4Dopq
 fz/GXw8SDcx93DZePZPW2MBXqGmuiQy9PTNjjZ/4mzx4xsocbFTef2S93u4uJMtwc1RU17iCM
 JtA38dPcPy2g3MMeF8rRMM8l/6G7jPRKBtiwe8eETjjL28w/0s1ST91bZ/u3tYm8ONEbzs4HN
 BWwZB9ul6p81EqOKHInMvjnLy3oQzFlgUBa0vhtfkp8kUFNg0o2rRvwtnSw4caALg+e0jdlPq
 e3+9r4hGa8QCYPwhm6LKkcKTzneQmk1RumCtjwJwZnnvLdh6aKkGut6GmpzESK3W5lHtDM+C8
 hc7sBnsK/0xnAbAwfwRqBJlzHKi2SVfqFmo2gC29ja+ltGmUsONWZstHCPwAA7HCMdi+TNoAz
 ckORSjeo1+nql+x5q6GjFaYdWCqZuP/EtrOLOfdTQiqFIdQzCxiYIyAJflOvkJ2GRj2sIQ8MG
 90N0syGr/wXy268pO01NkJDxPhiFF4fjtqCuXIvXtsbDNG5t0Q8I70bEPiJDhjl3r0F9+c38r
 q9HRc4yR9Gzta+EBiTQt3jiM9Qg00j5GyZgsieTwf7rWyIrcTqRRbs5TdTHPdrFDZDbquTE0E
 A3g0iY6hHERHMx5an6ev7tsTby90QK0GzOQu39AsaypP0jYmeU/leTzrgskDBeG1rBk/4qH66
 YHGekvrRH6fNhgDxirKvP77gMUP/Kz6C9aW2J1vnHpXCqPDnlQwD6rtrDsp0ZgOgZ+vMzanoq
 /iBiY5P3+lo61Jbp1i0kxOy+PI/AYFBf+ceuUdUFWO+3rLSMv16oB6RROuyT/AUNIa+QsAmQv
 lBRb6A/
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

It is highly unlikely that any user would want to see ANSI color
sequences in a file. So let's stop doing that by default.

This is a backwards-incompatible change.

The reason this was not caught earlier is most likely that either
--output=<file> is not used, or only when stdout is redirected
anyway.

Technically, we do not default to --no-color here. Instead, we try to
override the GIT_COLOR_AUTO default because it would let want_color()
test whether stdout (instead of the specified file) is connected to a
terminal. Practically, we require the user to require color "always"
to force writing ANSI color sequences to the output file.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
Published-As: https://github.com/dscho/git/releases/tag/diff-o-v1

	Just something I noted while working on a bit more consistency
	with the diffopt.file patches.

	This is a backwards-incompatible change, though. So I extracted it
	from the patch series.

 diff.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/diff.c b/diff.c
index fa78fc1..b66b9be 100644
--- a/diff.c
+++ b/diff.c
@@ -3977,6 +3977,8 @@ int diff_opt_parse(struct diff_options *options,
 		if (!options->file)
 			die_errno("Could not open '%s'", path);
 		options->close_file = 1;
+		if (options->use_color != GIT_COLOR_ALWAYS)
+			options->use_color = GIT_COLOR_NEVER;
 		return argcount;
 	} else
 		return 0;
-- 
2.9.0.118.g0e1a633

base-commit: ab7797dbe95fff38d9265869ea367020046db118
