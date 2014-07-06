From: Christoph Bonitz <ml.christophbonitz@gmail.com>
Subject: Test failure in t9814-git-p4-rename.sh - my environment or bad test?
Date: Sun, 6 Jul 2014 16:32:15 +0200
Message-ID: <CABUJjW-iZU2Dp-yfuf302pNMuMj8NBXTvBW-0UHNxXdSWSk4Zw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 06 16:32:40 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X3nUY-0005ho-GA
	for gcvg-git-2@plane.gmane.org; Sun, 06 Jul 2014 16:32:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751513AbaGFOcW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Jul 2014 10:32:22 -0400
Received: from mail-ve0-f194.google.com ([209.85.128.194]:45142 "EHLO
	mail-ve0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751492AbaGFOcQ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Jul 2014 10:32:16 -0400
Received: by mail-ve0-f194.google.com with SMTP id jz11so968420veb.1
        for <git@vger.kernel.org>; Sun, 06 Jul 2014 07:32:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=hNZsaU38e1DnKETLxbzbT3F3X+i4Y6YFBRjFsJrFt/w=;
        b=XMXZ/wa4vJZnMaiFeqDevryCkPp27Pj8IRtj5FT74sk7o9g/qfH+uUBk8Fc6GQS68p
         3eXlbd56ySf3D4KAQqsXGOmADgtMhTdlLd8zLdYBDdrnHVWffWvzHC74GWnjlIRypZ5x
         PFBgNSZpJU98E0Z1qo1f/nukNrn1aL0doPXMcjrqLNYh20Ag4Jd1tZK3znM9Tcy7gV1f
         CTTOM0dV+Q/WeZcN+tYJ4/BeMdmvkiutzeHJTM8QJ6dbv5pjdCbjdjxj/YJpEp1WgBnc
         7vk2yr7QEGJ/3+qOEfVHUBMTf6KdvZIRhgDIk49HM96+ECtUEXQKikhC3mg2tK9ZJLMb
         rRxw==
X-Received: by 10.58.243.1 with SMTP id wu1mr22414673vec.27.1404657135941;
 Sun, 06 Jul 2014 07:32:15 -0700 (PDT)
Received: by 10.220.4.200 with HTTP; Sun, 6 Jul 2014 07:32:15 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252936>

Hi,

I'm trying to get the git p4 tests to pass on my machine (OS X
Mavericks) from master before making some changes. I'm experiencing a
test failure in "detect copies" of the rename test.

The test creates file2 with some content, creates a few copies (each
with a commit), then does the following (no git write operations
omitted):
echo "file2" >>file2 &&
cp file2 file10 &&
git add file2 file10 &&
git commit -a -m "Modify and copy file2 to file10" &&
... (some non-write-operations) ...
cp file2 file11 &&
git add file11 &&
git commit -a -m "Copy file2 to file11" &&
git diff-tree -r -C --find-copies-harder HEAD &&
src=$(git diff-tree -r -C --find-copies-harder HEAD | sed 1d | cut -f2) &&
test "$src" = file10 &&

This is where it fails on my machine. The git diff-tree output is this
:100644 100644 22a35c17c4c0779f75142036beef6ccd58525b9c
22a35c17c4c0779f75142036beef6ccd58525b9c C100 file2 file11
so git diff-tree sees file2 as the copy source, not file10. In my
opinion, the diff-tree result is legitimate (at that point, file2,
file10 and file11 are identical). Later in the tests, after making
more copies of file2, the conditions are more flexible, e.g.
test "$src" = file10 || test "$src" = file11 || test "$src" = file12 &&

IMO, the test discounts the legitimate possibility of diff-tree
detecting file2 as source, making unnecessary assumptions about
implementation details. Is this correct, or do I misunderstand the
workings of diff-tree?

I'd be grateful for advice, both on whether this is a bug, and if so,
which branch to base a patch on.

Best regards
Christoph Bonitz
