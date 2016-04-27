From: Andrew J <andj2223@gmail.com>
Subject: Strangeness with git-add and nested repositories
Date: Wed, 27 Apr 2016 01:31:11 -0700
Message-ID: <CAH6n4TdG9LQOPaaw_H6vuCgia0-4JXhPsSiAJPa5GtjfduQoSw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 27 10:31:21 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1avKsS-00010P-11
	for gcvg-git-2@plane.gmane.org; Wed, 27 Apr 2016 10:31:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752782AbcD0IbO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Apr 2016 04:31:14 -0400
Received: from mail-ig0-f196.google.com ([209.85.213.196]:34147 "EHLO
	mail-ig0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752409AbcD0IbM (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Apr 2016 04:31:12 -0400
Received: by mail-ig0-f196.google.com with SMTP id qu10so5622336igc.1
        for <git@vger.kernel.org>; Wed, 27 Apr 2016 01:31:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to;
        bh=ViZm0Hyp+ULclSPIhexPJbdiF3DxMK3kbqgp/EAsNms=;
        b=mPalX5cy8nX0XWVlBfpsZiGFM1S5Vp1dFKguK8qTnef/lsAQfgp6wZ0wRBoJSxSbMz
         VrFMXFTbjWiCkWqYBGskDGR+DbaMIArVyhpNDTS6nvmC4Qdqxdbsb5ZYrNJA1QjfokKY
         LNUKbuOEsrj5vQXxA8+wyfDG7K7njqihLpxd6J/QyI7uxIBmB176SQCo6eNAuoLD2mD5
         c0qgQEAgmwHGccT38m8UEPPn+E3xb5JAT7WhJ0sCaGRULmJNGI6by2KCCZZHhB1Nor0W
         IOWLTLslEi9ogBEXVYGQNQPCDzqAbLoJiOAgMhmVBZh70UUpa4QZ4P3J3fkQm5uugzkq
         KJJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=ViZm0Hyp+ULclSPIhexPJbdiF3DxMK3kbqgp/EAsNms=;
        b=SOxaH7kndHdFs/vsEyAHrnkLasCFAIiwD8Wie978cntZxqd9htpDZG2v6EUtacIB0q
         CHgNOvN4yUfF7IfN64rbaCt3nJvfFmPqs9BrJ4giN+zHobnsZeX0LdRPsSUmwnoQ0UHh
         Qq1KjBnBQh12tW0jixKSycUSjJ/eWxRSHm4kIBriENLzodUyU3UERyR03BVSS9IJmMrx
         KSIeY197YQmtmyy0hrjEcpz7bsdQK42vJljxQp90zl3kumYxTbMVxSQCBqSb29pnsZ4t
         weKM3X5U+93fLYMtJfU+iLyCuEzGFQrp1vywhatx4OUYAHSFiEUnSft53Pw3gLZC3zP/
         4GFw==
X-Gm-Message-State: AOPr4FXOeHnS7dfKs9W4QFyuP+0RGSWK7PscyrIjVq/VVv41hAP099BYuh2mXexf+FCLFQyYd2mtJfEQ8Q6oMA==
X-Received: by 10.50.141.193 with SMTP id rq1mr24726249igb.39.1461745871141;
 Wed, 27 Apr 2016 01:31:11 -0700 (PDT)
Received: by 10.107.10.219 with HTTP; Wed, 27 Apr 2016 01:31:11 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292715>

I've noticed some strangeness with git-add and nested repos.

This tar.gz has a reproduction script, parent repo, and nested repo
that exhibits the issue:
https://drive.google.com/uc?export=download&id=0Bwjufq6oAZMfcGVxZ2dlMElEVlE

If you extract the archive and do the following (on linux please, I
haven't even tried this on Windows):
cd git-add-bug
./bad-git-add.sh
(Examine the script before running, please)

It will echo what I'm encountering to the screen, so it should be
straightforward to follow, but I will summarize here:
If I run a git-add command where one or more of the files live in
nested repositories, like so (command is shortened here, includes more
files in the script):
git add -v -f --
src/chromium/src/third_party/libFuzzer/src/FuzzerInterface.h testfile
As confirmed by git-status, this results in testfile being added, but
FuzzerInterface.h not being added.
FuzzerInterface.h is inside of a nested repository
(src/chromium/src/third_party/libFuzzer/src/), while testfile is in
the current main repository.

On the other hand, the following command:
git add -v -f -- src/chromium/src/third_party/libFuzzer/src/FuzzerInterface.h
Results in FuzzerInterface.h being added, as confirmed by git-status.
Excluding testfile from the git-add command seems to do the trick.

My expectation:
Both testfile and FuzzerInterface.h should be added if they are
specified in the git-add command, regardless of whether they are
specified along with another file that doesn't happen to live in a
nested repository ("testfile" in this example).

If someone could help me understand what's going on here, I'd appreciate it.

Thanks,

Andrew
