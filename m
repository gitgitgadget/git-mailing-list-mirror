From: Stefan Beller <sbeller@google.com>
Subject: [RFC PATCH, WAS: "weird diff output?" v3a 0/2] implement shortest line diff chunk heuristic
Date: Fri, 15 Apr 2016 16:01:44 -0700
Message-ID: <1460761306-18794-1-git-send-email-sbeller@google.com>
Cc: git@vger.kernel.org, gitster@pobox.com, peff@peff.net,
	Jens.Lehmann@web.de, davidel@xmailserver.org,
	Stefan Beller <sbeller@google.com>
To: jacob.keller@gmail.com
X-From: git-owner@vger.kernel.org Sat Apr 16 01:01:58 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1arCkN-0006DH-9S
	for gcvg-git-2@plane.gmane.org; Sat, 16 Apr 2016 01:01:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751478AbcDOXBu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Apr 2016 19:01:50 -0400
Received: from mail-pa0-f51.google.com ([209.85.220.51]:32868 "EHLO
	mail-pa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751320AbcDOXBt (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Apr 2016 19:01:49 -0400
Received: by mail-pa0-f51.google.com with SMTP id zm5so59389561pac.0
        for <git@vger.kernel.org>; Fri, 15 Apr 2016 16:01:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=3qN214q702OQmRtCX2Btf+QFNlVEruP08QGk9HBmB6E=;
        b=FXJOBjp868BfAy+V9La+HnjU0rnVwY2fqdlFBhHzsqBmVUcC6IyNEm3xy2ey5B5aHe
         SADvdtDoixN1vbiyJ6Y8JDWhjUwQW9U3zyd93pJd/0HnEjdekk1Ry7kCXy1/OxY1Jngz
         h+9eed+YlAjZe91hemTz9ZEsvcunHP6iXRlckEUWy514cF7MlnXM8R5S1J7MMljet91T
         OGmRk/oX2/vUvZxPWnhJfd6Ho+mkLqgLP1fNpfpC3dY03ACP0149EDrUefpFv0n8KPJ8
         nL8zMfJJJzLXDumk8n+tWQaKaR1NGtQIvL0+IPwlXkK1cE7ro2NjHiYQU+3Wa/cc6RDP
         smRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=3qN214q702OQmRtCX2Btf+QFNlVEruP08QGk9HBmB6E=;
        b=KiSTufVrbtwzwfp6duJlUb1gG1Y9A1+re0yKiJO54CTovkw4xnec+lMFt7851jTfBO
         v4VdR26O2KgzxpciLhzscl5QPNKOYlrXe37/QT5WkIXEoPZ3oGcBYjRJe3MhuHzjLEIY
         FwiIpq3wEmSD8oW5GCuzvXT7bIbI4NWSKhu5/gKx1G2qYzHomv9H4KYUXe1pjJQjOyMw
         3IDvAc2S3lGr2JqDHFwYBbpV9YVPDELHzDnjHG+G+SxYrdgzuX1VmaWzamyKMYM6c9bE
         wTocoy1ioUx6/gmcyif+Nc6lRv0T+0ApH5klyRDwRSSrseCc1spnS5ku/l7EYySd/YnL
         0pBw==
X-Gm-Message-State: AOPr4FXH4uYOJ4uIhZ/rAGAf8MLPQMwU25zzFnohzUAQXxkwKvrvhlewyY7IcvQf7AkGDAcO
X-Received: by 10.66.33.1 with SMTP id n1mr32939910pai.65.1460761309056;
        Fri, 15 Apr 2016 16:01:49 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:c97d:dddf:ab88:e90])
        by smtp.gmail.com with ESMTPSA id m10sm66975065pfi.32.2016.04.15.16.01.48
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 15 Apr 2016 16:01:48 -0700 (PDT)
X-Mailer: git-send-email 2.8.1.189.gd13d43c
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291695>

This is a version based on Jacobs v2, with the same fixes as in his v3 (hopefully),
changing the heuristic, such that CRLF confusion might be gone.

TODO:
* add some tests
* think about whether we need a git attribute or not (I did some
  thinking, and if we do need to configure this at all, this is where I
  would put it)
  
Later on we want to have git attributes I'd think. For now let's just keep
the `git config diff.shortestlineheuristic true` config option for testing?
  
Changes since Jacobs v2:
 * s/empty line/shortest line/g
   That new heuristic is a superset of the empty line heuristic as empty lines
   are shortest lines.  This solves the "What is an empty line?" question
   (Think of CRLF vs LF)
 * fixed Jacobs rebase mistake (which is also fixed in Jacobs v3)

Changes since my v1:
* rename xdl_hash_and_recmatch to recs_match
* remove counting empty lines in the first section of the looping

Changes since Stefan's v1:
* Added a patch to implement xdl_hash_and_recmatch as Junio suggested.
* Fixed a segfault in Stefan's patch
* Added XDL flag to configure the behavior
* Used an int and counted empty lines via += instead of |=
* Renamed starts_with_emptyline to is_emptyline
* Added diff command line and config options

Jacob Keller (1):
  xdiff: add recs_match helper function

Stefan Beller (1):
  xdiff: implement empty line chunk heuristic

 Documentation/diff-config.txt  |  6 ++++++
 Documentation/diff-options.txt |  6 ++++++
 diff.c                         | 11 +++++++++++
 xdiff/xdiff.h                  |  2 ++
 xdiff/xdiffi.c                 | 43 ++++++++++++++++++++++++++++++++++++++----
 5 files changed, 64 insertions(+), 4 deletions(-)

-- 
2.8.1.189.gd13d43c
