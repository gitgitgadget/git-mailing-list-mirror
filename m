Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5F0802021E
	for <e@80x24.org>; Tue, 15 Nov 2016 14:13:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753519AbcKOONU (ORCPT <rfc822;e@80x24.org>);
        Tue, 15 Nov 2016 09:13:20 -0500
Received: from homie.mail.dreamhost.com ([208.97.132.208]:37514 "EHLO
        homiemail-a3.g.dreamhost.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752966AbcKOONT (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 15 Nov 2016 09:13:19 -0500
Received: from homiemail-a3.g.dreamhost.com (localhost [127.0.0.1])
        by homiemail-a3.g.dreamhost.com (Postfix) with ESMTP id ACBD228406E
        for <git@vger.kernel.org>; Tue, 15 Nov 2016 06:13:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=mattmccutchen.net; h=
        message-id:subject:from:to:date:content-type:mime-version:
        content-transfer-encoding; s=mattmccutchen.net; bh=sRNxN75tzK41k
        cj5c9G/R42i/1Y=; b=TpovthTPRo1dxzE+4w/wvpEukIC5R+cheOt05xZkSqNho
        vWFtjRmxJFOXW5CBFyHjvUNIzm6aVIaBq1lYOP45rhd2boy9Td+Aow5ruXhwdt8b
        8Est0kd8U9PxMazMrUWgJaE4guuAGZjYEwAHxQVOdBMSpLdk9sIsu5Hnzu1eDg=
Received: from main (c-50-177-20-184.hsd1.ma.comcast.net [50.177.20.184])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: matt@mattmccutchen.net)
        by homiemail-a3.g.dreamhost.com (Postfix) with ESMTPSA id 630C628406A
        for <git@vger.kernel.org>; Tue, 15 Nov 2016 06:13:18 -0800 (PST)
Message-ID: <1479219194.2406.73.camel@mattmccutchen.net>
Subject: Protecting old temporary objects being reused from concurrent "git
 gc"?
From:   Matt McCutchen <matt@mattmccutchen.net>
To:     git <git@vger.kernel.org>
Date:   Tue, 15 Nov 2016 09:13:14 -0500
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The Braid subproject management tool stores the subproject content in
the main tree and is able to switch to a different upstream revision of
a subproject by doing the equivalent of "git read-tree -m" on the
superproject tree and the two upstream trees. =C2=A0The tricky part is
preparing temporary trees with the upstream content moved to the path
configured for the superproject. =C2=A0The usual method is "git read-tree
--prefix", but using what index file? =C2=A0Braid currently uses the user=
's
actual worktree, which can leave a mess if it gets interrupted:

https://github.com/cristibalan/braid/blob/7d81da6e86e24de62a74f3ab8d88066=
6cb343b04/lib/braid/commands/update.rb#L98

I want to change this to something that won't leave an inconsistent
state if interrupted. =C2=A0I've written code for this kind of thing befo=
re
that sets GIT_INDEX_FILE and uses a temporary index file and "git
write-tree". =C2=A0But I realized that if "git gc" runs concurrently, the
generated tree could be deleted before it is used and the tool would
fail. =C2=A0If I had a need to run "git commit-tree", it seems like I mig=
ht
even end up with a commit object with a broken reference to a tree.
=C2=A0"git gc" normally doesn't delete objects that were created in the l=
ast
2 weeks, but if an identical tree was added to the object database more
than 2 weeks ago by another operation and is unreferenced, it could be
reused without updating its mtime and it could still get deleted.

Is there a recommended way to avoid this kind of problem in add-on
tools? =C2=A0(I searched the Git documentation and the web for informatio=
n
about races with "git gc" and didn't find anything useful.) =C2=A0If not,=
 it
seems to be a significant design flaw in "git gc", even if the problem
is extremely rare in practice. =C2=A0I wonder if some of the built-in
commands may have the same problem, though I haven't tried to test
them. =C2=A0If this is confirmed to be a known problem affecting built-in
commands, then at least I won't feel bad about introducing the
same=C2=A0problem=C2=A0into add-on tools. :/

Thanks,
Matt
