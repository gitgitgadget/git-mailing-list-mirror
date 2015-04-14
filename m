From: Stefan Beller <sbeller@google.com>
Subject: [PATCH 0/3] Large transactions in git
Date: Tue, 14 Apr 2015 15:25:05 -0700
Message-ID: <1429050308-9617-1-git-send-email-sbeller@google.com>
Cc: git@vger.kernel.org, Stefan Beller <sbeller@google.com>
To: gitster@pobox.com, mhagger@alum.mit.edu
X-From: git-owner@vger.kernel.org Wed Apr 15 00:25:31 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yi9Gr-0003zF-TD
	for gcvg-git-2@plane.gmane.org; Wed, 15 Apr 2015 00:25:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754165AbbDNWZT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Apr 2015 18:25:19 -0400
Received: from mail-ig0-f180.google.com ([209.85.213.180]:34020 "EHLO
	mail-ig0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753787AbbDNWZR (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Apr 2015 18:25:17 -0400
Received: by iget9 with SMTP id t9so84628154ige.1
        for <git@vger.kernel.org>; Tue, 14 Apr 2015 15:25:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=7JaiTMSpEdn7CDQR+e0Uei1Tw+lEVusMLTeHaZ518G8=;
        b=Yg7Zb3qeVt86yvuZTe2p90LNIO7x9N6xFcUyilqLoeyAXzRTfKdbSgnhVpTXxp/M0Z
         RLsdisUT91Src2tiPNZPAq7yyW+Zye90qCogqF3dycrip7ngorJ9MfLf2aj54/avEzIX
         c7dRyLry8vNngfDZ/zuSynaVYcNbOPuzY1oe3MQ4MpFEy9iij6+I/icfGrlTo17rCk7m
         1Y7QNox6KAbx6oSmde1dH0tdkXxzZJf7NFfghyAY109tB0aNVGmyBcQ2/nWVPzc4B9Cb
         RIs0j+S9h/DGU2EHOzAQPRO0KyhcZoW/mRmfPmUk0/H/jtyt6DmYxohl+0TBDN7yacUl
         5peQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=7JaiTMSpEdn7CDQR+e0Uei1Tw+lEVusMLTeHaZ518G8=;
        b=jLPI4og/foBZIB6tOZYIw6x6SvG19hJ5Syy86kvttbOUtZLWwaMJtRZNxSp0DwPHzC
         Cm0pZB28Qtx83rrNhbCPSEuANZYr1nV8S9B+984W+WU6oGjG5m3WWHQs6rwG9SG0CZ6v
         3mlfyFnlr+em1R5z9IwNAfaETfw3WqjxkeFvAzsFcnr71y7ma1Y+1/dQ7wvDNxCxvxxi
         NRG3IgQpr+dZTFHxg5Yiydv+Kt88E2/e95lY3w1bdYCfo6TKVskpNT/wf61Lxkm6I0wE
         CbcDyzhB9q3D3FQfvYHkpp5U6a/GDxxBUfexU3BW1Nnw4tsl3TqjrdY8C57A22Hghl59
         goNw==
X-Gm-Message-State: ALoCoQl9YupJdWcdD6GlZisXOR9qHnl11VUJVP+dAl1PmdiiBxx8IBUxn1v/9zkexx4zvpugBHon
X-Received: by 10.107.136.25 with SMTP id k25mr31320826iod.88.1429050316683;
        Tue, 14 Apr 2015 15:25:16 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b00:f14f:277:5d87:2236])
        by mx.google.com with ESMTPSA id 192sm1234635ioo.38.2015.04.14.15.25.15
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 14 Apr 2015 15:25:15 -0700 (PDT)
X-Mailer: git-send-email 2.3.0.81.gc37f363
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267169>

On Git Merge Wilhelm Bierbaum from Twitter made clear that we'd have problems
with large transactions in git. As I have been working on that series a few
months ago and it still bugs me, I thought about reviving the series.

However the series got stale a few months ago because we were not sure how
to do it right. The first few patches were deemed uncontroversial though,
which I am resending now. 

The first patch contains tests telling us what needs fixing.
The second patch renames the precondition for other tests, as ULIMIT is
a bit generic. The third patch removes the `lock_fd` field from struct
ref_lock which was duplicate information.

That said, this series is not fixing the actual issue, but I'd guess
having these patches is step forward actually.

Thanks,
Stefan

Stefan Beller (3):
  update-ref: test handling large transactions properly
  t7004: rename ULIMIT test prerequisite to ULIMIT_STACK_SIZE
  refs.c: remove lock_fd from struct ref_lock

 refs.c                | 16 ++++++----------
 t/t1400-update-ref.sh | 28 ++++++++++++++++++++++++++++
 t/t7004-tag.sh        |  4 ++--
 3 files changed, 36 insertions(+), 12 deletions(-)

-- 
2.3.0.81.gc37f363
