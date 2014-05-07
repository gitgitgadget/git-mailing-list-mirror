From: =?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1c2Vu?= <tboegi@web.de>
Subject: Re: [PATCH] t3910: show failure of core.precomposeunicode with decomposed
 filenames
Date: Wed, 07 May 2014 21:16:40 +0200
Message-ID: <536A8698.3000208@web.de>
References: <20140428161630.GA9435@sigill.intra.peff.net> <5365DA7B.6050000@web.de> <20140505214658.GA16971@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>,
	=?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1c2Vu?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Wed May 07 21:16:54 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wi7Kn-00083R-RI
	for gcvg-git-2@plane.gmane.org; Wed, 07 May 2014 21:16:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751515AbaEGTQu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 May 2014 15:16:50 -0400
Received: from mout.web.de ([212.227.17.12]:56082 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750895AbaEGTQt (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 May 2014 15:16:49 -0400
Received: from [192.168.209.26] ([78.72.74.102]) by smtp.web.de (mrweb102)
 with ESMTPSA (Nemesis) id 0Lpw6t-1XMPgv1ln5-00fj8q; Wed, 07 May 2014 21:16:46
 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:24.0) Gecko/20100101 Thunderbird/24.4.0
In-Reply-To: <20140505214658.GA16971@sigill.intra.peff.net>
X-Provags-ID: V03:K0:4wjdsyVRp7R64t4W96+ql5eMbhcD/xWpTQTlsYE2xOByP730HnL
 nreVoNTMHqhv8XoU60V4ty/hBj+BvcjMWSKw3gnSU4xRmWUepCEVFgtCKvtHSmIwa76wdCU
 47As3KKqlk4PKpKDlOCDpjcT3X1FpEuFB4XUdN1fptPVIF60HMvXjqVOY38WTHeht3WIOfW
 GmrI6kvIcpy0kcfzrF59Q==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248349>

On 2014-05-05 23.46, Jeff King wrote:
[]
>>   2. Do all index filename comparisons under Mac OS X using a UTF-8 aware
>>      comparison function regardless if core.precomposeunicode is set.
>>      This would probably have bad performance, and somewhat
>>      defeats the point of converting the filenames at the
>>      readdir level in the first place.
> 
> Right, I'm concerned about performance here, but I wonder if we can
> reuse the name-hash solutions from ignorecase.
Some short question, (sorry being short)
What do you think about this:

diff --git a/compat/precompose_utf8.c b/compat/precompose_utf8.c
index 95fe849..c807f38 100644
--- a/compat/precompose_utf8.c
+++ b/compat/precompose_utf8.c
@@ -57,6 +57,22 @@ void probe_utf8_pathname_composition(char *path, int len)
 }
 
 
+char *inverscompose_str_len(const char *in, size_t insz, int *outsz)
+{
+	char *prec_str = NULL;
+
+	if (has_non_ascii(in, insz, NULL)) {
+		int old_errno = errno;
+		prec_str = reencode_string_len(in, (int)insz,
+					       precomposed_unicode ? path_encoding : repo_encoding,
+					       precomposed_unicode ? repo_encoding : path_encoding,
+					       outsz);
+		errno = old_errno;
+	}
+	return prec_str;
+}
+
+
 void precompose_argv(int argc, const char **argv)
 {
 	int i = 0;
diff --git a/compat/precompose_utf8.h b/compat/precompose_utf8.h
index 3b73585..b9ac099 100644
--- a/compat/precompose_utf8.h
+++ b/compat/precompose_utf8.h
@@ -26,6 +26,7 @@ typedef struct {
 	struct dirent_prec_psx *dirent_nfc;
 } PREC_DIR;
 
+char *inverscompose_str_len(const char *in, size_t insz, int *outsz);
 void precompose_argv(int argc, const char **argv);
 void probe_utf8_pathname_composition(char *, int);
 
diff --git a/git-compat-util.h b/git-compat-util.h
index f6d3a46..5ae5f57 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -177,7 +177,7 @@ typedef unsigned long uintptr_t;
 #ifdef PRECOMPOSE_UNICODE
 #include "compat/precompose_utf8.h"
 #else
-#define precompose_str(in,i_nfd2nfc)
+#define inverscompose_str_len(s,i,o) NULL
 #define precompose_argv(c,v)
 #define probe_utf8_pathname_composition(a,b)
 #endif
diff --git a/name-hash.c b/name-hash.c
index 97444d0..3c4a4ee 100644
--- a/name-hash.c
+++ b/name-hash.c
@@ -210,7 +210,7 @@ struct cache_entry *index_dir_exists(struct index_state *istate, const char *nam
 	return NULL;
 }
 
-struct cache_entry *index_file_exists(struct index_state *istate, const char *name, int namelen, int icase)
+static struct cache_entry *index_file_exists_int(struct index_state *istate, const char *name, int namelen, int icase)
 {
 	struct cache_entry *ce;
 	struct hashmap_entry key;
@@ -227,6 +227,25 @@ struct cache_entry *index_file_exists(struct index_state *istate, const char *na
 	return NULL;
 }
 
+
+struct cache_entry *index_file_exists(struct index_state *istate, const char *name, int namelen, int icase)
+{
+	struct cache_entry *ce;
+	ce = index_file_exists_int(istate, name, namelen, icase);
+	if (ce)
+		return ce;
+	else {
+		int prec_len;
+		char *prec_name = inverscompose_str_len(name, namelen, &prec_len);
+		if (prec_name) {
+			ce = index_file_exists_int(istate, prec_name, prec_len, icase);
+			free(prec_name);
+		}
+	}
+	return ce;
+}
+
+
 void free_name_hash(struct index_state *istate)
 {
 	if (!istate->name_hash_initialized)
diff --git a/t/t3910-mac-os-precompose.sh b/t/t3910-mac-os-precompose.sh
index e4ba601..4414658 100755
--- a/t/t3910-mac-os-precompose.sh
+++ b/t/t3910-mac-os-precompose.sh
@@ -140,6 +140,22 @@ test_expect_success "Add long precomposed filename" '
 	git add * &&
 	git commit -m "Long filename"
 '
+
+test_expect_success 'handle existing decomposed filenames' '
+	git checkout master &&
+	git reset --hard &&
+	git checkout -b exist_decomposed &&
+	echo content >"verbatim.$Adiarnfd" &&
+	git -c core.precomposeunicode=false add "verbatim.$Adiarnfd" &&
+	git commit -m "existing decomposed file" &&
+	echo \"verbatim.A\\314\\210\" >expect &&
+	git ls-files >actual &&
+	test_cmp expect actual &&
+	>expect &&
+	git status | grep verbatim || : >actual &&
+	test_cmp expect actual
+'
+
 # Test if the global core.precomposeunicode stops autosensing
 # Must be the last test case
 test_expect_success "respect git config --global core.precomposeunicode" '
diff --git a/utf8.c b/utf8.c
index 77c28d4..fb8a99a 100644
--- a/utf8.c
+++ b/utf8.c
@@ -519,7 +519,7 @@ char *reencode_string_iconv(const char *in, size_t insz, iconv_t conv, int *outs
 	char *out, *outpos;
 	iconv_ibp cp;
 
-	outsz = insz;
+	outsz = 3*insz; /* for decompose */
 	outalloc = outsz + 1; /* for terminating NUL */
 	out = xmalloc(outalloc);
 	outpos = out;
