From: David Turner <dturner@twopensource.com>
Subject: [PATCH/RFC 3/6] http-backend: handle refspec argument
Date: Fri, 15 Apr 2016 15:19:06 -0400
Message-ID: <1460747949-3514-4-git-send-email-dturner@twopensource.com>
References: <1460747949-3514-1-git-send-email-dturner@twopensource.com>
Cc: David Turner <dturner@twopensource.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 15 21:20:05 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ar9HV-0006Y9-OR
	for gcvg-git-2@plane.gmane.org; Fri, 15 Apr 2016 21:19:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753394AbcDOTTu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Apr 2016 15:19:50 -0400
Received: from mail-qg0-f46.google.com ([209.85.192.46]:36576 "EHLO
	mail-qg0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752911AbcDOTTf (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Apr 2016 15:19:35 -0400
Received: by mail-qg0-f46.google.com with SMTP id f52so86790129qga.3
        for <git@vger.kernel.org>; Fri, 15 Apr 2016 12:19:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=gxLbxDoJS+p8jxfQenkCrJwcZEs34G7UqNK6UZNkhn0=;
        b=tbHaPKAhfHJP0bdp/PfwXX4pLt3bMEMjGFrqz6Oy5zdCdGQtNy24VSnMBX2jdhy59b
         j5ddkJga+rSsRT/yleTzWYcNyeJYEu/7Ix0PdOHetEVXPFRIMSBCyrPNFy6mT1eyfpZm
         xTSc9jNENGG0XiJb9sgueiCg0hHICr2v4vxZI8YovaRFPS0MoHCXtObBn9+X0YZyXTvi
         BaG9khE4dWZjAhFszKaTPcB6huhBzIeQ1icutCwCp+xX5jLJqcY97tDozMC2ku4G75gB
         ypKGdWcDSWGYcCDDQsxKK1D9Hn1T5m9x/fGFy58KnlQmaOMAUL9TMqJ+8UbpD9tMxAgp
         z61Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=gxLbxDoJS+p8jxfQenkCrJwcZEs34G7UqNK6UZNkhn0=;
        b=kDzuA+Ta/l7VLg7QRVWXy0p5ILSgOfN21z656GXq8gkWlgmabrP/MyCKbpVe0vTFaA
         rGhY4So33RT9HLztLVu6V46zpcFu1H5GtnIOW9tGYIUVCpKXIpv/nVcGGaiGaUPzJmBV
         AvV8BTuuazIQxeb41kk3f76B4ZCF3OEk4BpXPj/yfoqIoeTFGZYpzgS/djUgLfQ+G4AV
         CneggUTmxByVyOC0lDzG/k2zP4PAeAhQ0k4bfZ3+8eWgcNmO2tGqQ8EI9myQ4aKRea3D
         1VbaWERJwXgh44n/eV3rBi7G8037jmSL/19Md9SxAsJR/pZ/S/JQD1Mkr+DKcIzoI2Fy
         71dg==
X-Gm-Message-State: AOPr4FUw+opnaCt+pcYqWmKAEWz7Kq1oCxL0LsEdlhCb5H6cEVmPMMdaQNhkVYp0okvVwQ==
X-Received: by 10.140.82.20 with SMTP id g20mr27068201qgd.69.1460747974559;
        Fri, 15 Apr 2016 12:19:34 -0700 (PDT)
Received: from ubuntu.twitter.biz ([192.133.79.145])
        by smtp.gmail.com with ESMTPSA id c2sm21077097qkb.41.2016.04.15.12.19.33
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 15 Apr 2016 12:19:33 -0700 (PDT)
X-Mailer: git-send-email 2.4.2.767.g62658d5-twtrsrc
In-Reply-To: <1460747949-3514-1-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291643>

Allow clients to pass a "refspec" parameter through to upload-pack;
upload-pack will only advertise refs which match that refspec.

Signed-off-by: David Turner <dturner@twopensource.com>
---
 http-backend.c |  9 +++++++
 upload-pack.c  | 81 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++--
 2 files changed, 88 insertions(+), 2 deletions(-)

diff --git a/http-backend.c b/http-backend.c
index a4f0066..9731391 100644
--- a/http-backend.c
+++ b/http-backend.c
@@ -452,6 +452,7 @@ static void get_info_refs(char *arg)
 	if (service_name) {
 		struct argv_array argv = ARGV_ARRAY_INIT;
 		struct rpc_service *svc = select_service(service_name);
+		const char *refspec;
 
 		strbuf_addf(&buf, "application/x-git-%s-advertisement",
 			svc->name);
@@ -465,6 +466,14 @@ static void get_info_refs(char *arg)
 		argv_array_push(&argv, "--stateless-rpc");
 		argv_array_push(&argv, "--advertise-refs");
 
+		refspec = get_parameter("refspec");
+		if (refspec) {
+			struct strbuf interesting_refs = STRBUF_INIT;
+			strbuf_addstr(&interesting_refs, "--interesting-refs=");
+			strbuf_addstr(&interesting_refs, refspec);
+			argv_array_push(&argv, interesting_refs.buf);
+			strbuf_release(&interesting_refs);
+		}
 		argv_array_push(&argv, ".");
 		run_service(argv.argv, 0);
 		argv_array_clear(&argv);
diff --git a/upload-pack.c b/upload-pack.c
index b3f6653..da140c2 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -52,6 +52,7 @@ static int keepalive = 5;
 static int use_sideband;
 static int advertise_refs;
 static int stateless_rpc;
+static struct string_list interesting_refspecs = STRING_LIST_INIT_DUP;
 
 static void reset_timeout(void)
 {
@@ -687,16 +688,61 @@ static void receive_needs(void)
 	free(shallows.objects);
 }
 
-/* return non-zero if the ref is hidden, otherwise 0 */
+struct refspec_data {
+	int has_star;
+	size_t prefixlen;
+	size_t suffixlen;
+};
+
+static int matches_refspec(const char *refspec, struct refspec_data *data,
+		    const char *ref)
+{
+	size_t len;
+
+	if (!data->has_star)
+		return !strcmp(refspec, ref);
+
+	if (strncmp(refspec, ref, data->prefixlen))
+		return -1;
+
+	len = strlen(refspec);
+	if (len < data->prefixlen + data->suffixlen)
+		return -1;
+
+	return strcmp(ref + (len - data->suffixlen),
+		      refspec + data->prefixlen + 1);
+}
+
+/*
+ * return non-zero if the ref is hidden or outside the provided
+ * refspecs, otherwise 0
+*/
 static int mark_our_ref(const char *refname, const char *refname_full,
 			const struct object_id *oid)
 {
 	struct object *o = lookup_unknown_object(oid->hash);
+	struct string_list_item *item;
 
 	if (ref_is_hidden(refname, refname_full)) {
 		o->flags |= HIDDEN_REF;
 		return 1;
 	}
+
+	if (interesting_refspecs.nr) {
+		int found = 0;
+		/*
+		 * TODO: this could be faster for large numbers of
+		 * refspecs by using tries or a DFA.
+		 */
+		for_each_string_list_item(item, &interesting_refspecs)
+			if (matches_refspec(item->string, item->util, refname)) {
+				found = 1;
+				break;
+			}
+		if (!found)
+			return 1;
+
+	}
 	o->flags |= OUR_REF;
 	return 0;
 }
@@ -725,7 +771,7 @@ static int send_ref(const char *refname, const struct object_id *oid,
 {
 	static const char *capabilities = "multi_ack thin-pack side-band"
 		" side-band-64k ofs-delta shallow no-progress"
-		" include-tag multi_ack_detailed";
+		" include-tag multi_ack_detailed interesting-refs";
 	const char *refname_nons = strip_namespace(refname);
 	struct object_id peeled;
 
@@ -820,6 +866,24 @@ static int upload_pack_config(const char *var, const char *value, void *unused)
 	return parse_hide_refs_config(var, value, "uploadpack");
 }
 
+static struct refspec_data *make_refspec_data(const char *refspec)
+{
+	struct refspec_data *data;
+	const char *star;
+
+	data = xmalloc(sizeof(struct refspec_data));
+	star = strchr(refspec, '*');
+	if (star) {
+		data->has_star = 1;
+		data->prefixlen = star - refspec;
+		data->suffixlen = strlen(refspec) - (data->prefixlen + 1);
+	} else {
+		data->has_star = 0;
+	}
+
+	return data;
+}
+
 int main(int argc, char **argv)
 {
 	char *dir;
@@ -841,6 +905,19 @@ int main(int argc, char **argv)
 			advertise_refs = 1;
 			continue;
 		}
+		if (starts_with(arg, "--interesting-refs=")) {
+			struct string_list_item *item;
+
+			string_list_split(&interesting_refspecs, arg + 19,
+					  ' ', -1);
+			for_each_string_list_item(item, &interesting_refspecs) {
+				if (check_refname_format(item->string,
+							 REFNAME_REFSPEC_PATTERN))
+					die("invalid refspec %s", item->string);
+				item->util = make_refspec_data(item->string);
+			}
+			continue;
+		}
 		if (!strcmp(arg, "--stateless-rpc")) {
 			stateless_rpc = 1;
 			continue;
-- 
2.4.2.767.g62658d5-twtrsrc
