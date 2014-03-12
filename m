From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 1/2] fsck.c: Change the type of fsck_ident()'s first
 argument
Date: Wed, 12 Mar 2014 16:22:51 -0400
Message-ID: <20140312202251.GA3642@sigill.intra.peff.net>
References: <1394650290-3750-1-git-send-email-yshuiv7@gmail.com>
 <1394650290-3750-2-git-send-email-yshuiv7@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Yuxuan Shui <yshuiv7@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 12 21:22:59 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WNpg2-0007ea-FM
	for gcvg-git-2@plane.gmane.org; Wed, 12 Mar 2014 21:22:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751745AbaCLUWy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Mar 2014 16:22:54 -0400
Received: from cloud.peff.net ([50.56.180.127]:38325 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751244AbaCLUWx (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Mar 2014 16:22:53 -0400
Received: (qmail 412 invoked by uid 102); 12 Mar 2014 20:22:53 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 12 Mar 2014 15:22:53 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 12 Mar 2014 16:22:51 -0400
Content-Disposition: inline
In-Reply-To: <1394650290-3750-2-git-send-email-yshuiv7@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243986>

On Thu, Mar 13, 2014 at 02:51:29AM +0800, Yuxuan Shui wrote:

> Since fsck_ident doesn't change the content of **ident, the type of
> ident could be const char **.

Unfortunately, const double-pointers in C are a bit tricky, and a
pointer to "char *" cannot automatically be passed as a pointer to
"const char *". 

I think you want this on top:

diff --git a/fsck.c b/fsck.c
index 1789c34..7776660 100644
--- a/fsck.c
+++ b/fsck.c
@@ -281,7 +281,7 @@ static int fsck_ident(const char **ident, struct object *obj, fsck_error error_f
 
 static int fsck_commit(struct commit *commit, fsck_error error_func)
 {
-	char *buffer = commit->buffer;
+	const char *buffer = commit->buffer;
 	unsigned char tree_sha1[20], sha1[20];
 	struct commit_graft *graft;
 	int parents = 0;

Otherwise, gcc will complain about incompatible pointer types.

-Peff
