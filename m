Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 643151F6A9
	for <e@80x24.org>; Sat,  5 Jan 2019 15:50:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726242AbfAEPuq (ORCPT <rfc822;e@80x24.org>);
        Sat, 5 Jan 2019 10:50:46 -0500
Received: from mail-yw1-f48.google.com ([209.85.161.48]:41736 "EHLO
        mail-yw1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726236AbfAEPup (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 5 Jan 2019 10:50:45 -0500
Received: by mail-yw1-f48.google.com with SMTP id f65so15638344ywc.8
        for <git@vger.kernel.org>; Sat, 05 Jan 2019 07:50:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=77r7M6eF/Vec18n7jErCWjFvFCiyZR5abrn2ouZsxhY=;
        b=U15tOENVBn6JxGaTIDnohoXyCMp5hnXRECONz7tSgxqVcGlCin26tS/ngOtwIyFYo2
         VO9wdeLuDRlX7kv/uWW68ikg0koBBVQmzuhPqGq0W+wRw8rssX1RLmCr9xUmHiwt/rb9
         b5eS5gQtZHoamrAMxjM6Q1/9OV126TYdd6/CBesKKnizY7AXEpT66Z15EqIB7nP6/sFL
         pdHTcmGnsY6DeWEYZGv3Td+5X6iGT3awkLiVn1KK2lzgovLmA6j6wwWJ7T3NkW2H/DND
         aa71iVKJ/F6x2T6FXoeBbWFI5KBsEStt4ZBP1hZn3Fr2Tk34XQ7MlExiitE/9l0pPPBd
         lBog==
X-Gm-Message-State: AA+aEWZDICV9fRyiC86dT1I70bMrZRnzu8kocf+i9X2+ZpHMs6h29xEF
        yUcPf1v//Uat3LeRtMgFmhg1rqIai4BePZ1yEZzLRjOtqYY=
X-Google-Smtp-Source: AFSGD/Vc/n/mXRu3EKhhJXGfIDPQWMRXhhXyOXvIzbJmXvLao2h6KP3XEQ7ER3L0dq6qwXaw1rAPxpEwM1V1p6DuSSE=
X-Received: by 2002:a81:c5:: with SMTP id 188mr55016633ywa.327.1546703444177;
 Sat, 05 Jan 2019 07:50:44 -0800 (PST)
MIME-Version: 1.0
From:   Michal Novotny <clime@redhat.com>
Date:   Sat, 5 Jan 2019 16:50:30 +0100
Message-ID: <CANT8FXRRTpAaW0JxYCt94f52eKAz1cBAGpPA84CUTMJUgQrkuw@mail.gmail.com>
Subject: A few questions regarding git annotated tags
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,

I am making an rpm packaging application called rpkg-util
(https://pagure.io/rpkg-util) that can render parts of rpm metadata
from git metadata, e.g. software version. It uses annotated tags to
store most of the data that are then rendered to an rpm spec file
(e.g. the version or changelog).

Now I would like to make sure that I am not omitting some better
approach than the one that I am currently using and for that I would
like to ask the following questions.

I could potentially make it so that I tag subtrees instead of commits
and then derive the needed information from these subtree tags. This
could be useful if I have multiple rpm packages in different subtrees
of the same repo. I could then tag the subtree where the rpm package
is placed.

This could bring some simplification into the code but as far as I
know, you cannot easily checkout a tree tag, which is something a
packager should be able to do easily: to checkout a state of repo when
a certain subpackage was tagged. This is the first question. Can you
e.g. do:

git tag somename HEAD:

and then do something similar to

git checkout somename

which would restore the repository or at least the respective subtree
of it into the state when "somename" tag was created?

Right now, I am putting a package name directly into tag name so I
know what tags belong to what package based on that. And I am using
normal annotated tags. This works quite well, I would say, but at one
point I need to use shared state to move the discovered package name
from one part of the code to another so that the other part can work
with the correct subset of the available annotated tags. I wouldn't
need to do that if I could derive the correct tag subset based just on
the path to the subtree where a package is placed. The path can be
simply an input parameter of all my functions and they could all fetch
the correct tag subset based just on that information. Those functions
are independent of each other, they all derive some information from
the tags but each one is specialized to fetch a different piece of
information. This would be nice. Right now some of my functions accept
name when they need to fetch the associated tag set and work with it
and some accept path if they don't require the tag set.

Alternative approach to creating the tree tags would be to store the
path information into annotated tag message, which I could do. But is
there a relatively simple way to filter tags based on their message
content? Can I put the information into some other part of tag than
name or the message so that it can be easily filtered?

It would be also good if the association of the tags to the subtrees
was made obvious (it will no longer be obvious when it won't depend on
name of the tag) but that's a different problem that I could
potentially solve if I can make the tag<->subtree relation work in
some way. I am pretty happy with the current name-based solution but I
don't want to miss something obvious or less obvious.

Thank you
Michal Novotny
