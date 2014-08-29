From: Jeff King <peff@peff.net>
Subject: Re: git fsck exit code?
Date: Fri, 29 Aug 2014 16:31:46 -0400
Message-ID: <20140829203145.GA510@peff.net>
References: <1409177412.15185.3.camel@leckie>
 <20140829185325.GC29456@peff.net>
 <xmqqha0v5cgn.fsf@gitster.dls.corp.google.com>
 <1409343480.19256.2.camel@leckie>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	git mailing list <git@vger.kernel.org>
To: David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Fri Aug 29 22:31:52 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XNSps-0004Tp-9I
	for gcvg-git-2@plane.gmane.org; Fri, 29 Aug 2014 22:31:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750834AbaH2Ubs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Aug 2014 16:31:48 -0400
Received: from cloud.peff.net ([50.56.180.127]:33392 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750784AbaH2Ubr (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Aug 2014 16:31:47 -0400
Received: (qmail 3263 invoked by uid 102); 29 Aug 2014 20:31:47 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 29 Aug 2014 15:31:47 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 29 Aug 2014 16:31:46 -0400
Content-Disposition: inline
In-Reply-To: <1409343480.19256.2.camel@leckie>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256188>

On Fri, Aug 29, 2014 at 04:18:00PM -0400, David Turner wrote:

> > Even if git does not die, whenever it says broken link, missing
> > object, or object corrupt, we set errors_found and that variable
> > affects the exit status of fsck.  What does "some errors" exactly
> > mean in the original report?  Dangling objects are *not* errors and
> > should not cause fsck to report an error with its exit status.
> 
> error in tree 9f50addba2b4e9e928d9c6a7056bdf71b36fba90: contains
> duplicate file entries
> 
> (at least -- there might be more, but that's the one that bit me)

I think that we just don't set "errors_found" in fsck_obj (nor do we in
fsck_obj_buffer, but in that case its caller is verify-pack, which
propagates the return code). Maybe (completely untested):

diff --git a/builtin/fsck.c b/builtin/fsck.c
index d42a27d..29de901 100644
--- a/builtin/fsck.c
+++ b/builtin/fsck.c
@@ -388,7 +388,8 @@ static void fsck_sha1_list(void)
 		unsigned char *sha1 = entry->sha1;
 
 		sha1_list.entry[i] = NULL;
-		fsck_sha1(sha1);
+		if (fsck_sha1(sha1))
+			errors_found |= ERROR_OBJECT;
 		free(entry);
 	}
 	sha1_list.nr = 0;
