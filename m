From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 2/2] check-attr: move to the top of working tree when in non-bare repository
Date: Thu,  6 Feb 2014 10:40:33 -0800
Message-ID: <1391712033-9443-2-git-send-email-gitster@pobox.com>
References: <xmqqvbwsyvn8.fsf@gitster.dls.corp.google.com>
 <1391712033-9443-1-git-send-email-gitster@pobox.com>
Cc: Lasse Makholm <lasse.makholm@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 06 19:40:51 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WBTsY-0008Uu-9A
	for gcvg-git-2@plane.gmane.org; Thu, 06 Feb 2014 19:40:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753193AbaBFSkn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Feb 2014 13:40:43 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:55748 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752354AbaBFSkl (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Feb 2014 13:40:41 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BB696686F8;
	Thu,  6 Feb 2014 13:40:40 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=xYxW
	uEoGJOtxyQInok65QrZzV/M=; b=sR6r5wa9Ac/ZMc25zGLUdar+dDojhbqQTJJY
	WS1H6ekHA455J+LTCCWWEbxrKBWx5Bdukd2HwxBHXeHsQyqgFyYBhwRor4z9pedB
	Y/Wh8BHmQe7OgKV/bd5YqnLXnObpzgg+ST6WxOPkB4MIecHiPAVPCrKBghCtAwhF
	s7TXzSM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; q=dns; s=sasl; b=
	FyyG/tiI30FFVTojJh89HFbrGvOJeFZ3aiuxt7YOf5G4tBdYjrwyWUVX/1N/Pu3d
	8GnoHzPI3qcNGqmEbWyyp/nSFUtiRiocloqLKR/KO/tx/F+UHxeUaNvwk0T3XYBh
	4VcZhAMn6Okn0wjVI2CwbZF1zfqVrNnTYwa1nI98f+Q=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8A0A9686F7;
	Thu,  6 Feb 2014 13:40:40 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C916B686F3;
	Thu,  6 Feb 2014 13:40:39 -0500 (EST)
X-Mailer: git-send-email 1.9-rc2-233-ged4ee9f
In-Reply-To: <1391712033-9443-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 2D249816-8F5E-11E3-B2CC-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241709>

Lasse Makholm noticed that running "git check-attr" from a place
totally unrelated to $GIT_DIR and $GIT_WORK_TREE does not give
expected results.  I think it is because the command does not say it
wants to call setup_work_tree().

We still need to support use cases where only a bare repository is
involved, so unconditionally requiring a working tree would not work
well.  Instead, make a call only in a non-bare repository.

We may want to see if we want to do a similar fix in the opposite
direction to check-ignore.  The command unconditionally requires a
working tree, but it should be usable in a bare repository just like
check-attr attempts to be.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/check-attr.c  |  3 +++
 t/t0003-attributes.sh | 10 ++++++++++
 2 files changed, 13 insertions(+)

diff --git a/builtin/check-attr.c b/builtin/check-attr.c
index 075d01d..f29d6c3 100644
--- a/builtin/check-attr.c
+++ b/builtin/check-attr.c
@@ -94,6 +94,9 @@ int cmd_check_attr(int argc, const char **argv, const char *prefix)
 	struct git_attr_check *check;
 	int cnt, i, doubledash, filei;
 
+	if (!is_bare_repository())
+		setup_work_tree();
+
 	git_config(git_default_config, NULL);
 
 	argc = parse_options(argc, argv, prefix, check_attr_options,
diff --git a/t/t0003-attributes.sh b/t/t0003-attributes.sh
index 0554b13..6e6aef5 100755
--- a/t/t0003-attributes.sh
+++ b/t/t0003-attributes.sh
@@ -196,6 +196,16 @@ test_expect_success 'root subdir attribute test' '
 	attr_check subdir/a/i unspecified
 '
 
+test_expect_success 'using --git-dir and --work-tree' '
+	mkdir unreal real &&
+	git init real &&
+	echo "file test=in-real" >real/.gitattributes &&
+	(
+		cd unreal &&
+		attr_check file in-real "--git-dir ../real/.git --work-tree ../real"
+	)
+'
+
 test_expect_success 'setup bare' '
 	git clone --bare . bare.git
 '
-- 
1.9-rc2-233-ged4ee9f
