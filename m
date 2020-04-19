Return-Path: <SRS0=ylBF=6D=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9B21C38A30
	for <git@archiver.kernel.org>; Sun, 19 Apr 2020 12:24:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C0B78214AF
	for <git@archiver.kernel.org>; Sun, 19 Apr 2020 12:24:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725927AbgDSMYQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 19 Apr 2020 08:24:16 -0400
Received: from mattbas.org ([138.201.65.48]:55714 "EHLO mail.localdomain"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725793AbgDSMYQ (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 19 Apr 2020 08:24:16 -0400
X-Greylist: delayed 543 seconds by postgrey-1.27 at vger.kernel.org; Sun, 19 Apr 2020 08:24:16 EDT
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 1146BF21AAA
        for <git@vger.kernel.org>; Sun, 19 Apr 2020 14:15:08 +0200 (CEST)
To:     git@vger.kernel.org
From:   Glax <glax@dragon.best>
Subject: gitk crashes if the diff contains certain unicode characters
Message-ID: <edace460-d252-2742-7576-e7601b6e959c@dragon.best>
Date:   Sun, 19 Apr 2020 14:15:06 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Looks like certain characters cause gitk to crash when it tries to
render a diff.


How to repro:

	git init
	echo foo >foo
	git add foo
	git commit -m foo
	# The following assumes bash builtin echo
	echo -e '\u2754' >foo
	gitk

Now `foo` should contain the character U+2754 encoded as utf-8.

If on gitk you click on "Local uncommitted changes", it'll crash with
the following message:

	X Error of failed request:  BadLength (poly request too large or
internal Xlib length error)
	  Major opcode of failed request:  139 (RENDER)
	  Minor opcode of failed request:  20 (RenderAddGlyphs)
	  Serial number of failed request:  4220
	  Current serial number in output stream:  4247


Note that if I now commit, gitk will crash at startup because the diff
with the character are on the last commit (which gitk selects by default)

	git commit -am crash
	gitk # crashes
	gitk HEAD^ # works fine


After that, you can add a couple more commits and gitk works fine,
unless you click on one of the commits whose diff contain the character.
eg:

	echo foo >foo
	git commit -am foo
	echo bar >foo
	git commit -am bar
	gitk


Version / System:

	$ git --version
	git version 2.20.1
	$ lsb_release -d
	Description:    Ubuntu 19.10

