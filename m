From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 2/2] bundle: add parse_bundle_header() helper function
Date: Thu, 13 Oct 2011 15:35:31 -0700
Message-ID: <7vliso34gc.fsf@alter.siamese.dyndns.org>
References: <7vpqi034l0.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Phil Hord <hordp@cisco.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 14 00:35:41 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RETsL-00069L-0X
	for gcvg-git-2@lo.gmane.org; Fri, 14 Oct 2011 00:35:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755314Ab1JMWfg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Oct 2011 18:35:36 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:49472 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752473Ab1JMWfg (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Oct 2011 18:35:36 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 69A575C01;
	Thu, 13 Oct 2011 18:35:35 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=5bE1Nvhg+KS8flKtYJSoc9ZsCWE=; b=c6APuW
	qyaKX8LfeadiOhsHnHUw579eRVhreKK+bQuYVn54d4EehihUEuUkO5Abi+8m0VMc
	udB7p8szXAupjI0KaOeWG10BZGDnOkMqKxYSjfaybdP3wU8CpNFuZvCse1q7xlsw
	F3Ql7fX2gPtOfDQ5tVQrBrla8E6/Wp8MwMv5k=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=RmMjP2rs825eijnGSc08L3i5ydtSgpQ3
	FB66PzkPrD/WTlfPwgqC+hyXhx1+5CnnzNnm4UluWvopQIPhvbQbtCrVPJ/JrHm5
	SBn0FyZ3VUkfTJh3+UEP2BV9YJ6gyiY7/eS5QCJsMgAy/D3uNN4JZAuuaou+mSUB
	AyOWqk/nCPU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5B35E5C00;
	Thu, 13 Oct 2011 18:35:35 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E404D5BFB; Thu, 13 Oct 2011
 18:35:32 -0400 (EDT)
In-Reply-To: <7vpqi034l0.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Thu, 13 Oct 2011 15:32:43 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: A968BEFC-F5EB-11E0-97FE-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183527>

Move most of the code from read_bundle_header() to parse_bundle_header()
that takes a file descriptor that is already opened for reading, and make
the former responsible only for opening the file and noticing errors.

As a logical consequence of this, is_bundle() helper function can be
implemented as a non-complaining variant of read_bundle_header() that
does not return an open file descriptor, and can be used to tighten
the check used to decide the use of bundle transport in transport.c

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 * It generally is a bad practice to base a non-RFC patch on an RFC one,
   but in any case here is how I would do the is_bundle() helper.

 bundle.c    |   39 +++++++++++++++++++++++++++++++--------
 bundle.h    |    1 +
 transport.c |    2 +-
 3 files changed, 33 insertions(+), 9 deletions(-)

diff --git a/bundle.c b/bundle.c
index 3aa715c..105b005 100644
--- a/bundle.c
+++ b/bundle.c
@@ -40,19 +40,18 @@ static int strbuf_readline_fd(struct strbuf *sb, int fd)
 	return 0;
 }
 
-int read_bundle_header(const char *path, struct bundle_header *header)
+static int parse_bundle_header(int fd, struct bundle_header *header,
+			       const char *report_path)
 {
 	struct strbuf buf = STRBUF_INIT;
-	int fd = open(path, O_RDONLY);
 	int status = 0;
 
-	if (fd < 0)
-		return error("could not open '%s'", path);
-
 	/* The bundle header begins with the signature */
 	if (strbuf_readline_fd(&buf, fd) ||
 	    strcmp(buf.buf, bundle_signature)) {
-		error("'%s' does not look like a v2 bundle file", path);
+		if (report_path)
+			error("'%s' does not look like a v2 bundle file",
+			      report_path);
 		status = -1;
 		goto abort;
 	}
@@ -77,8 +76,9 @@ int read_bundle_header(const char *path, struct bundle_header *header)
 		if (get_sha1_hex(buf.buf, sha1) ||
 		    (40 <= buf.len && !isspace(buf.buf[40])) ||
 		    (!is_prereq && buf.len <= 40)) {
-			error("unrecognized header: %s%s (%d)",
-			      (is_prereq ? "-" : ""), buf.buf, (int)buf.len);
+			if (report_path)
+				error("unrecognized header: %s%s (%d)",
+				      (is_prereq ? "-" : ""), buf.buf, (int)buf.len);
 			status = -1;
 			break;
 		} else {
@@ -98,6 +98,29 @@ int read_bundle_header(const char *path, struct bundle_header *header)
 	return fd;
 }
 
+int read_bundle_header(const char *path, struct bundle_header *header)
+{
+	int fd = open(path, O_RDONLY);
+
+	if (fd < 0)
+		return error("could not open '%s'", path);
+	return parse_bundle_header(fd, header, path);
+}
+
+int is_bundle(const char *path, int quiet)
+{
+	struct bundle_header header;
+	int fd = open(path, O_RDONLY);
+
+	if (fd < 0)
+		return 0;
+	memset(&header, 0, sizeof(header));
+	fd = parse_bundle_header(fd, &header, quiet ? NULL : path);
+	if (fd >= 0)
+		close(fd);
+	return (fd >= 0);
+}
+
 static int list_refs(struct ref_list *r, int argc, const char **argv)
 {
 	int i;
diff --git a/bundle.h b/bundle.h
index e2aedd6..c6228e2 100644
--- a/bundle.h
+++ b/bundle.h
@@ -14,6 +14,7 @@ struct bundle_header {
 	struct ref_list references;
 };
 
+int is_bundle(const char *path, int quiet);
 int read_bundle_header(const char *path, struct bundle_header *header);
 int create_bundle(struct bundle_header *header, const char *path,
 		int argc, const char **argv);
diff --git a/transport.c b/transport.c
index c9c8056..84d6480 100644
--- a/transport.c
+++ b/transport.c
@@ -913,7 +913,7 @@ struct transport *transport_get(struct remote *remote, const char *url)
 		ret->fetch = fetch_objs_via_rsync;
 		ret->push = rsync_transport_push;
 		ret->smart_options = NULL;
-	} else if (is_local(url) && is_file(url)) {
+	} else if (is_local(url) && is_file(url) && is_bundle(url, 1)) {
 		struct bundle_transport_data *data = xcalloc(1, sizeof(*data));
 		ret->data = data;
 		ret->get_refs_list = get_refs_from_bundle;
-- 
1.7.7.289.gd0d4bb
