From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] resolve-undo.c: silence compiler complaints by casting
 void * to char *
Date: Mon, 01 Feb 2010 21:46:15 -0800
Message-ID: <7vr5p4favs.fsf@alter.siamese.dyndns.org>
References: <qzbyPiTgRGI0lsxvEmFa0WtwK5ko5snXQDNffxC66y9v0rlie5pcKzGT28WpzfQlFd0OvJNY_jo@cipher.nrlssc.navy.mil> <7vsk9kplla.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Brandon Casey <drafnel@gmail.com>
To: Brandon Casey <casey@nrlssc.navy.mil>
X-From: git-owner@vger.kernel.org Tue Feb 02 06:46:43 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NcBb0-0007Ao-91
	for gcvg-git-2@lo.gmane.org; Tue, 02 Feb 2010 06:46:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753809Ab0BBFqZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Feb 2010 00:46:25 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:47576 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752437Ab0BBFqY (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Feb 2010 00:46:24 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id A683596857;
	Tue,  2 Feb 2010 00:46:23 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=cYJWBf9hgUUt56Qb7zVx2hAPgIg=; b=QZ45+0
	5aoVV1+cSHsWQpQKWAMiXIepIAIecD66SYfYsUXOlmdvzR7fsna7HcfFw6wrrmG/
	pKtakbw8k9CucUNRFlYYoPKlPj15KwP75D6WLandWCHQzGBrd8TGMsrSM1H0/Gy3
	hB2WcIxjY9I+2CPbtbCOVfXC61W45LJMvV/gU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=vGSE22aUo3Dn3oOd2fkmQ1w68q4kQ5R8
	wVQwyZET1jAA8ymKgN87+mPiVJnL4qsET1GHJ9cW+RnEumQXfySZ8/RoCHWhrcT9
	uFOAjIMo7KS+yBDEL11sAu/Xe2gBSO+XDtrFFhmQKhHzqYXVbnrRg2klotgYMngz
	h0PBJbI3pLQ=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 703C196854;
	Tue,  2 Feb 2010 00:46:20 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 8FEE596853; Tue,  2 Feb
 2010 00:46:16 -0500 (EST)
In-Reply-To: <7vsk9kplla.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Mon\, 01 Feb 2010 15\:44\:49 -0800")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 4A01A358-0FBE-11DF-B9A8-6AF7ED7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138681>

Junio C Hamano <gitster@pobox.com> writes:

> Thanks for catching this.
>
> In this particular case, I however suspect that it would be cleaner to
> declare that the first parameter to resolve_undo_read() is a "char *"
> (or even "const char *"), as we are dealing with NUL delimited list of
> octal numbers and character strings.

It would look like this.  I wonder if we should make hash*() inline
functions to take (void *) or (const void *) pointers to avoid further
noises like this but that would be a separate topic.

 resolve-undo.c |    4 ++--
 resolve-undo.h |    2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/resolve-undo.c b/resolve-undo.c
index 37d73cd..0f50ee0 100644
--- a/resolve-undo.c
+++ b/resolve-undo.c
@@ -53,7 +53,7 @@ void resolve_undo_write(struct strbuf *sb, struct string_list *resolve_undo)
 	for_each_string_list(write_one, resolve_undo, sb);
 }
 
-struct string_list *resolve_undo_read(void *data, unsigned long size)
+struct string_list *resolve_undo_read(const char *data, unsigned long size)
 {
 	struct string_list *resolve_undo;
 	size_t len;
@@ -93,7 +93,7 @@ struct string_list *resolve_undo_read(void *data, unsigned long size)
 				continue;
 			if (size < 20)
 				goto error;
-			hashcpy(ui->sha1[i], data);
+			hashcpy(ui->sha1[i], (const unsigned char *)data);
 			size -= 20;
 			data += 20;
 		}
diff --git a/resolve-undo.h b/resolve-undo.h
index e4e5c1b..8458769 100644
--- a/resolve-undo.h
+++ b/resolve-undo.h
@@ -8,7 +8,7 @@ struct resolve_undo_info {
 
 extern void record_resolve_undo(struct index_state *, struct cache_entry *);
 extern void resolve_undo_write(struct strbuf *, struct string_list *);
-extern struct string_list *resolve_undo_read(void *, unsigned long);
+extern struct string_list *resolve_undo_read(const char *, unsigned long);
 extern void resolve_undo_clear_index(struct index_state *);
 extern int unmerge_index_entry_at(struct index_state *, int);
 extern void unmerge_index(struct index_state *, const char **);
