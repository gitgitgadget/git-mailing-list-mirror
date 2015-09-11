From: Stefan Beller <sbeller@google.com>
Subject: [RFC PATCHv1 0/2] Parallel git submodule fetching
Date: Fri, 11 Sep 2015 16:09:52 -0700
Message-ID: <1442012994-20374-1-git-send-email-sbeller@google.com>
Cc: peff@peff.net, gitster@pobox.com, jrnieder@gmail.com,
	johannes.schindelin@gmail.com, Jens.Lehmann@web.de,
	vlovich@gmail.com, Stefan Beller <sbeller@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Sep 12 01:10:07 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZaXSG-0002VC-4f
	for gcvg-git-2@plane.gmane.org; Sat, 12 Sep 2015 01:10:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754962AbbIKXKB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Sep 2015 19:10:01 -0400
Received: from mail-pa0-f45.google.com ([209.85.220.45]:33024 "EHLO
	mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754785AbbIKXJ6 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Sep 2015 19:09:58 -0400
Received: by pacex6 with SMTP id ex6so87131702pac.0
        for <git@vger.kernel.org>; Fri, 11 Sep 2015 16:09:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=RR5EYumUnJS0vd8V21Huwod3mLQIzN9zbozAcbwG/6U=;
        b=R6nKHKwq9tQApUebq+MtQ+4jk/NPlalX2UwkbGlRCHR7ZNHN5tRHatwZrtC85isrxZ
         D8CH8YcKHqefPNJ0EY9J83MyYSIuw53M5i0Z2zZd5fxRl803NZ/aZMYVlj4vD5WHbHMr
         UqQkYA1b+yr7dM+T6v/1awPKTKsPxmEf+4WPL/g/zCZFYsIxdVmwnkaZ2vZ+RLZMvFcA
         nRXUsN7jRsOyvIebQIMZmTmzAoqaLWNATKA9iZvs+0SEcGGI2OcvYsR3FvjwEA4Ut+uh
         szIpEhTn81fCTEOp/gbDg+F+Lmi93M+WFW4ObNT12nfUbUzGw9P73LTDWsfbnWHIdtnU
         Afpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=RR5EYumUnJS0vd8V21Huwod3mLQIzN9zbozAcbwG/6U=;
        b=CFEvO4O7ZWjLXNBtrnF+cQrRu4GhuasC/BwuVLt9hmbYWWNed4RTUIkGYsUgVWkCsy
         6AE8lUJOF1C7Z/zJNHhyI/VVnaK0kg6H3KnQrHrSpmcZsocSicXKsgAhxW/Ttd3Z3b/b
         biU6u2AXu45soCGGBuBYb5PbZc6BLwKwKtIWzCezOhvNr+GyNbnA0WZ1Kmg2S5/yn6oW
         YG54lJrju/h8llwpBELeB4Ar1EMf2TBbPhinOMRmeat/vs2amd57TiMT6dZcl+lAOcnT
         0iTEUwQ4OXLVqrrGXJtLU64PK1ChP+mnqwfP+EkDitd0GZZ4DG+fPbWeTKJRNDXv2URO
         EU1g==
X-Gm-Message-State: ALoCoQnHablJ/0AV3hexsXg3NFXmy8m51uhvhh+8TFeaU+GrEtcL8XJppPpEl2Q51WPXYeh+f7om
X-Received: by 10.68.164.97 with SMTP id yp1mr2708883pbb.133.1442012997830;
        Fri, 11 Sep 2015 16:09:57 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b00:44ea:73dc:b756:adf])
        by smtp.gmail.com with ESMTPSA id bh5sm2395414pbc.5.2015.09.11.16.09.56
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 11 Sep 2015 16:09:57 -0700 (PDT)
X-Mailer: git-send-email 2.6.0.rc0.131.gf624c3d
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277705>

This is a new approach to making git submodules faster without using threads.
We'll directly run commands in parallel without an intermediate thread pool.

patch 1 is fixing an error, which was hard to come by in a parallel world,
but is not much of a problem in a single-childed world.

The second patch works fine, (I'd love to hear feedback on the percieved
change of output) though it has still two edges I want to tackle:

* The fcntl call to make the pipes nonblocking is not checked for errors.
* We also need to communicate back if one process cannot spawn or such,
  i.e. the reporting for all subprocesses combined needs to added. I think
  about adding another callback which is called to finish up a child process.

Earlier attempts used a threading pool, which made the conversion very
easy as you don't need to touch lots of existing code as you would just
replace the run_command(..) call by an add_task(..). The threading pool
would abstract away the whole parallelism and its problems. It would also
have the backpressure to the main program, add_task would just not
return if there was no place left in the queue.

[1] http://www.spinics.net/lists/git/msg258435.html

Any feedback welcome!
Thanks,
Stefan

Jonathan Nieder (1):
  Sending "Fetching submodule <foo>" output to stderr

Stefan Beller (1):
  fetch: fetch submodules in parallel

 Documentation/fetch-options.txt |   7 ++
 builtin/fetch.c                 |   6 +-
 builtin/pull.c                  |   6 ++
 run-command.c                   | 144 ++++++++++++++++++++++++++++++++++++++++
 run-command.h                   |  29 ++++++++
 strbuf.c                        |  31 +++++++++
 strbuf.h                        |   1 +
 submodule.c                     |  99 +++++++++++++++++----------
 submodule.h                     |   2 +-
 t/t0061-run-command.sh          |  16 +++++
 t/t5526-fetch-submodules.sh     |  70 ++++++++++++-------
 test-run-command.c              |  23 +++++++
 12 files changed, 373 insertions(+), 61 deletions(-)

-- 
2.6.0.rc0.131.gf624c3d
