From: Julian Phillips <julian@quantumfyre.co.uk>
Subject: [RFC/PATCH 1/2] ref-dict: Add a set of functions for working with a
	ref dictionary
Date: Wed, 16 Sep 2009 08:53:02 +0100
Message-ID: <20090916075304.58044.664.julian@quantumfyre.co.uk>
References: <20090916074737.58044.42776.julian@quantumfyre.co.uk>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 16 09:58:08 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MnpOx-0006uG-8R
	for gcvg-git-2@lo.gmane.org; Wed, 16 Sep 2009 09:58:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755130AbZIPH55 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Sep 2009 03:57:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755068AbZIPH54
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Sep 2009 03:57:56 -0400
Received: from electron.quantumfyre.co.uk ([87.106.55.16]:36069 "EHLO
	electron.quantumfyre.co.uk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753610AbZIPH54 (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 16 Sep 2009 03:57:56 -0400
Received: from neutron.quantumfyre.co.uk (neutron.quantumfyre.co.uk [212.159.54.235])
	by electron.quantumfyre.co.uk (Postfix) with ESMTP id E0D9C33FA29
	for <git@vger.kernel.org>; Wed, 16 Sep 2009 08:57:58 +0100 (BST)
Received: (qmail 30299 invoked by uid 103); 16 Sep 2009 08:53:10 +0100
Received: from reaper.quantumfyre.co.uk by neutron.quantumfyre.co.uk (envelope-from <julian@quantumfyre.co.uk>, uid 201) with qmail-scanner-2.05st 
 (clamdscan: 0.94.2/9808. spamassassin: 3.2.1. perlscan: 2.05st.  
 Clear:RC:1(212.159.54.234):. 
 Processed in 0.041452 secs); 16 Sep 2009 07:53:10 -0000
Received: from reaper.quantumfyre.co.uk (HELO rayne.quantumfyre.co.uk) (212.159.54.234)
  by neutron.quantumfyre.co.uk with SMTP; 16 Sep 2009 08:53:10 +0100
X-git-sha1: 7d4c76086c179bb140b2393b9b3b6aa5837282ab 
X-Mailer: git-mail-commits v0.5.2
In-Reply-To: <20090916074737.58044.42776.julian@quantumfyre.co.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128614>

These are a set of helper functions that use the generic hash table
functions to provide a quick and easy mapping from ref name to sha1.

Signed-off-by: Julian Phillips <julian@quantumfyre.co.uk>
---
 Makefile   |    1 +
 ref-dict.c |   76 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 ref-dict.h |   13 ++++++++++
 3 files changed, 90 insertions(+), 0 deletions(-)
 create mode 100644 ref-dict.c
 create mode 100644 ref-dict.h

diff --git a/Makefile b/Makefile
index d4958b8..815e4c9 100644
--- a/Makefile
+++ b/Makefile
@@ -531,6 +531,7 @@ LIB_OBJS += reachable.o
 LIB_OBJS += read-cache.o
 LIB_OBJS += reflog-walk.o
 LIB_OBJS += refs.o
+LIB_OBJS += ref-dict.o
 LIB_OBJS += remote.o
 LIB_OBJS += replace_object.o
 LIB_OBJS += rerere.o
diff --git a/ref-dict.c b/ref-dict.c
new file mode 100644
index 0000000..b9cab4b
--- /dev/null
+++ b/ref-dict.c
@@ -0,0 +1,76 @@
+/*
+ * ref-dict.c
+ *
+ * A Hash-based dictionary for storing name-sha1 data for refs.
+ *
+ * Copyright (C) 2009 Julian Phillips
+ */
+
+#include "cache.h"
+#include "hash.h"
+#include "remote.h"
+#include "ref-dict.h"
+
+/* hash_name based on the function of the same name in name-hash.c */
+static unsigned int hash_name(const char *name)
+{
+	unsigned int hash = 0x123;
+	int namelen = strlen(name);
+
+	do {
+		unsigned char c = *name++;
+		hash = hash*101 + c;
+	} while (--namelen);
+	return hash;
+}
+
+/*
+ * A convienience function for creating a ref_dict from a ref_list.
+ */
+void ref_dict_create(struct hash_table *dict, const struct ref *ref_list)
+{
+	struct ref *ref;
+
+	init_hash(dict);
+
+	for (ref = (struct ref *)ref_list; ref; ref = ref->next) {
+		ref_dict_add(dict, ref->name, ref->old_sha1);
+	}
+}
+
+/*
+ * Add an entry to the ref_dict, recording that name maps to sha1.
+ */
+void ref_dict_add(struct hash_table *dict, const char *name,
+		const unsigned char *sha1)
+{
+	struct ref **ref;
+	struct ref *new_ref = alloc_ref(name);
+
+	hashcpy(new_ref->old_sha1, sha1);
+	
+	ref = (struct ref **)insert_hash(hash_name(name), new_ref, dict);
+	if (ref) {
+		new_ref->next = *ref;
+		*ref = new_ref;
+	}
+}
+
+/*
+ * Find the sha1 for the given name.  Returns 1 if found and copies the sha1
+ * into the space pointed to by sha1, returns 0 otherwise and sha1 is untouched.
+ */
+int ref_dict_get(const struct hash_table *dict, const char *name,
+		unsigned char *sha1)
+{
+	struct ref *ref = lookup_hash(hash_name(name), dict);
+
+	for (; ref; ref = ref->next) {
+		if (!strcmp(name, ref->name)) {
+			hashcpy(sha1, ref->old_sha1);
+			return 1;
+		}
+	}
+
+	return 0;
+}
diff --git a/ref-dict.h b/ref-dict.h
new file mode 100644
index 0000000..ca1e9a7
--- /dev/null
+++ b/ref-dict.h
@@ -0,0 +1,13 @@
+#ifndef REF_DICT_H
+#define REF_DICT_H
+
+#include "cache.h"
+#include "hash.h"
+
+void ref_dict_create(struct hash_table *dict, const struct ref *ref_list);
+void ref_dict_add(struct hash_table *dict, const char *name,
+		const unsigned char *sha1);
+int ref_dict_get(const struct hash_table *dict, const char *name,
+		unsigned char *sha1);
+
+#endif /* REF_DICT_H */
-- 
1.6.4.2
