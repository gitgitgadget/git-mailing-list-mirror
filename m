From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 0/5] A natural solution to the @ -> HEAD problem
Date: Wed,  1 May 2013 21:50:30 +0530
Message-ID: <1367425235-14998-1-git-send-email-artagnon@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Felipe Contreras <felipe.contreras@gmail.com>,
	Jeff King <peff@peff.net>, Duy Nguyen <pclouds@gmail.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed May 01 18:20:29 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UXZld-0006Jq-C3
	for gcvg-git-2@plane.gmane.org; Wed, 01 May 2013 18:20:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756269Ab3EAQUZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 May 2013 12:20:25 -0400
Received: from mail-pd0-f172.google.com ([209.85.192.172]:54490 "EHLO
	mail-pd0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755774Ab3EAQUX (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 May 2013 12:20:23 -0400
Received: by mail-pd0-f172.google.com with SMTP id 4so897832pdd.3
        for <git@vger.kernel.org>; Wed, 01 May 2013 09:20:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer;
        bh=vGeOcrINroTAVQzCXKDxOI8BPU32sC28ZcrIIZTCq4U=;
        b=lYhoQwiciEUWCg3DVPoPjQY+IA1HrUpJinad9bw59RbUJ7CcW0TuRU2gRwb71Tyg0L
         Rk9xiKCf2lJSS5u0Ik6Ubtdb0uftE+omW9IIRqmAaSu07qiZTdLio9mDZ02IQ6Uxgll/
         X8USTWOatiPzv7jne7medNHW9YY5rkdHFI6mD/y+pQxSghGqC1bwaU5McFftQ6P8KF/c
         e+UYFFG8JxUwexnBv7gyfCqlKt6JIOXJAn5h0J/yxlAiZv+PNWzuI/AHeYjqlcWqYU6e
         ImFtyUCOHSI7dcuEBFcesOBS+N7O8VGFAH2lT39Vr/OJ2m3gxHCWkudMOaKdlp4S52wQ
         blsw==
X-Received: by 10.68.224.65 with SMTP id ra1mr4840834pbc.103.1367425223243;
        Wed, 01 May 2013 09:20:23 -0700 (PDT)
Received: from localhost.localdomain ([122.164.132.210])
        by mx.google.com with ESMTPSA id sg4sm3549741pbc.7.2013.05.01.09.20.20
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 01 May 2013 09:20:22 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.rc0.24.g6456091
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223094>

Hi,

Felipe's approach to solving the problem is a recursive reinterpret()
that relies on parsing the sequence @[^{].  Seems like quite a
contrived hack, and I think we can do much better than this.

Here, I present my approach to solving the problem.  It interprets @
just like a ref in resolve_ref_unsafe(), after everything else has
been peeled off; the solution is just the few simple lines shown in
[5/5].

The core of the series tackles refactoring the @-parsing so that [5/5]
becomes possible without doing anything contrived.  [1/5] introduces
the problem I started solving: making symbolic refs work properly.
[2/5] and [3/5] are a result of me reading through the horrible
@-parsing code.  [4/5] finally solves the symbolic ref problem, and
[5/5] becomes trivial.

A side-effect of the series is that you can now do:

    $ git symbolic-ref H HEAD
    $ git show H@{u}

In other words, symbolic refs actually work now and you can use them
to achieve a lot of custom overrides.  I think it is a step in the
right direction.

Thanks for listening, and hope you enjoy reading the series as much as
I enjoyed writing it.

Ramkumar Ramachandra (5):
  t1508 (at-combinations): more tests; document failures
  sha1_name.c: don't waste cycles in the @-parsing loop
  sha1_name.c: simplify @-parsing in get_sha1_basic()
  remote.c: teach branch_get() to treat symrefs other than HEAD
  refs.c: make @ a pseudo-ref alias to HEAD

 Documentation/git-check-ref-format.txt |  2 +
 Documentation/revisions.txt            |  8 +++-
 refs.c                                 | 12 ++++-
 remote.c                               | 14 ++++++
 sha1_name.c                            | 85 +++++++++++++++++++++++++---------
 t/t1400-update-ref.sh                  |  3 ++
 t/t1508-at-combinations.sh             | 15 ++++++
 7 files changed, 113 insertions(+), 26 deletions(-)

-- 
1.8.3.rc0.24.g6456091
