Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBDDC487B6
	for <git@vger.kernel.org>; Sat, 24 Feb 2024 20:22:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708806179; cv=none; b=kHxOkIERkyro3WQeAxv0x3i6nET4Gbxo3X8Id+4Pp9U5A4610CjujFUIRHxIrAeZVj8hGzfu8hMQEmYhO8jX6He+0b0+szk3AKwwJ82MIhz26+BN7Mr275UI+dDJUUBq0G0XGwq4jTPwiu2bVFiFHsQvqQEBUoCTJh5zoMz4nL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708806179; c=relaxed/simple;
	bh=kHN5fJ27Vmrn3Q99bdwefLkjkGNKJeyuJVSLwNZrqLA=;
	h=From:To:Subject:CC:Date:Message-ID:MIME-Version:Content-Type; b=KM5HbCBI2qJkD/XwoRAMWCSGxqSnYpe3XkekJ/TRPAm2XLBI0tRzhbn9bReqrFns4CNTfp4syi9FYMf9EQZkoIm5ze0+JElSustgA876Aqomge11lllqffRAM/KiRmy9tfRoOzHCIac5HOgn7OmsMZEqS5F9TyOcE0NlxGxMFgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=imAg/BG7; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="imAg/BG7"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id CF1611E8FD3;
	Sat, 24 Feb 2024 15:22:50 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to
	:subject:cc:date:message-id:mime-version:content-type; s=sasl;
	 bh=kHN5fJ27Vmrn3Q99bdwefLkjkGNKJeyuJVSLwNZrqLA=; b=imAg/BG7+s5a
	jDAZDhFBKqOa3673iUNkp2wsbCsfh5lRpEp6MaVatb4MyLJRjGpTe89s4TBibLbk
	ofGrKlpw2ivD7N22IDPOcmVD3lQfidy347j2XrALDWGgU0sKHlnW/9LbREFZvwMO
	8KZWiDj+JT7XcsWDOSZbA52IQdtG5FI=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id C79711E8FD2;
	Sat, 24 Feb 2024 15:22:50 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.176.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 4034F1E8FD1;
	Sat, 24 Feb 2024 15:22:50 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: [PATCH] doc: clarify the wording on <git-compat-util.h> requirement
CC: Kyle Lippincott <spectral@google.com>,
    Calvin Wan <calvinwan@google.com>,
    Jonathan Tan <jonathantanmy@google.com>,
    Elijah Newren <newren@gmail.com>
Date: Sat, 24 Feb 2024 12:22:49 -0800
Message-ID: <xmqq4jdxmx2e.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 7B333A7E-D352-11EE-85D7-25B3960A682E-77302942!pb-smtp2.pobox.com

The reason why we insist including the compat-util header as the
very first thing is because it is our mechanism to absorb the
differences across platforms, like the order in which system header
files must be included, and C preprocessor feature macros that are
needed to trigger certain features we want out of the systems, and
insulate other headers and sources from such minutiae.

Earlier we tried to clarify the rule in the coding guidelines
document, but the wording was a bit fuzzy that can lead to
misinterpretations like you can include xdiff/xinclude.h only to
avoid having to include git-compat-util.h file even if you have
nothing to do with xdiff implementation, for example.  "You do not
have to include more than one of these" were also misleading and
would have been puzzling if you _needed_ to depend on more than one
of these approved headers (answer: you are allowed to include them
all if you need the declarations in them for reasons other than that
you want to avoid including compat-util yourself).

Instead of using the phrase "approved headers", enumerate them as
exceptions, each labeled with intended audiences, to avoid such
misinterpretations.  The structure also makes it easier to add new
exceptions, so add the description of "t/unit-tests/test-lib.h"
being an exception only for the unit tests implementation as an
example.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 * git-std-lib folks CC'ed to show them where to put their exception
   when things start to stabilize; Elijah CC'ed for his 8bff5ca0
   (treewide: ensure one of the appropriate headers is sourced
   first, 2023-02-24) and bc5c5ec0 (cache.h: remove this
   no-longer-used header, 2023-05-16).

 Documentation/CodingGuidelines | 30 ++++++++++++++++++++++++------
 1 file changed, 24 insertions(+), 6 deletions(-)

diff --git c/Documentation/CodingGuidelines w/Documentation/CodingGuidelines
index 578587a471..b3443dd773 100644
--- c/Documentation/CodingGuidelines
+++ w/Documentation/CodingGuidelines
@@ -446,12 +446,30 @@ For C programs:
    detail.
 
  - The first #include in C files, except in platform specific compat/
-   implementations and sha1dc/, must be either "git-compat-util.h" or
-   one of the approved headers that includes it first for you.  (The
-   approved headers currently include "builtin.h",
-   "t/helper/test-tool.h", "xdiff/xinclude.h", or
-   "reftable/system.h".)  You do not have to include more than one of
-   these.
+   implementations and sha1dc/, must be "git-compat-util.h".  In
+   addition:
+
+   - the implementation of the built-in commands in the "builtin/"
+     directory that include "builtin.h" for the cmd_foo() prototype
+     definition
+
+   - the test helper programs in the "t/helper/" directory that include
+     "t/helper/test-tool.h" for the cmd__foo() prototype definition
+
+   - the xdiff implementation in the "xdiff/" directory that includes
+     "xdiff/xinclude.h" for the xdiff machinery internals
+
+   - the unit test programs in "t/unit-tests/" directory that include
+     "test-lib.h" that gives them the unit-tests framework
+
+   - the source files that implement reftable in the "reftable/"
+     directory that include "reftable/system.h" for the reftable
+     internals
+
+   are allowed to assume that their header file includes
+   "git-compat-util.h", and they do not have to include
+   "git-compat-util.h" themselves.  These headers must be the first
+   header file to be "#include"d in them, though.
 
  - A C file must directly include the header files that declare the
    functions and the types it uses, except for the functions and types
