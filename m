From: Stefan Beller <sbeller@google.com>
Subject: [PATCH 0/8] Making reflog modifications part of the transactions API
Date: Fri,  5 Dec 2014 18:46:27 -0800
Message-ID: <1417833995-25687-1-git-send-email-sbeller@google.com>
Cc: Stefan Beller <sbeller@google.com>
To: git@vger.kernel.org, mhagger@alum.mit.edu, jrnieder@gmail.com,
	ronniesahlberg@gmail.com, gitster@pobox.com
X-From: git-owner@vger.kernel.org Sat Dec 06 03:46:50 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xx5OU-0004kd-1o
	for gcvg-git-2@plane.gmane.org; Sat, 06 Dec 2014 03:46:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751016AbaLFCqj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Dec 2014 21:46:39 -0500
Received: from mail-ig0-f172.google.com ([209.85.213.172]:54120 "EHLO
	mail-ig0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750779AbaLFCqi (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Dec 2014 21:46:38 -0500
Received: by mail-ig0-f172.google.com with SMTP id hl2so283137igb.5
        for <git@vger.kernel.org>; Fri, 05 Dec 2014 18:46:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=1vvS0Ejzspu/DP0/NBArkKIWKp4TCo++2lZCeBkKKJc=;
        b=RLIuqo90xwzV2EOz1PLgW7UJl1vfAfHW6ERx1w6mlgLQFGTD1G/b9LClqimvSBiq/a
         sTmAzb7exCffoBZhYsgcgXQ2ugAcRGiZT7YRrQ9sAit2vrN7EJb263o49a8hOww27g65
         6ef6N5BdBUBVSTgFZLgtPMthQbDsE9Nz/zyGGRf8FCGg0Ox8kPQ9ysEjxHCxZjKLHbaU
         h70Og4TudLxpVPMGktj1LxpQMIiJYa06gQkMyji12Afm8Hpg4CdPoD5PRvztJPOcyGjc
         y5GEIqpIOyB14euf135I/05SEBKbS27jBE+UksKYdhkVB5Bi6XV6irnzAvKp6YP/0HCM
         3GEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=1vvS0Ejzspu/DP0/NBArkKIWKp4TCo++2lZCeBkKKJc=;
        b=ZtOji1k+7wZPQFq/oi4OZwM4ihtHBB88bHwQ1mmyZlTpVqkIRzbOrd7ggiKyYANVwM
         2IF275iTevIRQkJ3xeW2tqXzlMwF7/8J0D3hsYARKVTQ9blQ2w+wW/5cHVO8BWfh/kmC
         6yH663PYNCRGMqQJqLF5NZDxWTDOjUeb3rIgkXVAn/+ZW1oKwzhX8+/X5oxXrELQvtMt
         KvJ7GcK/42M591pyjyrg+nhavYIlgW3iAlUcr1KijUbMhgaQcBliDXX008k6zJyEnI2Q
         Bopb2H6NH3MOGoE1YFAnEAVIJyZrkUjF9D2cZBiQn9I+QUlTICbVpPDIm3w24LRnk0hM
         vvow==
X-Gm-Message-State: ALoCoQnXj8iqigDhNTRhQVH1zE+SiOIzjI79HwL4/mmQzaxOiTiJL2BBsfWQueoQyxwtaMeQ593X
X-Received: by 10.42.95.208 with SMTP id g16mr18355185icn.81.1417833998166;
        Fri, 05 Dec 2014 18:46:38 -0800 (PST)
Received: from localhost ([2620:0:1000:5b00:4022:de56:febc:d879])
        by mx.google.com with ESMTPSA id l7sm160575igv.12.2014.12.05.18.46.37
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 05 Dec 2014 18:46:37 -0800 (PST)
X-Mailer: git-send-email 2.2.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260925>

This goes on top of Michaels series. The idea of this series is make the
reflogs being part of the transaction API, so it will be part of the contract
of transaction_commit to either commit all the changes or none at all.

Currently when using the transaction API to change refs, also reflogs are changed.
But the changes to the reflogs just happen as a side effect and not as part of
the atomic part of changes we want to commit altogether.

Ronnie Sahlberg (3):
  refs.c: use a reflog transaction when writing during expire
  refs.c: rename log_ref_setup to create_reflog
  refs.c: allow deleting refs with a broken sha1

Stefan Beller (5):
  refs.c: let fprintf handle the formatting
  refs.c: rename the transaction functions
  refs.c: rename transaction.updates to transaction.ref_updates
  refs.c: add transaction function to append to the reflog
  refs.c: add transaction function to delete the reflog

 branch.c               |  13 +-
 builtin/branch.c       |   5 +-
 builtin/checkout.c     |   8 +-
 builtin/commit.c       |  10 +-
 builtin/fetch.c        |  12 +-
 builtin/receive-pack.c |  13 +-
 builtin/replace.c      |  10 +-
 builtin/tag.c          |  10 +-
 builtin/update-ref.c   |  26 ++--
 cache.h                |   7 +
 fast-import.c          |  22 +--
 refs.c                 | 359 ++++++++++++++++++++++++++++++++++---------------
 refs.h                 |  43 +++---
 sequencer.c            |  12 +-
 t/t3200-branch.sh      |   8 ++
 walker.c               |  10 +-
 16 files changed, 359 insertions(+), 209 deletions(-)

-- 
2.2.0
