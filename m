From: Johan Herland <johan@herland.net>
Subject: Re: mac test failure -- test 3301
Date: Tue, 11 Nov 2014 02:40:19 +0100
Message-ID: <CALKQrgexnrCy-P6yTZB+U0--5peaTys9KqB+KGKqbAuyLA=NqA@mail.gmail.com>
References: <CAO2U3QhiWVvVKivBhE5R2xhjf8SPPtg6VSaQMxw7vbm_454jBQ@mail.gmail.com>
	<CAPig+cRxCj82F5aak0Y+Ce_SvUETtQ5dwM1RtzjUUvwtJ=WPYw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Michael Blume <blume.mike@gmail.com>,
	Git List <git@vger.kernel.org>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Tue Nov 11 02:40:36 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xo0Re-0005Dg-RP
	for gcvg-git-2@plane.gmane.org; Tue, 11 Nov 2014 02:40:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751298AbaKKBka (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Nov 2014 20:40:30 -0500
Received: from mail12.copyleft.no ([188.94.218.224]:54328 "EHLO
	mail12.copyleft.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751218AbaKKBk3 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Nov 2014 20:40:29 -0500
Received: from locusts.copyleft.no ([188.94.218.116] helo=mail.mailgateway.no)
	by mail12.copyleft.no with esmtp (Exim 4.76)
	(envelope-from <johan@herland.net>)
	id 1Xo0RW-0005tx-OZ
	for git@vger.kernel.org; Tue, 11 Nov 2014 02:40:27 +0100
Received: from mail-pa0-f44.google.com ([209.85.220.44])
	by mail.mailgateway.no with esmtpsa (TLSv1:RC4-SHA:128)
	(Exim 4.72 (FreeBSD))
	(envelope-from <johan@herland.net>)
	id 1Xo0RW-0004mT-EH
	for git@vger.kernel.org; Tue, 11 Nov 2014 02:40:26 +0100
Received: by mail-pa0-f44.google.com with SMTP id bj1so9502518pad.17
        for <git@vger.kernel.org>; Mon, 10 Nov 2014 17:40:19 -0800 (PST)
X-Received: by 10.68.69.7 with SMTP id a7mr7900518pbu.151.1415670019585; Mon,
 10 Nov 2014 17:40:19 -0800 (PST)
Received: by 10.70.68.3 with HTTP; Mon, 10 Nov 2014 17:40:19 -0800 (PST)
In-Reply-To: <CAPig+cRxCj82F5aak0Y+Ce_SvUETtQ5dwM1RtzjUUvwtJ=WPYw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 11, 2014 at 2:19 AM, Eric Sunshine <sunshine@sunshineco.com> wrote:
> On Mon, Nov 10, 2014 at 7:17 PM, Michael Blume <blume.mike@gmail.com> wrote:
>> the commit modernizing test 3301
>> (https://github.com/git/git/commit/fbe4f74865acfd) appears to break it
>> on my mac
>>
>> $ ./t3301-notes.sh -v
>> expecting success:
>> MSG=b4 git notes add &&
>> test_path_is_missing .git/NOTES_EDITMSG &&
>> test "1" = "$(git ls-tree refs/notes/commits | wc -l)" &&
>> test "b4" = "$(git notes show)" &&
>> git show HEAD^ &&
>> test_must_fail git notes show HEAD^
>>
>> b4
>> not ok 8 - create notes
>
> This and all other failures are due to the output of 'wc -l', which on
> Mac is "{whitespace}1" rather than just "1" as it is on other
> platforms. fbe4f748 added quotes around the $(... | wc -l) invocation
> which caused the whitespace to be retained. A minimum fix would be to
> drop the quotes surrounding $().

Ah, thanks!

I thought that quoting command output was a good idea in general. Am I
wrong, or is this just one exception to an otherwise good guideline?

Anyway, here is the minimal diff to remove quoting from the $(... | wc
-l) commands (probably whitespace damaged by GMail - sorry). Junio:
feel free to squash this in, or ask for a re-roll:

diff --git a/t/t3301-notes.sh b/t/t3301-notes.sh
index cd756ec..2c8abbc 100755
--- a/t/t3301-notes.sh
+++ b/t/t3301-notes.sh
@@ -52,7 +52,7 @@ test_expect_success 'show non-existent notes entry with %N' '
 test_expect_success 'create notes' '
     MSG=b4 git notes add &&
     test_path_is_missing .git/NOTES_EDITMSG &&
-    test "1" = "$(git ls-tree refs/notes/commits | wc -l)" &&
+    test "1" = $(git ls-tree refs/notes/commits | wc -l) &&
     test "b4" = "$(git notes show)" &&
     git show HEAD^ &&
     test_must_fail git notes show HEAD^
@@ -75,7 +75,7 @@ test_expect_success 'create reflog entry' '
 test_expect_success 'edit existing notes' '
     MSG=b3 git notes edit &&
     test_path_is_missing .git/NOTES_EDITMSG &&
-    test "1" = "$(git ls-tree refs/notes/commits | wc -l)" &&
+    test "1" = $(git ls-tree refs/notes/commits | wc -l) &&
     test "b3" = "$(git notes show)" &&
     git show HEAD^ &&
     test_must_fail git notes show HEAD^
@@ -84,7 +84,7 @@ test_expect_success 'edit existing notes' '
 test_expect_success 'cannot "git notes add -m" where notes already exists' '
     test_must_fail git notes add -m "b2" &&
     test_path_is_missing .git/NOTES_EDITMSG &&
-    test "1" = "$(git ls-tree refs/notes/commits | wc -l)" &&
+    test "1" = $(git ls-tree refs/notes/commits | wc -l) &&
     test "b3" = "$(git notes show)" &&
     git show HEAD^ &&
     test_must_fail git notes show HEAD^
@@ -93,7 +93,7 @@ test_expect_success 'cannot "git notes add -m" where
notes already exists' '
 test_expect_success 'can overwrite existing note with "git notes add -f -m"' '
     git notes add -f -m "b1" &&
     test_path_is_missing .git/NOTES_EDITMSG &&
-    test "1" = "$(git ls-tree refs/notes/commits | wc -l)" &&
+    test "1" = $(git ls-tree refs/notes/commits | wc -l) &&
     test "b1" = "$(git notes show)" &&
     git show HEAD^ &&
     test_must_fail git notes show HEAD^
@@ -102,7 +102,7 @@ test_expect_success 'can overwrite existing note
with "git notes add -f -m"' '
 test_expect_success 'add w/no options on existing note morphs into edit' '
     MSG=b2 git notes add &&
     test_path_is_missing .git/NOTES_EDITMSG &&
-    test "1" = "$(git ls-tree refs/notes/commits | wc -l)" &&
+    test "1" = $(git ls-tree refs/notes/commits | wc -l) &&
     test "b2" = "$(git notes show)" &&
     git show HEAD^ &&
     test_must_fail git notes show HEAD^
@@ -111,7 +111,7 @@ test_expect_success 'add w/no options on existing
note morphs into edit' '
 test_expect_success 'can overwrite existing note with "git notes add -f"' '
     MSG=b1 git notes add -f &&
     test_path_is_missing .git/NOTES_EDITMSG &&
-    test "1" = "$(git ls-tree refs/notes/commits | wc -l)" &&
+    test "1" = $(git ls-tree refs/notes/commits | wc -l) &&
     test "b1" = "$(git notes show)" &&
     git show HEAD^ &&
     test_must_fail git notes show HEAD^


...Johan

-- 
Johan Herland, <johan@herland.net>
www.herland.net
