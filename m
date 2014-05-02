From: dturner@twopensource.com
Subject: Watchman support for git
Date: Fri,  2 May 2014 19:14:08 -0400
Message-ID: <1399072451-15561-1-git-send-email-dturner@twopensource.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 03 01:14:50 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WgMfH-0005b5-3i
	for gcvg-git-2@plane.gmane.org; Sat, 03 May 2014 01:14:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752485AbaEBXOk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 May 2014 19:14:40 -0400
Received: from mail-qg0-f48.google.com ([209.85.192.48]:48207 "EHLO
	mail-qg0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752109AbaEBXOj (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 May 2014 19:14:39 -0400
Received: by mail-qg0-f48.google.com with SMTP id i50so4011555qgf.7
        for <git@vger.kernel.org>; Fri, 02 May 2014 16:14:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:subject:date:message-id;
        bh=51XsPeEnqrRhDqiN88s7GcAPRkNQ/DQMERqWsTsVsgo=;
        b=W+A/V8HPPmq+7bbN2vXUR4VOw8D/m+PmMI+9Vq2s7hhJjJRN4BLmTMWo997yx+Li1j
         l3Es254k06mfziOeCDg0N5CrPBXyDbq+Yd4vqYXjHDsCQn5uTSnYlxS12DdiVd6jkpgD
         jIgI9wo3LPpHIaz4AazMKs0L0nNZGYRbskEb0fq/qP0RYVeE/jVmJ/cdfNPtbfRyqBKP
         3QNRZA00PDImEgAKsQ9iY0gaeFntTwphKuFPkn11qCqXcS/ypZOxIZFJHaxwnTPAcZw4
         OT5Vm71FUcIMIouFuQGHleifFUS8lF53yEGaAuyFPzWLN2R2MaMFVPRuBAQwJeMVr4vI
         QrrA==
X-Gm-Message-State: ALoCoQlPYeAJTvTX23AwfPjsFvLCe0lrzU+5mXFzfEv/Rwm0qckpX/EWD7OnMlSG3dr+UowKH917
X-Received: by 10.224.30.131 with SMTP id u3mr26856853qac.50.1399072478624;
        Fri, 02 May 2014 16:14:38 -0700 (PDT)
Received: from stross.twitter.corp ([8.25.196.25])
        by mx.google.com with ESMTPSA id q62sm598071qgd.0.2014.05.02.16.14.36
        for <git@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 02 May 2014 16:14:37 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.rc0.31.g69c1a2d
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248004>

The most sigificant patch uses Facebook's watchman daemon[1] to monitor
the repository work tree for changes.  This makes allows git status
to avoid traversing the entire work tree to find changes.

This change requires libwatchman[2], a client library that I wrote for
watchman.

While making the watchman change, I also made a change to the index
format (contributed here in a separate patch).  Index integrity
checking uses the same SHA1 algorithm as the rest of git; this is
actually relatively slow.  It's not a huge part of run-time, but since
I wanted to do the same checking for the Watchman filesystem cache
(which is about twice as large as the index), I decided to optimize it
anyway.  I switched to VMAC.  VMAC is supposed to be a MAC, but
there's no reason it can't be used with a fixed key as a simple
integrity check.  VMAC is roughly five times faster than SHA1 on my
machine; This adds up to a 5% overal speed improvement on git status
(depending on the structure of your repo, and about 15% on git diff
--cached with no cached changes).

The index format change might be less important with the split index;
I haven't investigated that since at the time I wrote these patches,
it didn't exist.

Some numbers follow.  They are on my laptop, which has 4x i5-2520M
processors, 8GB of RAM, and a solid state disk.  They're all tested
with a hot cache.

Test repository 1: Linux

Linux is about 45k files in 3k directories.  The average length of a
filename is about 32 bytes.

Git status timing:
no watchman: 125ms
watchman: 90ms

Test repository 2: Superscience

My second test repository (which is a semi-synthetic repo generated
from various Twitter internal repos) is somewhat larger than this, and
gets a correspondingly larger improvement.  It is about 65k files in
20k directories; the average length of a filename is 67 bytes.

Git status timing:
no watchman, index version 4: 370 ms
no watchman, index version 5: 365 ms
watchman, index version 4: 170 ms
watchman, index version 5: 165 ms


[1] https://github.com/facebook/watchman
[2] https://github.com/twitter/libwatchman
