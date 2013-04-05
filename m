From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] http-backend: respect GIT_NAMESPACE with dumb clients
Date: Thu, 4 Apr 2013 22:56:55 -0400
Message-ID: <20130405025655.GA25970@sigill.intra.peff.net>
References: <CAAvHm8PCQx18Gk2S7dicG+_GksjFqVLfPNCbism1sHnPUMDNzg@mail.gmail.com>
 <1365091293-23758-1-git-send-email-jkoleszar@google.com>
 <7v6202jjhx.fsf@alter.siamese.dyndns.org>
 <CAAvHm8NyJ3nRZPygy+grMw5BLhLe8eWfEBNfK1tkC8Y34jRynA@mail.gmail.com>
 <20130405023516.GA32290@leaf>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: John Koleszar <jkoleszar@google.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Shawn Pearce <spearce@spearce.org>
To: Josh Triplett <josh@joshtriplett.org>
X-From: git-owner@vger.kernel.org Fri Apr 05 04:57:46 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UNwqR-00005K-Th
	for gcvg-git-2@plane.gmane.org; Fri, 05 Apr 2013 04:57:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161471Ab3DEC5E (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Apr 2013 22:57:04 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:56698 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1161071Ab3DEC5D (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Apr 2013 22:57:03 -0400
Received: (qmail 10000 invoked by uid 107); 5 Apr 2013 02:58:52 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 04 Apr 2013 22:58:52 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 04 Apr 2013 22:56:55 -0400
Content-Disposition: inline
In-Reply-To: <20130405023516.GA32290@leaf>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220135>

On Thu, Apr 04, 2013 at 07:35:16PM -0700, Josh Triplett wrote:

> > Including the HEAD ref in the advertisement from /info/refs ends up
> > duplicating it, since the dumb client unconditionally fetches the file
> > /HEAD to use as the that ref. I think the right thing to do is
> > generate the correct /HEAD using head_ref_namespaced(), rather than
> > returning the bare file $GIT_DIR/HEAD, but I'm not 100% sure how HEAD
> > and namespaces interact, since I haven't been able to produce a repo
> > with a different HEAD in a namespace. Can you verify this approach?
> 
> Semantically, every namespace should act like a completely independent
> repository, which includes having its own independent HEAD.  A namespace
> should *not* see the HEAD of the entire repository, only its own
> namespaced HEAD.

Yeah, that makes sense. I think we'd want something like the (totally
untested) patch below. And the tests I provided for t5551 should be
amended to set up a HEAD within the namespace, should make the resulting
clone non-bare, and should confirm that we check out the correct HEAD.

diff --git a/http-backend.c b/http-backend.c
index 8144f3a..84ba7f9 100644
--- a/http-backend.c
+++ b/http-backend.c
@@ -376,6 +376,14 @@ static int show_text_ref(const char *name, const unsigned char *sha1,
 	return 0;
 }
 
+static void get_head(char *arg)
+{
+	struct strbuf buf = STRBUF_INIT;
+	head_ref_namespaced(show_text_ref, &buf);
+	send_strbuf("text/plain", &buf);
+	strbuf_release(&buf);
+}
+
 static void get_info_refs(char *arg)
 {
 	const char *service_name = get_parameter("service");
@@ -520,7 +528,7 @@ static struct service_cmd {
 	const char *pattern;
 	void (*imp)(char *);
 } services[] = {
-	{"GET", "/HEAD$", get_text_file},
+	{"GET", "/HEAD$", get_head },
 	{"GET", "/info/refs$", get_info_refs},
 	{"GET", "/objects/info/alternates$", get_text_file},
 	{"GET", "/objects/info/http-alternates$", get_text_file},
