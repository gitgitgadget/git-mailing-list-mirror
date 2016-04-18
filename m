From: Stefan Beller <sbeller@google.com>
Subject: [PATCH 0/2 v4] xdiff: implement empty line chunk heuristic
Date: Mon, 18 Apr 2016 14:12:28 -0700
Message-ID: <1461013950-12503-1-git-send-email-sbeller@google.com>
Cc: git@vger.kernel.org, jacob.keller@gmail.com,
	Stefan Beller <sbeller@google.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Mon Apr 18 23:13:03 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1asGTa-0001ds-8B
	for gcvg-git-2@plane.gmane.org; Mon, 18 Apr 2016 23:12:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752027AbcDRVMk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Apr 2016 17:12:40 -0400
Received: from mail-pf0-f169.google.com ([209.85.192.169]:36415 "EHLO
	mail-pf0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751938AbcDRVMi (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Apr 2016 17:12:38 -0400
Received: by mail-pf0-f169.google.com with SMTP id e128so84309879pfe.3
        for <git@vger.kernel.org>; Mon, 18 Apr 2016 14:12:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=d3sMasQsIfb+9epDr3ZjPatXf0gRhC9U0xHyAF/YGs8=;
        b=Tk/DTG0OSB1YvT5FPAiYWiuRa+HbBDZ/vIcRySOkKwBPV4ebInsa/FvbVYF+tBwldK
         C8AR/sKs00jir4H+3ZRRwUyGiRGNxl79DfrM6V4n3fiIQ3nmkeC2nVjW/rv4mSn1Z4KC
         I/ER1klY6Qj8i5WbezoFRuYuB/lkceE6sBwfW++8HFCr4kAtjw5VVa4EX2e4dmE4Akcv
         n3JhkzqiXPoQuIYMd3MvRGdNOEXGs83oStj0Z8hWiT8jQT890K38YJNmTx08+AeRiWLa
         KE/dGCayS93UeDHlTFo+LF5X3fB7IZkBpIDyOO5ZG1QawUvfpwLA+fPfDqzTpNnvYwN+
         v0iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=d3sMasQsIfb+9epDr3ZjPatXf0gRhC9U0xHyAF/YGs8=;
        b=IuF/88QBTvd1L9C4HN2i5sR7mqLXK8ENA5HjZJYb28v+RfiTXXKYUcMFhZ+D5FDAan
         9bkU3+GiJfIorel31NX6rVqbIZHhJJhZ4N0eOyBvT48aBJi8en17xZLbVXwQ9FbJ4mNo
         zYVJzWeS2G6LdZ7EB1jZJ3eVG0MHS8h/wHjV1z6wdTb2W2cvrhIQs2mrRr3saB2QYBFE
         dRngY/+kyNHMP8NeJCNWdmZkV776jycT0YQJe+6bgi4ZT7WPTxvDB/JrOw7TXd/4EPtT
         /tCK1bBznfc1S3rbpQ4SHBFGm3iLKx67IaL7qZAu8Ad9mQqmqI6fgLlVAWtqP9C2rK1n
         aO7g==
X-Gm-Message-State: AOPr4FXT/0sAm7AXTsOkl+rV5OpS5VcTPsQhqwRsl4C8ecowfH7dZrjJtOBe5g1Ce2A5bHaf
X-Received: by 10.98.93.29 with SMTP id r29mr27924194pfb.18.1461013957710;
        Mon, 18 Apr 2016 14:12:37 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:6869:43f:e72f:2f19])
        by smtp.gmail.com with ESMTPSA id f12sm85763672pfd.87.2016.04.18.14.12.36
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 18 Apr 2016 14:12:36 -0700 (PDT)
X-Mailer: git-send-email 2.8.1.212.gdf84f39
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291827>

> OK, so perhaps either of you two can do a final version people can
> start having fun with?

Here we go. I squashed in your patch, although with a minor change:

-               if ((flags & XDF_SHORTEST_LINE_HEURISTIC)) {
+               if ((flags & XDF_COMPACTION_HEURISTIC) && blank_lines) {

We did not need that in the "shortest line" heuristic as we know
a line with the shortest line length must exist. We do not know about
empty lines though.

Thanks,
Stefan

Jacob Keller (1):
  xdiff: add recs_match helper function

Stefan Beller (1):
  xdiff: implement empty line chunk heuristic

 Documentation/diff-config.txt  |  5 +++++
 Documentation/diff-options.txt |  6 ++++++
 diff.c                         | 11 +++++++++++
 xdiff/xdiff.h                  |  2 ++
 xdiff/xdiffi.c                 | 40 ++++++++++++++++++++++++++++++++++++----
 5 files changed, 60 insertions(+), 4 deletions(-)

-- 
2.8.0.26.gba39a1b.dirty
