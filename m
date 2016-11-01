Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,
	STOX_REPLY_TYPE shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C184F20229
	for <e@80x24.org>; Tue,  1 Nov 2016 20:50:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752150AbcKAUuZ (ORCPT <rfc822;e@80x24.org>);
        Tue, 1 Nov 2016 16:50:25 -0400
Received: from smtp-out-2.talktalk.net ([62.24.135.66]:56550 "EHLO
        smtp-out-2.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751563AbcKAUuY (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Nov 2016 16:50:24 -0400
Received: from PhilipOakley ([92.22.77.238])
        by smtp.talktalk.net with SMTP
        id 1g0jczY73g5ct1g0jclC7n; Tue, 01 Nov 2016 20:50:22 +0000
X-Originating-IP: [92.22.77.238]
X-Spam: 0
X-OAuthority: v=2.2 cv=bdMpa6HB c=1 sm=1 tr=0 a=x3tYpWevBceDNTPbB0rC5A==:117
 a=x3tYpWevBceDNTPbB0rC5A==:17 a=IkcTkHD0fZMA:10 a=PKzvZo6CAAAA:8
 a=GZVtDt-L_emhOkbQmScA:9 a=QEXdDO2ut3YA:10 a=q92HNjYiIAC_jH7JDaYf:22
Message-ID: <7CE3166CFD244DAABF554451E8B0800F@PhilipOakley>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
From:   "Philip Oakley" <philipoakley@iee.org>
To:     "Jeff King" <peff@peff.net>, "Halde, Faiz" <fhalde@paypal.com>
Cc:     <git@vger.kernel.org>
References: <BY2PR0601MB16400EAC3E9683841907F4B2A2A10@BY2PR0601MB1640.namprd06.prod.outlook.com> <20161101174526.e2tilsriz2fqaru3@sigill.intra.peff.net>
Subject: Re: Git issue
Date:   Tue, 1 Nov 2016 20:50:23 -0000
Organization: OPDS
MIME-Version: 1.0
Content-Type: text/plain;
        format=flowed;
        charset="UTF-8";
        reply-type=original
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
X-CMAE-Envelope: MS4wfCJMlceNZUSMhITm5HNDjVyjxlhk6u9Rnazpwd6/s1/vO90QiZThJCgpU3XDOTBhCsyOo0cMgrCs13KFIcpz0PgGQpZcO8H3wEtbS8wWjlB/wCNIQGn9
 GQRBrJQcA67Qz8kkum+Y6bwhBGtKWsLqwT/k1njDUZ6YxwzgN1ARZ0IVDC8Krq0kv27oVa5ozEkzSFyxNRkEU4YOwnzzQ/SjYsESnDr50jPnTg6qxgT/QNKD
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: "Jeff King" <peff@peff.net>
> On Tue, Nov 01, 2016 at 10:28:57AM +0000, Halde, Faiz wrote:
>
>> I frequently use the following command to ignore changes done in a file
>>
>> git update-index --assume-unchanged somefile
>>
>> Now when I do a pull from my remote branch and say the file 'somefile'
>> was changed locally and in remote, git will abort the merge saying I
>> need to commit my changes of 'somefile'.
>>
>> But isn't the whole point of the above command to ignore the changes
>> within the file?
>
> No. The purpose of --assume-unchanged is to promise git that you will
> not change the file, so that it may skip checking the file contents in
> some cases as an optimization.

True. However...

>
> From "git help update-index":
>
>      --[no-]assume-unchanged
>    When this flag is specified, the object names recorded for
>    the paths are not updated. Instead, this option sets/unsets
>    the "assume unchanged" bit for the paths. When the "assume
>    unchanged" bit is on, the user promises not to change the
>    file and allows Git to assume that the working tree file
>    matches what is recorded in the index. If you want to change
>    the working tree file, you need to unset the bit to tell Git.
>    This is sometimes helpful when working with a big project on
>    a filesystem that has very slow lstat(2) system call (e.g.
>    cifs).
>
>    Git will fail (gracefully) in case it needs to modify this
>    file in the index e.g. when merging in a commit; thus, in
>    case the assumed-untracked file is changed upstream, you will
>    need to handle the situation manually.
>

The whole section (including the ones above this quote) are often confused 
between the promises of the user, and the alleged promises of Git. Even in 
the quote above the "Instead" probably shouldn't be there.

Given the number of misrepresentations (on the web) of what the bit does, 
and the ongoing misunderstandings of users it does feel like the man page 
article could be refreshed to be more assertive about the users promise, and 
Git's cautions.

My quick rough working on a more assertive update..
-- >8 --
----------------------  
Documentation/git-update-index.txt ----------------------
index 7386c93..4ec1711 100644
@@ -84,12 +84,12 @@ OPTIONS
         Set the execute permissions on the updated files.

 --[no-]assume-unchanged::
  When this flag is specified, the object names recorded
- for the paths are not updated.  Instead, this option
+ for the paths are not updated.  This option
  sets/unsets the "assume unchanged" bit for the
  paths.  When the "assume unchanged" bit is on, the user
- promises not to change the file and allows Git to assume
+ *promises* not to change the file and allows Git to assume
  that the working tree file matches what is recorded in
  the index.  If you want to change the working tree file,
  you need to unset the bit to tell Git.  This is
  sometimes helpful when working with a big project on a
@@ -300,19 +300,25 @@ $ git ls-files -s

 Using ``assume unchanged'' bit
 ------------------------------

-Many operations in Git depend on your filesystem to have an
+Many operations in Git depend on your filesystem having a fast and
 efficient `lstat(2)` implementation, so that `st_mtime`
 information for working tree files can be cheaply checked to see
 if the file contents have changed from the version recorded in
 the index file.  Unfortunately, some filesystems have
 inefficient `lstat(2)`.  If your filesystem is one of them, you
-can set "assume unchanged" bit to paths you have not changed to
-cause Git not to do this check.  Note that setting this bit on a
-path does not mean Git will check the contents of the file to
-see if it has changed -- it makes Git to omit any checking and
-assume it has *not* changed.  When you make changes to working
+can set "assume unchanged" bit to *paths you have not changed* to
+cause Git not to do this check.
+
+Note that setting this bit on a
+path does not mean Git will never check the contents of the file to
+see if it has changed. Though normally it makes Git to omit any checking to
+assume it has not changed.
+Commands which may overwrite local changes (pull/merge etc) are
+likely to check if the contents have changed
+
+If you make desired changes to working
 tree files, you have to explicitly tell Git about it by dropping
 "assume unchanged" bit, either before or after you modify them.

 In order to set "assume unchanged" bit, use `--assume-unchanged`
---
Philip 

