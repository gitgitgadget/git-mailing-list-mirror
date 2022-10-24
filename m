Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DA76C38A2D
	for <git@archiver.kernel.org>; Mon, 24 Oct 2022 21:03:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231902AbiJXVDa (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 24 Oct 2022 17:03:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229706AbiJXVDH (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Oct 2022 17:03:07 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A04655F9D
        for <git@vger.kernel.org>; Mon, 24 Oct 2022 12:08:38 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id A0F84150DA8;
        Mon, 24 Oct 2022 14:51:05 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=1EiLQwc6y1WjskgD1grdeDs5ZmGJS6lm5RgQXP
        V7D2o=; b=dWABMd75PiVWke0SFXSfcpudHVObylYpW1l+B1WF7khixF/n8H3wrO
        U5lO7cDgB8Gp0WQ9Yf6pfhzD3b9SZDZa2P5W3K9sK3pC6iWlpmqNkYHROaX8ay5U
        7671qbyK8BNIczWoStDqE0q/zJy+/W/L3zv6vajlna+lvAEwA71RI=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 7A65F150DA7;
        Mon, 24 Oct 2022 14:51:05 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.5.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 794DD150DA6;
        Mon, 24 Oct 2022 14:51:04 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "John Cai via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, John Cai <johncai86@gmail.com>
Subject: Re: [PATCH 0/2] Document fsck msg ids
References: <pull.1369.git.git.1666623639.gitgitgadget@gmail.com>
Date:   Mon, 24 Oct 2022 11:51:03 -0700
In-Reply-To: <pull.1369.git.git.1666623639.gitgitgadget@gmail.com> (John Cai
        via GitGitGadget's message of "Mon, 24 Oct 2022 15:00:36 +0000")
Message-ID: <xmqqpmehrr6w.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: CFEBC628-53CC-11ED-A90C-2AEEC5D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Here is to illustrate what I meant in my review comments on [2/2],
on top of these two patches.

Two structural changes worth noting are:

- I removed the inclusin from config/fsck.txt because otherwise the
  entry for fsck.<msg-id> becomes way too long and the next entry,
  fsck.skipList, may become harder to find.  But I am OK if you
  really want to make the list of msgids a sublist here, as long as
  it makes it clear that those with default severity FATAL cannot be
  configured away.  That has to be done outside of fsck-msgids.txt
  file (in other words, in config/fsck.txt where it includes the
  file) as it would be a good idea to keep the file a "pure" list,
  to keep it easy to auto-generate in the future.

- The description of each item begins with (SEVERITY) marking, as
  the ones that are (FATAL) cannot be configured.

I think I added all error types that your patch missed.  Also I
added (FATAL)/(ERROR)/(WARN)/(INFO) markings to show what their
default severity levels are, but I may have made mistakes.

If you want to take any part of these changes, feel free to do so,
but please do so after double checking.  This was primarily done to
illustrate how the end result should look like if I were doing this
topic, and not to show how each item should be described exactly.

Thanks.

 Documentation/config/fsck.txt |   5 +-
 Documentation/fsck-msgids.txt | 188 ++++++++++++++++++++++--------------------
 Documentation/git-fsck.txt    |  12 +++
 fsck.h                        |   6 ++
 4 files changed, 119 insertions(+), 92 deletions(-)

diff --git c/Documentation/config/fsck.txt w/Documentation/config/fsck.txt
index b0632075f2..a3c865df56 100644
--- c/Documentation/config/fsck.txt
+++ w/Documentation/config/fsck.txt
@@ -36,10 +36,9 @@ Setting an unknown `fsck.<msg-id>` value will cause fsck to die, but
 doing the same for `receive.fsck.<msg-id>` and `fetch.fsck.<msg-id>`
 will only cause git to warn.
 +
-The following `<msg-id>` are supported:
-+
+See `Fsck Messages` section of linkgit:git-fsck[1] for supported
+values of `<msg-id>`.
 
-include::../fsck-msgids.txt[]
 
 fsck.skipList::
 	The path to a list of object names (i.e. one unabbreviated SHA-1 per
diff --git c/Documentation/fsck-msgids.txt w/Documentation/fsck-msgids.txt
index 888fa3308b..6831982bdb 100644
--- c/Documentation/fsck-msgids.txt
+++ w/Documentation/fsck-msgids.txt
@@ -1,133 +1,143 @@
---
-`badDate`;;
-	Invalid date format in an author/committer line.
+`badDate`::
+	(ERROR) Invalid date format in an author/committer line.
 
-`badEmail`;;
-	Invalid email format in an author/committer line.
+`badDateOverflow`::
+	(ERROR) Invalid date value in an author/committer line.
 
-`badFilemode`;;
-	A tree contains a bad filemode entry.
+`badEmail`::
+	(ERROR) Invalid email format in an author/committer line.
 
-`badName`;;
-	An author/committer name is empty.
+`badFilemode`::
+	(INFO) A tree contains a bad filemode entry.
 
-`badObjectSha1`;;
-	An object has a bad sha1.
+`badName`::
+	(ERROR) An author/committer name is empty.
 
-`badParentSha1`;;
-	A commit object has a bad parent sha1.
+`badObjectSha1`::
+	(ERROR) An object has a bad sha1.
 
-`badTagName`;;
-	A tag has an invalid format.
+`badParentSha1`::
+	(ERROR) A commit object has a bad parent sha1.
 
-`badTimezone`;;
-	Found an invalid time zone in an author/committer line.
+`badTagName`::
+	(INFO) A tag has an invalid format.
 
-`badTree`;;
-	A tree cannot be parsed.
+`badTimezone`::
+	(ERROR) Found an invalid time zone in an author/committer line.
 
-`badTreeSha1`;;
-	A tree has an invalid format.
+`badTree`::
+	(ERROR) A tree cannot be parsed.
 
-`badType`;;
-	Found an invalid object type.
+`badTreeSha1`::
+	(ERROR) A tree has an invalid format.
 
-`duplicateEntries`;;
-	A tree contains duplicate file entries.
+`badType`::
+	(ERROR) Found an invalid object type.
 
-`emptyName`;;
-	A path contains an empty name.
+`duplicateEntries`::
+	(ERROR) A tree contains duplicate file entries.
 
-`fullPathName`;;
-	A path contains the full path starting with "/".
+`emptyName`::
+	(WARN) A path contains an empty name.
 
-`gitAttributesSymlink`;;
-	`.gitattributes` is a symlink.
+`fullPathName`::
+	(WARN) A path contains the full path starting with "/".
 
-`gitignoreSymlink`;;
-	`.gitignore` is a symlink.
+`gitAttributesSymlink`::
+	(INFO) `.gitattributes` is a symlink.
 
-`gitmodulesBlob`;;
-	A non-blob found at `.gitmodules`.
+`gitignoreSymlink`::
+	(INFO) `.gitignore` is a symlink.
 
-`gitmodulesMissing`;;
-	Unable to read `.gitmodules` blob.
+`gitmodulesBlob`::
+	(ERROR) A non-blob found at `.gitmodules`.
 
-`gitmodulesName`;;
-	A submodule name is invalid.
+`gitmodulesMissing`::
+	(ERROR) Unable to read `.gitmodules` blob.
 
-`gitmodulesParse`;;
-	Could not parse `.gitmodules` blob.
+`gitmodulesName`::
+	(ERROR) A submodule name is invalid.
+
+`gitmodulesParse`::
+	(INFO) Could not parse `.gitmodules` blob.
 
 `gitmodulesLarge`;
-	`.gitmodules` blob is too large to parse.
+	(ERROR) `.gitmodules` blob is too large to parse.
+
+`gitmodulesPath`::
+	(ERROR) `.gitmodules` path is invalid.
+
+`gitmodulesSymlink`::
+	(ERROR) `.gitmodules` is a symlink.
+
+`gitmodulesUpdate`::
+	(ERROR) Found an invalid submodule update setting.
 
-`gitmodulesPath`;;
-	`.gitmodules` path is invalid.
+`gitmodulesUrl`::
+	(ERROR) Found an invalid submodule url.
 
-`gitmodulesSymlink`;;
-	`.gitmodules` is a symlink.
+`hasDot`::
+	(WARN) A tree contains an entry named `.`.
 
-`gitmodulesUpdate`;;
-	Found an invalid submodule update setting.
+`hasDotdot`::
+	(WARN) A tree contains an entry named `..`.
 
-`gitmodulesUrl`;;
-	Found an invalid submodule url.
+`hasDotgit`::
+	(WARN) A tree contains an entry named `.git`.
 
-`hasDot`;;
-	A tree contains an entry named `.`.
+`mailmapSymlink`::
+	(WARN) `.mailmap` is a symlink.
 
-`hasDotdot`;;
-	A tree contains an entry named `..`.
+`missingAuthor`::
+	(ERROR) Author is missing.
 
-`hasDotgit`;;
-	A tree contains an entry named `.git`.
+`missingCommitter`::
+	(ERROR) Committer is missing.
 
-`mailmapSymlink`;;
-	`.mailmap` is a symlink.
+`missingEmail`::
+	(ERROR) Email is missing in an author/committer line.
 
-`missingAuthor`;;
-	Author is missing.
+`missingNameBeforeEmail`::
+	(ERROR) Missing name before an email in an author/committer line.
 
-`missingCommitter`;;
-	Committer is missing.
+`missingObject`::
+	(ERROR) Missing `object` line in tag object.
 
-`missingEmail`;;
-	Email is missing in an author/committer line.
+`missingSpaceBeforeDate`::
+	(ERROR) Missing space before date in an author/committer line.
 
-`missingNameBeforeEmail`;;
-	Missing space before an email in an author/committer line.
+`missingSpaceBeforeEmail`::
+	(ERROR) Missing space before the email in author/committer line.
 
-`missingObject`;;
-	Missing `object` line in tag object.
+`missingTag`::
+	(ERROR) Unexpected end after `type` line in a tag object.
 
-`missingSpaceBeforeDate`;;
-	Missing space before date in an author/committer line.
+`missingTagEntry`::
+	(ERROR) Missing `tag` line in a tag object.
 
-`missingSpaceBeforeEmail`;;
-	Missing space before the email in author/committer line.
+`missingTypeEntry`::
+	(ERROR) Missing `type` line in a tag object.
 
-`missingTag`;;
-	Unexpected end after `type` line in a tag object.
+`multipleAuthors`::`
+	(ERROR) Multiple author lines found in a commit.
 
-`missingTypeEntry`;;
-	Missing `type` line in a tag object.
+`nulInCommit`::
+	(WARN) Found a NUL byte in the commit object body.
 
-`multipleAuthors`;;`
-	Multiple author lines found in a commit.
+`nulInHeader`::
+	(FATAL) NUL byte exists in the object header.
 
-`nulInCommit`;;
-	Found a NUL byte in the commit object body.
+`treeNotSorted`::
+	(ERROR) A tree is not properly sorted.
 
-`treeNotSorted`;;
-	A tree is not properly sorted.
+`unknownType`::
+	(ERROR) Found an unknown object type.
 
-`unknownType`;;
-	Found an unknown object type.
+`unterminatedHeader`::
+	(FATAL) Missing end-of-line in the object header.
 
-`zeroPaddingDate`;;
-	Found a zero padded date in an author/commiter line.
+`zeroPaddingDate`::
+	(ERROR) Found a zero padded date in an author/commiter line.
 
-`zeroPaddedFilemode`;;
-	Found a zero padded filemode in a tree.
---
+`zeroPaddedFilemode`::
+	(WARN) Found a zero padded filemode in a tree.
diff --git c/Documentation/git-fsck.txt w/Documentation/git-fsck.txt
index 29318ea957..8124ae2e67 100644
--- c/Documentation/git-fsck.txt
+++ w/Documentation/git-fsck.txt
@@ -152,6 +152,18 @@ hash mismatch <object>::
 	object database value.
 	This indicates a serious data integrity problem.
 
+
+FSCK MESSAGES
+-------------
+
+The following lists the types of errors `git fsck` detects and what
+each error means, with their default severity.  The severity of the
+errors, other than those that are marked as "(FATAL)", can be tweaked
+by setting corresponding `fsck.<msg-id>` configuration variable.
+
+include::fsck-msgids.txt[]
+
+
 Environment Variables
 ---------------------
 
diff --git c/fsck.h w/fsck.h
index 7d99f6ea33..1fb26c4868 100644
--- c/fsck.h
+++ w/fsck.h
@@ -13,6 +13,12 @@ enum fsck_msg_type {
 	FSCK_WARN,
 };
 
+/*
+ * Documentation/fsck-msgids.txt is meant to document these; when
+ * modifying this list in any way, make sure to make corresponding
+ * changes there, too, to keep them in sync.
+ */
+
 #define FOREACH_FSCK_MSG_ID(FUNC) \
 	/* fatal errors */ \
 	FUNC(NUL_IN_HEADER, FATAL) \
