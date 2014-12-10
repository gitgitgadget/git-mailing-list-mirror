From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v3] pkt-line: allow writing of LARGE_PACKET_MAX buffers
Date: Wed, 10 Dec 2014 04:42:47 -0500
Message-ID: <CAPig+cR4p9C46wU2-nNVy7rpXzbW0fGmqzik85UP_1j3YUEmjA@mail.gmail.com>
References: <20141209174958.GA26167@peff.net>
	<20141209180916.GA26873@peff.net>
	<xmqqa92wla34.fsf@gitster.dls.corp.google.com>
	<20141210073447.GA20298@peff.net>
	<CAPig+cQQThA7wiz8iwkKX=ipg1n5w+gyeS8NqtbjGui986Hn+g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, Johannes Sixt <j6t@kdbg.org>,
	Michael Blume <blume.mike@gmail.com>,
	Git List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Dec 10 10:43:01 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XydnK-0000Ox-OP
	for gcvg-git-2@plane.gmane.org; Wed, 10 Dec 2014 10:42:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752554AbaLJJmu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Dec 2014 04:42:50 -0500
Received: from mail-ig0-f176.google.com ([209.85.213.176]:43907 "EHLO
	mail-ig0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752357AbaLJJms (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Dec 2014 04:42:48 -0500
Received: by mail-ig0-f176.google.com with SMTP id l13so6532115iga.9
        for <git@vger.kernel.org>; Wed, 10 Dec 2014 01:42:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=NcO8G1df+aDa3DCJPUbwteYFNz9gq/AkaFyd1RdlU50=;
        b=Jr90+5tC1RZ9MME1T1R2gWBqbvnctRTcCRkPwq2Ypcl4IoAnny6991XiXy3OyPHvZR
         eCGe0J1cB94h4dtZmnxCqVQd03DRr29VfdbYDUaxGpTK9qg7/416xA3AEkBn+gZ1iErd
         ciVPyBZRQiz1lI4w9rP1LiWF4QJyX8L53yjnoX6DL3fnH1qsKY56erUkeb+ggZTH9wWR
         0UoZ1xIs8d1u5z+baJVlJvVfyCXYXbIskwFaFDUBgkb7FQQCOUKC/nQ5OxNLGVUdPiRG
         n6gp36I/3i4HMjPjl/74oHwhRxJjxBSoNUn8LINIWszs7xBqzEgtFHlTHikM7FKCdqwX
         cWLw==
X-Received: by 10.107.3.37 with SMTP id 37mr2980748iod.82.1418204567673; Wed,
 10 Dec 2014 01:42:47 -0800 (PST)
Received: by 10.107.137.66 with HTTP; Wed, 10 Dec 2014 01:42:47 -0800 (PST)
In-Reply-To: <CAPig+cQQThA7wiz8iwkKX=ipg1n5w+gyeS8NqtbjGui986Hn+g@mail.gmail.com>
X-Google-Sender-Auth: NRCTHvTcsd7qtURhrCuimL25ssU
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261200>

On Wed, Dec 10, 2014 at 3:36 AM, Eric Sunshine <sunshine@sunshineco.com> wrote:
> On Wed, Dec 10, 2014 at 2:34 AM, Jeff King <peff@peff.net> wrote:
>> Below is a another iteration on the patch. The actual code changes are
>> the same as the strbuf one, but the tests take care to avoid assuming
>> the filesystem can handle such a long path. Testing on Windows and OS X
>> is appreciated.
>
> All three new tests fail on OS X. Thus far brief examination of the
> first failing tests shows that 'expect' and 'actual' differ:
>
> expect:
>     long
>     master
>
> actual:
>     master

The failure manifests as soon as the refname hits length 1024, at
which point for-each-ref stops reporting it. MAX_PATH on OS X is 1024,
so some part of the machinery invoked by for-each-ref likely is
rejecting refnames longer than that (even when coming from
packed-refs).
