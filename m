Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7C4E0207BD
	for <e@80x24.org>; Fri, 21 Apr 2017 03:41:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1034927AbdDUDlg (ORCPT <rfc822;e@80x24.org>);
        Thu, 20 Apr 2017 23:41:36 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:62629 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1032482AbdDUDlf (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Apr 2017 23:41:35 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 8BC5B80564;
        Thu, 20 Apr 2017 23:41:33 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=tSwY/amdDCABxxAIauWIQ7849Wg=; b=DtL+C2
        VM3gB1fvzHYhdA/WfjYUY6mBedV+uNxmDbUOq0zF3XFWbsgdma3r3wrZWdbM5hrI
        c099PBVmGnXB8H9AL6huRqm5MrQQSv/NyoZ92jUTqM7DUQW0t1+31ztdD5MC2ouj
        YtqHNo6bMB4J4IuvCPEkt7FZqVHx46A9WA+v4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=sugIxVSuHj3pkcpYL1JWp9sdMBr4pbNx
        zEquyYUf63asE1NjlFNnwn8WOl61k0RxCgTVVAzyIbcwmRP3HMziv1gyW/Spta2C
        nE4TQ5PdOaRQMDzeTZT8r+LQp1KcYr1xaD2KjiVvrs/twucWhO+Jey86sTSIISWW
        qZshPnP+pM8=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 8342580563;
        Thu, 20 Apr 2017 23:41:33 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id E740980562;
        Thu, 20 Apr 2017 23:41:32 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 00/15] Handle fopen() errors
References: <20170420112609.26089-1-pclouds@gmail.com>
        <xmqqlgqu7cq8.fsf@gitster.mtv.corp.google.com>
Date:   Thu, 20 Apr 2017 20:41:32 -0700
In-Reply-To: <xmqqlgqu7cq8.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
        message of "Thu, 20 Apr 2017 18:47:59 -0700")
Message-ID: <xmqqk26e5swj.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 699CE0B6-2644-11E7-9CF2-C260AE2156B6-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> I wonder if it is OK to only special case ENOENT for !fp cases,
> where existing code silently returns.  Perhaps it is trying to read
> an optional file, and it returns silently because lack of it is
> perfectly OK for the purpose of the code.  Are there cases where
> this optional file is inside an optional directory, leading to
> ENOTDIR, instead of ENOENT, observed and reported by your check?

"git grep -B1 warn_on_inaccessible" is enlightening.  I wonder if we
want to wrap the two lines into a hard to misuse helper function,
something along this line.  Would having this patch as a preparatory
step shrink your series?  The patch count would be the same, but you
wouldn't be writing "if (errno != ENOENT)" lines yourself.

 attr.c            | 3 +--
 git-compat-util.h | 3 +++
 wrapper.c         | 6 ++++++
 3 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/attr.c b/attr.c
index 1fcf042b87..f695ded53f 100644
--- a/attr.c
+++ b/attr.c
@@ -373,8 +373,7 @@ static struct attr_stack *read_attr_from_file(const char *path, int macro_ok)
 	int lineno = 0;
 
 	if (!fp) {
-		if (errno != ENOENT && errno != ENOTDIR)
-			warn_on_inaccessible(path);
+		warn_failure_to_read_open_optional_path(path);
 		return NULL;
 	}
 	res = xcalloc(1, sizeof(*res));
diff --git a/git-compat-util.h b/git-compat-util.h
index 8a4a3f85e7..998366c628 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -1094,6 +1094,9 @@ int access_or_die(const char *path, int mode, unsigned flag);
 /* Warn on an inaccessible file that ought to be accessible */
 void warn_on_inaccessible(const char *path);
 
+/* Call the above after fopen/open fails for optional input */
+void warn_failure_to_read_open_optional_path(const char *);
+
 #ifdef GMTIME_UNRELIABLE_ERRORS
 struct tm *git_gmtime(const time_t *);
 struct tm *git_gmtime_r(const time_t *, struct tm *);
diff --git a/wrapper.c b/wrapper.c
index 0542fc7582..172cb9fad6 100644
--- a/wrapper.c
+++ b/wrapper.c
@@ -576,6 +576,12 @@ int remove_or_warn(unsigned int mode, const char *file)
 	return S_ISGITLINK(mode) ? rmdir_or_warn(file) : unlink_or_warn(file);
 }
 
+void warn_failure_to_read_open_optional_path(const char *path)
+{
+	if (errno != ENOENT && errno != ENOTDIR)
+		warn_on_inaccessible(path);
+}
+
 void warn_on_inaccessible(const char *path)
 {
 	warning_errno(_("unable to access '%s'"), path);
