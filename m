From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 2/4] bundle: plug resource leak
Date: Wed,  2 Mar 2016 12:32:39 -0800
Message-ID: <1456950761-19759-3-git-send-email-gitster@pobox.com>
References: <xmqqfuw84uhb.fsf@gitster.mtv.corp.google.com>
 <1456950761-19759-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 02 21:33:00 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1abDS7-00070y-9v
	for gcvg-git-2@plane.gmane.org; Wed, 02 Mar 2016 21:32:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756056AbcCBUct (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Mar 2016 15:32:49 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:56116 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755863AbcCBUcr (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Mar 2016 15:32:47 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id A2A634807D;
	Wed,  2 Mar 2016 15:32:46 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=VOQT
	DEc1YDH6/cP3Sfh41v8hvJU=; b=j2KMaKCG6flbg43TTcBh4K4T6vRZZiPD8aZP
	34CyRj9vuUS+6pyed5WyDmCdflD44a8K3/Am1fRJJ+w161aYGewlVWrh+T+TLwPq
	dRCJj7BZKbAyivpjMmVW3ZMXjTC+k3CtwHIknnEXPJYbVREA7g6R0BVQE+bEe8k1
	8nec0cc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=xfKETz
	RNhOIDvgphCoN0oC9I66AhgZQIJoJW0xCxMZtJX4X2Ith2ERqgqOqkfEkh+s2MQI
	C7GJw7HgzLbEU1RzhPyNaF6D1UhF02VbKydF0Z73WZnbtYMlOHB+f1131lVhN5b1
	Q3eUfMouH8IqYrfzsTvUBh3WvIx9nv7l0nfXg=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 9848A4807C;
	Wed,  2 Mar 2016 15:32:46 -0500 (EST)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 13E4248078;
	Wed,  2 Mar 2016 15:32:45 -0500 (EST)
X-Mailer: git-send-email 2.8.0-rc0-114-g0b3e5e5
In-Reply-To: <1456950761-19759-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: EC300790-E0B5-11E5-8FF2-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288152>

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
