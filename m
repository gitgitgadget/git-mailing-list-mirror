From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] drop support for "experimental" loose objects
Date: Fri, 22 Nov 2013 04:58:02 -0500
Message-ID: <20131122095801.GB12042@sigill.intra.peff.net>
References: <20131120203350.GA31139@kitenet.net>
 <20131120213348.GA29004@sigill.intra.peff.net>
 <20131120222805.GC26468@kitenet.net>
 <20131121114157.GA7171@sigill.intra.peff.net>
 <20131121160426.GA21843@kitenet.net>
 <CAP8UFD2S1HUDYLbmEGFqLcBFExuB0h7=gqwsQ0qjpMSc+YaXog@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Joey Hess <joey@kitenet.net>, git <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Christian Couder <christian.couder@gmail.com>
X-From: git-owner@vger.kernel.org Fri Nov 22 10:58:13 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VjnV6-00056u-7F
	for gcvg-git-2@plane.gmane.org; Fri, 22 Nov 2013 10:58:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755260Ab3KVJ6G (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Nov 2013 04:58:06 -0500
Received: from cloud.peff.net ([50.56.180.127]:43681 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755165Ab3KVJ6E (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Nov 2013 04:58:04 -0500
Received: (qmail 8099 invoked by uid 102); 22 Nov 2013 09:58:04 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 22 Nov 2013 03:58:04 -0600
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 22 Nov 2013 04:58:02 -0500
Content-Disposition: inline
In-Reply-To: <CAP8UFD2S1HUDYLbmEGFqLcBFExuB0h7=gqwsQ0qjpMSc+YaXog@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238174>

On Thu, Nov 21, 2013 at 09:19:25PM +0100, Christian Couder wrote:

> Yeah, I think it might report wrong size in case of replaced objects
> for example.
> I looked at that following Junio's comment about the
> sha1_object_info() API, which,
> unlike read_sha1_file() API, does not interact with the "replace" mechanism:
> 
> http://thread.gmane.org/gmane.comp.version-control.git/234023/
> 
> I started to work on a patch about this but didn't take the time to
> finish and post it.

That seems kind of crazy. Would the fix be as simple as this:

diff --git a/sha1_file.c b/sha1_file.c
index 10676ba..a051d6c 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -2529,6 +2529,8 @@ int sha1_object_info_extended(const unsigned char *sha1, struct object_info *oi)
 	struct pack_entry e;
 	int rtype;
 
+	sha1 = lookup_replace_object(sha1);
+
 	co = find_cached_object(sha1);
 	if (co) {
 		if (oi->typep)

or do we need some way for callers to turn off replacement? I notice
that read_sha1_file has such a feature, but it is only used in one
place. I guess we would need to audit all the sha1_object_info callers.

-Peff
