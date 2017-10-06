Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 57E941FA21
	for <e@80x24.org>; Fri,  6 Oct 2017 05:53:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750815AbdJFFxm (ORCPT <rfc822;e@80x24.org>);
        Fri, 6 Oct 2017 01:53:42 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:56918 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750732AbdJFFxl (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Oct 2017 01:53:41 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id AC8CC9CC19;
        Fri,  6 Oct 2017 01:53:40 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=B3IQuPzx9xGkIxzlWEmWHts3eeA=; b=AYHNle
        oZP2JDqe6ZLPOGLQRB2lRmd2I3/u2tL9pVqCmfP84ocX/kikquQBH5Ect4ZJbesC
        ah+7YGtcLN0O6c3QmisruDjlHUHy2pvQj5z36gIwzIEDbJQOk9e6dENDq5I7wz/a
        i1aM+tHV60bfm9nkE4yoLIPXdKdCrFlDLZeBg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=R8qCbEv4uSrdi/4mcRgK/0tlzT0EDOgr
        xksOm8YzeQADKG3tD6woiJnvFEEOznTh39Nd8d+gOzXW4EM/ePwvQ2zVehL7Z7qZ
        EuS9AG0fbbgURm9WrKNK2Jo/n/X8pHJ8vAnm60GyHwjXM1duNljwNsG9vngRqyAG
        7fRiZf8Dcng=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id A54849CC17;
        Fri,  6 Oct 2017 01:53:40 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 1E2009CC16;
        Fri,  6 Oct 2017 01:53:40 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Damien =?utf-8?Q?Mari=C3=A9?= <damien@dam.io>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v2] run-command: add hint when a hook is ignored
References: <0102015ee1e41f17-927a8da1-ac14-4399-8424-fee8a82c2b0a-000000@eu-west-1.amazonses.com>
        <0102015eee503678-52126849-7580-4832-9d46-0f5ac7a52336-000000@eu-west-1.amazonses.com>
        <xmqq4lrcyj1p.fsf@gitster.mtv.corp.google.com>
Date:   Fri, 06 Oct 2017 14:53:38 +0900
In-Reply-To: <xmqq4lrcyj1p.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
        message of "Fri, 06 Oct 2017 13:52:34 +0900")
Message-ID: <xmqqh8vcx1nh.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B3F99434-AA5A-11E7-A05D-8EF31968708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> I think it is easier to reason about if this were not "else if", but
> just a simple "if".

And here are two small suggested changes to the code portion of your
patch.

 - break if / else if cascade into two independent if / if
   statements for clarity.

 - give the "ignored hook" advice only once per <process,hook>
   pair.



 run-command.c | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/run-command.c b/run-command.c
index 0f8a5f7fa2..0e60dd2075 100644
--- a/run-command.c
+++ b/run-command.c
@@ -5,6 +5,7 @@
 #include "argv-array.h"
 #include "thread-utils.h"
 #include "strbuf.h"
+#include "string-list.h"
 
 void child_process_init(struct child_process *child)
 {
@@ -1170,19 +1171,25 @@ const char *find_hook(const char *name)
 	strbuf_git_path(&path, "hooks/%s", name);
 	if (access(path.buf, X_OK) < 0) {
 		int err = errno;
+
 #ifdef STRIP_EXTENSION
 		strbuf_addstr(&path, STRIP_EXTENSION);
 		if (access(path.buf, X_OK) >= 0)
 			return path.buf;
-		else if (errno == EACCES)
+		if (errno == EACCES)
 			err = errno;
 #endif
 		if (err == EACCES && advice_ignored_hook) {
-			advise(_(
-				"The '%s' hook was ignored because "
-				"it's not set as executable.\n"
-				"You can disable this warning with "
-				"`git config advice.ignoredHook false`."), path.buf);
+			static struct string_list advise_given = STRING_LIST_INIT_DUP;
+
+			if (!string_list_lookup(&advise_given, name)) {
+				string_list_insert(&advise_given, name);
+				advise(_("The '%s' hook was ignored because "
+					 "it's not set as executable.\n"
+					 "You can disable this warning with "
+					 "`git config advice.ignoredHook false`."),
+				       path.buf);
+			}
 		}
 		return NULL;
 	}
-- 
2.15.0-rc0-155-g07e9c1a78d

