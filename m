From: Bryan Turner <bturner@atlassian.com>
Subject: 2.2.0-rc behavior changes (1/2)
Date: Mon, 10 Nov 2014 19:47:32 +1100
Message-ID: <CAGyf7-GxJ6XHjKqwktKqpo_mFuC_D3gzeOGNTdt4sweAnFqNRg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Git Users <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Nov 10 09:53:42 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XnkjF-0005KS-G4
	for gcvg-git-2@plane.gmane.org; Mon, 10 Nov 2014 09:53:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751952AbaKJIxh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Nov 2014 03:53:37 -0500
Received: from na3sys009aog137.obsmtp.com ([74.125.149.18]:54892 "HELO
	na3sys009aog137.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1750930AbaKJIxg (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 10 Nov 2014 03:53:36 -0500
X-Greylist: delayed 363 seconds by postgrey-1.27 at vger.kernel.org; Mon, 10 Nov 2014 03:53:36 EST
Received: from mail-ob0-f170.google.com ([209.85.214.170]) (using TLSv1) by na3sys009aob137.postini.com ([74.125.148.12]) with SMTP
	ID DSNKVGB9EInetQtThhwo0xybgvytwTjKbO/z@postini.com; Mon, 10 Nov 2014 00:53:36 PST
Received: by mail-ob0-f170.google.com with SMTP id nt9so5886699obb.1
        for <git@vger.kernel.org>; Mon, 10 Nov 2014 00:53:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to
         :content-type;
        bh=A7YlXCV8uAaiCHFcnjZRPKHTlxLVTFBg1scQ4W+dAk4=;
        b=S9PLxhdjvFQ46qqPITgBbFM3QxIEPp8brK3niGEBFhAEH+1/nIIhrjHBBLRgcseqTZ
         Smul34W2qVKuw9yhPCFsGIocjjalu862ZkdgoGI3EQBBZTfBgcr2dUAi4MWTwdRLL+TC
         pyOGN4JYhDy885QrLKt2NsSG+N+11PRRH1F4WBFfLPnWsleIgTm0DJRVgLWqlm4oQ/N7
         ZamY2li2F8FU71o6U1otB/lcZ+Gr5hzTFErxMFW4Jdj+jOVutLtpvJ+mmrHPMzsZFkNj
         8ipctnmsvI2lXEC+ilnqW2ZpeJUY64Xx09oPwnx1wZyrvqR8Zcw4rS40tfzzFy90hsdY
         gDrw==
X-Received: by 10.202.83.195 with SMTP id h186mr24355756oib.1.1415609252513;
        Mon, 10 Nov 2014 00:47:32 -0800 (PST)
X-Gm-Message-State: ALoCoQlhHz/8Dt2mT7ZiYkIolwIjkuqQyWtTm2gwGqG4/hQ04F+fOPo0mlz8rNt7/5SmOijIczAzPyRVdZALT0/RB7hqv75w3XTSN9+Hkop34wFpkmAP8obp8xeuJBKk9qqNXFgtUyxu8rAghHC12NsP3UhUFp83fA==
X-Received: by 10.202.83.195 with SMTP id h186mr24355745oib.1.1415609252376;
 Mon, 10 Nov 2014 00:47:32 -0800 (PST)
Received: by 10.182.245.170 with HTTP; Mon, 10 Nov 2014 00:47:32 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I've been running a test suite we use to verify Git behaviors across
versions, and the 2.2.0 RCs (0 and 1 both) have a couple of small
behavioral differences. I'm sending them in separate e-mails just to
make the contents easier to grok.

Important: It's entirely possible neither of these is a _bug_; they
may both be intentional changes in behavior.

First change: git update-ref -d /refs/heads/nonexistent
<some-valid-sha1> now produces an error about ref locking that it
didn't produce before

Git 2.1.x and prior produced this output:
error: unable to resolve reference refs/heads/nonexistent: No such
file or directory

Now, in the 2.2.0 RCs, it says:
error: unable to resolve reference refs/heads/nonexistent: No such
file or directory
error: Cannot lock the ref 'refs/heads/nonexistent'.

This one feels more like a bug, but again may not be. I say it feels
like a bug because of the order of the messages: If git has decided
the ref doesn't exist, why is it still trying to lock it?

This change bisects to:

bturner@felurian:~/Development/git/git$ git bisect bad
7521cc4611a783f4a8174bd0fcec5f4a47357ac1 is the first bad commit
commit 7521cc4611a783f4a8174bd0fcec5f4a47357ac1
Author: Ronnie Sahlberg <sahlberg@google.com>
Date:   Wed Apr 30 09:22:45 2014 -0700

    refs.c: make delete_ref use a transaction

Best regards,
Bryan Turner
