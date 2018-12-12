Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FORGED_GMAIL_RCVD,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CE2F120A1E
	for <e@80x24.org>; Wed, 12 Dec 2018 07:15:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726298AbeLLHPT (ORCPT <rfc822;e@80x24.org>);
        Wed, 12 Dec 2018 02:15:19 -0500
Received: from mail.javad.com ([54.86.164.124]:52322 "EHLO mail.javad.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726242AbeLLHPT (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Dec 2018 02:15:19 -0500
Received: from osv (unknown [89.175.180.246])
        by mail.javad.com (Postfix) with ESMTPSA id BA0303FC89
        for <git@vger.kernel.org>; Wed, 12 Dec 2018 07:15:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1544598918;
        bh=w5OvIdsTaq92P7FfZSGiTIey9TrmnVJf+d1Xp3IGcuk=; l=2232;
        h=Received:From:To:Subject;
        b=H04fhO+tRvT5DbMPHpOnEEE0z+MieWQQMyouFnVvKWok3aeyHFX53zVnGGEM6hgAF
         clpGo7aCRumrUMjyV6U48u+ORgzn+yv6mj9v9Ux7aqvy60gjN65cxW1YM3ueq4dBzx
         o6FEliUWnCjd4VoJNx1eYtTSY0V+vUrKGl+5JqIQ=
Authentication-Results: ip-172-31-2-110;
        spf=pass (sender IP is 89.175.180.246) smtp.mailfrom=osv@javad.com smtp.helo=osv
Received-SPF: pass (ip-172-31-2-110: connection is authenticated)
Received: from osv by osv with local (Exim 4.84_2)
        (envelope-from <osv@osv.gnss.ru>)
        id 1gWyjj-0001fd-SD
        for git@vger.kernel.org; Wed, 12 Dec 2018 10:15:15 +0300
From:   Sergey Organov <sorganov@gmail.com>
To:     git@vger.kernel.org
Subject: Minor(?) usability issue with branch.<name>.pushRemote
Date:   Wed, 12 Dec 2018 10:15:15 +0300
Message-ID: <871s6n43ng.fsf@javad.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,

I've got confusing behavior and the cause was somewhat hard to discover:

-- 8< --
$ git status
On branch linux
Your branch is ahead of 'vendor/jps2rin_arm' by 2 commits.
  (use "git push" to publish your local commits)

nothing to commit, working tree clean
$ git push
Everything up-to-date
$ git status
On branch linux
Your branch is ahead of 'vendor/jps2rin_arm' by 2 commits.
  (use "git push" to publish your local commits)

nothing to commit, working tree clean
$ git branch -vv
* linux  e8906f9 [vendor/jps2rin_arm: ahead 2] Linux: get rid of unused files
  master 4d1f931 [origin/master] Linux: add README and config
-- 8< --

What's going on here? Why 'git status' and 'git branch' both insist
there are 2 unpushed commits yet 'git push' does nothing? Let's try to
figure:

-- 8< --
$ git push -v
Pushing to /var/local/group/firmware/git/jps2rin
To /var/local/group/firmware/git/jps2rin
 = [up to date]      linux -> linux
updating local tracking ref 'refs/remotes/origin/linux'
Everything up-to-date
-- 8< --

So it pushes branch 'linux' to 'linux' at

/var/local/group/firmware/git/jps2rin

where everything is already published... And this push destination
doesn't match 'vendor/jps2rin_arm' to which both 'git status' and 'git
branch -vv' refer, so that's where the difference is! 

Here is actual branch configuration:

-- 8< --
$ git config --get-regexp branch[.]linux
branch.linux.remote vendor
branch.linux.merge jps2rin_arm
branch.linux.pushremote origin
branch.linux.rebase preserve
$ git remote -v
origin	/var/local/group/firmware/git/jps2rin (fetch)
origin	/var/local/group/firmware/git/jps2rin (push)
vendor	ssh://git@git/gis/Justin2 (fetch)
vendor	ssh://git@git/gis/Justin2 (push)
-- 8< --

So, finally, it's 'branch.linux.pushremote' that is the "offender".

Looks like both 'git status' and 'git branch -vv' should somehow learn
about 'branch.<name>.pushremote' feature so that their
output/suggestions make more sense?

By the way, is there a simpler/better way to print entire configuration
of a [current] branch? More human-readable? Including
"branch.<name>.description"?

$ git --version
git version 2.20.0.1.g8ad5d13

-- 
Sergey
