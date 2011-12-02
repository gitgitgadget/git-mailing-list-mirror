From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 6/6] chunked-object: fallback checkout codepaths
Date: Thu,  1 Dec 2011 16:40:49 -0800
Message-ID: <1322786449-25753-7-git-send-email-gitster@pobox.com>
References: <1322699263-14475-6-git-send-email-gitster@pobox.com>
 <1322786449-25753-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Dec 02 01:41:31 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RWHBy-000769-Dw
	for gcvg-git-2@lo.gmane.org; Fri, 02 Dec 2011 01:41:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756151Ab1LBAlH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 Dec 2011 19:41:07 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:50155 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756102Ab1LBAlE (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Dec 2011 19:41:04 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 593276B38
	for <git@vger.kernel.org>; Thu,  1 Dec 2011 19:41:04 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=7enz
	gr4cHqXcoxoo8cOdrJUeNEw=; b=PbVkqxMxxYruKkTe8vwix1vmY+QFPmTA0o4p
	dYGkRzGK9uHIw2h3lZdJ4Jk/SzyhjfS4RwlBJ46rto1kth8kLAl4qB1elXFrKrLA
	wyz74VadKhkCCzzRbBGFbbvy5ExM4naxA741WoRMNH5ET1SOG07KalVnMfPgFxQ9
	HHmZSFc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=nuQMCs
	VeaiDOls5aR1Ac+cmL5fSjeUus6v+3JX3mz+/0GQ2RMx/6qqcwgNqwev+sUzjeRc
	J15baPITQu+DFBfImHIO/uEWtHlij+uv8lPtIPnMux9m2bWnPlU431eTspJvBfQT
	XjmzsrZlkMwv3YZ/WJIuOfPOVWRz1E/Ifgfyw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 503B46B37
	for <git@vger.kernel.org>; Thu,  1 Dec 2011 19:41:04 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A36CE6B36 for
 <git@vger.kernel.org>; Thu,  1 Dec 2011 19:41:03 -0500 (EST)
X-Mailer: git-send-email 1.7.8.rc4.177.g4d64
In-Reply-To: <1322786449-25753-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 50514E88-1C7E-11E1-9698-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186204>

This prepares the default codepaths based on the traditional "slurping
everything in-core" model around read_sha1_file() API for objects that use
chunked encoding. Needless to say, these codepaths are unsuitable for the
kind of objects that use chunked encoding and are intended to only serve
as the fallback where specialized "large object API" support is still
lacking.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 sha1_file.c      |   54 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 t/t1050-large.sh |   14 +++++++++++++-
 2 files changed, 67 insertions(+), 1 deletions(-)

diff --git a/sha1_file.c b/sha1_file.c
index 14902cc..7355716 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -1607,6 +1607,11 @@ static int packed_object_info(struct packed_git *p, off_t obj_offset,
 		if (sizep)
 			*sizep = size;
 		break;
+	case OBJ_CHUNKED_BLOB:
+		if (sizep)
+			*sizep = size;
+		type = OBJ_DEKNUHC(type);
+		break;
 	default:
 		error("unknown object type %i at offset %"PRIuMAX" in %s",
 		      type, (uintmax_t)obj_offset, p->pack_name);
@@ -1648,6 +1653,51 @@ static void *unpack_compressed_entry(struct packed_git *p,
 	return buffer;
 }
 
+static void *unpack_chunked_entry(struct packed_git *p,
+				  struct pack_window **w_curs,
+				  off_t curpos,
+				  unsigned long size)
+{
+	/*
+	 * *NOTE* *NOTE* *NOTE*
+	 *
+	 * In the longer term, we should aim to exercise this codepath
+	 * less and less often, as it defeats the whole purpose of
+	 * chuncked object encoding!
+	 */
+	unsigned char *buffer;
+	const unsigned char *in, *ptr;
+	unsigned long avail, ofs;
+	int chunk_cnt;
+
+	buffer = xmallocz(size);
+	in = use_pack(p, w_curs, curpos, &avail);
+	ptr = in;
+	chunk_cnt = decode_in_pack_varint(&ptr);
+	curpos += ptr - in;
+	ofs = 0;
+	while (chunk_cnt--) {
+		unsigned long csize;
+		unsigned char *data;
+		enum object_type type;
+
+		in = use_pack(p, w_curs, curpos, &avail);
+		data = read_sha1_file(in, &type, &csize);
+		if (!data)
+			die("malformed chunked object contents ('%s' does not exist)",
+			    sha1_to_hex(in));
+		if (type != OBJ_BLOB)
+			die("malformed chunked object contents (not a blob)");
+		if (size < ofs + csize)
+			die("malformed chunked object contents (sizes do not add up)");
+		memcpy(buffer + ofs, data, csize);
+		ofs += csize;
+		curpos += 20;
+		free(data);
+	}
+	return buffer;
+}
+
 #define MAX_DELTA_CACHE (256)
 
 static size_t delta_base_cached;
@@ -1883,6 +1933,10 @@ void *unpack_entry(struct packed_git *p, off_t obj_offset,
 	case OBJ_TAG:
 		data = unpack_compressed_entry(p, &w_curs, curpos, *sizep);
 		break;
+	case OBJ_CHUNKED_BLOB:
+		data = unpack_chunked_entry(p, &w_curs, curpos, *sizep);
+		*type = OBJ_DEKNUHC(*type);
+		break;
 	default:
 		data = NULL;
 		error("unknown object type %i at offset %"PRIuMAX" in %s",
diff --git a/t/t1050-large.sh b/t/t1050-large.sh
index d6cb66d..eea45d1 100755
--- a/t/t1050-large.sh
+++ b/t/t1050-large.sh
@@ -124,8 +124,20 @@ test_expect_success 'split limit' '
 		# switch to a better chunking heuristics.
 		echo cruft >head &&
 		cat split >>head &&
-		git add head
+		git add head &&
 
+		echo blob >expect &&
+		git cat-file -t :split >actual &&
+		test_cmp expect actual &&
+
+		git cat-file -p :split >actual &&
+		# You probably do not want to use test_cmp here...
+		cmp split actual &&
+
+		mv split expect &&
+		git checkout split &&
+		# You probably do not want to use test_cmp here...
+		cmp expect split
 	)
 '
 
-- 
1.7.8.rc4.177.g4d64
