From: David Turner <dturner@twopensource.com>
Subject: Re: [BUG] t7063-status-untracked-cache flaky?
Date: Fri, 16 Oct 2015 17:25:40 -0400
Organization: Twitter
Message-ID: <1445030740.20887.33.camel@twopensource.com>
References: <326E1A8B-3612-4771-80B8-77346C0D762D@gmail.com>
	 <56211619.3090907@web.de> <1445026298.20887.28.camel@twopensource.com>
	 <xmqqfv1aeena.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Torsten =?ISO-8859-1?Q?B=F6gershausen?= <tboegi@web.de>,
	Lars Schneider <larsxschneider@gmail.com>,
	Git List <git@vger.kernel.org>, pclouds@gmail.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Oct 16 23:25:59 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZnCVX-0003zo-0W
	for gcvg-git-2@plane.gmane.org; Fri, 16 Oct 2015 23:25:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751011AbbJPVZn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 Oct 2015 17:25:43 -0400
Received: from mail-qk0-f180.google.com ([209.85.220.180]:33439 "EHLO
	mail-qk0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750774AbbJPVZm (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Oct 2015 17:25:42 -0400
Received: by qkas79 with SMTP id s79so60264996qka.0
        for <git@vger.kernel.org>; Fri, 16 Oct 2015 14:25:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:content-type:mime-version
         :content-transfer-encoding;
        bh=Tlg67ThzH1eUJl82vrkGZabARgzK+vQOwpvUh3pJHVI=;
        b=kAffr5Qu6Zxw57cBzKra30Kgusho+Whpww7l4+tSbh45wCmu1H2KtAozzgsfGhaZM3
         zPkNhbtRt8BRo11rf3Y9SztIAkSOtYreXTO5ibosz+QicfxFHDFr86+P2ZSIONDK9NAV
         DI7UuYJuOICUbM0ZQ5Xuhc0/+uGWdkScg5nGNGXzZFFz4rJtGwbl660WFffHvNNVoCmT
         3Lp37hW4qqK7OvNbsiXI370XLQKiVyCss+eOKG7KRMCDZm1OKduSnc55mhRqENX1CqSQ
         OCYSFbpXVb3YRm1J6NIrH/Wk2SG/+a6MFInW/re4qGPsW/sgcDXpwV4eXwG1orezfXI7
         qSJQ==
X-Gm-Message-State: ALoCoQkeYi9hBHhcta56T294ancLYqVkBfMK23ClAUnJ3Q5q8tbCPHY6F6TnfWxdPrZmNA47tEt2
X-Received: by 10.55.207.3 with SMTP id e3mr21692159qkj.32.1445030741732;
        Fri, 16 Oct 2015 14:25:41 -0700 (PDT)
Received: from ubuntu ([192.133.79.147])
        by smtp.gmail.com with ESMTPSA id w71sm6851674qkw.20.2015.10.16.14.25.40
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 16 Oct 2015 14:25:40 -0700 (PDT)
In-Reply-To: <xmqqfv1aeena.fsf@gitster.mtv.corp.google.com>
X-Mailer: Evolution 3.12.11-0ubuntu3 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279772>

On Fri, 2015-10-16 at 13:34 -0700, Junio C Hamano wrote:
> David Turner <dturner@twopensource.com> writes:
> 
> > The problem is:
> >
> > trash directory.t7063-status-untracked-cache$ diff trace trace.expect 
> > 3,4c3,4
> > < directory invalidation: 1
> > < opendir: 1
> > ---
> >> directory invalidation: 2
> >> opendir: 2
> >
> >
> > I can repro on a SSD.
> >
> > I had to try many times to reproduce (I think even more the second
> > time). I just ran the test in a while loop until it failed.
> >
> > I suspect that the kernel might be a bit slow to update the mtime on the
> > directory, but I have not yet been able to repro, and I don't understand
> > why it only happens in this one test, since sparseness should be
> > completely unrelated.
> 
> If you are invalidating your cache based on mtime of the directory,
> an operation within mtime granularity can cause you to miss it,
> unless you try to be conservative and do the "assume invalid if
> racy".  And if you do "assume invalid if racy", the result will
> become timing dependent.  You may end up invalidating more than
> absolutely necessary, i.e. the test writer may have known that at
> least 1 must be definitely stale at that point in the test, but
> if another directory was iffy and the code played safe, you would
> see one more invalidation than expected (which would lead to
> scanning the directory, hence one more opendir).
> 
> Is that what is going on here?

The test has a sleep to avoid this.  Looking at it, I think it just
needs one more sleep.  Testing now; if correct, I'll send a patch.
