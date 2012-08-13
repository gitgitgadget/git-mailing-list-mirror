From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/4] connect: learn to parse capabilities with values
Date: Mon, 13 Aug 2012 12:03:48 -0700
Message-ID: <7vboieehrf.fsf@alter.siamese.dyndns.org>
References: <20120810075342.GA30072@sigill.intra.peff.net>
 <20120810075816.GC8399@sigill.intra.peff.net>
 <7v7gt6jz3s.fsf@alter.siamese.dyndns.org>
 <20120810211509.GB888@sigill.intra.peff.net>
 <7v393uif9g.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Aug 13 21:04:11 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T0zvn-0004Wo-Au
	for gcvg-git-2@plane.gmane.org; Mon, 13 Aug 2012 21:04:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752307Ab2HMTD5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Aug 2012 15:03:57 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:42885 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752040Ab2HMTD4 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Aug 2012 15:03:56 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 61FDB8981;
	Mon, 13 Aug 2012 15:03:53 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=zJI40iuJJswAmrRRBmSDBWTF268=; b=FcOFp1
	8omvw6T+G6PMRIsGz45blBMCODZb8QcpsViyshb2gUh8vSeUpxQR4647aq6YYVXX
	17kNOupiYcgMgtOUHFeNJCqjFCb/2p51LVhSxDDkVZHo29tyMtRVpPEHKm3FWYvd
	fWipPGOqZe/XywFP+tGkIprxdUbK4dAOe1xuA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=SlpWl5JcgRXXtnqI7D4K2Q/EUKD1xrT2
	NIO1/P6/K5kTbM2HdgVTLNV7I4HH1zHihs9KUI2AXlSi4+9ad/Oa9BFmQkxxkCvx
	2nOs/zIOGoGtNVb5RNwqNfGyCyKGN+QJMLyfBAtq+EIec+4EH+ZVhJcmaEUBfy8F
	isuLZtmBtAo=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4E8518980;
	Mon, 13 Aug 2012 15:03:53 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B407C897E; Mon, 13 Aug 2012
 15:03:49 -0400 (EDT)
In-Reply-To: <7v393uif9g.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Fri, 10 Aug 2012 14:55:07 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 9DB4377A-E579-11E1-A625-01B42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203353>

Junio C Hamano <gitster@pobox.com> writes:

> I forgot to mention it, but the above was done also to make it
> "possible but not mandatory" to pay extra allocation penalty.  The
> caller can choose to parse the string into an int, for example,
> without extra allocation.  Only the ones that want a string value
> and keep a copy around do have to do xmemdupz().
>
>> Anyway, do you think this is even worth doing at this point? I'm
>> lukewarm on the final two patches due to the existence of
>> GIT_TRACE_PACKET, which is much more likely to be useful.
>
> In the longer term, I think giving callers access to the parameter
> value given to a capability is necessary.  If we had this facility
> in the old days, we wouldn't have done side-band-64k but spelled it
> as side-band=64k.
>
> For the agent=<foo>, certainly we don't need it.

Here are the first of two patches to replace your 3 and 4 without
extra allocations, primarily for further discussion.

-- >8 --
Subject: [PATCH 3/4] connect: expose the parameter to a capability

We already take care to parse a capability like "foo=bar" properly,
but the code does not provide a good way of actually finding out
what is on the right-hand side of the "=".

Based on the patch by Jeff King <peff@peff.net>

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 cache.h   |  1 +
 connect.c | 27 ++++++++++++++++++++-------
 2 files changed, 21 insertions(+), 7 deletions(-)

diff --git a/cache.h b/cache.h
index 06413e1..d239cee 100644
--- a/cache.h
+++ b/cache.h
@@ -1030,6 +1030,7 @@ struct extra_have_objects {
 };
 extern struct ref **get_remote_heads(int in, struct ref **list, unsigned int flags, struct extra_have_objects *);
 extern int server_supports(const char *feature);
+extern const char *server_feature(const char *feature, int *len_ret);
 extern const char *parse_feature_request(const char *features, const char *feature);
 
 extern struct packed_git *parse_pack_index(unsigned char *sha1, const char *idx_path);
diff --git a/connect.c b/connect.c
index 912cdde..42640bc 100644
--- a/connect.c
+++ b/connect.c
@@ -99,12 +99,7 @@ struct ref **get_remote_heads(int in, struct ref **list,
 	return list;
 }
 
-int server_supports(const char *feature)
-{
-	return !!parse_feature_request(server_capabilities, feature);
-}
-
-const char *parse_feature_request(const char *feature_list, const char *feature)
+static const char *parse_feature_request_1(const char *feature_list, const char *feature, int *lenp)
 {
 	int len;
 
@@ -117,13 +112,31 @@ const char *parse_feature_request(const char *feature_list, const char *feature)
 		if (!found)
 			return NULL;
 		if ((feature_list == found || isspace(found[-1])) &&
-		    (!found[len] || isspace(found[len]) || found[len] == '='))
+		    (!found[len] || isspace(found[len]) || found[len] == '=')) {
+			if (lenp)
+				*lenp = strcspn(found, " \t\n");
 			return found;
+		}
 		feature_list = found + 1;
 	}
 	return NULL;
 }
 
+const char *parse_feature_request(const char *feature_list, const char *feature)
+{
+	return parse_feature_request_1(feature_list, feature, NULL);
+}
+
+const char *server_feature(const char *feature, int *len)
+{
+	return parse_feature_request_1(server_capabilities, feature, len);
+}
+
+int server_supports(const char *feature)
+{
+	return !!server_feature(feature, NULL);
+}
+
 enum protocol {
 	PROTO_LOCAL = 1,
 	PROTO_SSH,
-- 
1.7.12.rc2.85.g1de7134
