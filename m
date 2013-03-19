From: Thomas Rast <trast@student.ethz.ch>
Subject: [PATCH v2] index-pack: guard nr_resolved_deltas reads by lock
Date: Tue, 19 Mar 2013 15:16:41 +0100
Message-ID: <8ddf4db38f33034b5ebf504a18948bccf841ab72.1363702423.git.trast@student.ethz.ch>
References: <CACsJy8C0AYvAEm6fJFv+JLWpg3HuFG0erKXnq3NxpkYAy=qb_w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>, Stefan Zager <szager@google.com>
To: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 19 15:17:18 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UHxLo-0000KM-Vt
	for gcvg-git-2@plane.gmane.org; Tue, 19 Mar 2013 15:17:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754888Ab3CSOQp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Mar 2013 10:16:45 -0400
Received: from edge20.ethz.ch ([82.130.99.26]:32879 "EHLO edge20.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753152Ab3CSOQo (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Mar 2013 10:16:44 -0400
Received: from CAS11.d.ethz.ch (172.31.38.211) by edge20.ethz.ch
 (82.130.99.26) with Microsoft SMTP Server (TLS) id 14.2.298.4; Tue, 19 Mar
 2013 15:16:38 +0100
Received: from pctrast.inf.ethz.ch (129.132.153.233) by CAS11.d.ethz.ch
 (172.31.38.211) with Microsoft SMTP Server (TLS) id 14.2.298.4; Tue, 19 Mar
 2013 15:16:42 +0100
X-Mailer: git-send-email 1.8.2.490.gc3bbe62
In-Reply-To: <CACsJy8C0AYvAEm6fJFv+JLWpg3HuFG0erKXnq3NxpkYAy=qb_w@mail.gmail.com>
X-Originating-IP: [129.132.153.233]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218516>

The threaded parts of index-pack increment the number of resolved
deltas in nr_resolved_deltas guarded by counter_mutex.  However, the
per-thread outer loop accessed nr_resolved_deltas without any locks.

This is not wrong as such, since it doesn't matter all that much
whether we get an outdated value.  However, unless someone proves that
this one lock makes all the performance difference, it would be much
cleaner to guard _all_ accesses to the variable with the lock.

The only such use is display_progress() in the threaded section (all
others are in the conclude_pack() callchain outside the threaded
part).  To make it obvious that it cannot deadlock, move it out of
work_mutex.

Signed-off-by: Thomas Rast <trast@student.ethz.ch>
---

> The only thing I don't
> like here is the double locking (work_lock then counter_lock) is an
> invitation for potential deadlocks (not now, but who now what can
> change later). I think you could move work_lock(); down after
> counter_unlock() so we hold one lock at a time.

Good point.


 builtin/index-pack.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index b3fee45..a481f54 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -967,8 +967,10 @@ static void *threaded_second_pass(void *data)
 	set_thread_data(data);
 	for (;;) {
 		int i;
-		work_lock();
+		counter_lock();
 		display_progress(progress, nr_resolved_deltas);
+		counter_unlock();
+		work_lock();
 		while (nr_dispatched < nr_objects &&
 		       is_delta_type(objects[nr_dispatched].type))
 			nr_dispatched++;
-- 
1.8.2.490.gc3bbe62
