From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH 0/3] Make update-refs more atomic
Date: Tue,  8 Apr 2014 16:21:21 -0700
Message-ID: <1396999284-4691-1-git-send-email-sahlberg@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 09 01:21:37 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WXfKi-0007GK-Cg
	for gcvg-git-2@plane.gmane.org; Wed, 09 Apr 2014 01:21:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757372AbaDHXVb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Apr 2014 19:21:31 -0400
Received: from mail-qc0-f201.google.com ([209.85.216.201]:53074 "EHLO
	mail-qc0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756235AbaDHXV3 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Apr 2014 19:21:29 -0400
Received: by mail-qc0-f201.google.com with SMTP id c9so250310qcz.0
        for <git@vger.kernel.org>; Tue, 08 Apr 2014 16:21:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=ZDept4/E5r5QkJkGkI+yXDVlRVONWAB7CGzyWtraZ3I=;
        b=bLMTlc//8YxJiO0bJVRGCaciLfL+Y7TWN3c6bi1gaj8fVqztGiEtwy4lveUUxn14Tp
         mdUD6IUPpU3CF7jLkOhVWGohxjLVNHWFQq6s4I4+H0el/Lh9Epib8XW0kNtQrDo7eRH+
         OtvkjpQkQYZHbL/a1pDQzk6TjFt/rIfkvvZ5XQGbkNlv4Adhe8aZBxzOBWWx4MCGi3+P
         dZKeQTJ0b98RAdwzgYf00feOA7j94KRY/gwZpqT1uPf4avZHid5PAJ1AmTLjn7giZtqt
         dHhSMQZrDTWACdrV9YCv9LVMoqn3iOjrpbXbgTyuUppFGHB68VRT0EHyT4ndteCeEqKH
         I7jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=ZDept4/E5r5QkJkGkI+yXDVlRVONWAB7CGzyWtraZ3I=;
        b=lqnD+cSKghIMCx7ePdvuR58skxAlc0y0N8MfVrX7fxmtmaxpNTWjWbPePD7IPuwU7U
         E4QR5PDWtC7uQzLdLNi+EFMPKd49nCLAZEKDLSAOli0IQnEyIk0CpA41jqQtu3ROiIRN
         T5t2mxkUEDnNqu6wiX0vb3unz+bNiaFlrNP3piEhQUiPGO132/MH972rtMX3uRIk+DN0
         d1NVI9kH6DNju1FsLR/rK/o4tZ0JmrY5IMPxhxRnHhQmFdRTxlP5DMRYFM13b2DHDCG5
         NBxfKGcDKbmylYOMdoN5ya4S+Z1CSvKBJ42Zobdcm+LZg4LAq6bixBp4eJj9sot0J2Mu
         QX2Q==
X-Gm-Message-State: ALoCoQlfvfw4f8MxVFifAoG0ghE9tAQeBlAEENLxxsXg70P9T6OciBWj2ZhjcNdKlrCkDTJs2oZ0/cw5NhqfFYNaWJVGlLEJKxtcU4yPPlASl//xZa1EIf/Y1bddIimwa7JeA0O3HbNzzwhiQI/e9kkgyifzOzuO6QEr8GtQ2K2WCjQuumtOQ1gb8ADSQjztH+VqabFBF3n8
X-Received: by 10.236.117.79 with SMTP id i55mr2591372yhh.16.1396999288781;
        Tue, 08 Apr 2014 16:21:28 -0700 (PDT)
Received: from corp2gmr1-2.hot.corp.google.com (corp2gmr1-2.hot.corp.google.com [172.24.189.93])
        by gmr-mx.google.com with ESMTPS id r61si693639yhf.1.2014.04.08.16.21.28
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 08 Apr 2014 16:21:28 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-2.hot.corp.google.com (Postfix) with ESMTP id A085B5A4223;
	Tue,  8 Apr 2014 16:21:28 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 3EACEE0878; Tue,  8 Apr 2014 16:21:28 -0700 (PDT)
X-Mailer: git-send-email 1.9.1.477.g7668a0d.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245966>

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



Ronnie Sahlberg (3):
  Split writing and commiting a ref into two separate functions.
  Split delete_ref_loose() into a separate flag-for-deletion and commit
    phase
  Change update_refs to run a single commit loop once all work is
    finished.

 branch.c               | 10 ++++--
 builtin/commit.c       |  5 +++
 builtin/fetch.c        |  7 +++-
 builtin/receive-pack.c |  4 +++
 builtin/replace.c      |  6 +++-
 builtin/tag.c          |  6 +++-
 fast-import.c          |  7 +++-
 refs.c                 | 90 +++++++++++++++++++++++++++++++++-----------------
 refs.h                 |  6 ++++
 sequencer.c            |  4 +++
 walker.c               |  4 +++
 11 files changed, 112 insertions(+), 37 deletions(-)

-- 
1.9.1.477.g7668a0d.dirty
