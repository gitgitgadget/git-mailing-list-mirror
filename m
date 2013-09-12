From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-compat-util: Avoid strcasecmp() being inlined
Date: Thu, 12 Sep 2013 11:35:21 -0700
Message-ID: <xmqqd2odq45y.fsf@gitster.dls.corp.google.com>
References: <523094F0.9000509@gmail.com> <20130911182921.GE4326@google.com>
	<CAHGBnuN0pSmX7_mM6xpRqpF4qPVbP7oBK416NrTVM7tu=DZTjg@mail.gmail.com>
	<20130911214116.GA12235@sigill.intra.peff.net>
	<CAHGBnuP3iX9pqm5kK9_WjAXr5moDuJ1jxtUkXwKEt2jjLTcLkQ@mail.gmail.com>
	<20130912101419.GY2582@serenity.lan>
	<xmqq61u6qcez.fsf@gitster.dls.corp.google.com>
	<20130912182057.GB32069@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: John Keeping <john@keeping.me.uk>,
	Sebastian Schuberth <sschuberth@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Karsten Blees <karsten.blees@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Sep 12 20:35:37 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VKBjp-0004ct-9d
	for gcvg-git-2@plane.gmane.org; Thu, 12 Sep 2013 20:35:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755656Ab3ILSf1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Sep 2013 14:35:27 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:34595 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754110Ab3ILSfY (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Sep 2013 14:35:24 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8E3EB40635;
	Thu, 12 Sep 2013 18:35:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=xGuaz3VrvmXZ2iyW3632WXkIFjM=; b=xd4btG
	d0AUzs+EfyFwRl8zi3pmVs0bWTmC3Xhn/0LnT3qs4qcLWOF+6RteUjNZxqBFQYVs
	FbxuC+9PgauLwYBSsT+vejWM6WGAw540DGPDHjlBBcjhDe4+deeH2ZWoOzQpp7FQ
	+y009EoNCApH+OOrSoBdvmqTX7WeaLifLcFN0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=S5qcUGOZINr6SOhpR2URlPDhQ0TL6vXX
	zjdiqOoaQeCNSjk1NvM104WkkBGW3Mg4QV3EFlB/vRbCSVedriMolQhroHO9KNRx
	+wT37tHK2HVdfBbJJnERchkW537TP5Drv1YcT3xFuHeKktwfzCVzTYEe6VUBTMHJ
	jgKOpZJ8sUU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 81E4940634;
	Thu, 12 Sep 2013 18:35:23 +0000 (UTC)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B84D040629;
	Thu, 12 Sep 2013 18:35:22 +0000 (UTC)
In-Reply-To: <20130912182057.GB32069@sigill.intra.peff.net> (Jeff King's
	message of "Thu, 12 Sep 2013 14:20:57 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 157951D6-1BDA-11E3-AF5E-CA9B8506CD1E-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234669>

Jeff King <peff@peff.net> writes:

> On Thu, Sep 12, 2013 at 08:37:08AM -0700, Junio C Hamano wrote:
>
>> > I wonder if GCC has changed it's behaviour to more closely match C99.
>> > Clang as a compatibility article about this sort of issue:
>> >
>> >     http://clang.llvm.org/compatibility.html#inline
>> 
>> Interesting.  The ways the page suggests as fixes are
>> 
>>  - change it to a "statis inline";
>>  - remove "inline" from the definition;
>>  - provide an external (non-inline) def somewhere else;
>>  - compile with gnu899 dialect.
>
> Right, option 3 seems perfectly reasonable to me, as we must be prepared
> to cope with a decision not to inline the function, and there has to be
> _some_ linked implementation. But shouldn't libc be providing an
> external, linkable strcasecmp in this case?

That is exactly my point when I said that the third one is nonsense
for a definition in the standard header file.

I think we would want something like below.

-- >8 --
Subject: [PATCH] mailmap: work around implementations with pure inline strcasecmp

On some systems, string.h has _only_ inline definition of strcasecmp
without supplying a non-inline implementation anywhere, which is,
eh, "unusual"; we cannot take an address of such a function to store
it in namemap.cmp.  Work it around by introducing our own level of
indirection.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 mailmap.c | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/mailmap.c b/mailmap.c
index 44614fc..8863e23 100644
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
 
@@ -241,7 +254,7 @@ int read_mailmap(struct string_list *map, char **repo_abbrev)
 	int err = 0;
 
 	map->strdup_strings = 1;
-	map->cmp = strcasecmp;
+	map->cmp = namemap_cmp;
 
 	if (!git_mailmap_blob && is_bare_repository())
 		git_mailmap_blob = "HEAD:.mailmap";
-- 
1.8.4-485-gec42fe2
