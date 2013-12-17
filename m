From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/3] prune-packed: fix a possible buffer overflow
Date: Tue, 17 Dec 2013 10:43:06 -0800
Message-ID: <xmqqd2kvmi85.fsf@gitster.dls.corp.google.com>
References: <1387287838-25779-1-git-send-email-mhagger@alum.mit.edu>
	<1387287838-25779-2-git-send-email-mhagger@alum.mit.edu>
	<CACsJy8DVc4soBrS1RbTLv93b5rere3htyL1DjRw=UcT4zVN9FA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michael Haggerty <mhagger@alum.mit.edu>,
	Git Mailing List <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Dec 17 19:43:21 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vszc1-0002FX-7e
	for gcvg-git-2@plane.gmane.org; Tue, 17 Dec 2013 19:43:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755515Ab3LQSnP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Dec 2013 13:43:15 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:36827 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755356Ab3LQSnN (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Dec 2013 13:43:13 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CF0F05BD19;
	Tue, 17 Dec 2013 13:43:11 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=1bWT/twRb2VexDbdySHqsncJj60=; b=T3wJxb
	ADemNYBh9C2sq2ldtITz99jBqM9BHXOT5QJBb5BJnU4txIGU6pmU5pmiZ11MBa5+
	tVjWyluQcFB0RdWrUIPGe+zWZB0noXG5qEZIhSVVMpXpWaPyIknhLax8DjpVBufC
	bRp/OlJi+npR4yQ9e1HR5kZGjGrnnV5c0NtAs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Fl54/j0pFgbjEFgwK0EF+FJuf5ah9adA
	GK6DiXfVgONIxScn4ygj8mZfkdhMOXZ+7iwHGGVBmtpOR+IdyRwtL0ME/vawpTbT
	heZ7k//uflqCth6NfjSl5jD/9Q+GiX5BIFBW7zSsm4M5rXTa8pXKcRSnDNsqCe8g
	IRfEp+UbQUA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 71A0C5BD16;
	Tue, 17 Dec 2013 13:43:11 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 8FA6E5BD14;
	Tue, 17 Dec 2013 13:43:09 -0500 (EST)
In-Reply-To: <CACsJy8DVc4soBrS1RbTLv93b5rere3htyL1DjRw=UcT4zVN9FA@mail.gmail.com>
	(Duy Nguyen's message of "Tue, 17 Dec 2013 20:57:29 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 1357F210-674B-11E3-BA1D-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239396>

Duy Nguyen <pclouds@gmail.com> writes:

> Why don't we take this opportunity to replace that array with a
> strbuf? The conversion looks simple with this function.

Indeed.  Something like this, perhaps?

 builtin/prune-packed.c | 38 +++++++++++++++++++++-----------------
 1 file changed, 21 insertions(+), 17 deletions(-)

diff --git a/builtin/prune-packed.c b/builtin/prune-packed.c
index fa6ce42..fcf5fb6 100644
--- a/builtin/prune-packed.c
+++ b/builtin/prune-packed.c
@@ -10,58 +10,62 @@ static const char * const prune_packed_usage[] = {
 
 static struct progress *progress;
 
-static void prune_dir(int i, DIR *dir, char *pathname, int len, int opts)
+static void prune_dir(int i, DIR *dir, struct strbuf *pathname, int opts)
 {
 	struct dirent *de;
 	char hex[40];
+	int top_len = pathname->len;
 
 	sprintf(hex, "%02x", i);
 	while ((de = readdir(dir)) != NULL) {
 		unsigned char sha1[20];
 		if (strlen(de->d_name) != 38)
 			continue;
-		memcpy(hex+2, de->d_name, 38);
+		memcpy(hex + 2, de->d_name, 38);
 		if (get_sha1_hex(hex, sha1))
 			continue;
 		if (!has_sha1_pack(sha1))
 			continue;
-		memcpy(pathname + len, de->d_name, 38);
+
+		strbuf_add(pathname, de->d_name, 38);
 		if (opts & PRUNE_PACKED_DRY_RUN)
-			printf("rm -f %s\n", pathname);
+			printf("rm -f %s\n", pathname->buf);
 		else
-			unlink_or_warn(pathname);
+			unlink_or_warn(pathname->buf);
 		display_progress(progress, i + 1);
+		strbuf_setlen(pathname, top_len);
 	}
 }
 
 void prune_packed_objects(int opts)
 {
 	int i;
-	static char pathname[PATH_MAX];
 	const char *dir = get_object_directory();
-	int len = strlen(dir);
+	struct strbuf pathname = STRBUF_INIT;
+	int top_len;
 
+	strbuf_addstr(&pathname, dir);
 	if (opts & PRUNE_PACKED_VERBOSE)
 		progress = start_progress_delay("Removing duplicate objects",
 			256, 95, 2);
 
-	if (len > PATH_MAX - 42)
-		die("impossible object directory");
-	memcpy(pathname, dir, len);
-	if (len && pathname[len-1] != '/')
-		pathname[len++] = '/';
+	if (pathname.len && pathname.buf[pathname.len - 1] != '/')
+		strbuf_addch(&pathname, '/');
+
+	top_len = pathname.len;
 	for (i = 0; i < 256; i++) {
 		DIR *d;
 
 		display_progress(progress, i + 1);
-		sprintf(pathname + len, "%02x/", i);
-		d = opendir(pathname);
+		strbuf_setlen(&pathname, top_len);
+		strbuf_addf(&pathname, "%02x/", i);
+		d = opendir(pathname.buf);
 		if (!d)
 			continue;
-		prune_dir(i, d, pathname, len + 3, opts);
+		prune_dir(i, d, &pathname, opts);
 		closedir(d);
-		pathname[len + 2] = '\0';
-		rmdir(pathname);
+		strbuf_setlen(&pathname, top_len + 2);
+		rmdir(pathname.buf);
 	}
 	stop_progress(&progress);
 }
