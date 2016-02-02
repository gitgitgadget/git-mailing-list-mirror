From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 2/4] git: protect against unbalanced calls to {save,restore}_env()
Date: Tue, 02 Feb 2016 15:47:55 -0800
Message-ID: <xmqqr3guptck.fsf_-_@gitster.mtv.corp.google.com>
References: <56A72235.9080602@drmicha.warpmail.net>
	<1453814801-1925-1-git-send-email-pclouds@gmail.com>
	<xmqq60ygcd9a.fsf@gitster.mtv.corp.google.com>
	<xmqqbn87a54v.fsf@gitster.mtv.corp.google.com>
	<CACsJy8DzHYpw3TT3i17W-8eiR9J9DOQUO6mkxffUEnGqT1u96Q@mail.gmail.com>
	<xmqqtwlz8c4w.fsf@gitster.mtv.corp.google.com>
	<xmqqy4ba627n.fsf_-_@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Git Mailing List <git@vger.kernel.org>,
	Michael J Gruber <git@drmicha.warpmail.net>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 03 00:48:03 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aQkfx-0000FR-KP
	for gcvg-git-2@plane.gmane.org; Wed, 03 Feb 2016 00:48:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754849AbcBBXr6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Feb 2016 18:47:58 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:58679 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752099AbcBBXr5 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Feb 2016 18:47:57 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 251C54199C;
	Tue,  2 Feb 2016 18:47:57 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=kdiTDrljksgpIU13Cke+9nIUGss=; b=iKAiTs
	no0U9piCOI2sk4La+kQxiEDf10H5449Kq99sV3sOPFpDvjQA+GCGfyTGwMyO4Th6
	FzqihHwFkE7m/n6twxqdTXI2iJ1CxBTyomPK2mTlCO04/jWKQtXrlCmu75FWKkKx
	3m5diN8TiFKhFtQIBcpFoqKSoTtlBj7s3rMsU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=JesSkJIu2XaY7Z8rIgmkyQzQW7UWQp6t
	JXsrDULECXclsmQbiS8SgRDI/Sm63T1fLtwiLD1MlP5JGvXs5tn890ZGkQwcZvOS
	q85QYqeKD48wNCz5V2S2fVQb/TWtQ648a3ZpG8lF89rGNkfh8a/SGtLhq8MR09EX
	/FKyzB7JjWc=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 1C67B4199B;
	Tue,  2 Feb 2016 18:47:57 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 92BAB41999;
	Tue,  2 Feb 2016 18:47:56 -0500 (EST)
In-Reply-To: <xmqqy4ba627n.fsf_-_@gitster.mtv.corp.google.com> (Junio
	C. Hamano's message of "Wed, 27 Jan 2016 15:18:36 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 6238933C-CA07-11E5-8741-04C16BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285317>

We made sure that save_env_before_alias() does not skip saving the
environment when asked to (which led to use-after-free of orig_cwd
in restore_env() in the buggy version) with the previous step.

Protect against future breakage where somebody adds new callers of
these functions in an unbalanced fashion.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 git.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/git.c b/git.c
index a57a4cb..e39b972 100644
--- a/git.c
+++ b/git.c
@@ -26,11 +26,15 @@ static const char *env_names[] = {
 };
 static char *orig_env[4];
 static int saved_env_before_alias;
+static int save_restore_env_balance;
 
 static void save_env_before_alias(void)
 {
 	int i;
 	saved_env_before_alias = 1;
+
+	assert(save_restore_env_balance == 0);
+	save_restore_env_balance = 1;
 	orig_cwd = xgetcwd();
 	for (i = 0; i < ARRAY_SIZE(env_names); i++) {
 		orig_env[i] = getenv(env_names[i]);
@@ -42,6 +46,9 @@ static void save_env_before_alias(void)
 static void restore_env(int external_alias)
 {
 	int i;
+
+	assert(save_restore_env_balance == 1);
+	save_restore_env_balance = 0;
 	if (!external_alias && orig_cwd && chdir(orig_cwd))
 		die_errno("could not move to %s", orig_cwd);
 	free(orig_cwd);
-- 
2.7.0-391-gcd29568
