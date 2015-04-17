From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] type_from_string_gently: make sure length matches
Date: Fri, 17 Apr 2015 13:54:27 -0700
Message-ID: <xmqqd232pjb0.fsf@gitster.dls.corp.google.com>
References: <20150417145247.GA2421@peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Karthik Nayak <karthik.188@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Apr 17 22:54:35 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YjDHW-0000sf-QI
	for gcvg-git-2@plane.gmane.org; Fri, 17 Apr 2015 22:54:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751896AbbDQUya (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 Apr 2015 16:54:30 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:61283 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750865AbbDQUy3 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Apr 2015 16:54:29 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 10FBB492B8;
	Fri, 17 Apr 2015 16:54:29 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=+heYHM0UqWEPV1hNdb+/Ek+HZ+M=; b=DMv5uo
	Ab27v3Coqa+JZ1Euq0gpQR4EVWO+TdMfGW56pLxXY8Bkry+egVujqmNVUeqSHOeu
	uvP+ZqrGMYDiBvaHYLRZFNUmaWAwWdrfY6Y5wDsJBlMwMDeepHAN0NvynIU/V71d
	9RzwxDUy9AVIOJZyByaf3EJADw0STdGTiNFxg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=KyJi7oakECy7rNOQ8BiVGRsi8n98wlOE
	FUTkBA6NCpAPvrpdPF+2UD78/ECp1/cKwPpjnRjqaxhcvjwCok0tri95Vt029MNo
	+daHhla3DXlwPq1fxSu6I1LqUfebZ0bBT5hphO8KtNJoUvctonvDIiCfAlfGjbDw
	LnyrFxzjNn0=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 09E8C492B6;
	Fri, 17 Apr 2015 16:54:29 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 82236492B5;
	Fri, 17 Apr 2015 16:54:28 -0400 (EDT)
In-Reply-To: <20150417145247.GA2421@peff.net> (Jeff King's message of "Fri, 17
	Apr 2015 10:52:48 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: F05304F8-E543-11E4-AACC-83E09F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267390>

Jeff King <peff@peff.net> writes:

> When commit fe8e3b7 refactored type_from_string to allow
> input that was not NUL-terminated, it switched to using
> strncmp instead of strcmp. But this means we check only the
> first "len" bytes of the strings, and ignore any remaining
> bytes in the object_type_string. We should make sure that it
> is also "len" bytes, or else we would accept "comm" as
> "commit", and so forth.
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
> Since the strings we are matching are literals, we could also record
> their sizes in the object_type_strings array and check the length first
> before even calling strncmp. I doubt this is a performance hot-spot,
> though.
>
> You could also potentially just use strlen(object_type_strings[i]), but
> I'm not sure if compilers will optimize out the strlen in this case,
> since it is in a loop.

That thought crossed my mind while reading your patch.  It could
even make it go faster if we made object_type_strings into an array
of counted strings (i.e. "struct { const char *str; int len; }")
and then took advantage of the fact that we have lengths of both.


 object.c | 24 ++++++++++++++----------
 1 file changed, 14 insertions(+), 10 deletions(-)

diff --git a/object.c b/object.c
index aedac24..51584ea 100644
--- a/object.c
+++ b/object.c
@@ -18,19 +18,22 @@ struct object *get_indexed_object(unsigned int idx)
 	return obj_hash[idx];
 }
 
-static const char *object_type_strings[] = {
-	NULL,		/* OBJ_NONE = 0 */
-	"commit",	/* OBJ_COMMIT = 1 */
-	"tree",		/* OBJ_TREE = 2 */
-	"blob",		/* OBJ_BLOB = 3 */
-	"tag",		/* OBJ_TAG = 4 */
+static struct {
+	const char *str;
+	int len;
+} object_type_name[] = {
+	{ NULL, 0 },      /* OBJ_NONE = 0 */
+	{ "commit", 6 },  /* OBJ_COMMIT = 1 */
+	{ "tree", 4 },	  /* OBJ_TREE = 2 */
+	{ "blob", 4 },    /* OBJ_BLOB = 3 */
+	{ "tag", 3 },     /* OBJ_TAG = 4 */
 };
 
 const char *typename(unsigned int type)
 {
-	if (type >= ARRAY_SIZE(object_type_strings))
+	if (type >= ARRAY_SIZE(object_type_name))
 		return NULL;
-	return object_type_strings[type];
+	return object_type_name[type].str;
 }
 
 int type_from_string_gently(const char *str, ssize_t len, int gentle)
@@ -40,8 +43,9 @@ int type_from_string_gently(const char *str, ssize_t len, int gentle)
 	if (len < 0)
 		len = strlen(str);
 
-	for (i = 1; i < ARRAY_SIZE(object_type_strings); i++)
-		if (!strncmp(str, object_type_strings[i], len))
+	for (i = 1; i < ARRAY_SIZE(object_type_name); i++)
+		if (object_type_name[i].len == len &&
+			    !strncmp(str, object_type_name[i].str, len))
 			return i;
 
 	if (gentle)
