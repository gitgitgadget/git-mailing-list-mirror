From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 1/2] bundle: plug resource leak
Date: Tue, 01 Mar 2016 15:35:34 -0800
Message-ID: <xmqqvb556abd.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 02 00:35:44 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aatpO-0003L6-92
	for gcvg-git-2@plane.gmane.org; Wed, 02 Mar 2016 00:35:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751406AbcCAXfj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Mar 2016 18:35:39 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:51757 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751097AbcCAXfi (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Mar 2016 18:35:38 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id A6E7A49EE3;
	Tue,  1 Mar 2016 18:35:36 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:mime-version:content-type; s=sasl; bh=V
	OQTDEc1YDH6/cP3Sfh41v8hvJU=; b=DCM7S6pcNtzJxt4O9W1fxkjiVpQCZHuNn
	SfKz0KIzcH3ptNP2ZkcMkJiN6IcgzCn7Gwd7dMwG8kla7yO36ghO+cc2jRPR/doP
	OJkxLKA8aBy/q1mN81kNKqx3T5Md1SMTJJov54oFFk85QhGnrlgxtS/k+D9cmANB
	Iojgr1e7bs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:mime-version:content-type; q=dns; s=sasl; b=lsj
	QkDV8rqpEDaCQG9vG4RmVOmQaeW8SKM9V3hel9nvKh67DjD0n6BmEta0+K2TcxUM
	8o9CqQnjzEzJkxYaMkg3v4vlC57//ArlC2YtDp4/92+kUyW/hfNBOmzLYNDRe3ib
	23s7kTbYRY4C8ACbM56Ml6vxEDV1z6FjHAvN/1eo=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 9C5C449EE2;
	Tue,  1 Mar 2016 18:35:36 -0500 (EST)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 1D43949EE1;
	Tue,  1 Mar 2016 18:35:36 -0500 (EST)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 4C6D06B8-E006-11E5-84C4-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288080>

The bundle header structure holds two lists of refs and object
names, which should be released when the user is done with it.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 bundle.c    | 12 ++++++++++++
 bundle.h    |  1 +
 transport.c |  1 +
 3 files changed, 14 insertions(+)

diff --git a/bundle.c b/bundle.c
index 506ac49..9c5a6f0 100644
--- a/bundle.c
+++ b/bundle.c
@@ -102,6 +102,18 @@ int is_bundle(const char *path, int quiet)
 	return (fd >= 0);
 }
 
+void release_bundle_header(struct bundle_header *header)
+{
+	int i;
+
+	for (i = 0; i < header->prerequisites.nr; i++)
+		free(header->prerequisites.list[i].name);
+	free(header->prerequisites.list);
+	for (i = 0; i < header->references.nr; i++)
+		free(header->references.list[i].name);
+	free(header->references.list);
+}
+
 static int list_refs(struct ref_list *r, int argc, const char **argv)
 {
 	int i;
diff --git a/bundle.h b/bundle.h
index 1584e4d..f7ce23b 100644
--- a/bundle.h
+++ b/bundle.h
@@ -23,5 +23,6 @@ int verify_bundle(struct bundle_header *header, int verbose);
 int unbundle(struct bundle_header *header, int bundle_fd, int flags);
 int list_bundle_refs(struct bundle_header *header,
 		int argc, const char **argv);
+void release_bundle_header(struct bundle_header *);
 
 #endif
diff --git a/transport.c b/transport.c
index ca3cfa4..08e15c5 100644
--- a/transport.c
+++ b/transport.c
@@ -107,6 +107,7 @@ static int close_bundle(struct transport *transport)
 	struct bundle_transport_data *data = transport->data;
 	if (data->fd > 0)
 		close(data->fd);
+	release_bundle_header(&data->header);
 	free(data);
 	return 0;
 }
-- 
2.8.0-rc0-114-g0b3e5e5
