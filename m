From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC] Porting builtin/branch.c to use the printing options of ref-filter.{c,h}
Date: Tue, 25 Aug 2015 11:50:57 -0700
Message-ID: <xmqq4mjnyzfy.fsf@gitster.dls.corp.google.com>
References: <CAOLa=ZRpMsFr2p=X+Z7z95W+0wGd9i5XaSDeVSmS-BUFCj6dWw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Git <git@vger.kernel.org>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Christian Couder <christian.couder@gmail.com>
To: Karthik Nayak <karthik.188@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 25 20:51:05 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZUJJI-0002MT-8r
	for gcvg-git-2@plane.gmane.org; Tue, 25 Aug 2015 20:51:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752896AbbHYSu7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Aug 2015 14:50:59 -0400
Received: from mail-pa0-f53.google.com ([209.85.220.53]:33165 "EHLO
	mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751042AbbHYSu7 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Aug 2015 14:50:59 -0400
Received: by pacti10 with SMTP id ti10so59403475pac.0
        for <git@vger.kernel.org>; Tue, 25 Aug 2015 11:50:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=lLsNlnghAIfTtXsDn077cwcKG1tJQ38HkJGDNNYbODA=;
        b=uQevgAP7T1TcP+YU988lalnp6MWv87GIak4eqKkaemQHwc42uc4lKqktusSeGZKFnY
         Xxekd/UVm06AztidjpMy1Am+y44CJGY7ibVOQLvc4pzctMYwG6OsfE0gbJuUy3iIjprW
         kIlOaPzkXEuo3Rgy7WVIBaZslb8JQKRkoZErCWYVqIYui0hb1HB8p4xa/63P5hCxYKH1
         ZFbGyfT3aQKe8WniWapItn8VJYK7rKFWvwU2wXsTzZ9y0lQ0mDVUU1EW7Wvlckg61h/u
         1g/rZZwysANGeELGieShqeF8daUBtyyoFgJd9z4RtWmiNFFdGfoUdl5f7kdxkbl8h2cy
         Odbw==
X-Received: by 10.68.116.142 with SMTP id jw14mr60149288pbb.147.1440528658651;
        Tue, 25 Aug 2015 11:50:58 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:cdc0:fd6d:4069:6223])
        by smtp.gmail.com with ESMTPSA id w6sm21915483pdn.46.2015.08.25.11.50.57
        (version=TLS1_2 cipher=AES128-SHA256 bits=128/128);
        Tue, 25 Aug 2015 11:50:57 -0700 (PDT)
In-Reply-To: <CAOLa=ZRpMsFr2p=X+Z7z95W+0wGd9i5XaSDeVSmS-BUFCj6dWw@mail.gmail.com>
	(Karthik Nayak's message of "Tue, 25 Aug 2015 23:15:21 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276558>

Karthik Nayak <karthik.188@gmail.com> writes:

> I'm working on porting over the printing options of ref-filter to `git
> branch -l`.
> This is a follow up to
> http://article.gmane.org/gmane.comp.version-control.git/276377
>
> Theres a slight issue with this which I'd like to discuss about.
>
> When we use `-a` option in `git branch -l`
> It lists local branches and remotes with each having a different output format.
> This with reference to ref-filter would mean either
>
> 1. Change format in between local and remote refs

I thought the end result of consolidation would be for for-each-ref,
branch -l, and tag -l to be "first collect what to show, and then
show them according to a single format given".  How could it be
possible to switch format?  It's not even like each element collected
in the first phase is marked so that the second "display" phase know
which one is which.

> 2. Have a format like %(if)...local check....%(then)....local branch
> format....%(else)....remote format %(end).

That, if we had a working if/then/else/end, would be a good
demonstration of it.  

If this were only for internal use by "branch -l", it might be
overkill, but the end users with for-each-ref --format options would
want to do the same thing as built-in patterns, so it is a good goal
to aim at.

> I prefer the latter, but that might lead to a large format. Any suggestions?

A less ambitious option might be:

  3. Invent "%(refname:<some magic>)" format similar to
     %(refname:short) but does your thing depending on the prefix
     refs/heads/ and refs/remotes/.

but that will not work if the difference between local and remote
format is not merely textual (e.g. paint them in different color).
