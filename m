Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DF0DC433C1
	for <git@archiver.kernel.org>; Mon, 22 Mar 2021 04:54:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 534A86196C
	for <git@archiver.kernel.org>; Mon, 22 Mar 2021 04:54:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229764AbhCVExo (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 22 Mar 2021 00:53:44 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:60982 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229621AbhCVExj (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Mar 2021 00:53:39 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 099D7AC5FA;
        Mon, 22 Mar 2021 00:53:39 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Oj2G0yOW3MltwfqEgfXgYXRiAZA=; b=IPjIB1
        kn/aiUpi+HiVOQjFMYbSeRebeqAV4IvaGwgccq06EbRQQOzXoQ2Npc7HI60d+qdI
        REnKaKPtmQoy6fv1YZ7VNCk9jpXSkVggxpj8n23Vh6a7mp2gWzjxYlYpzWzXgSoI
        vBemlmiyxhnNO+vv0SskouddCkST4MZ3kMWbI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=uN8WONadiRKoX0swC3+InmmbHQaKTYS2
        7+qW46dKlz7m6t/cpZUpUphISYAfK733Fr9ODzYlJneJjtsBmIVzBBM1wFCIHXog
        Kf3DzPag/xhCoDkxinFPVBwTgJ9/GIEypvfdyDff1yenpveTobCTDv8G6EeBDOSo
        PVXH4tQeweg=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 00362AC5F8;
        Mon, 22 Mar 2021 00:53:38 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 76AB4AC5F7;
        Mon, 22 Mar 2021 00:53:38 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Madhu <enometh@meer.net>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] init: don't reset core.filemode on git-new-workdirs.
References: <20210321.175821.1385189088303987287.enometh@meer.net>
        <xmqq1rc89nk7.fsf@gitster.g>
        <20210322.081043.1437207928602570397.enometh@meer.net>
Date:   Sun, 21 Mar 2021 21:53:37 -0700
In-Reply-To: <20210322.081043.1437207928602570397.enometh@meer.net> (Madhu's
        message of "Mon, 22 Mar 2021 08:10:43 +0530 (IST)")
Message-ID: <xmqq7dlz94by.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 90F63C54-8ACA-11EB-8903-D152C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Madhu <enometh@meer.net> writes:

>> I see that in a later part of the same function, we test if the
>> filesystem supports symbolic links but do so only when we are
>> running "git init" afresh.  Perhaps the filemode trustability check
>> and the config-set to record core.filemode should all be moved there
>> inside the "if (!reinit)" block.
>>
>> All of the above assumes that the problem being solved is about what
>> happens when "git init" is run in an already functioning working
>> tree.  If I misread what problem you are trying to solve, then none
>> of what I suggested in the above may apply.
>
> I think you have understood the problem.  At present But doing the
> filemode trustability check on .git/config assumes it is a regular
> file anyway if it is to work at all.  My suggestion in the patch only
> enforces that assumption explicitly.

There are two points we should consider.

 * Historically, we've used .git/config as the sample file to check,
   but that was not because we wanted to make sure we can chmod the
   config file, but because we knew the file has to be there.  If
   .git/config is sometimes a symbolic link, and if chmod test
   requires a regular file, we do not have to use .git/config as the
   sample file.  We could instead switch to use a different,
   temporary, file.  After all, the symlink check I pointed out in
   the message you are responding to uses a brand new temporary
   filename for that, and there is no reason why we shouldn't do the
   same with a regular file for the filemode test.

 * If running "git init" in an already functioning repository can be
   a useful way to "re-initialize" and/or "correct" various aspect
   of the repository (e.g. perhaps core.filemode is incorrectly set
   originally and running "git init" again corrects it), we would
   want to allow that in a normal repository as well as in a
   repository that is created by new-workdir the same way.  Or if it
   is not useful and we want "re-initialize" not to touch the
   filemode, we would want to skip the check in a normal repository
   as well as in a new-workdir repository the same way.  That is why
   "if symlink, then skip" is wrong---it targets the new-workdir
   case specifically.

I personally do not have a strong opinion either way, but to me, it
seems that "does the filesystem support filemode?" and "does the
filesystem support symbolic link?" are at about the same level and
should be treated similarly unless there is a good reason not to.
And the symlink check is never done in "reinit" case, so perhaps
when "git init" is run again in an already functioning repository,
we should not muck with the filemode, either.

A natural conclusion of the line of thought is that we can move the
"check filemode trustability" block (from the comment to concluding
git_config_set()) inside the "if (!reinit)" that happens a bit later
and we'd be fine---as an existing normal repository, as well as what
new-workdir creates, won't have to do the "let's chmod +x/-x the
config file and see what happens" code at all (perhaps the attached
patch, which hasn't even been compile tested).

On the other hand, if it is worth "fixing" the filemode setting
while re-initializing, we probably should switch to use a temporary
file instead of 'config'.  And we may want to reconsider the placement
of the "is symlink supported?" check---which may also have to be
redone to "fix" its existing value.


 builtin/init-db.c | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git c/builtin/init-db.c w/builtin/init-db.c
index dcc45bef51..61817a02a8 100644
--- c/builtin/init-db.c
+++ w/builtin/init-db.c
@@ -282,20 +282,6 @@ static int create_default_files(const char *template_path,
 
 	initialize_repository_version(fmt->hash_algo, 0);
 
-	/* Check filemode trustability */
-	path = git_path_buf(&buf, "config");
-	filemode = TEST_FILEMODE;
-	if (TEST_FILEMODE && !lstat(path, &st1)) {
-		struct stat st2;
-		filemode = (!chmod(path, st1.st_mode ^ S_IXUSR) &&
-				!lstat(path, &st2) &&
-				st1.st_mode != st2.st_mode &&
-				!chmod(path, st1.st_mode));
-		if (filemode && !reinit && (st1.st_mode & S_IXUSR))
-			filemode = 0;
-	}
-	git_config_set("core.filemode", filemode ? "true" : "false");
-
 	if (is_bare_repository())
 		git_config_set("core.bare", "true");
 	else {
@@ -309,6 +295,20 @@ static int create_default_files(const char *template_path,
 	}
 
 	if (!reinit) {
+		/* Check filemode trustability */
+		path = git_path_buf(&buf, "config");
+		filemode = TEST_FILEMODE;
+		if (TEST_FILEMODE && !lstat(path, &st1)) {
+			struct stat st2;
+			filemode = (!chmod(path, st1.st_mode ^ S_IXUSR) &&
+					!lstat(path, &st2) &&
+					st1.st_mode != st2.st_mode &&
+					!chmod(path, st1.st_mode));
+			if (filemode && !reinit && (st1.st_mode & S_IXUSR))
+				filemode = 0;
+		}
+		git_config_set("core.filemode", filemode ? "true" : "false");
+
 		/* Check if symlink is supported in the work tree */
 		path = git_path_buf(&buf, "tXXXXXX");
 		if (!close(xmkstemp(path)) &&
