Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B87931FF72
	for <e@80x24.org>; Tue, 24 Oct 2017 15:16:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751686AbdJXPQi (ORCPT <rfc822;e@80x24.org>);
        Tue, 24 Oct 2017 11:16:38 -0400
Received: from alum-mailsec-scanner-5.mit.edu ([18.7.68.17]:46189 "EHLO
        alum-mailsec-scanner-5.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751504AbdJXPQd (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 24 Oct 2017 11:16:33 -0400
X-AuditID: 12074411-f95ff70000007f0a-27-59ef5950299c
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        (using TLS with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by alum-mailsec-scanner-5.mit.edu (Symantec Messaging Gateway) with SMTP id A4.8E.32522.0595FE95; Tue, 24 Oct 2017 11:16:32 -0400 (EDT)
Received: from bagpipes.fritz.box (p57BCCBEA.dip0.t-ipconnect.de [87.188.203.234])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id v9OFGTov001980
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
        Tue, 24 Oct 2017 11:16:31 -0400
From:   Michael Haggerty <mhagger@alum.mit.edu>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org,
        Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 0/2] Fix an error-handling path when locking refs
Date:   Tue, 24 Oct 2017 17:16:23 +0200
Message-Id: <cover.1508856679.git.mhagger@alum.mit.edu>
X-Mailer: git-send-email 2.14.1
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrKIsWRmVeSWpSXmKPExsUixO6iqBsQ+T7SoGO+hUXXlW4mi4beK8wW
        t1fMZ7b40dLD7MDi8ff9ByaPZ717GD0uXlL2+LxJLoAlissmJTUnsyy1SN8ugSvj5PwbbAUd
        ohW7VncwNzAuEuxi5OSQEDCR6Gm6zdzFyMUhJLCDSWLnyQUsEM4pJol5LzawgFSxCehKLOpp
        ZgKxRQTUJCa2HQKLMwukSHQ872YEsYUFHCVOvJ4BVsMioCqx6jOEzStgLrFxxwpWiG3yEuce
        3GaewMi1gJFhFaNcYk5prm5uYmZOcWqybnFyYl5eapGuqV5uZoleakrpJkaI3wV3MM44KXeI
        UYCDUYmHt8H8XaQQa2JZcWXuIUZJDiYlUd5/74FCfEn5KZUZicUZ8UWlOanFhxglOJiVRHhX
        mLyPFOJNSaysSi3Kh0lJc7AoifPyLVH3ExJITyxJzU5NLUgtgsnKcHAoSfBGRAA1ChalpqdW
        pGXmlCCkmTg4QYbzAA1nCQMZXlyQmFucmQ6RP8VozNFx8+4fJo5nM183MAux5OXnpUqJ8+aE
        A5UKgJRmlObBTYPF7itGcaDnhHnvgizlAcY93LxXQKuYgFbJ2r8BWVWSiJCSamA0v5yT7su0
        2NmjOzT/mcHpY2W27WESLamuzNwWSxQFBGb0XZXqdzMK+sbhoiCkcTTi5Wrf5k6NeVsjGmeG
        3GUzO5rGn30uLHnZEwnDKbnxX64dt73Ss+HYjEZp96PL//C45Mx0l/CNm9vYYHvGKIr9i+3E
        0n2Ve++dm8H7NJmXc93n5RbzXZVYijMSDbWYi4oTAbvj7wW4AgAA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In [1], Peff described a bug that he found that could cause a
reference transaction to be partly carried-out and partly not, with a
successful return. The scenario that he discussed was the deletion of
one reference and creation of another, where the two references D/F
conflict with each other.

But in fact the problem is more general; it can happen whenever a
reference deletion within a transaction is processed successfully, and
then another reference update in the same transaction fails in
`lock_ref_for_update()`. In such a case the failed update and any
subsequent ones could be silently ignored.

There is a longer explanation in the second patch's commit message.

The tests that I added probe a bunch of D/F update scenarios, which I
think should be characteristic of the scenarios that would trigger
this bug. It would be nice to have tests that examine other types of
failures (e.g., wrong `old_oid` values).

Bit since the fix is obviously a strict improvement and can prevent
data loss, and since the release process is already pretty far along,
I wanted to send this out ASAP. We can follow it up later with
additional tests.

These patches apply to current master. They are also available from my
GitHub fork [2] as branch `ref-locking-fix`.

While looking at this code again, I realized that the new code
rewrites the `packed-refs` file more often than did the old code.
Specifically, after dc39e09942 (files_ref_store: use a transaction to
update packed refs, 2017-09-08), the `packed-refs` file is overwritten
for any transaction that includes a reference delete. Prior to that
commit, `packed-refs` was only overwritten if a deleted reference was
actually present in the existing `packed-refs` file. This is even the
case if there was previously no `packed-refs` file at all; now any
reference deletion causes an empty `packed-refs` file to be created.

I think this is a conscionable regression, since deleting references
that are purely loose is probably not all that common, and the old
code had to read the whole `packed-refs` file anyway. Nevertheless, it
is obviously something that I would like to fix (though maybe not for
2.15? I'm open to input about its urgency.)

[1] https://public-inbox.org/git/20171024082409.smwsd6pla64jjlua@sigill.intra.peff.net/
[2] https://github.com/mhagger/git

Michael Haggerty (2):
  t1404: add a bunch of tests of D/F conflicts
  files_transaction_prepare(): fix handling of ref lock failure

 refs/files-backend.c         |   2 +-
 t/t1404-update-ref-errors.sh | 146 +++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 147 insertions(+), 1 deletion(-)

-- 
2.14.1

