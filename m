From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH v3 1/3] perf: let's disable symlinks when they are not
 available
Date: Fri, 13 May 2016 15:25:51 +0200 (CEST)
Message-ID: <5d8189c4306b44c9fc7d3f3c2fba4adb2a343249.1463145936.git.johannes.schindelin@gmx.de>
References: <cover.1462955446.git.johannes.schindelin@gmx.de> <cover.1463145936.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 13 15:26:15 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b1D6a-0000Mt-Va
	for gcvg-git-2@plane.gmane.org; Fri, 13 May 2016 15:26:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752097AbcEMN0J (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 May 2016 09:26:09 -0400
Received: from mout.gmx.net ([212.227.15.15]:55997 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751917AbcEMN0G (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 May 2016 09:26:06 -0400
Received: from virtualbox ([37.24.143.84]) by mail.gmx.com (mrgmx001) with
 ESMTPSA (Nemesis) id 0MUYnD-1bAFdk3iFf-00RIZo; Fri, 13 May 2016 15:25:51
 +0200
X-X-Sender: virtualbox@virtualbox
In-Reply-To: <cover.1463145936.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:9JPxWFnTHC/jeOzpuMaHfvJXA2Imd2/PQVj+NNzpJ5izMWs6ovT
 MfmG/ZJP65sx3oM2P85a2awvXmGXkz0fZfuCwOkcIAm+7PlQJr0YKXXl0CokyCPk6wOFaCj
 8/xUYedHH3kKdtbEYat3Clkpo6FLalN2eZUef9mfpFRVkjC4OKHj6G+Uf0lc64UCzmT5hxR
 kDGrnPrlYlM3Gi0bSuLvg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:lsPIxL+l1Js=:Ko0QU05ZYXGAic4RChNKR4
 3OJeb1DL8s5IUMTJyvP+ZLVLS7qTyjY1oZvP3vNoAqjdPriPe31Dyiz8iuNDxLOTSjuThhUS0
 MLFDCFR2MEmUo4JuDNn8x3J1XouL12RZe5KvaE/3uGvtfInP29UwnT8QAI9pFo284YKHCK7n9
 TxDcXhymiZ/ACdXE8ghATt/miAK83t9wLQECin/7MdLh+zl4Wa/IL/YRBN2TMRvW/HulJp0sy
 QnXTXMncGoh0s3J3giCGbb29GmJaPyCpNgebP9Gtvw/m1YcKfS/4vNpuiBvlvR85Bg6AZHQCl
 Hmj57aZqZmoBkfG/RjY+3R3w7BNc1swSjdsBo56mJq/n1CbGAXItT5phWaAK6qgTpfvlkfv7X
 Fpq2b9+AKkdyhPT9b7tSOjIBz5kKRTjHlX+QsG5epyjqUcqTpFNZNvMtEZSJcYbBByUqZLQkC
 X/GCBmu8AZMIO5t8eAvjWcSurXKzYTbCskWQy9oVmqKVCha6ioD9zj5FH47pTUyZr7PxWwZHy
 24j1gamrigF9XzN24dqHA50Nh2ZzET2Rqogn1alaRl483N0kYlHb7DXZBTNDGmSY+fcK8GNug
 UlGC364+MENAVmFNkoZPS9Ty2ZbbIXWyFRJkENwkVkHsKzNcmMWv8ZiX0E7TvXhukHrYWjkqa
 5li/wx8WU35CmqnjgLRoyILKzbZ3dhVYYK1+QYasyD7Gl/ox/+HKY/4CglcUxr2n4mPtmUVJX
 dnIndZ8k4O6Ma4yRFSEDBwIzc5NSYjxEXKxuQFtlQurCwxfNm8O3POuCbb4qCqYH5hWvLxlp 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294535>

We already have a perfectly fine prereq to tell us whether it is safe to
use symlinks. So let's use it.

This fixes the performance tests in Git for Windows' SDK, where symlinks
are not really available ([*1*]). This is not an issue with Git for
Windows itself because it configures core.symlinks=false in its system
config.  However, the system config is disabled for the performance
tests, for obvious reasons: we want them to be independent of the
vagaries of any local configuration.

Footnote *1*: Windows has symbolic links. Git for Windows disables them
by default, though (for example: in standard setups, non-admins lack the
privilege to create symbolic links). For details, see
https://github.com/git-for-windows/git/wiki/Symbolic-Links

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/perf/perf-lib.sh | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/t/perf/perf-lib.sh b/t/perf/perf-lib.sh
index 5cf74ed..9fa0706 100644
--- a/t/perf/perf-lib.sh
+++ b/t/perf/perf-lib.sh
@@ -96,7 +96,10 @@ test_perf_create_repo_from () {
 			esac
 		done &&
 		cd .. &&
-		git init -q &&
+		git init -q && {
+			test_have_prereq SYMLINKS ||
+			git config core.symlinks false
+		} &&
 		mv .git/hooks .git/hooks-disabled 2>/dev/null
 	) || error "failed to copy repository '$source' to '$repo'"
 }
-- 
2.8.2.465.gb077790
