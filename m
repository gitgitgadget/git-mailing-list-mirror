From: Jeff King <peff@peff.net>
Subject: Re: [RFC/PATCH 0/1] cygwin: Remove the Win32 l/stat() functions
Date: Wed, 26 Jun 2013 18:43:36 -0400
Message-ID: <20130626224336.GA22486@sigill.intra.peff.net>
References: <51C5FD28.1070004@ramsay1.demon.co.uk>
 <51C6BC4B.9030905@web.de>
 <51C8BF2C.2050203@ramsay1.demon.co.uk>
 <7vy59y4w3r.fsf@alter.siamese.dyndns.org>
 <51C94425.7050006@alum.mit.edu>
 <51CB610C.7050501@ramsay1.demon.co.uk>
 <20130626223552.GA12785@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Michael Haggerty <mhagger@alum.mit.edu>,
	Junio C Hamano <gitster@pobox.com>,
	Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
	Johannes Sixt <j6t@kdbg.org>,
	"Shawn O. Pearce" <spearce@spearce.org>, mlevedahl@gmail.com,
	dpotapov@gmail.com, GIT Mailing-list <git@vger.kernel.org>
To: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
X-From: git-owner@vger.kernel.org Thu Jun 27 00:43:44 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UryRD-0006pQ-V4
	for gcvg-git-2@plane.gmane.org; Thu, 27 Jun 2013 00:43:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752940Ab3FZWnk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Jun 2013 18:43:40 -0400
Received: from cloud.peff.net ([50.56.180.127]:33072 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751444Ab3FZWnj (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Jun 2013 18:43:39 -0400
Received: (qmail 22047 invoked by uid 102); 26 Jun 2013 22:44:44 -0000
Received: from c-98-244-76-202.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (98.244.76.202)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 26 Jun 2013 17:44:44 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 26 Jun 2013 18:43:36 -0400
Content-Disposition: inline
In-Reply-To: <20130626223552.GA12785@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229068>

On Wed, Jun 26, 2013 at 06:35:52PM -0400, Jeff King wrote:

> I am curious how often Cygwin gives us the false positive. If it is
> every time, then the check is not doing much good at all. Is it possible
> for you to instrument stat_validity_check to report how often it does or
> does not do anything useful?

Maybe like this:

diff --git a/read-cache.c b/read-cache.c
index d5201f9..19dcb69 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -1958,6 +1958,14 @@ void stat_validity_clear(struct stat_validity *sv)
 	sv->sd = NULL;
 }
 
+static int unchanged;
+static int attempts;
+static void print_stats(void)
+{
+	fprintf(stderr, "stat data was unchanged %d/%d\n",
+		unchanged, attempts);
+}
+
 int stat_validity_check(struct stat_validity *sv, const char *path)
 {
 	struct stat st;
@@ -1966,7 +1974,16 @@ int stat_validity_check(struct stat_validity *sv, const char *path)
 		return sv->sd == NULL;
 	if (!sv->sd)
 		return 0;
-	return S_ISREG(st.st_mode) && !match_stat_data(sv->sd, &st);
+	if (!S_ISREG(st.st_mode))
+		return 0;
+	if (!attempts++)
+		atexit(print_stats);
+	if (!match_stat_data(sv->sd, &st)) {
+		unchanged++;
+		return 1;
+	}
+	else
+		return 0;
 }
 
 void stat_validity_update(struct stat_validity *sv, int fd)

Running "t3211 -v", I see things like:

  stat data was unchanged 3/3
  stat data was unchanged 20/20
  stat data was unchanged 2/2
  Deleted branch yadda (was d1ff1c9).
  stat data was unchanged 8/8
  ok 8 - peeled refs survive deletion of packed ref

I am curious if you will see 0/20 or 19/20 there on Cygwin.

-Peff
