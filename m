From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] string-list.h: Add STRING_LIST_INIT macro and make use
 of it.
Date: Sun, 27 Jun 2010 09:44:53 -0700
Message-ID: <7vbpawifwa.fsf@alter.siamese.dyndns.org>
References: <c4c9797a4cbea89f1f0fb0501e6a03912b598b17.1277595284.git.tfransosi@gmail.com>
 <de7ad1688930aa47515736885b7d8438118e7aa1.1277595923.git.tfransosi@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, jrnieder@gmail.com, srabbelier@gmail.com
To: Thiago Farina <tfransosi@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jun 27 18:45:16 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OSuyp-0007bK-Sb
	for gcvg-git-2@lo.gmane.org; Sun, 27 Jun 2010 18:45:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755784Ab0F0QpI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 27 Jun 2010 12:45:08 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:62891 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754916Ab0F0QpG (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 Jun 2010 12:45:06 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 18221BFE1B;
	Sun, 27 Jun 2010 12:45:05 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=YI+EVY12Bf+aXZQvHOKLZh9B4II=; b=VZnTDY
	5PZHB11t16TdUSbnUMGuQkSqEuEtZOKPAQo43ytQimC7dLW9qKcvrSfmy8WtT8MH
	pT1mHldZ46JdQJkp00+YpWbyJFCOBDm023l9C/5qU+IVgt+DQhDQFQQqnm/GC8G7
	zC08HpLK2NC/dnsAJn+YTyRU0GK5yJKioQ3fQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=EUf9YDY669hrpaJhIUrdVAYaPTTcvhbp
	uKYQqiEE53uIgha5dspEOW+OgvKIHj00/xatMNWJPGO08MfEStOHvVW3q/42J71t
	zykA6+BnnAJIdpTgqJ3RNf0+2WcPMsCjWJfJrz9SJM4UqTW8uiCQeTko34uPxsxZ
	NRFZ5ve3J9k=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id C2F48BFE18;
	Sun, 27 Jun 2010 12:45:00 -0400 (EDT)
Received: from pobox.com (unknown [69.181.135.33]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id BF935BFE16; Sun, 27 Jun
 2010 12:44:55 -0400 (EDT)
In-Reply-To: <de7ad1688930aa47515736885b7d8438118e7aa1.1277595923.git.tfransosi@gmail.com>
 (Thiago Farina's message of "Sat\, 26 Jun 2010 20\:47\:28 -0300")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 53DDF0E2-820B-11DF-9900-9056EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149794>

I think you need the attached on top to be more complete.

But I wonder if this is worth it (not this "more complete", but your
patch).  We convert 16 or so instances of initialization for "no strdup"
list, but there are about the same number of "strdup" instances still
spelled out:

    $ git grep -e 'struct string_list [^ ]* = {.*'
    $ git grep -e 'struct string_list [^ ]* = {.*1'

Wouldn't it be more sensible to use this instead?

    #define STRING_LIST_INIT(pleasedup) { NULL, 0, 0, (pleasedup) }

---
 builtin/mv.c       |    2 +-
 builtin/remote.c   |    4 ++--
 transport-helper.c |    2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/builtin/mv.c b/builtin/mv.c
index c07f53b..e2f0279 100644
--- a/builtin/mv.c
+++ b/builtin/mv.c
@@ -63,7 +63,7 @@ int cmd_mv(int argc, const char **argv, const char *prefix)
 	const char **source, **destination, **dest_path;
 	enum update_mode { BOTH = 0, WORKING_DIRECTORY, INDEX } *modes;
 	struct stat st;
-	struct string_list src_for_dst = {NULL, 0, 0, 0};
+	struct string_list src_for_dst = STRING_LIST_INIT;
 
 	git_config(git_default_config, NULL);
 
diff --git a/builtin/remote.c b/builtin/remote.c
index 9d41792..5ff2b5b 100644
--- a/builtin/remote.c
+++ b/builtin/remote.c
@@ -134,7 +134,7 @@ static int add_branch(const char *key, const char *branchname,
 static int add(int argc, const char **argv)
 {
 	int fetch = 0, mirror = 0, fetch_tags = TAGS_DEFAULT;
-	struct string_list track = { NULL, 0, 0 };
+	struct string_list track = STRING_LIST_INIT;
 	const char *master = NULL;
 	struct remote *remote;
 	struct strbuf buf = STRBUF_INIT, buf2 = STRBUF_INIT;
@@ -1483,7 +1483,7 @@ static int get_one_entry(struct remote *remote, void *priv)
 
 static int show_all(void)
 {
-	struct string_list list = { NULL, 0, 0 };
+	struct string_list list = STRING_LIST_INIT;
 	int result;
 
 	list.strdup_strings = 1;
diff --git a/transport-helper.c b/transport-helper.c
index 0381de5..86a79b9 100644
--- a/transport-helper.c
+++ b/transport-helper.c
@@ -689,7 +689,7 @@ static int push_refs_with_export(struct transport *transport,
 	struct child_process *helper, exporter;
 	struct helper_data *data = transport->data;
 	char *export_marks = NULL, *import_marks = NULL;
-	struct string_list revlist_args = { NULL, 0, 0 };
+	struct string_list revlist_args = STRING_LIST_INIT;
 	struct strbuf buf = STRBUF_INIT;
 
 	helper = get_helper(transport);
