From: Jeff King <peff@peff.net>
Subject: [PATCH v2] check_and_freshen_file: fix reversed success-check
Date: Wed, 8 Jul 2015 16:33:52 -0400
Message-ID: <20150708203352.GA23901@peff.net>
References: <DUB120-W5049F72955243F44BB2511F6920@phx.gbl>
 <20150707141305.GA629@peff.net>
 <DUB120-W36B78FEE6DC80BDCB05D7FF6920@phx.gbl>
 <20150707194956.GA13792@peff.net>
 <559D60DC.4010304@kdbg.org>
 <20150708180539.GA12353@peff.net>
 <20150708183331.GA16138@peff.net>
 <xmqqegkixxja.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Johannes Sixt <j6t@kdbg.org>,
	=?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
	X H <music_is_live_lg@hotmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jul 08 22:34:00 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZCw2a-0001tH-7m
	for gcvg-git-2@plane.gmane.org; Wed, 08 Jul 2015 22:34:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933482AbbGHUd4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Jul 2015 16:33:56 -0400
Received: from cloud.peff.net ([50.56.180.127]:57775 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S933000AbbGHUdz (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Jul 2015 16:33:55 -0400
Received: (qmail 31487 invoked by uid 102); 8 Jul 2015 20:33:54 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 08 Jul 2015 15:33:54 -0500
Received: (qmail 24327 invoked by uid 107); 8 Jul 2015 20:34:02 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 08 Jul 2015 16:34:02 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 08 Jul 2015 16:33:52 -0400
Content-Disposition: inline
In-Reply-To: <xmqqegkixxja.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273708>

On Wed, Jul 08, 2015 at 12:24:41PM -0700, Junio C Hamano wrote:

> > If our utime() call fails, we treat this the same as not
> > having the object in the first place; the safe thing to do
> > is write out another copy. However, the loose-object check
> > accidentally inverst the utime() check; it returns failure
> 
> s/inverst/invert/?

Whoops, should be "inverts".

> I think each of the functions in the check_and_freshen_* callchain
> can at least have a comment in front of it, saying what the returned
> value means, to unconfuse readers.  "Return 1 when the thing exists
> and no further action is necessary; return 0 when the thing does not
> exist or not in a good state and should be overwritten (if the
> caller has something to overwrite it with, that is)" or something?
> 
> Their returning "1" instead of "-1" could be taken as a hint that
> says "this non-zero return does not signal a _failure_", but it is a
> rather weak hint.

Fair enough. Here's a re-roll with some extra comments, and the typo-fix
from above.

-- >8 --
Subject: check_and_freshen_file: fix reversed success-check

When we want to write out a loose object file, we have
always first made sure we don't already have the object
somewhere. Since 33d4221 (write_sha1_file: freshen existing
objects, 2014-10-15), we also update the timestamp on the
file, so that a simultaneous prune knows somebody is
likely to reference it soon.

If our utime() call fails, we treat this the same as not
having the object in the first place; the safe thing to do
is write out another copy. However, the loose-object check
accidentally inverts the utime() check; it returns failure
_only_ when the utime() call actually succeeded. Thus it was
failing to protect us there, and in the normal case where
utime() succeeds, it caused us to pointlessly write out and
link the object.

This passed our freshening tests, because writing out the
new object is certainly _one_ way of updating its utime. So
the normal case was inefficient, but not wrong.

While we're here, let's also drop a comment in front of the
check_and_freshen functions, making a note of their return
type (since it is not our usual "0 for success, -1 for
error").

Signed-off-by: Jeff King <peff@peff.net>
---
 sha1_file.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/sha1_file.c b/sha1_file.c
index 77cd81d..e435289 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -443,6 +443,7 @@ void prepare_alt_odb(void)
 	read_info_alternates(get_object_directory(), 0);
 }
 
+/* Returns 1 if we have successfully freshened the file, 0 otherwise. */
 static int freshen_file(const char *fn)
 {
 	struct utimbuf t;
@@ -450,11 +451,18 @@ static int freshen_file(const char *fn)
 	return !utime(fn, &t);
 }
 
+/*
+ * All of the check_and_freshen functions return 1 if the file exists and was
+ * freshened (if freshening was requested), 0 otherwise. If they return
+ * 0, you should not assume that it is safe to skip a write of the object (it
+ * either does not exist on disk, or has a stale mtime and may be subject to
+ * pruning).
+ */
 static int check_and_freshen_file(const char *fn, int freshen)
 {
 	if (access(fn, F_OK))
 		return 0;
-	if (freshen && freshen_file(fn))
+	if (freshen && !freshen_file(fn))
 		return 0;
 	return 1;
 }
-- 
2.5.0.rc1.340.ge59e3eb
