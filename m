Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8779F2018E
	for <e@80x24.org>; Sun, 10 Jul 2016 16:02:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757274AbcGJQCr (ORCPT <rfc822;e@80x24.org>);
	Sun, 10 Jul 2016 12:02:47 -0400
Received: from mail-oi0-f45.google.com ([209.85.218.45]:34582 "EHLO
	mail-oi0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757180AbcGJQCq (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Jul 2016 12:02:46 -0400
Received: by mail-oi0-f45.google.com with SMTP id s66so118857275oif.1
        for <git@vger.kernel.org>; Sun, 10 Jul 2016 09:02:46 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:from:date:message-id:subject:to:cc;
        bh=asknbPte4hsrRfoJ9DgsbhoEA9fSBTfySHBjdSXDI1w=;
        b=pV5eRpnxQzUFsMuEjCt6PqteWFuwURGz/UmOADeogpwS84JBf2JpU9bTIIF54GnQNh
         kXBD7d4Z/G3raXk+IThf9/yYAfp4ELWni8Pt9eVVijwuGk37PDPXXph0JeNbTIScWxO0
         /SlA20gWjST/Hm2NmgIhapf7H4/mNt0tpwYi9o2v7fX5Eo49a0GumL7pgJOMyFzF4I4q
         IbfAUyT2d/LsrdMbNuBBcA7zLTFiDL36j7FJTUh2kfM0qQk3INI3EVtSClzkdRsGninu
         fchh+Cb86rXx0oDRSHddiO2vvw1686JfarRXBWm0daQY5MvPG8piY0tGTz23QSpKHq/q
         7h9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:from:date:message-id:subject
         :to:cc;
        bh=asknbPte4hsrRfoJ9DgsbhoEA9fSBTfySHBjdSXDI1w=;
        b=S2EM3n23s5KlES8TmlMLr+wRqxT5Sq6y7/9K/xN6y1myyWxPea56WYgIgiBKUmeRK6
         Up+zEL66mQXeS8f+ywQ2WBp6Fy9Vtk+7WE2g9zy+DFOrCh9EVLr7CrNnEfr9lOjQH/ch
         2nZIMmW69OEGXoa4f8Yudw7lTy3AFfCcfh7C6gpMeD0uV07Ngz5b7r83BSLQnYuPVE7K
         4gSGWBO5s2l/ytXmD9KhgFucCQ/ZiLzYOVkKSdXUODc/P9mTPdGBFBjRhSht/YWbrcox
         YidLVjtasHvABDQnrXm9bZQwxziQZoZhLUDKI1lpyJwSVGApQLkpbtg6q7VMh6Lz3jBG
         dJjA==
X-Gm-Message-State: ALyK8tKO8vZp+PoMCewWU00pxdrPE/XxCdJTGgMiAY5A9i12BxlItEhsVNN+7NcPvQfiT7bMYThzHDW0pjrYhA==
X-Received: by 10.202.223.132 with SMTP id w126mr8039568oig.20.1468166565464;
 Sun, 10 Jul 2016 09:02:45 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.182.221.68 with HTTP; Sun, 10 Jul 2016 09:02:44 -0700 (PDT)
From:	Linus Torvalds <torvalds@linux-foundation.org>
Date:	Sun, 10 Jul 2016 09:02:44 -0700
X-Google-Sender-Auth: Hkn-AcjdKf-rE_ktLSKayKtbOIg
Message-ID: <CA+55aFz=sZnABJr6F2yF_xvx6J6fZod6BbiL2OwszEnjjn-dEw@mail.gmail.com>
Subject: Odd git overrflow bug?
To:	Junio C Hamano <gitster@pobox.com>
Cc:	Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

We have an odd bug report in the kernel, where somebody had trouble
bisecting all the way due to

  "git is failing with "you are trying to use to much memory"(?!)"

which can't be an exact  error message quote, but the closest I can
find smells like the "unsigned_add_overflows()" check in the strbuf
code. Very odd.

See

    https://bugzilla.kernel.org/show_bug.cgi?id=121701

for the bug report.

I'm not seeing how that could *possibly* happen,  but if it indeed is
that strbuf code, maybe it could print out the function name (there
are two different cases) and values so give a hint about where/how
this happens..

Of course, since the bug report isn't an exact quote anyway, maybe
that wouldn't have helped anyway. I asked for more information.

           Linus
