From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Segfault in the attr stack
Date: Thu, 02 Jun 2016 08:59:29 -0700
Message-ID: <xmqqshwvvaxq.fsf@gitster.mtv.corp.google.com>
References: <CAGZ79ka_4vZfNhgOyMeFKdossO-S5Q7RVnvEzB8YAJNc1YQ+uQ@mail.gmail.com>
	<CAGZ79kbSKgS42nAShsK3JV78geam3k84=ipWRx7vbRODuHcmcA@mail.gmail.com>
	<CAPc5daXuQAeWvJAciRA_Kzyoxa=atEntGzKhqzjiN+ho6TnQyg@mail.gmail.com>
	<xmqqh9dcwmrr.fsf@gitster.mtv.corp.google.com>
	<xmqq8tyowias.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: "git\@vger.kernel.org" <git@vger.kernel.org>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Thu Jun 02 17:59:46 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b8V24-00082B-O2
	for gcvg-git-2@plane.gmane.org; Thu, 02 Jun 2016 17:59:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161223AbcFBP7f (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Jun 2016 11:59:35 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:58167 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932812AbcFBP7e (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Jun 2016 11:59:34 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id AB0DE21292;
	Thu,  2 Jun 2016 11:59:32 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=7WRt1dy9B1CbIAmBqnqmKlqnVws=; b=P0qxwU
	d+Qbxlw3AkNzZdS3ystqK+JRuruqBse1y3a38LCv7sjELHeJLargQYy0FrMNjqwJ
	snETFRkXHZDEAAVqZ1nH9HSxdnScYy6loLGvSLRyhP4eR3mmBUndD4brKsJH+ueD
	ZmDnQcDxybhLjPzD41dnZLwONnKxer36F7s7E=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=TpNWwgXfq8MdctCVju3TWgRrQ8wW4Xa9
	zuxaisyvmc/TidErmrVsH4EroYSusgX/S9OirA/GmV6wYCoc8egBpvqvNT+wRMx9
	S/aef3VJJ7Nek6kMLcBsmKkVVHWqmJXPZ+bj/miiOMZWfoFSJbMIi0KFWYaJLTj3
	6lPlL31km5M=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 9B64F21291;
	Thu,  2 Jun 2016 11:59:32 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 163AB21290;
	Thu,  2 Jun 2016 11:59:32 -0400 (EDT)
In-Reply-To: <xmqq8tyowias.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
	message of "Wed, 01 Jun 2016 17:22:51 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: FE9C2CD4-28DA-11E6-9E43-EE617A1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296210>

Junio C Hamano <gitster@pobox.com> writes:

>>> Gaah, of course.
>>>
>>> This is coming from the cache preload codepath, where multiple threads
>>> try to run ce_path_match().
>>> It used to be OK because pathspec magic never looked at attributes,
>>> but now it does, and attribute system is not thread-safe.

I'll look into teaching a threadble interface to the attribute
subsystem, but for now, this should get you unstuck, I think.

One of the ways preload codepath assures that multiple threads do
not stomp on the shared datastructure is by copying things that are
involved in the operation, and there is copy_pathspec() call.  I
think the "pathspec magic that limits with the attributes" topic,
which adds to the pathspec structure, needs to update the function
so that its shared data structure is properly copied.  Before the
series, I think the pathspec structure only has either pointers to
borrowed strings (e.g. raw) or scalars, and it was sufficient to do
a shallow copy with memcpy().  With the change, that is no longer
the case.

Which would mean we'd need to make sure that any codepath that calls
copy_pathspec() needs to think about how to clean it up.  Before the
change, preload-index codepath didn't have to, but with the change,
it will.  We'd need pathspec_clear() or something like that.

 pathspec.c      | 12 ++++++++++++
 pathspec.h      |  2 ++
 preload-index.c |  4 ++++
 3 files changed, 18 insertions(+)

diff --git a/pathspec.c b/pathspec.c
index 0a02255..326863a 100644
--- a/pathspec.c
+++ b/pathspec.c
@@ -208,6 +208,18 @@ static void eat_long_magic(struct pathspec_item *item, const char *elt,
 	*copyfrom_ = copyfrom;
 }
 
+int pathspec_is_non_threadable(const struct pathspec *pathspec)
+{
+	int i;
+
+	for (i = 0; i < pathspec->nr; i++) {
+		const struct pathspec_item *item = &pathspec->items[i];
+		if (item->attr_check)
+			return 1;
+	}
+	return 0;
+}
+
 /*
  * Take an element of a pathspec and check for magic signatures.
  * Append the result to the prefix. Return the magic bitmap.
diff --git a/pathspec.h b/pathspec.h
index 5308137..07d21f0 100644
--- a/pathspec.h
+++ b/pathspec.h
@@ -115,4 +115,6 @@ extern void add_pathspec_matches_against_index(const struct pathspec *pathspec,
 extern const char *check_path_for_gitlink(const char *path);
 extern void die_if_path_beyond_symlink(const char *path, const char *prefix);
 
+extern int pathspec_is_non_threadable(const struct pathspec *);
+
 #endif /* PATHSPEC_H */
diff --git a/preload-index.c b/preload-index.c
index c1fe3a3..af46878 100644
--- a/preload-index.c
+++ b/preload-index.c
@@ -76,6 +76,10 @@ static void preload_index(struct index_state *index,
 	if (!core_preload_index)
 		return;
 
+	/* Do not preload when pathspec uses non-threadable subsystems */
+	if (pathspec && pathspec_is_non_threadable(pathspec))
+		return; /* for now ... */
+
 	threads = index->cache_nr / THREAD_COST;
 	if (threads < 2)
 		return;
