From: Ilya Bobyr <ilya.bobyr@gmail.com>
Subject: [RFC/PATCH v3] Better control of the tests run by a test suite
Date: Tue, 22 Apr 2014 01:19:24 -0700
Message-ID: <1398154767-1276-1-git-send-email-ilya.bobyr@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Thomas Rast <trast@inf.ethz.ch>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 22 10:20:04 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WcVvv-0001h1-JT
	for gcvg-git-2@plane.gmane.org; Tue, 22 Apr 2014 10:20:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753270AbaDVIT7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Apr 2014 04:19:59 -0400
Received: from mail-pb0-f50.google.com ([209.85.160.50]:39617 "EHLO
	mail-pb0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751562AbaDVIT4 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Apr 2014 04:19:56 -0400
Received: by mail-pb0-f50.google.com with SMTP id md12so4672639pbc.23
        for <git@vger.kernel.org>; Tue, 22 Apr 2014 01:19:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=fO7l1GYG8f0x73AKNmOuaBwMmumYyMiIVaYqF8FTmsA=;
        b=E5cW99jgYpQlf4u8E/cMsDYvYMOQIdjzlk0EdnGcRFfn2nC1aD7IOAZ8WgONJfh/vY
         PNsz8REzpttxR1c4+v7NGFv8bUqCXC3oqpKbzWKJuE92P9oyOJ2/rloLEy00uPIgQ9IC
         ONQ4uIoPPAcCwxmozwOipMsxypmsHDPRg32jOb6sPGZXsU04pPQEE/t24ZHJiQKXEVMC
         jhRqQ9fhjEPVsE5ozx2+ajnrA6YDq/K4tWs+UzIzw5Vbp4frglDPWNihG6bZtGGzWwdx
         9GN19SyQuHKiQtdF5JR5bkGzrIOVI4xIax3I/JD16m+n9wB1QQLv+eWQJQlBGg5ZEO/M
         kZ5Q==
X-Received: by 10.66.146.170 with SMTP id td10mr43070473pab.105.1398154795574;
        Tue, 22 Apr 2014 01:19:55 -0700 (PDT)
Received: from localhost.localdomain (c-50-136-172-14.hsd1.ca.comcast.net. [50.136.172.14])
        by mx.google.com with ESMTPSA id om6sm83107950pbc.43.2014.04.22.01.19.54
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 22 Apr 2014 01:19:54 -0700 (PDT)
X-Mailer: git-send-email 1.7.9
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246713>

This patches add `--run` option to the test suites to allow one to run
individual tests out of the test suite.  Like this:

    ./t0000-basic.sh --run='-4,7,9-12,15-'

Both spaces and commas are accepted as separators for the ranges (In
previous versions only spaces were accepted).

Two previous versions are here:

    [RFC/PATCH] Better control of the tests run by a test suite
    http://www.mail-archive.com/git@vger.kernel.org/msg46419.html

    [RFC/PATCH v2] Better control of the tests run by a test suite
    http://www.mail-archive.com/git@vger.kernel.org/msg46877.html

In this version I have removed mathematical operators and used ranges as
suggested by Junio[1] and Eric Sunshine[2].

[1] http://www.mail-archive.com/git@vger.kernel.org/msg47098.html
[2] http://www.mail-archive.com/git@vger.kernel.org/msg46960.html

This version also includes changes according to the comments from Eric
Sunshine in the documentation.  But as this version has slightly different
documentation, it would be nice if someone would read it once again :)

Shell patterns are not allowed any more.  I think they are not that useful
and ranges cover almost the same functionality.  Also with patterns like
'[8-9]', it is harder to produce good error messages for invalid range
ends.

This conversion is a bit unfinished:

On 3/31/2014 10:09 AM, Junio C Hamano wrote:
> I would have to say that there is already an established pattern to
> pick ranges that normal people understand well and it would be silly
> to invent another more verbose way to express the same thing.  You
> tell your Print Dialog which page to print with e.g. "-4,7,9-12,15-",
> not ">=4 7 ...".  
>
> Would the same notation be insufficient for our purpose?  You do not
> even have to worry about negation that way.

    http://www.mail-archive.com/git@vger.kernel.org/msg47098.html

Negation was not necessary for my use cases even in the first version.
I've added it more because it seemed to be very close to the functionality
I was adding and not that complicated.

So, I've left the negation in the new version as well.


I am actually thinking now that --verbose-only= and --valgrind= could be
switched to use the same syntax as in --run.

I also noticed that I am doing the following quite often:

    ./t0000-basic.sh --run=1-4,27 --verbose-only=27

Maybe it would be better to support 'v' suffix as a flag to indicate what
a test needs to be run in verbose mode:

    ./t0000-basic.sh --run=1-4,27v


Ilya Bobyr (3):
  test-lib: Document short options in t/README
  test-lib: tests skipped by GIT_SKIP_TESTS say so
  test-lib: '--run' to run only specific tests

 t/README         |   81 ++++++++++-
 t/t0000-basic.sh |  419 +++++++++++++++++++++++++++++++++++++++++++++++++++++-
 t/test-lib.sh    |  120 +++++++++++++++-
 3 files changed, 604 insertions(+), 16 deletions(-)
