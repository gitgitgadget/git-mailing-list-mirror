From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 12/12] refs: do not invalidate the packed-refs cache unnecessarily
Date: Wed, 19 Jun 2013 09:51:33 +0200
Message-ID: <1371628293-28824-13-git-send-email-mhagger@alum.mit.edu>
References: <1371628293-28824-1-git-send-email-mhagger@alum.mit.edu>
Cc: Jeff King <peff@peff.net>, Johan Herland <johan@herland.net>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jun 19 09:52:48 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UpDC6-0003fT-LI
	for gcvg-git-2@plane.gmane.org; Wed, 19 Jun 2013 09:52:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933816Ab3FSHwM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Jun 2013 03:52:12 -0400
Received: from alum-mailsec-scanner-6.mit.edu ([18.7.68.18]:46212 "EHLO
	alum-mailsec-scanner-6.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756553Ab3FSHwH (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 19 Jun 2013 03:52:07 -0400
X-AuditID: 12074412-b7f656d00000102f-d4-51c163266984
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-6.mit.edu (Symantec Messaging Gateway) with SMTP id 91.27.04143.62361C15; Wed, 19 Jun 2013 03:52:06 -0400 (EDT)
Received: from michael.berlin.jpk.com (mx.berlin.jpk.com [212.222.128.135] (may be forged))
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id r5J7pZWe002453
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Wed, 19 Jun 2013 03:52:05 -0400
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1371628293-28824-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrAIsWRmVeSWpSXmKPExsUixO6iqKuWfDDQoGmhikXXlW4mi4beK8wW
	8+7uYrK4vWI+s8WPlh5mi93TFrA5sHn8ff+ByePSy+9sHs969zB6XLyk7PF44glWj8+b5ALY
	orhtkhJLyoIz0/P07RK4Mz6+2spc8JSr4sDti0wNjA84uhg5OSQETCTW/ZvMDmGLSVy4t56t
	i5GLQ0jgMqPEuodb2EASQgK3mSTOfIoHsdkEdCUW9TQzgdgiAmoSE9sOsYA0MAvsZpRYfvoU
	2CRhgVCJpjdNzCA2i4CqxId7J8HivAKuEr9vrGSE2KYgMeXhe6AaDg5OoPjZZZ4Qu1wk5p2a
	zDqBkXcBI8MqRrnEnNJc3dzEzJzi1GTd4uTEvLzUIl0zvdzMEr3UlNJNjJAwE9rBuP6k3CFG
	AQ5GJR7ehpUHAoVYE8uKK3MPMUpyMCmJ8rInHQwU4kvKT6nMSCzOiC8qzUktPsQowcGsJMKr
	5wCU401JrKxKLcqHSUlzsCiJ8/5crO4nJJCeWJKanZpakFoEk5Xh4FCS4A0DGSpYlJqeWpGW
	mVOCkGbi4AQRXCAbeIA2lIIU8hYXJOYWZ6ZDFJ1iVJQS540ESQiAJDJK8+AGwBLCK0ZxoH+E
	eatBqniAyQSu+xXQYCagwULf94EMLklESEk1MPrKbLNLPSGyffYnq/oJXEW1B2JN/8UXnPH2
	FPooOtEuolL70MVXW/fyXg1jmzb1kbKAjNeOyd7CPZzXLy7JLPl65tVypSNLz8dJ761ue3F6
	0009voNdVp5KJ13SNp0+L/mWLScs59U2maYNm/awPZvt2+N5JTch7yN7b+ir72za 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228364>

Now that we keep track of the packed-refs file metadata, we can detect
when the packed-refs file has been modified since we last read it, and
we do so automatically every time that get_packed_ref_cache() is
called.  So there is no need to invalidate the cache automatically
when lock_packed_refs() is called; usually the old copy will still be
valid.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/refs.c b/refs.c
index 350054c..4b989b0 100644
--- a/refs.c
+++ b/refs.c
@@ -2133,11 +2133,14 @@ int lock_packed_refs(struct lock_file *lock, int flags)
 {
 	struct packed_ref_cache *packed_ref_cache;
 
-	/* Discard the old cache because it might be invalid: */
-	clear_packed_ref_cache(&ref_cache);
 	if (hold_lock_file_for_update(lock, git_path("packed-refs"), flags) < 0)
 		return -1;
-	/* Read the current packed-refs while holding the lock: */
+	/*
+	 * Get the current packed-refs while holding the lock.  If the
+	 * packed-refs file has been modified since we last read it,
+	 * this will automatically invalidate the cache and re-read
+	 * the packed-refs file.
+	 */
 	packed_ref_cache = get_packed_ref_cache(&ref_cache);
 	packed_ref_cache->lock = lock;
 	/* Increment the reference count to prevent it from being freed: */
-- 
1.8.3.1
