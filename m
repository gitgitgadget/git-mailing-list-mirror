From: John Szakmeister <john@szakmeister.net>
Subject: Re: [PATCH 0/3] Reject non-ff pulls by default
Date: Thu, 5 Sep 2013 08:37:20 -0400
Message-ID: <CAEBDL5U2Y-dxtGyDTW+C-SseSpuF40BNMW3oZDnfzRx8KxG7fA@mail.gmail.com>
References: <1377988690-23460-1-git-send-email-felipe.contreras@gmail.com>
	<xmqqd2opu8hr.fsf@gitster.dls.corp.google.com>
	<CAMP44s2NzzS48BBpD_oQ24t2SYETte7_U4+O+32SOo5qhooQew@mail.gmail.com>
	<xmqqfvtlpm2l.fsf@gitster.dls.corp.google.com>
	<20130904081047.GB2582@serenity.lan>
	<xmqqa9jso69u.fsf@gitster.dls.corp.google.com>
	<7DC052455C7C4B50A4EAFC1EF63D006C@PhilipOakley>
	<xmqqr4d4jird.fsf@gitster.dls.corp.google.com>
	<CAEBDL5VfHObeWZWvj0bnv5x+QF1_DACdU+Ehds6fHUioziHWrQ@mail.gmail.com>
	<20130905113822.GF2582@serenity.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Philip Oakley <philipoakley@iee.org>,
	Felipe Contreras <felipe.contreras@gmail.com>,
	git@vger.kernel.org, Andreas Krey <a.krey@gmx.de>
To: John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Thu Sep 05 14:37:34 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VHYoW-0004EX-4f
	for gcvg-git-2@plane.gmane.org; Thu, 05 Sep 2013 14:37:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759668Ab3IEMhZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Sep 2013 08:37:25 -0400
Received: from mail-wi0-f179.google.com ([209.85.212.179]:52530 "EHLO
	mail-wi0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757158Ab3IEMhW (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Sep 2013 08:37:22 -0400
Received: by mail-wi0-f179.google.com with SMTP id hm2so1771658wib.12
        for <git@vger.kernel.org>; Thu, 05 Sep 2013 05:37:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=RSQmb13d8O9eC15AdiCTKodZeuCTFZwg5Jx7kHLqoho=;
        b=rBpNk5qttLJqjuXkvpLksyK5e0XBBFJHBZSnL1OLm1+hYI/KgzCMfXj94EJyAbvzsg
         ML8doBTE7NidrONTf6NGpc4wwP3TkomMGJRJi895RpalB0EL14GXUyhxBqJrB7xaJcPc
         7F3V0aqVX9T5M2RBHhZ/T3Q41TZSgn6iotEmPi+UJCfZ6df/rxRzEF7vdEE2l69WNvaA
         K1F0p6A1uLD4jwEJxlDNwF1EkVYyH9n4B9nS2mUMvnZcRD2AhnF9i2b2f4sYv53xLFCh
         enHqVGJY8V4MOLmymvqYtoKaGQ1qlBsLONYyKICTnysac6tORjrlNTsSmdvm2Pp6vfrY
         f+Uw==
X-Received: by 10.180.20.208 with SMTP id p16mr5659296wie.6.1378384640914;
 Thu, 05 Sep 2013 05:37:20 -0700 (PDT)
Received: by 10.180.90.105 with HTTP; Thu, 5 Sep 2013 05:37:20 -0700 (PDT)
In-Reply-To: <20130905113822.GF2582@serenity.lan>
X-Google-Sender-Auth: 3nUJP1GFZ3ksR1ECa6XcIl9K_5Y
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233954>

On Thu, Sep 5, 2013 at 7:38 AM, John Keeping <john@keeping.me.uk> wrote:
> On Thu, Sep 05, 2013 at 07:01:03AM -0400, John Szakmeister wrote:
[snip]
>> So what I really want isn't quite rebase.  I'm not sure any of the
>> proposed solutions would work.  It'd be really nice to replay only the
>> mainline commits, without affecting commits introduced from a topic
>> branch.
>
> Does "git rebase --preserve-merges" do what you want here?

No, unfortunately, it does not.  If the topic branch was not based on
the current tip of master, "git rebase --preserve-merges" will rebase
the commits of the topic branch as well.  So this:

       Q -- R -- S     (topic)
     /            \
    A -- B ------- D   (master)

Will become this after "git rebase --preserve-merges @{u}":

                 Q' -- R' -- S'    (topic')
               /              \
    A -- B -- C -------------- D'  (master)

It's unfortunate for a couple of reasons.  First, we don't want Q, R,
and S rebased--we just want the merge replayed.  Secondly, it gets
more confusing because Q, R, and S were rebased, but the topic branch
wasn't actually touched.  So topic still contains Q, R, and S, but
master now contains Q', R', and S'.  What we actually want is:

       Q -- R -- S     (topic)
     /            \
    A -- B -- C -- D'  (master)

HTH!

-John
