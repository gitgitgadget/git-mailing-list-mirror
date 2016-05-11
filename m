From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH v2 1/3] perf: let's disable symlinks when they are not
 available
Date: Wed, 11 May 2016 10:42:44 +0200 (CEST)
Message-ID: <d651a7fdd7af6e1e7c32599bca9efeb6fd923e7c.1462955446.git.johannes.schindelin@gmx.de>
References: <cover.1462894344.git.johannes.schindelin@gmx.de> <cover.1462955446.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed May 11 10:44:13 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b0PkZ-0000Dn-D2
	for gcvg-git-2@plane.gmane.org; Wed, 11 May 2016 10:44:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751985AbcEKIoE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 May 2016 04:44:04 -0400
Received: from mout.gmx.net ([212.227.15.15]:59706 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751370AbcEKIoC (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 May 2016 04:44:02 -0400
Received: from virtualbox ([37.24.143.84]) by mail.gmx.com (mrgmx003) with
 ESMTPSA (Nemesis) id 0M0xbD-1bu2pr3iLX-00v9lM; Wed, 11 May 2016 10:43:52
 +0200
X-X-Sender: virtualbox@virtualbox
In-Reply-To: <cover.1462955446.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:u1dU2YOYaB969BreuuGLUsHs6hUII4O92e3bySs6FS/eDMqyFsQ
 S/Bl9VS7PZzqJJP40QD56VMup4bOYKVTdKo1iOUjVTewmMNilYoRp3Zitlyup2lyzLTdxaV
 3MqGfoKSTUyowZxjspFrKqBO6t8gpOmh6V0AbTtHPGH0nKm3Y7esRUCWYA91jvfJvV+eoe0
 +Ms356G9cuaqlVlBa2wcw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:sKfHK2vmU1A=:0iRtWXIScKWUPuC57J2EkT
 O6so4n0IY8wI293ri2aOPEm/uIKEUJuH2o2jeWNZxCbdL2ZMEj+Mo50L+SA1SM5k6pskAlA3m
 ldLLSOISmn7zLTXGPByFlyOELWo/6bS8b5mmtmE2cYEJ6sRFKHsev61PSJO8SlyAX33iv0deg
 11q5cOQCSbB7NoCtbEsqBDJW6G+7n9tGpd+6nEcellbfkvFKDix2H9Otz76cZeHTp+UECO1Ll
 eELc+EZO8zaVab6fDgPENyyqKXC6GbFiqrDTLkq0qZhbApvENCCSqFflpJLRWqAljfKsB442q
 Gm0rdKCoRQMULAlmT4DYgaX6qg7mku2YM6Svam/hVR8gv3j01Lguiiw2yq4SPs4jQMHfCpkeu
 QI4TIvbz8vfgFOgmU2oh3PZv8kJ8WHNztebGvQaxeJ8Q8LF+lr88n44ftgzLhQuvxDW8/z9KP
 IKeXYSButPJbvBTEYrXbsN38ErFC6yH8EKXwdddrO29Xnt4NT35khLOj6aLPpENs6tuV/HykG
 YjEe/ilw+IvrzVz3R5HlheLZvJF1nVlDeLvZDxXlhIZWwyTgWmu/cpnhKBu/Uk9KIIlrwLdHJ
 ClwiYuMSJFjYpV45sZ/FHJAh/sTOGeZWuy3OIDS34jUTAV+WhR/HpgMojFISir2G08hXEJqso
 biRSnwGTaDQDKMa3StbONTc24KvEUVAbl8ua8D4tY8a21Yq2IlcAnULHrxdqj+t3HrEDVi/gn
 i/BnkrHzclK133sSoWfO6Lq3noMq6Z7KQS+KJr8RZYQFjr7m6+oX0e74JrsfO0Q3KIjm+FPJ 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294243>

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
 t/perf/perf-lib.sh | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/t/perf/perf-lib.sh b/t/perf/perf-lib.sh
index 5cf74ed..50c8c39 100644
--- a/t/perf/perf-lib.sh
+++ b/t/perf/perf-lib.sh
@@ -97,6 +97,10 @@ test_perf_create_repo_from () {
 		done &&
 		cd .. &&
 		git init -q &&
+		git init -q && {
+			test_have_prereq SYMLINKS ||
+			git config core.symlinks false
+		} &&
 		mv .git/hooks .git/hooks-disabled 2>/dev/null
 	) || error "failed to copy repository '$source' to '$repo'"
 }
-- 
2.8.2.465.gb077790
