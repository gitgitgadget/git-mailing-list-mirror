From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: [PATCH] index-pack: protect deepest_delta in multithread code
Date: Tue, 19 Mar 2013 14:50:26 +0100
Message-ID: <87d2uv7b31.fsf@pctrast.inf.ethz.ch>
References: <CACsJy8DgQZFewPjLSXSkdHHWqhQDqExoVq-pBGpKr1G8w06uvQ@mail.gmail.com>
	<1363698075-12452-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>, Thomas Rast <trast@student.ethz.ch>,
	Stefan Zager <szager@google.com>
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 19 14:50:59 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UHwwM-0005Ry-00
	for gcvg-git-2@plane.gmane.org; Tue, 19 Mar 2013 14:50:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755216Ab3CSNua convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 19 Mar 2013 09:50:30 -0400
Received: from edge20.ethz.ch ([82.130.99.26]:30540 "EHLO edge20.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752323Ab3CSNua convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 19 Mar 2013 09:50:30 -0400
Received: from CAS11.d.ethz.ch (172.31.38.211) by edge20.ethz.ch
 (82.130.99.26) with Microsoft SMTP Server (TLS) id 14.2.298.4; Tue, 19 Mar
 2013 14:50:23 +0100
Received: from pctrast.inf.ethz.ch.ethz.ch (129.132.153.233) by
 CAS11.d.ethz.ch (172.31.38.211) with Microsoft SMTP Server (TLS) id
 14.2.298.4; Tue, 19 Mar 2013 14:50:26 +0100
In-Reply-To: <1363698075-12452-1-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Tue, 19
 Mar 2013 20:01:15 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2 (gnu/linux)
X-Originating-IP: [129.132.153.233]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218514>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.com> writes:

> deepest_delta is a global variable but is updated without protection
> in resolve_delta(), a multithreaded function. Add a new mutex for it,
> but only protect and update when it's actually used (i.e. show_stat i=
s
> non-zero).
>
> Another variable that will not be updated is delta_depth in "struct
> object_entry" as it's only useful when show_stat is 1. Putting it in
> "if (show_stat)" makes it clearer.
>
> The local variable "stat" is renamed to "show_stat" after moving to
> global scope because the name "stat" conflicts with stat(2) syscall.

Looks good to me, too.  However, I think it would still be less magical
if we had the below too.  It also silences helgrind.

-- >8 --
Subject: [PATCH] index-pack: guard nr_resolved_deltas reads by lock

The threaded parts of index-pack increment the number of resolved
deltas in nr_resolved_deltas guarded by counter_mutex.  However, the
per-thread outer loop accessed nr_resolved_deltas without any locks.

This is not wrong as such, since it doesn't matter all that much
whether we get an outdated value.  However, unless someone proves that
this one lock makes all the performance difference, it would be much
cleaner to guard _all_ accesses to the variable with the lock.

Signed-off-by: Thomas Rast <trast@student.ethz.ch>
---
 builtin/index-pack.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index b3fee45..6be99e2 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -968,7 +968,9 @@ static void *threaded_second_pass(void *data)
 	for (;;) {
 		int i;
 		work_lock();
+		counter_lock();
 		display_progress(progress, nr_resolved_deltas);
+		counter_unlock();
 		while (nr_dispatched < nr_objects &&
 		       is_delta_type(objects[nr_dispatched].type))
 			nr_dispatched++;
--=20
1.8.2.487.g725f6bb


--=20
Thomas Rast
trast@{inf,student}.ethz.ch
