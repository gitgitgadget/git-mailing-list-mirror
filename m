From: Elliott Cable <me@ell.io>
Subject: Strange situation with --assume-unchanged and diff --find-copies-harder
Date: Sun, 11 May 2014 14:20:57 -0500
Message-ID: <CAPZ477Ot8MiTUNx1AwDTb5sGDDerDvBY=znsK4Fhcb5taYsaHA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 11 21:59:55 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WjZuc-0007Jn-U6
	for gcvg-git-2@plane.gmane.org; Sun, 11 May 2014 21:59:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932981AbaEKT7u convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 11 May 2014 15:59:50 -0400
Received: from mail-oa0-f47.google.com ([209.85.219.47]:59955 "EHLO
	mail-oa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757629AbaEKTU6 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 11 May 2014 15:20:58 -0400
Received: by mail-oa0-f47.google.com with SMTP id i7so7245733oag.34
        for <git@vger.kernel.org>; Sun, 11 May 2014 12:20:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ell.io; s=google;
        h=mime-version:date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        bh=A5trMXZHRSzi5nNA0i3fm9T78blIgNeFQXeyWyVo9HE=;
        b=EPOOkoHIQVIsr51Z6/szwM5hfZhyTdaV5i3uYCVyuE38VwU4etTa59mf0GCh2kJDi4
         B6EQH0uDtZzjxQVI9XsvkbgGrVyoTx/eM4OrOLk9yGN7WAvVDpbYo+HWkw1TrpchLROm
         uGYq1ryY+zU2biSyg/wT7Zi4U16B3bIDzXI+s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to
         :content-type:content-transfer-encoding;
        bh=A5trMXZHRSzi5nNA0i3fm9T78blIgNeFQXeyWyVo9HE=;
        b=abU24kzsbebtXyT8h5/dedt0y+loJcLJ+kGRTG8PSF4LUhxGriz7u3jYl7VMgGMADL
         le9Mjy6WEIe8FBdAZs9psmMA2Cb6ygVBk8aNHntYRiySSwAl+qqqw8uNNPebfwjryQX4
         2o59pBGr30C6ENKg+bxaYrCE++9cYejiUaq1eldBYETIVQb3+rVjBxf+OrDJ6MOxvG3h
         JOPW9uypGH+++gBtKQbOp5MWBoEUCBNHQ41RKrS5XN/8lXHs/90s5fcobKzC+2SWn1w0
         KLKOpf6TPWyEhVdFb27MdN+VvIlP73dmtqodvhl1tjP4AChBaK9CabOX9RbDoSZYU+Ia
         m3+A==
X-Gm-Message-State: ALoCoQnXlcwtbyPlBc8Df9Th1Q8UT7eQE49eFGuflQLTkQ00MuwCr4933U7tjYeUukxfspJSq2jm
X-Received: by 10.182.45.161 with SMTP id o1mr28685141obm.29.1399836057716;
 Sun, 11 May 2014 12:20:57 -0700 (PDT)
Received: by 10.60.57.234 with HTTP; Sun, 11 May 2014 12:20:57 -0700 (PDT)
X-Originating-IP: [70.194.70.163]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248681>

So, I've spent some time in the #git channel on Freenode chatting
about this, and we couldn't figure it out. I can't reproduce it in a
newly-made repository, but it's reproducible with the repository I've
been working in.

    > git status
    On branch Master
    Your branch is ahead of 'ec/Master' by 2 commits.
     (use "git push" to publish your local commits)

    nothing to commit, working directory clean
    > g diff --find-copies-harder
    diff --git i/Executables/paws.js w/Executables/paws.js
    old mode 100755
    new mode 100644
    > stat -f '%p' Executables/paws.js
    100755
    >

 - As demonstrated by the `stat`, the mode-change shown by `git diff`
is a phantom change; it never happened.
 - If I remove the `--find-copies-harder` flag, it doesn't show up.
 - If I choose to --no-assume-unchanged the executable, it doesn't show=
 up.
 - If I change the actual file-mode to the 644 it thinks it is, and
commit it, it doesn't show up.

It's only the precise combination of A) a file flagged +x, B) that
file --assume-unchange'd on the index, and C) diff called with the
--find-copies-harder flag, that shows the phantom mode-change.

I tried reproducing that situation in a clean repository, and the
problem didn't seem to surface. You're welcome to clone the repository
in question, however, and reproduce it yourself:

    > git clone https://github.com/ELLIOTTCABLE/Paws.js.git
    > git update-index --assume-unchanged Executables/paws.js
    > git diff --find-copies-harder
    > stat -f '%p' Executables/paws.js

I'm working on git 1.9.2.

=E2=81=93=E2=80=89ELLIOTTCABLE=E2=80=84=E2=80=94=E2=80=84fly safe.
=E2=80=83=E2=80=89http://ell.io/tt
