Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5BB41211B3
	for <e@80x24.org>; Tue,  4 Dec 2018 03:35:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725983AbeLDDfa (ORCPT <rfc822;e@80x24.org>);
        Mon, 3 Dec 2018 22:35:30 -0500
Received: from www.dnalounge.com ([3.16.178.106]:35300 "EHLO
        cerebrum.dnalounge.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725969AbeLDDfa (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Dec 2018 22:35:30 -0500
X-Greylist: delayed 493 seconds by postgrey-1.27 at vger.kernel.org; Mon, 03 Dec 2018 22:35:29 EST
Received: from [10.0.1.2] (70-36-236-109.dsl.static.fusionbroadband.com [70.36.236.109])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by cerebrum.dnalounge.com (Postfix) with ESMTPSA id CCE5696925;
        Mon,  3 Dec 2018 19:27:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=jwz.org; s=mail;
        t=1543894035; bh=9kXubSbnmjGFkSYg/8Lah2WmuZPTMOArZ2UYalzGLUs=;
        h=From:Date:Subject:To;
        b=0zXkLqockXUEuO90GhOa2dot9EAyswxJNAhLTnSk3b1fNYoofuTc+s+SMBxFi3nTl
         0++PwKy0QHR8WhxvI9S+0wX/8GbKrhYZox2as6FlwF0Ani45/91To/AnbMxVZOLgJG
         GKpxYNZlezUkP5PBSG977LghFGtNrPimWSGyifHA=
From:   Jamie Zawinski <jwz@jwz.org>
Content-Type: text/plain;
        charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0 (Mac OS X Mail 12.1 \(3445.101.1\))
Date:   Mon, 3 Dec 2018 19:27:13 -0800
Subject: sharedrepository=group not working
Message-Id: <F9365CBF-3D2D-4A05-AC0D-4604067B5826@jwz.org>
To:     git@vger.kernel.org
X-Mailer: Apple Mail (2.3445.101.1)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I think sharedrepository=3Dgroup stopped working some time between =
2.10.5 (works) and 2.12.4 (does not). 2.19.2 also does not.

I have a user trying to push to a shared repo; the user is not the owner =
of the files but it is in the same group. All the repo files are g+rw =
and all the repo directories are g+srw.

	drwxrwsr-x. 252 jwz cvs 4096 Dec  3 18:53 =
/cvsroot/dna.git/objects/

I am getting:

	error: remote unpack failed: unable to create temporary object =
directory
	To /cvsroot/dna.git
	 ! [remote rejected]           master -> master (unpacker error)

If I'm reading this strace right, it looks like git is successfully =
creating a directory under objects/ and then failing to create a =
subdirectory of it (maybe because the just-created parent directory =
ended up with the wrong permissions?)

 mkdir("./objects/incoming-U5EN8D", 0700 <unfinished ...>
 <... mkdir resumed> )       =3D 0
 rt_sigaction(SIGINT, {0x56a860, [INT], SA_RESTORER|SA_RESTART, =
0x7f842cb3b2f0},  <unfinished ...>
 <... rt_sigaction resumed> {SIG_IGN, [], 0}, 8) =3D 0
 rt_sigaction(SIGHUP, {0x56a860, [HUP], SA_RESTORER|SA_RESTART, =
0x7f842cb3b2f0}, {SIG_DFL, [], 0}, 8) =3D 0
 rt_sigaction(SIGTERM, {0x56a860, [TERM], SA_RESTORER|SA_RESTART, =
0x7f842cb3b2f0}, {SIG_DFL, [], 0}, 8) =3D 0
 rt_sigaction(SIGQUIT, {0x56a860, [QUIT], SA_RESTORER|SA_RESTART, =
0x7f842cb3b2f0}, {SIG_DFL, [], 0}, 8) =3D 0
 rt_sigaction(SIGPIPE, {0x56a860, [PIPE], SA_RESTORER|SA_RESTART, =
0x7f842cb3b2f0}, {SIG_DFL, [PIPE], SA_RESTORER|SA_RESTART, =
0x7f842cb3b2f0}, 8) =3D 0
 mkdir("./objects/incoming-U5EN8D/pack", 0777) =3D -1 EACCES (Permission =
denied)


--
Jamie Zawinski      https://www.jwz.org/      https://www.dnalounge.com/

