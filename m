From: Jeff King <peff@peff.net>
Subject: Re: git clone silently aborts if stdout gets a broken pipe
Date: Wed, 18 Sep 2013 14:45:51 -0400
Message-ID: <20130918184551.GC18821@sigill.intra.peff.net>
References: <A612847CFE53224C91B23E3A5B48BAC798CD91DB0B@xmail3.se.axis.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Peter Kjellerstedt <peter.kjellerstedt@axis.com>
X-From: git-owner@vger.kernel.org Wed Sep 18 20:46:10 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VMMlK-0006YS-CR
	for gcvg-git-2@plane.gmane.org; Wed, 18 Sep 2013 20:46:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752036Ab3IRSqA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Sep 2013 14:46:00 -0400
Received: from cloud.peff.net ([50.56.180.127]:56415 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751657Ab3IRSp7 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Sep 2013 14:45:59 -0400
Received: (qmail 21285 invoked by uid 102); 18 Sep 2013 18:46:00 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 18 Sep 2013 13:46:00 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 18 Sep 2013 14:45:51 -0400
Content-Disposition: inline
In-Reply-To: <A612847CFE53224C91B23E3A5B48BAC798CD91DB0B@xmail3.se.axis.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234982>

On Wed, Sep 18, 2013 at 06:52:13PM +0200, Peter Kjellerstedt wrote:

> The failing Perl code used a construct like this:
> 
> 	Git::command_oneline('clone', $url, $path);
> 
> There is no error raised, but the directory specified by 
> $path is not created. If I look at the process using strace 
> I can see the clone taking place, but then it seems to get 
> a broken pipe since the code above only cares about the 
> first line from stdout (and with the addition of "Checking 
> connectivity..." git clone now outputs two lines to stdout).

I think your perl script is somewhat questionable, as it is making
assumptions about the output of git-clone, and you would do better to
accept arbitrary-sized output (or better yet, leave stdout pointing to
the user, so they can see the output, which is meant for them).

That being said, the new messages should almost certainly go to stderr.

-- >8 --
Subject: [PATCH] clone: write "checking connectivity" to stderr

In commit 0781aa4 (clone: let the user know when
check_everything_connected is run, 2013-05-03), we started
giving the user a progress report during clone. However,
since the actual work happens in a sub-process, we do not
use the usual progress code that counts the objects, but
rather just print a message ourselves.

This message goes to stdout via printf, which is unlike
other progress messages (both the eye candy within clone,
and the "checking connectivity" progress in other commands).
Let's send it to stderr for consistency.

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/clone.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/builtin/clone.c b/builtin/clone.c
index ca3eb68..3c91844 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -551,12 +551,12 @@ static void update_remote_refs(const struct ref *refs,
 
 	if (check_connectivity) {
 		if (0 <= option_verbosity)
-			printf(_("Checking connectivity... "));
+			fprintf(stderr, _("Checking connectivity... "));
 		if (check_everything_connected_with_transport(iterate_ref_map,
 							      0, &rm, transport))
 			die(_("remote did not send all necessary objects"));
 		if (0 <= option_verbosity)
-			printf(_("done\n"));
+			fprintf(stderr, _("done\n"));
 	}
 
 	if (refs) {
-- 
1.8.4.rc4.16.g228394f
