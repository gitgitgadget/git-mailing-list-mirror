From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 4/4] fetch-pack: mention server version with verbose
 output
Date: Mon, 13 Aug 2012 21:59:27 -0400
Message-ID: <20120814015927.GA7891@sigill.intra.peff.net>
References: <20120810075342.GA30072@sigill.intra.peff.net>
 <20120810075816.GC8399@sigill.intra.peff.net>
 <7v7gt6jz3s.fsf@alter.siamese.dyndns.org>
 <20120810211509.GB888@sigill.intra.peff.net>
 <7v393uif9g.fsf@alter.siamese.dyndns.org>
 <7vboieehrf.fsf@alter.siamese.dyndns.org>
 <7v7gt2ehl4.fsf_-_@alter.siamese.dyndns.org>
 <20120813205423.GA31630@sigill.intra.peff.net>
 <7v628mcxdf.fsf@alter.siamese.dyndns.org>
 <20120813211109.GA32688@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Aug 14 03:59:37 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T16Pw-0005JR-Dh
	for gcvg-git-2@plane.gmane.org; Tue, 14 Aug 2012 03:59:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754738Ab2HNB7a (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Aug 2012 21:59:30 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:36750 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754458Ab2HNB73 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Aug 2012 21:59:29 -0400
Received: (qmail 32095 invoked by uid 107); 14 Aug 2012 01:59:39 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 13 Aug 2012 21:59:39 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 13 Aug 2012 21:59:27 -0400
Content-Disposition: inline
In-Reply-To: <20120813211109.GA32688@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203379>

On Mon, Aug 13, 2012 at 05:11:10PM -0400, Jeff King wrote:

> On Mon, Aug 13, 2012 at 02:09:32PM -0700, Junio C Hamano wrote:
> 
> > >> +	if ((agent_feature = server_feature("agent", &agent_len)) != NULL &&
> > >> +	    5 < agent_len && agent_feature[5] == '=') {
> > >>  		agent_supported = 1;
> > >> +		if (args.verbose) {
> > >> +			fprintf(stderr, "Server version is %.*s\n",
> > >> +				agent_len - 6, agent_feature + 6);
> > >> +		}
> > >> +	}
> > >
> > > Yeah, this is exactly the kind of ugliness I was trying to avoid with my
> > > allocating wrapper. Still, there is only one call site, so I do not care
> > > overly much (and I as I've already said, I'm lukewarm on the final two
> > > patches, anyway).
> > 
> > Actually, the above is vastly superiour compared to the allocating
> > kind.  Be honest and think about it.  If the caller wants to
> > allocate, it could, and it does not even have to count.  If the
> > caller does not want to allocate, it does not have to pay the price.
> 
> My point is that the run-time allocation price is quite small, but the
> readability cost of that ugly conditional with the magic "5" is
> non-trivial. But they are apples and oranges, so it is hard to compare
> their amounts directly.

So if we want to avoid the allocation, then this is how I would do it:
by returning the feature's _value_ and not the whole key. Since we know
that the beginning part must obviously match what we fed it anyway, it
is not that interesting.

-- >8 --
Subject: [PATCH] parse_feature_request: make it easier to see feature values

We already take care to parse key/value capabilities like
"foo=bar", but the code does not provide a good way of
actually finding out what is on the right-hand side of the
"=".

A server using "parse_feature_request" could accomplish this
with some extra parsing. You must skip past the "key"
portion manually, check for "=" versus NUL or space, and
then find the length by searching for the next space (or
NUL).  But clients can't even do that, since the
"server_supports" interface does not even return the
pointer.

Instead, let's have our parser share more information by
providing a pointer to the value and its length. The
"parse_feature_value" function returns a pointer to the
feature's value portion, along with the length of the value.
If the feature is missing, NULL is returned. If it does not
have an "=", then a zero-length value is returned.

Similarly, "server_feature_value" behaves in the same way,
but always checks the static server_feature_list variable.

We can then implement "server_supports" in terms of
"server_feature_value". We cannot implement the original
"parse_feature_request" in terms of our new function,
because it returned a pointer to the beginning of the
feature. However, no callers actually cared about the value
of the returned pointer, so we can simplify it to a boolean
just as we do for "server_supports".

Signed-off-by: Jeff King <peff@peff.net>
---
 cache.h   |  4 +++-
 connect.c | 45 ++++++++++++++++++++++++++++++++++++---------
 2 files changed, 39 insertions(+), 10 deletions(-)

diff --git a/cache.h b/cache.h
index 67f28b4..95daa69 100644
--- a/cache.h
+++ b/cache.h
@@ -1038,7 +1038,9 @@ struct extra_have_objects {
 };
 extern struct ref **get_remote_heads(int in, struct ref **list, unsigned int flags, struct extra_have_objects *);
 extern int server_supports(const char *feature);
-extern const char *parse_feature_request(const char *features, const char *feature);
+extern int parse_feature_request(const char *features, const char *feature);
+extern const char *server_feature_value(const char *feature, int *len_ret);
+extern const char *parse_feature_value(const char *feature_list, const char *feature, int *len_ret);
 
 extern struct packed_git *parse_pack_index(unsigned char *sha1, const char *idx_path);
 
diff --git a/connect.c b/connect.c
index 55a85ad..49e56ba 100644
--- a/connect.c
+++ b/connect.c
@@ -115,12 +115,7 @@ struct ref **get_remote_heads(int in, struct ref **list,
 	return list;
 }
 
-int server_supports(const char *feature)
-{
-	return !!parse_feature_request(server_capabilities, feature);
-}
-
-const char *parse_feature_request(const char *feature_list, const char *feature)
+const char *parse_feature_value(const char *feature_list, const char *feature, int *lenp)
 {
 	int len;
 
@@ -132,14 +127,46 @@ const char *parse_feature_request(const char *feature_list, const char *feature)
 		const char *found = strstr(feature_list, feature);
 		if (!found)
 			return NULL;
-		if ((feature_list == found || isspace(found[-1])) &&
-		    (!found[len] || isspace(found[len]) || found[len] == '='))
-			return found;
+		if (feature_list == found || isspace(found[-1])) {
+			const char *value = found + len;
+			/* feature with no value (e.g., "thin-pack") */
+			if (!*value || isspace(*value)) {
+				if (lenp)
+					*lenp = 0;
+				return value;
+			}
+			/* feature with a value (e.g., "agent=git/1.2.3") */
+			else if (*value == '=') {
+				value++;
+				if (lenp)
+					*lenp = strcspn(value, " \t\n");
+				return value;
+			}
+			/*
+			 * otherwise we matched a substring of another feature;
+			 * keep looking
+			 */
+		}
 		feature_list = found + 1;
 	}
 	return NULL;
 }
 
+int parse_feature_request(const char *feature_list, const char *feature)
+{
+	return !!parse_feature_value(feature_list, feature, NULL);
+}
+
+const char *server_feature_value(const char *feature, int *len)
+{
+	return parse_feature_value(server_capabilities, feature, len);
+}
+
+int server_supports(const char *feature)
+{
+	return !!server_feature_value(feature, NULL);
+}
+
 enum protocol {
 	PROTO_LOCAL = 1,
 	PROTO_SSH,
-- 
1.7.12.rc2.11.gf0a1e27
