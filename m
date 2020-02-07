Return-Path: <SRS0=Q4JT=33=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCAD0C2BA83
	for <git@archiver.kernel.org>; Fri,  7 Feb 2020 18:34:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0F1821741
	for <git@archiver.kernel.org>; Fri,  7 Feb 2020 18:34:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="eZ8o1fRR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727154AbgBGSeA (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 7 Feb 2020 13:34:00 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:60761 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727131AbgBGSeA (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Feb 2020 13:34:00 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 66A3B54C88;
        Fri,  7 Feb 2020 13:33:58 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=UXYKHx67t0i6lMegSGxnCPky7w8=; b=eZ8o1f
        RR0hq6NEg2HHH5MaqenHCVNbaZ3ESYuvqYcaS5fKegwWZ6vFb337fLNExbVGVSgS
        9nxl0t5ZrMhU9NBYTJ6X8kOH/aSRghY1qRNRrehC9I4PXKvyXqSiCNMlEStZULDf
        1sOLOi+ZN3SjxdoOJyglbpJLwtoE1L/PQvsgs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=vi+T6nHxWxG04LxXuCkOWM0l4sy+CPCW
        DOvJ+/zSplv7kMeeojRAgzx8QwmpVY6PVMrLWJ3t8VUBqOc3HmV/lrr69edQ1J27
        frAdsnB0o8h7JPvrpKNNfbTWrpn6oI07oreqalYIO9kvLJ0uklRa5GfJosX9EtB1
        L+zxVv+Mb9Q=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 5DDD654C87;
        Fri,  7 Feb 2020 13:33:58 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id C805D54C84;
        Fri,  7 Feb 2020 13:33:57 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Markus Klein <masmiseim@gmx.de>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org,
        "Markus Klein via GitGitGadget" <gitgitgadget@gmail.com>
Subject: Re: [PATCH v2] clone: use submodules.recurse option for automatically clone submodules
References: <pull.695.git.git.1580505092071.gitgitgadget@gmail.com>
        <pull.695.v2.git.git.1580851963616.gitgitgadget@gmail.com>
        <xmqq1rr7fsh3.fsf@gitster-ct.c.googlers.com>
Date:   Fri, 07 Feb 2020 10:33:56 -0800
In-Reply-To: <xmqq1rr7fsh3.fsf@gitster-ct.c.googlers.com> (Junio C. Hamano's
        message of "Thu, 06 Feb 2020 11:03:52 -0800")
Message-ID: <xmqqa75u457v.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 67049834-49D8-11EA-815D-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> So, I would sort-of understand if you pretend --recurse-submodules
> was given from the command line when submodule.recurse is set to
> true (which would mean that you'd append "." to the string list).
> But I do not understand why appending "true" is a good thing at all
> here.
>
> Another thing I noticed.
>
> If you have "[submodule] recurse" in your $HOME/.gitconfig, you'd
> want to be able to countermand from the command line with
>
>     git clone --no-recurse-submodules ...
>
> so that the clone would not go recursive.  And that should be
> tested.  
>
> You'd also want the opposite, i.e. with "[submodule] recurse=no" in
> your $HOME/.gitconfig and running
>
>     git clone --recurse-submodules ...
>
> should countermand the configuration.


Totally untested, but just to illustrate the approach, here is a
sample patch to implement "Pretend --recurse-submodules=. is set on
the command line when submodule.recurse is set (in the 'last one
wins' sense) and there is no --recurse-submodules command line
option."  It should outline the right interactions between the
command line options and configuration variable, like allowing "git
clone --no-recurse-submodules" to defeat submodule.recurse
configuration.

Not that I agree that "[submodules] recurse" set in the
$HOME/.gitconfig should affect "git clone".  It is merely to
illustrate how it could be done, if it were a good idea.

 builtin/clone.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/builtin/clone.c b/builtin/clone.c
index 0fc89ae2b9..163803d89e 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -32,6 +32,7 @@
 #include "connected.h"
 #include "packfile.h"
 #include "list-objects-filter-options.h"
+#include "submodule.h"
 
 /*
  * Overall FIXMEs:
@@ -71,6 +72,8 @@ static struct list_objects_filter_options filter_options;
 static struct string_list server_options = STRING_LIST_INIT_NODUP;
 static int option_remote_submodules;
 
+static int recurse_submodules_option_given;
+
 static int recurse_submodules_cb(const struct option *opt,
 				 const char *arg, int unset)
 {
@@ -81,7 +84,7 @@ static int recurse_submodules_cb(const struct option *opt,
 	else
 		string_list_append((struct string_list *)opt->value,
 				   (const char *)opt->defval);
-
+	recurse_submodules_option_given = 1;
 	return 0;
 }
 
@@ -929,6 +932,13 @@ static int path_exists(const char *path)
 	return !stat(path, &sb);
 }
 
+static int git_clone_config(const char *var, const char *value, void *cb)
+{
+	if (starts_with(var, "submodule."))
+		return git_default_submodule_config(var, value, NULL);
+	return git_default_config(var, value, cb);
+}
+
 int cmd_clone(int argc, const char **argv, const char *prefix)
 {
 	int is_bundle = 0, is_local;
@@ -1103,7 +1113,9 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 
 	write_config(&option_config);
 
-	git_config(git_default_config, NULL);
+	git_config(git_clone_config, NULL);
+	if (!recurse_submodules_option_given && should_update_submodules())
+		string_list_append(&option_recurse_submodules, ".");
 
 	if (option_bare) {
 		if (option_mirror)
