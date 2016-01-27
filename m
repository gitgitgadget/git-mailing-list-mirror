From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 2/3] git: protect against unbalanced calls to {save,restore}_env()
Date: Tue, 26 Jan 2016 22:50:27 -0800
Message-ID: <xmqq7fiva53g.fsf_-_@gitster.mtv.corp.google.com>
References: <56A72235.9080602@drmicha.warpmail.net>
	<1453814801-1925-1-git-send-email-pclouds@gmail.com>
	<xmqq60ygcd9a.fsf@gitster.mtv.corp.google.com>
	<xmqqbn87a54v.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, git@drmicha.warpmail.net
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jan 27 07:50:37 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aOJw1-0001Cf-PM
	for gcvg-git-2@plane.gmane.org; Wed, 27 Jan 2016 07:50:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753591AbcA0Gua (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Jan 2016 01:50:30 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:62414 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752075AbcA0Gu3 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Jan 2016 01:50:29 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 648083243B;
	Wed, 27 Jan 2016 01:50:29 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=NT+G0goMH8NWmcV39xHiplm+1/I=; b=eXKWKy
	NpV9t0tiS4f0UmICctpx8EHle9nSdU5kM2gIrROoyWjMYuf01ElRgsYjrZFapTZK
	EsH+GvFtT9/3Ou69it2u8X3V3I9esbD8hoFYDjwOW/EWRjbXWjJMLAf7adU701tt
	UsHzniJjmMMIAI6HORTEf7YE1gEno4FoeHeos=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=bGCzWyeSf9QBb5BCIL8QMoZmg8mMxsV7
	8CRBN/liQEhq30YUfxc5TbTBz3kZuwudJX0Mum4ng0kyW47R2iVfD6eA2yVdvbND
	VRecw81TIjI2vtID9EMGL8dXZmaWFQ7iE+LhekuKy8tShYWZEmPvXIcGws/xGgCX
	A+4bmqG1DzI=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 5A8953243A;
	Wed, 27 Jan 2016 01:50:29 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id D062032439;
	Wed, 27 Jan 2016 01:50:28 -0500 (EST)
In-Reply-To: <xmqqbn87a54v.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
	message of "Tue, 26 Jan 2016 22:49:36 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 40736AC8-C4C2-11E5-B9B7-80A36AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284873>

We made sure that save_env_before_alias() does not skip saving the
environment when asked to (which led to double free of orig_cwd in
restore_env()) with the previous step.  Protect against future
breakage where somebody adds new callers of these functions in an
unbalanced fashion.

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
2.7.0-368-g4610598
