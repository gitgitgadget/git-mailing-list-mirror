From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH 0/4] Make update_refs more atomic V2
Date: Thu, 10 Apr 2014 11:30:21 -0700
Message-ID: <1397154625-11884-1-git-send-email-sahlberg@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 10 20:37:03 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WYJqO-0006pO-G9
	for gcvg-git-2@plane.gmane.org; Thu, 10 Apr 2014 20:37:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030397AbaDJSgy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Apr 2014 14:36:54 -0400
Received: from mail-vc0-f201.google.com ([209.85.220.201]:34423 "EHLO
	mail-vc0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758938AbaDJSgx (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Apr 2014 14:36:53 -0400
Received: by mail-vc0-f201.google.com with SMTP id ik5so625176vcb.2
        for <git@vger.kernel.org>; Thu, 10 Apr 2014 11:36:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=/OIAeCT0/8H+w1zzba+QTBCdwXE+dd6Kjy+8lLvOU7c=;
        b=DXGL4vzXMHKB65JkZOdkHUGiN/Ivcl2BphzN1Fo1D8vPlYhG0udZu5SL7H0ohwM9CL
         McG0Dn61mZW8DOiTPE9ii76uMdTrqWZyiX84MTuL7b4YMN68PNEZBL1iLQTbKqoYoYGO
         7pGL+4P6qNhIVRQuxgVyXQwnEfZGVECxHddBJYgd+/iXIycyzbMq/ulxrQ9GoHmz+5yb
         Va9nA14NuikNvefUM8GWwia437UDBUhJDU+oAiRurt4gcc7zufk7oMlCpzq93+CPX4mb
         n2qhHROlPhkM8HfbI1Mqo32kunCrEFd6P7ic9bsLNqLXUfx/2lm1OvkWeL8sHYIjDCH4
         VGWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=/OIAeCT0/8H+w1zzba+QTBCdwXE+dd6Kjy+8lLvOU7c=;
        b=kNFFTWVZoG9ktJ2czvEDp73gqojc4iRFrhrI4i/W60yLqdYXJdk+7oP89uur+GOSzY
         yK1V8eQ5Sq+2L+DoY7P+MtHDszQlerNoZDA3Q9BJi5t8dv8loMUTnQdJKIoCCmvzq/kK
         XWf2hjQFfg3iY9BOQK44b1hJiv3kpZxBcl9vZCEOVgzVBjjHLjT2wUKmoy9te7xD9NDX
         j4sIzLzc76ocAhrMZPaEK6rX0TAlHEmF9gsQkPvpboF0C288Wwg/lqjfYaS8skhd9z6x
         QDUVyaSeQPuRROQrUDKgf12SDYuSE2iQh+Klipt94nGypObcn7ls1WxnOJslPX4aG0HL
         SNng==
X-Gm-Message-State: ALoCoQns2wXeFhHVbKozvtx/1+zJ9RdbINF0J5BMqw8es82vRSV+g3HmwlQL09rvs1aTILM4scrofdzqtS2vIE23WaubhNnjKKb1e/tZGpHTVLFR28I4v0clOvNwm//KoDcCH3GeTwv88TdZmeVDYxXovbuTI8i1nLDMAPrDntyLVPz1grW3Ay9Xy8S4ILDL/ZAP8cPSBosm
X-Received: by 10.224.13.12 with SMTP id z12mr8824528qaz.7.1397154628630;
        Thu, 10 Apr 2014 11:30:28 -0700 (PDT)
Received: from corp2gmr1-2.hot.corp.google.com (corp2gmr1-2.hot.corp.google.com [172.24.189.93])
        by gmr-mx.google.com with ESMTPS id a44si797169yhb.6.2014.04.10.11.30.28
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 10 Apr 2014 11:30:28 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-2.hot.corp.google.com (Postfix) with ESMTP id 79D825A41AE;
	Thu, 10 Apr 2014 11:30:28 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 1B939E0591; Thu, 10 Apr 2014 11:30:27 -0700 (PDT)
X-Mailer: git-send-email 1.9.1.478.ga5a8238.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246029>

refs.c:update_refs() intermingles doing updates and checks with actually
applying changes to the refs in loops that abort on error.
This is done one ref at a time and means that if an error is detected that
will fail the operation after only some of the ref operations have been
been updated on the disk.

These patches change the update and delete functions to use a three
call pattern of

1, lock
2, update, or flag for deletion
3, apply on disk

In the final patch I change update_refs to perform these actions in three
separate loops where the final loop to 'apply on disk' all the changes will
only be performed if there were no error conditions detected during any of
previous loops.

This should make the changes of refs in update_refs slightly more atomic.


This may overlap with other current patch series for making refs updates
more atomic which may mean these patches become obsolete, but I would still
like some review and feedback on these changes.

Version 2:
Updates and fixes based on Junio's feedback.
* Fix the subject line for patches so they comply with the project standard.
* Redo the update/delete loops so that we maintain the correct order of
  operations. Perform all updates first, then perform the deletes.
* Add an additional patch that allows us to do the update/delete in the correct
  order from within a single loop by first sorting the refs so that deletes
  are after all non-deletes.


Ronnie Sahlberg (4):
  refs.c: split writing and commiting a ref into two separate functions
  refs.c: split delete_ref_loose() into a separate flag-for-deletion and
    commit phase
  refs.c: change update_refs to run the commit loops once all work is
    finished
  refs.c: sort the refs by new_sha1 and merge the two update/delete
    loops into one

 branch.c               |  10 ++++-
 builtin/commit.c       |   5 +++
 builtin/fetch.c        |   7 +++-
 builtin/receive-pack.c |   4 ++
 builtin/replace.c      |   6 ++-
 builtin/tag.c          |   6 ++-
 fast-import.c          |   7 +++-
 refs.c                 | 102 +++++++++++++++++++++++++++++++++----------------
 refs.h                 |   6 +++
 sequencer.c            |   4 ++
 walker.c               |   4 ++
 11 files changed, 123 insertions(+), 38 deletions(-)

-- 
1.9.1.478.ga5a8238.dirty
