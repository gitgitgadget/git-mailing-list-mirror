From: Thomas Gummerer <t.gummerer@gmail.com>
Subject: [PATCH v3 0/3] Introduction of a ce_namelen field
Date: Wed, 11 Jul 2012 11:22:35 +0200
Message-ID: <1341998558-8502-1-git-send-email-t.gummerer@gmail.com>
References: <7vy5mtlebz.fsf@alter.siamese.dyndns.org>
Cc: gitster@pobox.com, trast@student.ethz.ch, mhagger@alum.mit.edu,
	pclouds@gmail.com, t.gummerer@gmail.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 11 11:23:28 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sot8n-0001jJ-U1
	for gcvg-git-2@plane.gmane.org; Wed, 11 Jul 2012 11:23:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753561Ab2GKJXU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Jul 2012 05:23:20 -0400
Received: from mail-ee0-f46.google.com ([74.125.83.46]:55856 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751835Ab2GKJXT (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Jul 2012 05:23:19 -0400
Received: by eekb15 with SMTP id b15so151965eek.19
        for <git@vger.kernel.org>; Wed, 11 Jul 2012 02:23:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=MkYyWoBXxlKxLFVI6LdLN/6J8jHqU0nmxr+WrD4V3jY=;
        b=Ipo8Xqz7GxzK4X428mGeFo/cChid4SlyJE0XKWmxFN0Su6a7+7Dqxj6kPXl+cMybUe
         VYsTGv1h53qZNFxJNumkCg+VWukPbwW814a/5WbVxxU+oxwgwH9U+KuRkv65K36xnvg1
         xx1AXlFqyYZDXMQiLr2BUk9K89He0j5tfJpGyq8cUDPKTxfXvIsXxKRtlb5k230gEtWx
         yns/ktYJC0r/JrKV4w2zaHnbhYyS/MT9mu+QvoQWohGo5mKXFQxQtB5bwR9HFTurHAXC
         y23vJ7B4USlQz2IrSq91KmriT9w7KwTGsOzRkb3fYJhk7DbEn6ZybrHvxNmTer2RMOmI
         NTaA==
Received: by 10.14.97.137 with SMTP id t9mr11838314eef.73.1341998597678;
        Wed, 11 Jul 2012 02:23:17 -0700 (PDT)
Received: from localhost ([2a01:7e00::f03c:91ff:fedf:f4db])
        by mx.google.com with ESMTPS id u56sm3885001eef.7.2012.07.11.02.23.16
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 11 Jul 2012 02:23:17 -0700 (PDT)
X-Mailer: git-send-email 1.7.10.GIT
In-Reply-To: <7vy5mtlebz.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201291>

Thanks to Junio for reviewing v2 of this patch series.

The speedup coming from introducing the field exists, but is minimal,
here are the times for 1000 runs of git ls-files on the Webkit index,
first without the ce_namelen field, and then with the ce_namelen field.
$ time ./test.sh

real 4m40.895s
user 3m39.642s
sys 0m40.159s

$ time ./test.sh

real 4m34.872s
user 3m37.176s
sys 0m40.401s

1/3 is a bugfix for very long files which share at least 4096
characters in their filename. It also includes a test, tough I'm
not sure I have put it in the right place.

The other two patches are rerolls from v2 of this series.

[PATCH v3 1/3] read-cache.c: Handle long filenames correctly
[PATCH v3 2/3] Strip namelen out of ce_flags into a ce_namelen field
[PATCH v3 3/3] Replace strlen() with ce_namelen()

builtin/apply.c           |    3 ++-
builtin/blame.c           |    3 ++-
builtin/checkout.c        |    3 ++-
builtin/update-index.c    |    9 ++++++---
cache.h                   |   19 ++++++-------------
read-cache.c              |   62 +++++++++++++++++++++++++++++++++++++++-----------------------
t/t0007-long-filenames.sh |   62 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
tree.c                    |    7 ++++---
unpack-trees.c            |    5 +++--
9 files changed, 126 insertions(+), 47 deletions(-)
