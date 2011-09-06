From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 1/5] sha1_file cleanup: remove redundant variable
 check
Date: Tue, 06 Sep 2011 09:59:21 -0700
Message-ID: <7vaaaha9p2.fsf@alter.siamese.dyndns.org>
References: <1315304645-12009-1-git-send-email-Hui.Wang@windriver.com>
 <1315304645-12009-2-git-send-email-Hui.Wang@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: <git@vger.kernel.org>, <tali@admingilde.org>
To: Wang Hui <Hui.Wang@windriver.com>
X-From: git-owner@vger.kernel.org Tue Sep 06 18:59:31 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R0yzi-0004gz-Ks
	for gcvg-git-2@lo.gmane.org; Tue, 06 Sep 2011 18:59:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752361Ab1IFQ7Z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Sep 2011 12:59:25 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:45087 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751830Ab1IFQ7X (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Sep 2011 12:59:23 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2A4844978;
	Tue,  6 Sep 2011 12:59:23 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=GJS5uN5TcRmUtxkmc7TfqYoJkdg=; b=x+YRX1
	1eWgiG+qLLldUlaM3MMC7vlK4Y6q709mAkA3/h9JZwjc4IsgkfRsTc35VYx3o8Es
	bjRgdsUCLQkIKeGFOSZgDxnAzNbJmBERw3/9Xx5g9mcYQgL+W2Sgx5eAZ7kHeJcP
	1gji+RrZyZQW1m9/pt/rg5zxu7YbCVKMpq7YY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Xa9EZpKqLfVitRJFLuIEWwiuZswzxXwY
	tSA1/kqgYAcVZi+lk9Ahy9fRJ+9FX0ASxnvbKZzIDq09Xl+SF6K1iuO0oN8fYH0L
	t4yTt/4Zx/q4l0pGTEZNlWDw823T9XuO7L8+aXvsGkaC3SkzT+TZR+OTMHloZ3RT
	ar7MBcwZAeU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 214C24977;
	Tue,  6 Sep 2011 12:59:23 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 73ABB4976; Tue,  6 Sep 2011
 12:59:22 -0400 (EDT)
In-Reply-To: <1315304645-12009-2-git-send-email-Hui.Wang@windriver.com> (Wang
 Hui's message of "Tue, 6 Sep 2011 18:24:01 +0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 91982718-D8A9-11E0-B192-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180815>

Wang Hui <Hui.Wang@windriver.com> writes:

> From: Hui Wang <Hui.Wang@windriver.com>
>
> This variable check is always true, so it is redundant and need to be
> removed.
>
> We can't remove the init value for this variable, since removing
> it will introduce building warning:
> 'base_len' may be used uninitialized in this function.

If we are into cleaning things up, we should instead notice and say "yuck"
to the repeated "is entry is absolute and relative base is given" check.

Wouldn't something like this makes things easier to follow and also avoids
the "when does the path normalized and made absolute" issue?

Completely untested and I may have off-by-one errors and such, but I think
you would get the idea...

 sha1_file.c |   29 ++++++++++++-----------------
 1 files changed, 12 insertions(+), 17 deletions(-)

diff --git a/sha1_file.c b/sha1_file.c
index e002056..26aa3be 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -248,27 +248,22 @@ static int link_alt_odb_entry(const char * entry, int len, const char * relative
 	const char *objdir = get_object_directory();
 	struct alternate_object_database *ent;
 	struct alternate_object_database *alt;
-	/* 43 = 40-byte + 2 '/' + terminating NUL */
-	int pfxlen = len;
-	int entlen = pfxlen + 43;
-	int base_len = -1;
+	int pfxlen, entlen;
+	struct strbuf pathbuf = STRBUF_INIT;
 
 	if (!is_absolute_path(entry) && relative_base) {
-		/* Relative alt-odb */
-		if (base_len < 0)
-			base_len = strlen(relative_base) + 1;
-		entlen += base_len;
-		pfxlen += base_len;
+		strbuf_addstr(&pathbuf, relative_base);
+		strbuf_addch(&pathbuf, '/');
 	}
-	ent = xmalloc(sizeof(*ent) + entlen);
+	strbuf_add(&pathbuf, entry, len);
+	normalize_path_copy(pathbuf.buf, pathbuf.buf);
+	strbuf_setlen(&pathbuf, strlen(pathbuf.buf));
 
-	if (!is_absolute_path(entry) && relative_base) {
-		memcpy(ent->base, relative_base, base_len - 1);
-		ent->base[base_len - 1] = '/';
-		memcpy(ent->base + base_len, entry, len);
-	}
-	else
-		memcpy(ent->base, entry, pfxlen);
+	pfxlen = pathbuf.len;
+	entlen = pfxlen + 43; /* '/' + 2 hex + '/' + 38 hex + NUL */
+	ent = xmalloc(sizeof(*ent) + entlen);
+	memcpy(ent->base, pathbuf.buf, pfxlen);
+	strbuf_release(&pathbuf);
 
 	ent->name = ent->base + pfxlen + 1;
 	ent->base[pfxlen + 3] = '/';
