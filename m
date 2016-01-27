From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 2/3] git: protect against unbalanced calls to {save,restore}_env()
Date: Wed, 27 Jan 2016 15:19:49 -0800
Message-ID: <xmqqtwly625m.fsf_-_@gitster.mtv.corp.google.com>
References: <56A72235.9080602@drmicha.warpmail.net>
	<1453814801-1925-1-git-send-email-pclouds@gmail.com>
	<xmqq60ygcd9a.fsf@gitster.mtv.corp.google.com>
	<xmqqbn87a54v.fsf@gitster.mtv.corp.google.com>
	<xmqq7fiva53g.fsf_-_@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, git@drmicha.warpmail.net
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jan 28 00:20:01 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aOZNU-0003T0-SE
	for gcvg-git-2@plane.gmane.org; Thu, 28 Jan 2016 00:19:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755246AbcA0XTx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Jan 2016 18:19:53 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:55219 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755242AbcA0XTv (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Jan 2016 18:19:51 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 332E23F1C8;
	Wed, 27 Jan 2016 18:19:51 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=USpKXcCpV5plyQSUz/2LmQMcAHM=; b=BvSlds
	HASsypRDfcLYA9KL/AnGkCoCXW3QXm33gaZFxZuEXw5OE7Jadunpl5TZI8TwLeIN
	DSOveIPHl2lHL++/Yg9Uc3WL9kpKQidNrdZd8XVkPqADN4L+dZu6Ou7yaEcjLL/B
	jTEFa19xfQJoTogPM4F/GaYuc8OSSfZ7TVL7c=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=xisRuVRztZ0dnId0NIfkuFB9XI21JSBw
	IssU6nBLKd7/TqMc1PwXXGzt2+QOwVHgTf9ytRRgexRDATxgG4vooLkcsYJe4Brm
	2EW8AexbXBLFMVnGdAd/63oicJxdfa0wgNHX+wIHMz9nLkGTKJizef43VFKt4+g/
	SvWx9GyfdbY=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 285003F1C6;
	Wed, 27 Jan 2016 18:19:51 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 9F9063F1C5;
	Wed, 27 Jan 2016 18:19:50 -0500 (EST)
In-Reply-To: <xmqq7fiva53g.fsf_-_@gitster.mtv.corp.google.com> (Junio
	C. Hamano's message of "Tue, 26 Jan 2016 22:50:27 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 76D70E82-C54C-11E5-BBBA-80A36AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

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
2.7.0-368-gb6e04f9
