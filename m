From: John Koleszar <jkoleszar@google.com>
Subject: [PATCH] http-backend: respect GIT_NAMESPACE with dumb clients
Date: Wed,  3 Apr 2013 08:52:09 -0700
Message-ID: <1365004329-15264-1-git-send-email-jkoleszar@google.com>
References: <CAAvHm8N8Sm-EuA5ofPp1qNJrZGqcRbzA3LFX5s0-g8oCnB8bhw@mail.gmail.com>
Cc: git@vger.kernel.org, Shawn Pearce <spearce@spearce.org>,
	Josh Triplett <josh@joshtriplett.org>,
	John Koleszar <jkoleszar@google.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Apr 03 17:53:20 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UNPzx-0005fl-91
	for gcvg-git-2@plane.gmane.org; Wed, 03 Apr 2013 17:53:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761092Ab3DCPws (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Apr 2013 11:52:48 -0400
Received: from mail-ie0-f201.google.com ([209.85.223.201]:45411 "EHLO
	mail-ie0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758296Ab3DCPwr (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Apr 2013 11:52:47 -0400
Received: by mail-ie0-f201.google.com with SMTP id a11so408066iee.0
        for <git@vger.kernel.org>; Wed, 03 Apr 2013 08:52:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=CHJGVKPMuF3WgpT1lCta47UruCxfU5o+J3cMTs+KloE=;
        b=L0EZKBB0eeyHgZr/DohwnGStMG3HghBeb98/HF88PIoT4MJOZI01aELdm8NUIrKfWb
         iJy64s4p7JN3ER2++t2vSIgIa5VVbHmZ+x4Cwa/rBs6jv9csQ8rc4G9d9oEzdxT3nFIH
         qOk6TAQitPt6UBenSth75pHAYUbHNlW0bt38N7PoN4iITq2unEVNHQGCH2tnNOkfaTzu
         5T2+qo5XhGGEk4LaTTGJWsaikUe0YLuqlMwVxT/JtgideJ6QObcHL8hua/vbhkOVNLc7
         dhSfg4sZaW/gewR5yXwhplmdWfW2tv3GovS29BCGtjep7VTRkdTRQxRE0ifVYKHF5lNe
         rAqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:x-gm-message-state;
        bh=CHJGVKPMuF3WgpT1lCta47UruCxfU5o+J3cMTs+KloE=;
        b=R8dM5IXMc0rXjHmU4Onyh37NR/bqKho3XhevNkegSuesiXctZ90lnjkrWyst4on+3O
         j5ovWuOpHzFW2nW7XGNPHCprNxMjnQKEl3SkR3PgH31ZmvNtsG80Fx6APO47u2knqAiP
         FEIkDCVqleZjUlhAhc0IpzPE4ZcO7w7zM18uII/YZ8GHV/ZOItGzLf8rqQVyrPySjpgr
         XOItcem1jJmPiNs6MgkuTFHU44AL+WZsHWBFHk+vKdESft9+iZaq/PufiJPqWQEyAihL
         CigXxyX+0ERLbiuF760HVco1uZPdpia7If0ceYZ2flDLZO1/Fh9PgBSeUt7Z1NZuXPSV
         uj4g==
X-Received: by 10.42.103.72 with SMTP id l8mr1784598ico.20.1365004366489;
        Wed, 03 Apr 2013 08:52:46 -0700 (PDT)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id r9si1072777igl.1.2013.04.03.08.52.46
        (version=TLSv1.1 cipher=AES128-SHA bits=128/128);
        Wed, 03 Apr 2013 08:52:46 -0700 (PDT)
Received: from sigill.mtv.corp.google.com (sigill.mtv.corp.google.com [172.22.77.100])
	by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id BB24731C1C6;
	Wed,  3 Apr 2013 08:52:45 -0700 (PDT)
Received: by sigill.mtv.corp.google.com (Postfix, from userid 105890)
	id 449DCA00EA; Wed,  3 Apr 2013 08:52:45 -0700 (PDT)
X-Mailer: git-send-email 1.8.1.3
In-Reply-To: <CAAvHm8N8Sm-EuA5ofPp1qNJrZGqcRbzA3LFX5s0-g8oCnB8bhw@mail.gmail.com>
X-Gm-Message-State: ALoCoQkssBu8tpf2LdB+jDgxiulrviAyDBalY/XgD0887E+fOFHgBG6RL+svKwqpM7ndKE+udS22zTYHCJruTbQo6lvdY5voBHv8S60p2DKRQRMMe3fKtsDOMy7dOdNA4Y4BNlF6wO0q7RwPbe6Wth3EII0tM/Mi/0MjqEYIPJ0Q9tKIbppdot+NWbnp8voMZpPGuUUNuqoU
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219950>

Filter the list of refs returned via the dumb HTTP protocol according
to the active namespace, consistent with other clients of the
upload-pack service.

Signed-off-by: John Koleszar <jkoleszar@google.com>
---

This should incorporate all of Junio's and Josh's comments. Also fixes
a bug in the first patch where the HEAD wasn't included in the list
of refs returned. PTAL.

 http-backend.c                   |  9 ++++++---
 t/lib-httpd/apache.conf          |  5 +++++
 t/t5560-http-backend-noserver.sh |  7 +++++++
 t/t5561-http-backend.sh          | 11 +++++++++++
 t/t556x_common                   | 25 +++++++++++++++++++++++++
 5 files changed, 54 insertions(+), 3 deletions(-)

diff --git a/http-backend.c b/http-backend.c
index f50e77f..d32128f 100644
--- a/http-backend.c
+++ b/http-backend.c
@@ -361,17 +361,19 @@ static void run_service(const char **argv)
 static int show_text_ref(const char *name, const unsigned char *sha1,
 	int flag, void *cb_data)
 {
+	const char *name_nons = strip_namespace(name);
 	struct strbuf *buf = cb_data;
 	struct object *o = parse_object(sha1);
 	if (!o)
 		return 0;
 
-	strbuf_addf(buf, "%s\t%s\n", sha1_to_hex(sha1), name);
+	strbuf_addf(buf, "%s\t%s\n", sha1_to_hex(sha1), name_nons);
 	if (o->type == OBJ_TAG) {
 		o = deref_tag(o, name, 0);
 		if (!o)
 			return 0;
-		strbuf_addf(buf, "%s\t%s^{}\n", sha1_to_hex(o->sha1), name);
+		strbuf_addf(buf, "%s\t%s^{}\n", sha1_to_hex(o->sha1),
+		            name_nons);
 	}
 	return 0;
 }
@@ -402,7 +404,8 @@ static void get_info_refs(char *arg)
 
 	} else {
 		select_getanyfile();
-		for_each_ref(show_text_ref, &buf);
+		head_ref_namespaced(show_text_ref, &buf);
+		for_each_namespaced_ref(show_text_ref, &buf);
 		send_strbuf("text/plain", &buf);
 	}
 	strbuf_release(&buf);
diff --git a/t/lib-httpd/apache.conf b/t/lib-httpd/apache.conf
index 938b4cf..ad85537 100644
--- a/t/lib-httpd/apache.conf
+++ b/t/lib-httpd/apache.conf
@@ -61,6 +61,11 @@ Alias /auth/dumb/ www/auth/dumb/
 	SetEnv GIT_COMMITTER_NAME "Custom User"
 	SetEnv GIT_COMMITTER_EMAIL custom@example.com
 </LocationMatch>
+<LocationMatch /smart_namespace/>
+	SetEnv GIT_EXEC_PATH ${GIT_EXEC_PATH}
+	SetEnv GIT_HTTP_EXPORT_ALL
+	SetEnv GIT_NAMESPACE ns
+</LocationMatch>
 ScriptAliasMatch /smart_*[^/]*/(.*) ${GIT_EXEC_PATH}/git-http-backend/$1
 ScriptAlias /broken_smart/ broken-smart-http.sh/
 <Directory ${GIT_EXEC_PATH}>
diff --git a/t/t5560-http-backend-noserver.sh b/t/t5560-http-backend-noserver.sh
index ef98d95..85a5625 100755
--- a/t/t5560-http-backend-noserver.sh
+++ b/t/t5560-http-backend-noserver.sh
@@ -26,6 +26,13 @@ GET() {
 	test_cmp exp act
 }
 
+GET_BODY() {
+	REQUEST_METHOD="GET" && export REQUEST_METHOD &&
+	run_backend "/repo.git/$1" &&
+	sane_unset REQUEST_METHOD &&
+	tr '\015' Q <act.out | sed '1,/^Q$/d'
+}
+
 POST() {
 	REQUEST_METHOD="POST" && export REQUEST_METHOD &&
 	CONTENT_TYPE="application/x-$1-request" && export CONTENT_TYPE &&
diff --git a/t/t5561-http-backend.sh b/t/t5561-http-backend.sh
index b5d7fbc..97f97a1 100755
--- a/t/t5561-http-backend.sh
+++ b/t/t5561-http-backend.sh
@@ -23,6 +23,10 @@ GET() {
 	test_cmp exp act
 }
 
+GET_BODY() {
+	curl "$HTTPD_URL/$SMART/repo.git/$1"
+}
+
 POST() {
 	curl --include --data "$2" \
 	--header "Content-Type: application/x-$1-request" \
@@ -134,6 +138,13 @@ POST /smart/repo.git/git-receive-pack HTTP/1.1 200 -
 ###
 GET  /smart/repo.git/info/refs?service=git-receive-pack HTTP/1.1 403 -
 POST /smart/repo.git/git-receive-pack HTTP/1.1 403 -
+
+###  namespace test
+###
+GET  /smart/repo.git/info/refs HTTP/1.1 200
+GET  /smart/repo.git/info/refs?service=git-upload-pack HTTP/1.1 200
+GET  /smart_namespace/repo.git/info/refs HTTP/1.1 200
+GET  /smart_namespace/repo.git/info/refs?service=git-upload-pack HTTP/1.1 200
 EOF
 test_expect_success 'server request log matches test results' '
 	sed -e "
diff --git a/t/t556x_common b/t/t556x_common
index 82926cf..6c34f33 100755
--- a/t/t556x_common
+++ b/t/t556x_common
@@ -120,3 +120,28 @@ test_expect_success 'http.receivepack false' '
 	GET info/refs?service=git-receive-pack "403 Forbidden" &&
 	POST git-receive-pack 0000 "403 Forbidden"
 '
+test_expect_success 'backend respects namespaces' '(
+	log_div "namespace test"
+	config http.uploadpack true &&
+	config http.getanyfile true &&
+
+	NS=ns &&
+	(cd "$HTTPD_DOCUMENT_ROOT_PATH/repo.git" &&
+		git update-ref refs/namespaces/$NS/refs/heads/master HEAD
+	) &&
+
+	SMART=smart
+	git ls-remote public >expected &&  
+	grep /$NS/ expected >/dev/null &&
+	GET_BODY "info/refs" >actual &&
+	test_cmp expected actual &&
+	GET_BODY "info/refs?service=git-upload-pack" | grep /$NS/ >/dev/null &&
+
+	SMART=smart_namespace &&
+	GIT_NAMESPACE=$NS && export GIT_NAMESPACE &&
+	git ls-remote public >expected &&  
+	! grep /$NS/ expected>/dev/null &&
+	GET_BODY "info/refs" >actual &&
+	test_cmp expected actual &&
+	! (GET_BODY "info/refs?service=git-upload-pack" | grep /$NS/ >/dev/null)
+)'
-- 
1.8.1.3
