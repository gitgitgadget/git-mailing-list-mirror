From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 00/34] libify mailinfo and call it directly from am
Date: Tue, 20 Oct 2015 14:24:23 -0700
Message-ID: <xmqqh9ll6xo8.fsf@gitster.mtv.corp.google.com>
References: <1444855557-2127-1-git-send-email-gitster@pobox.com>
	<1445239731-10677-1-git-send-email-gitster@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 20 23:24:32 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZoeOT-0006aT-Mw
	for gcvg-git-2@plane.gmane.org; Tue, 20 Oct 2015 23:24:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752269AbbJTVY0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Oct 2015 17:24:26 -0400
Received: from mail-pa0-f50.google.com ([209.85.220.50]:36427 "EHLO
	mail-pa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751457AbbJTVYZ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Oct 2015 17:24:25 -0400
Received: by pacfv9 with SMTP id fv9so33421923pac.3
        for <git@vger.kernel.org>; Tue, 20 Oct 2015 14:24:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=JiWRf31WPm58my5miqkzZoAM4GduMO26ZNzLYfkrMRQ=;
        b=hIBt35hQA731bMC1e6CFGZltIiUmvYxwXRAk8E3J+AuiEfHc2aQ6T04zuNM3V8z1DA
         kUqKRiITaACJ2lwyqq0eF8bcltlZdv0A+GC3apfBrbAnLhFgZ5yWykz8ymxoUVAXHD9O
         MaEZ8sUoaXXVCulE4dtUjJA+CePR5sM2bNVDksyMhAEVQ6ZTV3cfUc5V5bVBf7ksSYCX
         Wx0Ef/3XFn504pu5CmhFuLJmCiV35e6zcTmZdbimRsW85FUHnzVky9ZtZ5Umhf8UXxvx
         4YrzEU1dlRKjIQNEK7227WJfOvuQqkE+57URB1/SjBSQmtqqjXY7BsKDc2kRz+8MOc7q
         hhqg==
X-Received: by 10.68.111.129 with SMTP id ii1mr6340485pbb.1.1445376264959;
        Tue, 20 Oct 2015 14:24:24 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:f0a2:278f:6a7e:e323])
        by smtp.gmail.com with ESMTPSA id qb7sm5420839pab.47.2015.10.20.14.24.24
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 20 Oct 2015 14:24:24 -0700 (PDT)
In-Reply-To: <1445239731-10677-1-git-send-email-gitster@pobox.com> (Junio
	C. Hamano's message of "Mon, 19 Oct 2015 00:28:17 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279942>

Junio C Hamano <gitster@pobox.com> writes:

> During the discussion on the recent "git am" regression, I noticed
> that the command reimplemented in C spawns one "mailsplit" and then
> spawns "mailinfo" followed by "apply --index" to commit the changes
> described in each message.  As there are platforms where spawning
> subprocess via run_command() interface is heavy-weight, something
> that is conceptually very simple like "mailinfo" is better called
> directly inside the process---something that is lightweight and
> frequently used is where the overhead of run_command() would be felt
> most.

Although I still haven't seen any offer to help from those who work
on the platforms that may benefit from this series the most, I have
some numbers on my desktop (Dell T3500 2.66GHz Xeon X5650 with 12GB,
running Ubuntu), where the cost of spawning is not as costly as
elsewhere, making this series less pressing.

Between 'master' and the version with this series (on 'jch'),
applying this 34-patch series itself on top of 'master' using "git
am", best of 5 numbers for running:

    time git am mbox >/dev/null

are

      (master)                 (with the series)
    real    0m0.648s            real    0m0.537s
    user    0m0.358s            user    0m0.338s
    sys     0m0.172s            sys     0m0.154s

I haven't re-read the series to catch leaks yet, so in that sense
the series is still not ready to be merged to 'next' (of course,
help with fresh set of eyes is very much appreciated here).
