From: Johan Herland <johan@herland.net>
Subject: [PATCH 0/5] Fixing problem with deleting symrefs
Date: Tue, 16 Oct 2012 15:44:49 +0200
Message-ID: <1350395094-11404-1-git-send-email-johan@herland.net>
References: <CAPc5daUws-MfzC9imkytTrLaHyyywE4_OX1jAUVPCTK2WyUF=w@mail.gmail.com>
Cc: git@vger.kernel.org, rene.scharfe@lsrfire.ath.cx, vmiklos@suse.cz,
	Johan Herland <johan@herland.net>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Tue Oct 16 15:45:41 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TO7Sl-0004jH-Ra
	for gcvg-git-2@plane.gmane.org; Tue, 16 Oct 2012 15:45:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754156Ab2JPNpI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Oct 2012 09:45:08 -0400
Received: from mail-ee0-f46.google.com ([74.125.83.46]:51720 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754054Ab2JPNpH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Oct 2012 09:45:07 -0400
Received: by mail-ee0-f46.google.com with SMTP id b15so3506445eek.19
        for <git@vger.kernel.org>; Tue, 16 Oct 2012 06:45:05 -0700 (PDT)
Received: by 10.14.213.201 with SMTP id a49mr21231424eep.4.1350395105439;
        Tue, 16 Oct 2012 06:45:05 -0700 (PDT)
Received: from gamma.cisco.com (64-103-25-233.cisco.com. [64.103.25.233])
        by mx.google.com with ESMTPS id o47sm11333415eem.11.2012.10.16.06.45.03
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 16 Oct 2012 06:45:04 -0700 (PDT)
X-Mailer: git-send-email 1.7.12.1.609.g5cd6968
In-Reply-To: <CAPc5daUws-MfzC9imkytTrLaHyyywE4_OX1jAUVPCTK2WyUF=w@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207828>

I see that Rene Scharfe has also worked on the same issue, while I was
preparing these patches...

On Mon, Oct 15, 2012 at 11:29 AM, Junio C Hamano <jch2355@gmail.com> wrote:
> Even though update-ref deferences a symref when it updates one to point at a
> new object, I personally don't think update-ref -d that derefs makes any
> sense. I'd rather see it error out when given a symref, with or without
> --no-deref option.

I'm not sure. We have multiple testcases that directly test deleting a ref
through a symref (e.g. t1400), so supporting this seems like a concious
decision. Erroring out when given a symref will break the following
testcases:
 - t1400 (git update-ref -d)
 - t3310 & t3311 (git notes merge --abort is broken)
 - t5505 (git remote set-head --delete and renaming a remote is broken)

> But even if it did, removing a ref pointed by a symref should really remove
> it, and forgetting to remove a leftover entry in packed-ref has no excuse
> bug.
>
> I'd say what you observed is a double bug.

Patch #1 - #2 fixes the 2nd bug (removing through a symref should remove
both loose and packed versions of the ref).

Patch #3 fixes an associated problem where deleting a symref would remove
the dereferenced ref's reflog instead of the symref's reflog.

Patch #4 - #5 introduces solution A presented in my previous mail (i.e.
'git branch -d' never dereferences symrefs).

Johan Herland (5):
  t1400-update-ref: Add test verifying bug with symrefs in delete_ref()
  delete_ref(): Fix deletion of refs through symbolic refs
  delete_ref(): Remove the correct reflog when deleting symrefs
  Add tests for using symbolic refs as branch name aliases.
  branch -d: Fix failure to remove branch aliases (symrefs)

 builtin/branch.c                        |  2 +-
 refs.c                                  | 35 +++++++++++-----------
 t/t1400-update-ref.sh                   | 18 +++++++++++
 t/t3220-symbolic-ref-as-branch-alias.sh | 53 +++++++++++++++++++++++++++++++++
 4 files changed, 90 insertions(+), 18 deletions(-)
 create mode 100755 t/t3220-symbolic-ref-as-branch-alias.sh

--
1.7.12.1.609.g5cd6968
