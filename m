From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 5/8] string-list: add pos to iterator callback
Date: Tue, 1 Jul 2014 15:00:37 -0400
Message-ID: <20140701190037.GA15828@sigill.intra.peff.net>
References: <20140625233429.GA20457@sigill.intra.peff.net>
 <20140625234252.GE23146@sigill.intra.peff.net>
 <xmqq1tu5x9ao.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jul 01 21:00:46 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X23II-0006TX-RT
	for gcvg-git-2@plane.gmane.org; Tue, 01 Jul 2014 21:00:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751538AbaGATAi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Jul 2014 15:00:38 -0400
Received: from cloud.peff.net ([50.56.180.127]:54373 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751141AbaGATAh (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Jul 2014 15:00:37 -0400
Received: (qmail 21569 invoked by uid 102); 1 Jul 2014 19:00:37 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 01 Jul 2014 14:00:37 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 01 Jul 2014 15:00:37 -0400
Content-Disposition: inline
In-Reply-To: <xmqq1tu5x9ao.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252734>

On Tue, Jul 01, 2014 at 10:45:19AM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > When we are running a string-list foreach or filter, the
> > callback function sees only the string_list_item, along with
> > a void* data pointer provided by the caller. This is
> > sufficient for most purposes.
> >
> > However, it can also be useful to know the position of the
> > item within the string (for example, if the data pointer
> 
> s/the string/&-list/ (or s/&/&_list/).

Thanks, yeah.

> While I can buy that some callers would want to learn the pos in the
> list, I am not sure if this is a good direction to go.  Primarily, I
> am having trouble sifting between "want" and "need".
> 
> How often do callers want to do this?  If only narrow specialized
> callers want this, is it unreasonable to ask them to add a "int ctr"
> in their cb_data and use "pos = ((struct theirs *)cb_data)->ctr++"
> in their callback instead?

Not all that often, I suppose (I only add one caller in this series). I
just found it a little hack-ish to force callers to keep their own
counter when we already have it (especially because it is not too hard
to get it wrong, for example by forgetting to increment the counter in
one code path of the callback).

Here's what the caller would look like without "pos" (done as a patch on
top of the series, so pos is still there, but no longer used).

diff --git a/builtin/tag.c b/builtin/tag.c
index f17192c..dc6f105 100644
--- a/builtin/tag.c
+++ b/builtin/tag.c
@@ -151,14 +151,20 @@ static int util_is_not_null(struct string_list_item *it, int pos, void *data)
 	return !!it->util;
 }
 
-static int matches_contains(struct string_list_item *it, int pos, void *data)
+struct contains_callback_data {
+	int ctr;
+	unsigned char *contains;
+};
+
+static int matches_contains(struct string_list_item *it, int pos, void *vdata)
 {
-	unsigned char *contains = data;
-	return contains[pos];
+	struct contains_callback_data *data = vdata;
+	return data->contains[data->ctr++];
 }
 
 static void limit_by_contains(struct string_list *tags, struct commit_list *with)
 {
+	struct contains_callback_data cbdata;
 	struct commit_list *tag_commits = NULL, **tail = &tag_commits;
 	unsigned char *result;
 	int i;
@@ -180,7 +186,10 @@ static void limit_by_contains(struct string_list *tags, struct commit_list *with
 
 	result = xmalloc(tags->nr);
 	commit_contains(with, tag_commits, NULL, result);
-	filter_string_list(tags, 1, matches_contains, result);
+
+	cbdata.ctr = 0;
+	cbdata.contains = result;
+	filter_string_list(tags, 1, matches_contains, &cbdata);
 
 	free(result);
 	free_commit_list(tag_commits);

So I think it's a small change in a lot of places rather than a kind of
ugly change in one spot.

All that being said, I think the real issue here is that I want more
than a string list (I am already using the util field for the sha1, but
this code would be potentially simpler if I could also store the commit
object). In the long run I hope to factor out a ref-listing API that can
be used by tag, branch, and for-each-ref. And then this string-list code
would go away in favor of a more expansive struct. So it may not be
worth worrying about keeping it too clean.

-Peff
