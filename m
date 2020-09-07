Return-Path: <SRS0=kCdt=CQ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BCF7C43461
	for <git@archiver.kernel.org>; Mon,  7 Sep 2020 18:51:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4FAF22145D
	for <git@archiver.kernel.org>; Mon,  7 Sep 2020 18:51:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="Lng6lWqd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729404AbgIGSvI (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Sep 2020 14:51:08 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:55506 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729204AbgIGSvG (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Sep 2020 14:51:06 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 885A9E4495;
        Mon,  7 Sep 2020 14:51:04 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=TEbg9p0mJi0RUJvjPue2ecFg+bo=; b=Lng6lW
        qd2YA0ilLUNb8aKTFZoPi+siZQtunP5fSVCYsYXTYFDkE8qdzRuAIF9X6p1JnMWb
        4ce1fHzGMBNvsCSFMNrx+tRUw67fpfGLax+zTK5t7PTsbfuvp/R27ZYNHriRrd9W
        3Fd3XiqyG38PHZKX6dl9MYI7nHUiBi0pGHLik=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=YuZYfEl85Jl2LKRNZyPeEMSFzPFWbflv
        ENO52083EITx9y/8GNbToDts9dljUaM/eItdZ6sjDt8nESIGXZGBWYs95kaQkVDC
        uB/0WrA3SUKRNNqIKEuMlP2QVXe86M3DhlV2ip5Jfa3SzBs4XpxCJbWi4gibg3tC
        Dv7QKy1QbXg=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 815DEE4494;
        Mon,  7 Sep 2020 14:51:04 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id C141BE4492;
        Mon,  7 Sep 2020 14:51:01 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Drew DeVault" <sir@cmpwn.com>
Cc:     <git@vger.kernel.org>
Subject: Re: Proposal: server-advertised config options
References: <C5HAJYI9RDPU.1CPN4E1JCQCAQ@homura>
Date:   Mon, 07 Sep 2020 11:51:00 -0700
In-Reply-To: <C5HAJYI9RDPU.1CPN4E1JCQCAQ@homura> (Drew DeVault's message of
        "Mon, 07 Sep 2020 12:52:12 -0400")
Message-ID: <xmqqimcp1kvf.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 13571D00-F13B-11EA-AB58-843F439F7C89-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Drew DeVault" <sir@cmpwn.com> writes:

> The basic idea is that the server could advertise some config options
> which it recommends the client sets for a given repo after a fetch. Some
> possible use-cases for this feature include setting:
>
> - format.subjectPrefix to 'PATCH my-project'
> - sendemail.to to the mailing list address
> - push.pushOption to recommended push options
>
> Upon cloning, each recommended config option would be displayed to the
> user, and they would be prompted ([Y/n]) to agree to set that value in
> the config file for that repository. Additionally, there would be a
> config option which white-lists a list of config options which are
> automatically agreed to without prompting, and each config option would
> have one of the following states:
>
> - accept-silent: set the option without printing a message
> - accept-verbose: set the option and display a message
> - prompt: prompt the user to set this config option
> - reject-silent: silently refuse to set this config option
> - reject-verbose: refuse to set this config option and display a message
>
> We would default to reject-verbose for all unknown config options and
> include a set of defaults which specifies the appropriate trust level
> for various useful benign options (such as the examples above).
>
> The implementation would involve advertising config-advertisement in the
> fetch protocol. Both the client and server would have to agree to use
> it. If the server supports it but the client does not (in the case of an
> old client), it could fall back to printing the list of recommended
> options to stderr.
>
> To choose which config options to advertise, a new option would be
> introduced (uploadpack.advertiseOptions) for example, which has a list
> of .git/config options from the remote repository to forward to the
> client.
>
> This would be a lot of work so I'd like to float it for discussion
> before getting started. What do you guys think?

Assuming I am among the guys (do you solicit opinions from gals, by
the way?), here are a few unconnected random thoughts.

I do not want to see this as a "server" thing.  All the examples are
"per project preference" and I do agree it would be nice to have a
standardised way for projects to communicate their preference to
their participants.  Regardless of the hosting site I clone and
fetch my project from, I'd want to see it communicated consistently
to them.

Which means that it must not be a patch to the "server" component to
what responds to your "git fetch" and "git clone" (i.e. upload-pack)
as some hosting sites do not even use upload-pack.

Also, I do not want to see this as a "git" thing and I mean it in
two ways.  

In addition to your examples of "per project preference", there are
projects' coding style guides, etc., that we do not enforce as git
config at all, e.g. how wide your editors TAB and single level of
indentation should be.  It will unnecessarily narrow your view to
assume that the kind of "per project preference" you convey from the
project to its participants need to be the Git configuration and
nothing else.

And this should not be a "git the SCM" thing.  If you download and
extract a release tarball and write a patch on top of it, you should
be able to learn what the project convention of what the "[PATCH]"
prefix looks like and what the mailing list address is, even though
you did not clone with "git".

All of the above leads to a design to have a common convention
widely shared among projects to express project preferences over
different kind of tools, among which Git is one of them, and store
it in a known location in the projects' trees.  Most importantly,
there must not be any Git protocol extension for doing this kind of
thing.  

Don't limit the user's choice in either of these two ways.  The
preferences for tools other than Git should be sharable with the
same ease as preference for Git, and the preference should be
sharable with the same ease to those who use Git and those who
don't.

Perhaps have a .project-preference/ directory at the root level of
the project tree, talk with other SCM vendors and editor vendors to
design what kind of information are recorded in that directory and
how, and write a script to work on that to map the project
preference information to git configuration while other SCM vendors
and editor vendors write their scripts to help their users to map
the project preference information to the configuration files that
their tools use.  Then you can either write a wrapper around "git
clone" to first run "git clone" and then run these scripts you
prepare to process the contents of the .project-preference
directory, or perhaps trigger these scripts from the post-clone hook.
