Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26578130495
	for <git@vger.kernel.org>; Mon,  9 Sep 2024 23:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725924081; cv=none; b=aUZlRo86ylZD07hKHBepAZJnIy6NQ1hSMOExTnPkp01tUKDegPsCPlCcEU4zscbqXVUOUYvmGFQ1fLG1eFAUBrCrViOJfPmpuz2fHfHf3k5ttIf9aINZD+UNlMyyqHBISuoZxwCFo7E3pp/VfK49LALHUAJ3uCQoESUPNW+NN34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725924081; c=relaxed/simple;
	bh=j76Fo+wy1YH0Zw0XaEHaUKS5MJ0BrQZ9uR0qKsjEVAg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oHonlg13JR+CabSSw/o8klxP4Hnan8WLKiIq5bvDElQFStKY83RMHgIFe4VaZI9H+lEWfDnzlp/NUZQU0UrFRbzyKhPqIEqIAv8he3NJzJdUALjNZU4EenXb0iJvtIY1O4pp+vVSsBAkjq5SwgMtdlZsBxi6257eN7LOm7Cinm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 32267 invoked by uid 109); 9 Sep 2024 23:21:19 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 09 Sep 2024 23:21:19 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 25024 invoked by uid 111); 9 Sep 2024 23:21:18 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 09 Sep 2024 19:21:18 -0400
Authentication-Results: peff.net; auth=none
Date: Mon, 9 Sep 2024 19:21:18 -0400
From: Jeff King <peff@peff.net>
To: git@vger.kernel.org
Cc: Brooke Kuhlmann <brooke@alchemists.io>
Subject: [PATCH 9/9] ref-filter: add ref_format_clear() function
Message-ID: <20240909232118.GI921834@coredump.intra.peff.net>
References: <20240909230758.GA921697@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240909230758.GA921697@coredump.intra.peff.net>

After using the ref-filter API, callers should use ref_filter_clear() to
free any used memory. However, there's not a matching function to clear
the ref_format struct.

Traditionally this did not need to be cleaned up, as it was just a way
for the caller to store and pass format options as a single unit. Even
though the parsing step of some placeholders may allocate data, that's
usually inside their "used_atom" structs, which are part of the
ref_filter itself.

But a few placeholders keep data outside of there. The %(ahead-behind)
and %(is-base) parsers both keep a master list of bases, because they
perform a single filtering pass outside of the use of any particular
atom. And since the format parser does not have access to the ref_filter
struct, they store their cross-atom data in the ref_format struct
itself.

And thus when they are finished, the ref_format also needs to be cleaned
up. So let's add a function to do so, and call it from all of the users
of the ref-filter API.

The %(is-base) case is found by running LSan on t6300. After this patch,
the script can now be marked leak-free.

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/branch.c        |  1 +
 builtin/for-each-ref.c  |  1 +
 builtin/tag.c           |  1 +
 builtin/verify-tag.c    |  1 +
 ref-filter.c            | 13 +++++++++++++
 ref-filter.h            |  3 +++
 t/t6300-for-each-ref.sh |  1 +
 7 files changed, 21 insertions(+)

diff --git a/builtin/branch.c b/builtin/branch.c
index 3f870741bf..c98601c6fe 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -878,6 +878,7 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
 		string_list_clear(&output, 0);
 		ref_sorting_release(sorting);
 		ref_filter_clear(&filter);
+		ref_format_clear(&format);
 		return 0;
 	} else if (edit_description) {
 		const char *branch_name;
diff --git a/builtin/for-each-ref.c b/builtin/for-each-ref.c
index 5517a4a1c0..c72fa05bcb 100644
--- a/builtin/for-each-ref.c
+++ b/builtin/for-each-ref.c
@@ -104,6 +104,7 @@ int cmd_for_each_ref(int argc, const char **argv, const char *prefix)
 	filter_and_format_refs(&filter, flags, sorting, &format);
 
 	ref_filter_clear(&filter);
+	ref_format_clear(&format);
 	ref_sorting_release(sorting);
 	strvec_clear(&vec);
 	return 0;
diff --git a/builtin/tag.c b/builtin/tag.c
index a1fb218512..607e48e311 100644
--- a/builtin/tag.c
+++ b/builtin/tag.c
@@ -702,6 +702,7 @@ int cmd_tag(int argc, const char **argv, const char *prefix)
 cleanup:
 	ref_sorting_release(sorting);
 	ref_filter_clear(&filter);
+	ref_format_clear(&format);
 	strbuf_release(&buf);
 	strbuf_release(&ref);
 	strbuf_release(&reflog_msg);
diff --git a/builtin/verify-tag.c b/builtin/verify-tag.c
index c731e2f87b..77becf7e75 100644
--- a/builtin/verify-tag.c
+++ b/builtin/verify-tag.c
@@ -65,5 +65,6 @@ int cmd_verify_tag(int argc, const char **argv, const char *prefix)
 		if (format.format)
 			pretty_print_ref(name, &oid, &format);
 	}
+	ref_format_clear(&format);
 	return had_error;
 }
diff --git a/ref-filter.c b/ref-filter.c
index 0f51095bbd..ce1bcfad85 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -3621,3 +3621,16 @@ void ref_filter_clear(struct ref_filter *filter)
 	free_commit_list(filter->unreachable_from);
 	ref_filter_init(filter);
 }
+
+void ref_format_init(struct ref_format *format)
+{
+	struct ref_format blank = REF_FORMAT_INIT;
+	memcpy(format, &blank, sizeof(blank));
+}
+
+void ref_format_clear(struct ref_format *format)
+{
+	string_list_clear(&format->bases, 0);
+	string_list_clear(&format->is_base_tips, 0);
+	ref_format_init(format);
+}
diff --git a/ref-filter.h b/ref-filter.h
index e794b8a676..754038ab07 100644
--- a/ref-filter.h
+++ b/ref-filter.h
@@ -221,4 +221,7 @@ void filter_is_base(struct repository *r,
 void ref_filter_init(struct ref_filter *filter);
 void ref_filter_clear(struct ref_filter *filter);
 
+void ref_format_init(struct ref_format *format);
+void ref_format_clear(struct ref_format *format);
+
 #endif /*  REF_FILTER_H  */
diff --git a/t/t6300-for-each-ref.sh b/t/t6300-for-each-ref.sh
index e8db612f95..b3163629c5 100755
--- a/t/t6300-for-each-ref.sh
+++ b/t/t6300-for-each-ref.sh
@@ -5,6 +5,7 @@
 
 test_description='for-each-ref test'
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 GNUPGHOME_NOT_USED=$GNUPGHOME
 . "$TEST_DIRECTORY"/lib-gpg.sh
-- 
2.46.0.867.gf99b2b8e0f
