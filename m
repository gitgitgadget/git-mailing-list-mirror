Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2634318E75D
	for <git@vger.kernel.org>; Tue, 18 Jun 2024 23:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718754288; cv=none; b=uE4j8InlG1fiFOLKwlmKEygu1Sy7oIoS3gD2XU7FyzLXQmGBCAh2Yw8vk3+Q69Q6bHP8wXFejiHL0vLR5HXadUOQfLOjS8NuQwXnsWjPHjwcf0XbEEOVjqFlOrWr+of8SggvOgw019EKH4FfSE+aW7DAjEIfJf6YzKlRCWJIqa8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718754288; c=relaxed/simple;
	bh=gmukrHaFgIZGGfhwgk9yqtSRsLusJU+tXTB+O9rpHDk=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=klwYbL6YnK9VapU58caOEZJdU+WWtV7tJbp6wZ3NPg/Zy9RUe05JGYknnuL8OqLi8qcK8UQcPxJcqZDPD3fZhbcCq8Qj5Xr8XcmGOJT1hEd1Y9hP57CMgMxGMeJdx1caN7pYYLqW3KHZ+V0gfVdADzLvNPncxwk+8+8wNpx3hUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=WbZtME15; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="WbZtME15"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id EDFF12DB49;
	Tue, 18 Jun 2024 19:44:45 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references:mime-version
	:content-transfer-encoding; s=sasl; bh=gmukrHaFgIZGGfhwgk9yqtSRs
	LusJU+tXTB+O9rpHDk=; b=WbZtME15fAFqjifZ7Pu5n8AVF9VmrNxhJ68MlFdwk
	CDG/+G24aDvYmZS2RClZfaJok9M62L9krCLs2Diy9/uY461DYTWeCLuumSfYUlP9
	qlv61OQaCc5Gc+MnyuQmqTahx7dUU96xyMR0euHlCD5/59BGr+HqFz69CqHEwkG2
	WQ=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id E76C12DB48;
	Tue, 18 Jun 2024 19:44:45 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.204.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 609EF2DB47;
	Tue, 18 Jun 2024 19:44:45 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: [PATCH 2/4] attr: notice and report read failure of .gitattributes files
Date: Tue, 18 Jun 2024 16:44:33 -0700
Message-ID: <20240618234436.4107855-3-gitster@pobox.com>
X-Mailer: git-send-email 2.45.2-711-gd2c001ca14
In-Reply-To: <20240618234436.4107855-1-gitster@pobox.com>
References: <20240618233303.GA188880@coredump.intra.peff.net>
 <20240618234436.4107855-1-gitster@pobox.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Pobox-Relay-ID:
 BDE27D7E-2DCC-11EF-8500-5B6DE52EC81B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable

The code that reads .gitattributes files was careless in dealing in
unusual circumstances.

 - It let read errors silently ignored.

 - It tried to read ".gitattributes" that is a directory on
   platforms that allowed open(2) to open directories.

To make the latter consistent with what we do for fopen() on
directories ("git grep" for FREAD_READS_DIRECTORIES for details),
check if we opened a directory, silently close it and return
success.  Catch all read errors before we close and report as
needed.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 attr.c                | 10 +++++++++-
 t/t0003-attributes.sh |  9 +++++++++
 2 files changed, 18 insertions(+), 1 deletion(-)

diff --git a/attr.c b/attr.c
index 300f994ba6..9ab9cf1551 100644
--- a/attr.c
+++ b/attr.c
@@ -747,6 +747,11 @@ static struct attr_stack *read_attr_from_file(const =
char *path, unsigned flags)
 		fclose(fp);
 		return NULL;
 	}
+	if (S_ISDIR(st.st_mode)) {
+		/* On FREAD_READS_DIRECTORIES platforms */
+		fclose(fp);
+		return NULL;
+	}
 	if (st.st_size >=3D ATTR_MAX_FILE_SIZE) {
 		warning(_("ignoring overly large gitattributes file '%s'"), path);
 		fclose(fp);
@@ -760,7 +765,10 @@ static struct attr_stack *read_attr_from_file(const =
char *path, unsigned flags)
 		handle_attr_line(res, buf.buf, path, ++lineno, flags);
 	}
=20
-	fclose(fp);
+	if (ferror(fp))
+		warning_errno(_("failed while reading gitattributes file '%s'"), path)=
;
+	if (fclose(fp))
+		warning_errno(_("cannot fclose gitattributes file '%s'"), path);
 	strbuf_release(&buf);
 	return res;
 }
diff --git a/t/t0003-attributes.sh b/t/t0003-attributes.sh
index 66ccb5889d..783c20146d 100755
--- a/t/t0003-attributes.sh
+++ b/t/t0003-attributes.sh
@@ -603,6 +603,15 @@ test_expect_success EXPENSIVE 'large attributes blob=
 ignored' '
 	test_cmp expect err
 '
=20
+test_expect_success '.gitattribute directory behaves as if it does not e=
xist' '
+	test_when_finished "rm -fr dir" &&
+	mkdir -p dir/.gitattributes &&
+	>dir/ectory &&
+	git -C dir check-attr --all ectory >out 2>err &&
+	test_grep ! "failed while reading" err &&
+	test_grep ! "cannot fclose" err
+'
+
 test_expect_success 'builtin object mode attributes work (dir and regula=
r paths)' '
 	>normal &&
 	attr_check_object_mode normal 100644 &&
--=20
2.45.2-711-gd2c001ca14

