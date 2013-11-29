From: Thomas Rast <tr@thomasrast.ch>
Subject: Re: [PATCH/WIP] Repair DF conflicts during fetch.
Date: Fri, 29 Nov 2013 20:07:02 +0100
Message-ID: <871u1zf2nd.fsf@thomasrast.ch>
References: <1385747858-29343-1-git-send-email-jackerran@gmail.com>
	<1385747858-29343-2-git-send-email-jackerran@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Tom Miller <jackerran@gmail.com>
X-From: git-owner@vger.kernel.org Fri Nov 29 20:07:31 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VmTPW-0004JZ-Ia
	for gcvg-git-2@plane.gmane.org; Fri, 29 Nov 2013 20:07:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754610Ab3K2THV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Nov 2013 14:07:21 -0500
Received: from psi.thgersdorf.net ([176.9.98.78]:35977 "EHLO mail.psioc.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754024Ab3K2THS (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Nov 2013 14:07:18 -0500
Received: from localhost (localhost [127.0.0.1])
	by localhost.psioc.net (Postfix) with ESMTP id 098124D6574;
	Fri, 29 Nov 2013 20:07:13 +0100 (CET)
X-Virus-Scanned: amavisd-new at psioc.net
Received: from mail.psioc.net ([127.0.0.1])
	by localhost (mail.psioc.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id dtt6sUdoXaVz; Fri, 29 Nov 2013 20:07:02 +0100 (CET)
Received: from linux-1gf2.thomasrast.ch (unknown [213.55.184.182])
	(using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
	(Client did not present a certificate)
	by mail.psioc.net (Postfix) with ESMTPSA id 7130D4D64DE;
	Fri, 29 Nov 2013 20:07:02 +0100 (CET)
In-Reply-To: <1385747858-29343-2-git-send-email-jackerran@gmail.com> (Tom
	Miller's message of "Fri, 29 Nov 2013 11:57:38 -0600")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238533>

Tom Miller <jackerran@gmail.com> writes:

> When a DF conflict occurs during a fetch, --prune should be able to fix
> it. When fetching with --prune, the fetching process happens before
> pruning causing the DF conflict to persist and report an error. This
> patch prunes before fetching, thus correcting DF conflicts during a
> fetch.
>
> Signed-off-by: Tom Miller <jackerran@gmail.com>
> ---
>  builtin/fetch.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)

Good catch.

I can't comment on the correctness of the patch right now, but here's a
test you could steal.  It just reproduces what you describe, and I did
verify that it confirms the fix ;-)

diff --git i/t/t5510-fetch.sh w/t/t5510-fetch.sh
index 5d4581d..a981125 100755
--- i/t/t5510-fetch.sh
+++ w/t/t5510-fetch.sh
@@ -614,4 +614,18 @@ test_expect_success 'all boundary commits are excluded' '
 	test_bundle_object_count .git/objects/pack/pack-${pack##pack	}.pack 3
 '
 
+test_expect_success 'branchname D/F conflict resolved by --prune' '
+	git branch dir/file &&
+	git clone . prune-df-conflict &&
+	git branch -D dir/file &&
+	git branch dir &&
+	(
+		cd prune-df-conflict &&
+		git fetch --prune &&
+		git rev-parse origin/dir >../actual
+	) &&
+	git rev-parse dir >expect &&
+	test_cmp expect actual
+'
+
 test_done


-- 
Thomas Rast
tr@thomasrast.ch
