From: Christoph Bonitz <ml.christophbonitz@gmail.com>
Subject: [PATCH] git p4 test: fix failure in 9814-git-p4-rename.sh Was: Re:
 Test failure in t9814-git-p4-rename.sh - my environment or bad test?
Date: Wed, 23 Jul 2014 23:28:13 +0200
Message-ID: <CABUJjW8TFCw2wwAO83vMBPc7vQc+rvuPOAca-CNECEduUn19Ew@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Pete Wyckoff <pw@padd.com>
X-From: git-owner@vger.kernel.org Wed Jul 23 23:28:21 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XA45C-0001yh-Qq
	for gcvg-git-2@plane.gmane.org; Wed, 23 Jul 2014 23:28:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933428AbaGWV2P (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Jul 2014 17:28:15 -0400
Received: from mail-vc0-f173.google.com ([209.85.220.173]:40702 "EHLO
	mail-vc0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933349AbaGWV2O (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Jul 2014 17:28:14 -0400
Received: by mail-vc0-f173.google.com with SMTP id hy10so3340644vcb.4
        for <git@vger.kernel.org>; Wed, 23 Jul 2014 14:28:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:cc:content-type;
        bh=0KQPqg3OAX1PCZu4El+AEom5UKz1pRF0tvjlc+5aH8s=;
        b=jbs8oLS6XwtkCbJwlG1da0Uxj/T5kR3n8uAqqYlI+BxAloE9lLivSqmUZy/J7O52nz
         OrXTEgnOkN/JhJk/Lhoy2A6iY7kL64csB1f7925Dqm0DBlh4Ipa/ot1ykMmfCFzp7Jov
         VlyNsb9BNrR6vRHdHQo5/qWvQAU4Pn7Z54x1LCAts4HdN5qXilimgsvBpdjI5MFWuHOY
         Ru53RxfKhyOKZl7Qw6OweMn792yjo6k7qqlN2Fdd9cUeLcGmO3vPprsg/0V7vtsEgxRy
         AxDGjn7uhVYVM/7+pLnHhoT6X8yTjJjELdgnDYQLqu22yNFvEg4KxTjUm3lksjTgXHNy
         Ywjw==
X-Received: by 10.52.82.166 with SMTP id j6mr5343211vdy.87.1406150893650; Wed,
 23 Jul 2014 14:28:13 -0700 (PDT)
Received: by 10.220.80.132 with HTTP; Wed, 23 Jul 2014 14:28:13 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254126>

The scenario in the rename test makes unnecessary assumptions about
which file git file-tree will detect as a source for a copy-operations.
Furthermore, copy detection is not tested by checking the resulting
perforce revision history via p4 filelog, but via git diff-tree.

This patch makes the test more robust by accepting each of the possible
sources, and more rigorous by doing so via p4 filelog.
---
 t/t9814-git-p4-rename.sh | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/t/t9814-git-p4-rename.sh b/t/t9814-git-p4-rename.sh
index 1fc1f5f..4068510 100755
--- a/t/t9814-git-p4-rename.sh
+++ b/t/t9814-git-p4-rename.sh
@@ -156,18 +156,16 @@ test_expect_success 'detect copies' '
  git diff-tree -r -C HEAD &&
  git p4 submit &&
  p4 filelog //depot/file10 &&
- p4 filelog //depot/file10 | grep -q "branch from //depot/file" &&
+ p4 filelog //depot/file10 | grep -q "branch from //depot/file2" &&

  cp file2 file11 &&
  git add file11 &&
  git commit -a -m "Copy file2 to file11" &&
  git diff-tree -r -C --find-copies-harder HEAD &&
- src=$(git diff-tree -r -C --find-copies-harder HEAD | sed 1d | cut -f2) &&
- test "$src" = file10 &&
  git config git-p4.detectCopiesHarder true &&
  git p4 submit &&
  p4 filelog //depot/file11 &&
- p4 filelog //depot/file11 | grep -q "branch from //depot/file" &&
+ p4 filelog //depot/file11 | grep -q -E "branch from //depot/file(2|10)" &&

  cp file2 file12 &&
  echo "some text" >>file12 &&
@@ -177,7 +175,7 @@ test_expect_success 'detect copies' '
  level=$(git diff-tree -r -C --find-copies-harder HEAD | sed 1d | cut
-f1 | cut -d" " -f5 | sed "s/C0*//") &&
  test -n "$level" && test "$level" -gt 0 && test "$level" -lt 98 &&
  src=$(git diff-tree -r -C --find-copies-harder HEAD | sed 1d | cut -f2) &&
- test "$src" = file10 || test "$src" = file11 &&
+ test "$src" = file2 || test "$src" = file10 || test "$src" = file11 &&
  git config git-p4.detectCopies $(($level + 2)) &&
  git p4 submit &&
  p4 filelog //depot/file12 &&
@@ -190,12 +188,10 @@ test_expect_success 'detect copies' '
  git diff-tree -r -C --find-copies-harder HEAD &&
  level=$(git diff-tree -r -C --find-copies-harder HEAD | sed 1d | cut
-f1 | cut -d" " -f5 | sed "s/C0*//") &&
  test -n "$level" && test "$level" -gt 2 && test "$level" -lt 100 &&
- src=$(git diff-tree -r -C --find-copies-harder HEAD | sed 1d | cut -f2) &&
- test "$src" = file10 || test "$src" = file11 || test "$src" = file12 &&
  git config git-p4.detectCopies $(($level - 2)) &&
  git p4 submit &&
  p4 filelog //depot/file13 &&
- p4 filelog //depot/file13 | grep -q "branch from //depot/file"
+ p4 filelog //depot/file13 | grep -q -E "branch from //depot/file(2|10|11|12)"
  )
 '

-- 
2.0.1

On Mon, Jul 7, 2014 at 3:10 AM, Pete Wyckoff <pw@padd.com> wrote:
> ml.christophbonitz@gmail.com wrote on Sun, 06 Jul 2014 16:32 +0200:
>> I'm trying to get the git p4 tests to pass on my machine (OS X
>> Mavericks) from master before making some changes. I'm experiencing a
>> test failure in "detect copies" of the rename test.
>>
>> The test creates file2 with some content, creates a few copies (each
>> with a commit), then does the following (no git write operations
>> omitted):
>> echo "file2" >>file2 &&
>> cp file2 file10 &&
>> git add file2 file10 &&
>> git commit -a -m "Modify and copy file2 to file10" &&
>> ... (some non-write-operations) ...
>> cp file2 file11 &&
>> git add file11 &&
>> git commit -a -m "Copy file2 to file11" &&
>> git diff-tree -r -C --find-copies-harder HEAD &&
>> src=$(git diff-tree -r -C --find-copies-harder HEAD | sed 1d | cut -f2) &&
>> test "$src" = file10 &&
>>
>> This is where it fails on my machine. The git diff-tree output is this
>> :100644 100644 22a35c17c4c0779f75142036beef6ccd58525b9c
>> 22a35c17c4c0779f75142036beef6ccd58525b9c C100 file2 file11
>> so git diff-tree sees file2 as the copy source, not file10. In my
>> opinion, the diff-tree result is legitimate (at that point, file2,
>> file10 and file11 are identical). Later in the tests, after making
>> more copies of file2, the conditions are more flexible, e.g.
>> test "$src" = file10 || test "$src" = file11 || test "$src" = file12 &&
>>
>> IMO, the test discounts the legitimate possibility of diff-tree
>> detecting file2 as source, making unnecessary assumptions about
>> implementation details. Is this correct, or do I misunderstand the
>> workings of diff-tree?
>>
>> I'd be grateful for advice, both on whether this is a bug, and if so,
>> which branch to base a patch on.
>
> I think your analysis is correct.  And I agree that later tests
> have noticed this ambiguity and added multiple comparisons like
> you quote.
>
> I'm not sure how to robustify this.  At least doing the multiple
> comparisons should make the tests work again.  The goal of this
> series of tests is to make sure that copy detection is working,
> not to verify that the correct copy choice was made.  That should
> be in other (non-p4) tests.
>
> Do send patches based on Junio's master.  I can ack, and they'll
> show up in a future git release.
>
> Thanks!
>
>                 -- Pete
