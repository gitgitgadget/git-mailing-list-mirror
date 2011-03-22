From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] builtin/diff.c: remove duplicated call to diff_result_code()
Date: Tue, 22 Mar 2011 14:45:43 -0700
Message-ID: <7vk4fqkewo.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 22 22:46:02 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q29Om-00051T-JG
	for gcvg-git-2@lo.gmane.org; Tue, 22 Mar 2011 22:45:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932323Ab1CVVpv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Mar 2011 17:45:51 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:49235 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754616Ab1CVVpv (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Mar 2011 17:45:51 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 81BCD45BF;
	Tue, 22 Mar 2011 17:47:29 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:mime-version:content-type; s=sasl; bh=p
	yeTuYyKtEwqrnTMJPRBDZ5/6es=; b=IwacwqnF13HDcgICXJowcmAXJjMh+dToa
	cSALSkiFrQotZr3FUkR1SbAz8EMQO7OKm1xCF/toLfrfVaEwJZNNND8RpfqPsQz0
	d1EzPbb/UymGcF2p88py6Arb/0DGvC2JvV28xXYEEZ7I+LvGUtzWIEonPDNz8ABN
	6WuMZjTKHo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:message-id:mime-version:content-type; q=dns; s=
	sasl; b=U+I8kbgmzXyPCs81F1k77NeISQayJKJrc9Jl4iaSxHU7FtL1hSkic7TN
	0qyKyrLjYObtIQjpG76NKcT6F0SW06JtwOYsQ5l7TMXlvfCtC1wxnLeq39T1o/6K
	ItHR4Syvt23lMl5zOSOFs80Crovipvabn325K6ruq7aP8At5YAw=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 5F1BB45BC;
	Tue, 22 Mar 2011 17:47:26 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 76C8E45BB; Tue, 22 Mar 2011
 17:47:23 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: FA26FD14-54CD-11E0-AE4C-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169779>

The return value from builtin_diff_files() is fed to diff_result_code()
by the caller, and all other callees like builtin_diff_index() do not
have their own call to diff_result_code().  Remove the duplicated one
from builtin_diff_files() and let the caller handle it.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 * This probably does not make a difference right now, but it will at
   the end of the rebased 'rename-degrade-cc-to-c' series.

 builtin/diff.c |    4 +---
 1 files changed, 1 insertions(+), 3 deletions(-)

diff --git a/builtin/diff.c b/builtin/diff.c
index 4c9deb2..171ac39 100644
--- a/builtin/diff.c
+++ b/builtin/diff.c
@@ -207,7 +207,6 @@ static void refresh_index_quietly(void)
 
 static int builtin_diff_files(struct rev_info *revs, int argc, const char **argv)
 {
-	int result;
 	unsigned int options = 0;
 
 	while (1 < argc && argv[1][0] == '-') {
@@ -241,8 +240,7 @@ static int builtin_diff_files(struct rev_info *revs, int argc, const char **argv
 		perror("read_cache_preload");
 		return -1;
 	}
-	result = run_diff_files(revs, options);
-	return diff_result_code(&revs->diffopt, result);
+	return run_diff_files(revs, options);
 }
 
 int cmd_diff(int argc, const char **argv, const char *prefix)
