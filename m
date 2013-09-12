From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-compat-util: Avoid strcasecmp() being inlined
Date: Thu, 12 Sep 2013 08:37:08 -0700
Message-ID: <xmqq61u6qcez.fsf@gitster.dls.corp.google.com>
References: <523094F0.9000509@gmail.com> <20130911182921.GE4326@google.com>
	<CAHGBnuN0pSmX7_mM6xpRqpF4qPVbP7oBK416NrTVM7tu=DZTjg@mail.gmail.com>
	<20130911214116.GA12235@sigill.intra.peff.net>
	<CAHGBnuP3iX9pqm5kK9_WjAXr5moDuJ1jxtUkXwKEt2jjLTcLkQ@mail.gmail.com>
	<20130912101419.GY2582@serenity.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Sebastian Schuberth <sschuberth@gmail.com>,
	Jeff King <peff@peff.net>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Karsten Blees <karsten.blees@gmail.com>
To: John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Thu Sep 12 17:37:40 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VK8xP-00008R-C3
	for gcvg-git-2@plane.gmane.org; Thu, 12 Sep 2013 17:37:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754222Ab3ILPhQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Sep 2013 11:37:16 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:64141 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753521Ab3ILPhO (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Sep 2013 11:37:14 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BE64B3FF1D;
	Thu, 12 Sep 2013 15:37:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=aroPf1wUvgXiGthpQE7u4YNwOvY=; b=bDtF8W
	sU+pzCoAxwRB+07laAvuWlz3Ds98AdYQT5VuoV8aXRYbA67GI6LknpjnvqJm3Kee
	Xp7GJh882rXF+6ki8TFwhgoN8F1JxInhxcG0+SJNuEEdzXIM1wVj6RyFzkGJbtkd
	BpmbJJy/nJQsLNEmGnY9MOS5tPipgDg3nhPQ0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=wCrpM9K/cFoqcTPbZOcWbgTnO/nrC0Qm
	azv28UnaoGkp9LyRtIVbwBqFmW1uE2gE5wR9ThYkqDhGp/WZ7ja/XO4s261DbSZw
	W/lP9PnIwV+PS+F9dP5DBsAcKSjuY4KIdOw3EloFqiD4K12llTUU7kbGSDfdc0Du
	kUs8/n+PoKI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id AFCBE3FF1B;
	Thu, 12 Sep 2013 15:37:13 +0000 (UTC)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D40C73FF0E;
	Thu, 12 Sep 2013 15:37:12 +0000 (UTC)
In-Reply-To: <20130912101419.GY2582@serenity.lan> (John Keeping's message of
	"Thu, 12 Sep 2013 11:14:19 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 31CF2130-1BC1-11E3-9693-CA9B8506CD1E-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234656>

John Keeping <john@keeping.me.uk> writes:

> On Thu, Sep 12, 2013 at 11:36:56AM +0200, Sebastian Schuberth wrote:
>> > Just wondering if that is the root of the problem, or if maybe there is
>> > something else subtle going on. Also, does __CRT_INLINE just turn into
>> > "inline", or is there perhaps some other pre-processor magic going on?
>> 
>> This is the function definition from string.h after preprocessing:
>> 
>> extern __inline__ int __attribute__((__cdecl__)) __attribute__ ((__nothrow__))
>> strncasecmp (const char * __sz1, const char * __sz2, size_t __sizeMaxCompare)
>>   {return _strnicmp (__sz1, __sz2, __sizeMaxCompare);}
>
> I wonder if GCC has changed it's behaviour to more closely match C99.
> Clang as a compatibility article about this sort of issue:
>
>     http://clang.llvm.org/compatibility.html#inline

Interesting.  The ways the page suggests as fixes are

 - change it to a "statis inline";
 - remove "inline" from the definition;
 - provide an external (non-inline) def somewhere else;
 - compile with gnu899 dialect.

But the first two are non-starter, and the third one to force
everybody to define an equivalent implementation is nonsense, for a
definition in the standard header file.

I agree with an earlier conclusion that defining our own wrapper
(with an explanation why such a redundant wrapper exists) is the
best course of action at this point, until the system header is
fixed.

 mailmap.c | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/mailmap.c b/mailmap.c
index a7969c4..d36d424 100644
--- a/mailmap.c
+++ b/mailmap.c
@@ -52,6 +52,19 @@ static void free_mailmap_entry(void *p, const char *s)
 	string_list_clear_func(&me->namemap, free_mailmap_info);
 }
 
+/*
+ * On some systems, string.h has _only_ inline definition of strcasecmp
+ * without supplying a non-inline implementation anywhere, which is, eh,
+ * "unusual"; we cannot take an address of such a function to store it in
+ * namemap.cmp.  This is here as a workaround---do not assign strcasecmp
+ * directly to namemap.cmp until we know no systems that matter have such
+ * an "unusual" string.h.
+ */
+static int namemap_cmp(const char *a, const char *b)
+{
+	return strcasecmp(a, b);
+}
+
 static void add_mapping(struct string_list *map,
 			char *new_name, char *new_email,
 			char *old_name, char *old_email)
@@ -75,7 +88,7 @@ static void add_mapping(struct string_list *map,
 		item = string_list_insert_at_index(map, index, old_email);
 		me = xcalloc(1, sizeof(struct mailmap_entry));
 		me->namemap.strdup_strings = 1;
-		me->namemap.cmp = strcasecmp;
+		me->namemap.cmp = namemap_cmp;
 		item->util = me;
 	}
 
@@ -237,7 +250,7 @@ int read_mailmap(struct string_list *map, char **repo_abbrev)
 	int err = 0;
 
 	map->strdup_strings = 1;
-	map->cmp = strcasecmp;
+	map->cmp = namemap_cmp;
 
 	if (!git_mailmap_blob && is_bare_repository())
 		git_mailmap_blob = "HEAD:.mailmap";
