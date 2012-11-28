From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v7 p2 0/2] fast-export fixes
Date: Wed, 28 Nov 2012 23:23:58 +0100
Message-ID: <1354141440-26534-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 28 23:24:35 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tdq3W-0006l1-Og
	for gcvg-git-2@plane.gmane.org; Wed, 28 Nov 2012 23:24:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932295Ab2K1WYT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Nov 2012 17:24:19 -0500
Received: from mail-bk0-f46.google.com ([209.85.214.46]:58508 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755909Ab2K1WYT (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Nov 2012 17:24:19 -0500
Received: by mail-bk0-f46.google.com with SMTP id q16so5975572bkw.19
        for <git@vger.kernel.org>; Wed, 28 Nov 2012 14:24:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=nK1xLbakVpXhjz4+09IB8RQYz+WHhas73CCMrue5eDc=;
        b=EnmQmVIDSwl0seFuo8aTYnKoFWfb0TnuiT9UUs6TqQgkWaAucEqUpGBl/G6BeS0gt6
         TMJhghMKO0xMBzaLYqBdaomNbrRzCcyhWNAEPs8+2W63VYuPOBNhKe+VW5+ZBk3hI0qb
         1Hj93BEq707ENJKtI7V80B4iQLkzQQQ66nQARXpjTnOvio42d5hupiUsTB4S5Yd88oUf
         UJdIwtHrTK8Sy5xCZGoEMCsOOdGkepFmRQT0Q8wuVNbgTHd9E2HOjGZb+9+W1aK+fZkG
         babDWpsnuzj8fKCWvDU+L/Mv0eo6g6ncapMVJeK3YM2CAMYVN+OuZsreun6v8ZIrSzrD
         1UCA==
Received: by 10.204.5.205 with SMTP id 13mr6376295bkw.111.1354141457809;
        Wed, 28 Nov 2012 14:24:17 -0800 (PST)
Received: from localhost (ip-109-43-0-26.web.vodafone.de. [109.43.0.26])
        by mx.google.com with ESMTPS id hm8sm10826724bkc.10.2012.11.28.14.24.15
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 28 Nov 2012 14:24:16 -0800 (PST)
X-Mailer: git-send-email 1.8.0.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210798>

Hi,

Here's version 7 part 2; I've dropped all the unnecessary patches, nobody seems
to care about the current brokedness, and I did them only to show that these
are correct, and that remote helpers without marks just don't work. These are
the ones I care about.

Below is a summary of what happens when you apply both patches, and how the new
behavior is obviously correct. All the refs point to the same object.

== before ==

  % git fast-export --export--marks=marks master
  # exported stuff
  % git fast-export --{import,export}-marks=marks test
  # nothing
  % git fast-export --{import,export}-marks=marks master ^uninteresting
  reset refs/heads/uninteresting
  from :6

  % git fast-export --{import,export}-marks=marks ^uninteresting master ^foo test
  reset refs/heads/test
  from :6

  reset refs/heads/foo
  from :6

  reset refs/heads/master
  from :6

  % git fast-export --{import,export}-marks=marks uninteresting..master

== after ==

  % git fast-export --export--marks=marks master
  # exported stuff
  % git fast-export --{import,export}-marks=marks test
  reset refs/heads/test
  from :6

  % git fast-export --{import,export}-marks=marks master ^uninteresting
  reset refs/heads/master
  from :6

  % git fast-export --{import,export}-marks=marks ^uninteresting master ^foo test
  reset refs/heads/test
  from :6

  reset refs/heads/master
  from :6

  % git fast-export --{import,export}-marks=marks uninteresting..master
  reset refs/heads/master
  from :6

Changes since v6:

  * Drop all the extra patches
  * Reorder patches so tests never fail

Felipe Contreras (2):
  fast-export: don't handle uninteresting refs
  fast-export: make sure updated refs get updated

 builtin/fast-export.c     | 21 ++++++++++++++-------
 t/t5801-remote-helpers.sh | 28 ++++++++++++++++------------
 t/t9350-fast-export.sh    | 45 +++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 75 insertions(+), 19 deletions(-)

-- 
1.8.0.1
