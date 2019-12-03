Return-Path: <SRS0=UYkv=ZZ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4739EC432C0
	for <git@archiver.kernel.org>; Tue,  3 Dec 2019 22:08:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 072FB20659
	for <git@archiver.kernel.org>; Tue,  3 Dec 2019 22:08:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="R+Yal3fv";
	dkim=pass (1024-bit key) header.d=kyleam.com header.i=@kyleam.com header.b="fyrpe4Mi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727625AbfLCWIH (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 3 Dec 2019 17:08:07 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:55713 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727578AbfLCWIG (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Dec 2019 17:08:06 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id CAAA2A7A3D;
        Tue,  3 Dec 2019 17:08:04 -0500 (EST)
        (envelope-from kyle@kyleam.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:date:message-id:mime-version:content-type; s=sasl; bh=Z
        5xfmVW9tIc+S9FnJFlZ8pUYy6I=; b=R+Yal3fvMtp05vxAJ4L0cktEM+LjRN5Uz
        xC6K35b6dDkTr9xm5mfOxRB28uUZGncScQmYJwJ8b7FNoExVfR0c5J0KDneazXZx
        tLGF9RDAy3/MO8QxPidKDmDs5tsLBXhTFKaiZzhuFShrNIdpP0gzj1T8Lme3OcVm
        F3fr0CFIqk=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id C3DA5A7A3C;
        Tue,  3 Dec 2019 17:08:04 -0500 (EST)
        (envelope-from kyle@kyleam.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=kyleam.com;
 h=from:to:cc:subject:date:message-id:mime-version:content-type; s=mesmtp;
 bh=czEnkk7cmpqHRFxJeXW+YupJDaw4lnKXtCIjmY5wnIU=;
 b=fyrpe4MiKkIDxSZZsKh/RRFh4bIRam76W/lOotU7jZYGu/yd0uD0nMhdRh9EoaJDD5JIWWHbSCllVfERFgnN05xTVHGkhmEkx8SzA39Z4xOt2eYVooP/5q//0mzE9XelEPHoTIwrNUB/HJ+xfANazBotVsQtK5Zc8FFIz6UpkJA=
Received: from localhost (unknown [45.33.91.115])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 114B8A7A38;
        Tue,  3 Dec 2019 17:08:02 -0500 (EST)
        (envelope-from kyle@kyleam.com)
From:   Kyle Meyer <kyle@kyleam.com>
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>
Subject: [BUG?] ls-files -o now traverses nested repo when given multiple pathspecs
Date:   Tue, 03 Dec 2019 17:08:00 -0500
Message-ID: <87fti15agv.fsf@kyleam.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 5F869438-1619-11EA-BF50-8D86F504CC47-24757444!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

89a1f4aaf7 (dir: if our pathspec might match files under a dir, recurse
into it, 2019-09-17) introduced a change in behavior in terms of
traversing untracked nested repositories.  Say we have a repository that
contains a single untracked repository with untracked content:

    $ git init && git init a && touch a/x

Calling ls-files with the nested repository as the sole pathspec does
not recurse into that repository:

    $ git ls-files --other a
    a/

However, as of 89a1f4aaf7, adding an additional pathspec results in the
nested repository being traversed:

    $ git ls-files --other a foo
    a/
    a/x

Reading 89a1f4aaf7 and skimming the patch series and related thread [*],
I haven't found anything that makes me think this change in behavior was
intentional.

[*]: https://lore.kernel.org/git/20190905154735.29784-1-newren@gmail.com/
