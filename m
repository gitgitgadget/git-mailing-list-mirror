From: Jeff King <peff@peff.net>
Subject: Re: Bug report: Git 1.8 on Ubuntu 13.10 refs not valid
Date: Mon, 31 Mar 2014 14:57:54 -0400
Message-ID: <20140331185754.GA4426@sigill.intra.peff.net>
References: <5334398E.8090402@gmail.com>
 <20140327184916.GA28668@sigill.intra.peff.net>
 <5339A38D.1080504@gmail.com>
 <20140331180118.GA31023@sigill.intra.peff.net>
 <xmqqbnwm6x5i.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Siggi <siggin@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Mar 31 20:58:08 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WUhPI-0007Mz-6k
	for gcvg-git-2@plane.gmane.org; Mon, 31 Mar 2014 20:58:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753667AbaCaS55 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 31 Mar 2014 14:57:57 -0400
Received: from cloud.peff.net ([50.56.180.127]:51140 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753125AbaCaS54 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 31 Mar 2014 14:57:56 -0400
Received: (qmail 3733 invoked by uid 102); 31 Mar 2014 18:57:56 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 31 Mar 2014 13:57:56 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 31 Mar 2014 14:57:54 -0400
Content-Disposition: inline
In-Reply-To: <xmqqbnwm6x5i.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245509>

On Mon, Mar 31, 2014 at 11:27:53AM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > That being said, git _could_ be more liberal in accepting a content-type
> > with parameters (even though it does not know about any parameters, and
> > charset here is completely meaningless). I have mixed feelings on that.
> 
> It may be just a matter of replacing strbuf_cmp() with "the initial
> part must be this string" followed by "it could have an optional
> whitespaces and semicolon after that", but I share the mixed
> feelings.

Yeah, I think something like this is probably enough:

diff --git a/remote-curl.c b/remote-curl.c
index 52c2d96..be21fb6 100644
--- a/remote-curl.c
+++ b/remote-curl.c
@@ -221,6 +221,13 @@ static int show_http_message(struct strbuf *type, struct strbuf *msg)
 	return 0;
 }
 
+static int match_content_type(struct strbuf *have, struct strbuf *want)
+{
+	if (!starts_with(have->buf, want->buf))
+		return 0;
+	return have->len == want->len || have->buf[want->len] == ';';
+}
+
 static struct discovery* discover_refs(const char *service, int for_push)
 {
 	struct strbuf exp = STRBUF_INIT;
@@ -277,7 +284,7 @@ static struct discovery* discover_refs(const char *service, int for_push)
 	strbuf_addf(&exp, "application/x-%s-advertisement", service);
 	if (maybe_smart &&
 	    (5 <= last->len && last->buf[4] == '#') &&
-	    !strbuf_cmp(&exp, &type)) {
+	    match_content_type(type.buf, exp.buf)) {
 		char *line;
 
 		/*

though perhaps there are exotic whitespace rules that we would also need
to allow. Either way, I do not think it is the implementation that is
the problem, but rather the semantics.

> I am not sure if it is a right thing to follow "be liberal to
> accept" dictum in this case.  It may be liberal in accepting
> blindly, but if the other end is asking a behaviour that is not
> standard (but perhaps in future versions of Git such an enhanced
> service may be implemented by the client), by ignoring the parameter
> we do not even know about how to handle, we would be giving surprises
> to the overall protocol exchange.

I actually think ignoring them could provide room for future expansion
in git (i.e., we could add new c-t parameters with the knowledge that
existing git would ignore them). So there is a potential upside.  But
current git does _not_ ignore them. Git v1.10 (or 2.0, or whatever)
could, but we would have to wait for old versions to die out before
making that assumption anyway.

It's also possible that we would want to intentionally break
compatibility (to say "if you do not understand foo=bar, then do not
even process this"). But I don't think that is a big deal, as we could
already switch the content-type itself ("x-upload-pack-advertisement2"
or something). And if we really wanted to dump extra optional data into
the http conversation, we can already do so with http headers.

So really, I do not see us ever realistically expanding into
content-type parameters. This would _just_ be about handling odd
implementations. And there I can see it as us being nice (I do not think
"charset" is doing anything here), or us being careful about broken
implementations (why would one add a charset parameter at all? If the
implementation is blindly re-encoding to utf8 or something, it could
very well be corrupting the data in rare cases).

Given that there is only one implementation known to this in the first
place, I'd be inclined to say "fix that implementation". If it becomes
a widespread problem, then we can think about loosening the check after
reviewing exactly what each implementation is doing.

I think all of that is to say I'm violently agreeing with you. But
having tried to think it through, I felt it was worth posting the more
detailed thought process.

-Peff
