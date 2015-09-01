From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCHv4 3/3] submodule: implement `clone` as a builtin helper
Date: Tue, 1 Sep 2015 15:15:10 -0400
Message-ID: <CAPig+cQUKVSmt6KNpo01wo8Wzq4YxoX130ROWEri7pVXv1YLqg@mail.gmail.com>
References: <1441131869-29474-1-git-send-email-sbeller@google.com>
	<1441131869-29474-4-git-send-email-sbeller@google.com>
	<CAPig+cRxQdquKZXdmpiZjj8JFB2wdCE4UcbW6qYUwvtZsVw=ug@mail.gmail.com>
	<20150901190506.GA8254@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Stefan Beller <sbeller@google.com>,
	Junio C Hamano <gitster@pobox.com>,
	Git List <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Johannes Schindelin <johannes.schindelin@gmail.com>,
	Jens Lehmann <Jens.Lehmann@web.de>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Sep 01 21:15:24 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZWr1a-00069g-GS
	for gcvg-git-2@plane.gmane.org; Tue, 01 Sep 2015 21:15:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753590AbbIATPM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Sep 2015 15:15:12 -0400
Received: from mail-yk0-f169.google.com ([209.85.160.169]:36413 "EHLO
	mail-yk0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752095AbbIATPL (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Sep 2015 15:15:11 -0400
Received: by ykcf206 with SMTP id f206so316126ykc.3
        for <git@vger.kernel.org>; Tue, 01 Sep 2015 12:15:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=MON7SnfszNlsf5/RjC0EOxYSEaqB8YxjBJUwv/2Wv1Q=;
        b=fLhmNSn7htiahCFWZrku9XdQBDEK+JpwJa1kAoPgxVr7AdvdfLMNBBcXHtt33f+3f4
         +jqyfayWfRd38k9Dpk4UInQFzxnrn+jLLA21UUwfJR+2CshrsCl5jRiAaSuGJ1rozV5m
         TuLTC/yjIvNM8BkpYx3bDq/1SWzRRFbV4deay+T/Ys/H4rA/59BEyUdMfQHKfpnbBZcr
         6YnyRcZDWN1bxi4IFU7eCJkyNJ8x7Dp1yimoZ5wVfJczCR50fAS+TEA4aP48iAdU8gJu
         JnbITox9XaQQCwXb1dnH1yTeMwfxRy9VRUcw4taOpXOVmTHnxXdf7xquG15oOEQKPeMJ
         ICag==
X-Received: by 10.170.161.85 with SMTP id c82mr64649ykd.13.1441134910570; Tue,
 01 Sep 2015 12:15:10 -0700 (PDT)
Received: by 10.37.36.145 with HTTP; Tue, 1 Sep 2015 12:15:10 -0700 (PDT)
In-Reply-To: <20150901190506.GA8254@sigill.intra.peff.net>
X-Google-Sender-Auth: ifKyGTJMyHCwFJLyfSy2ClO9VOM
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277034>

On Tue, Sep 1, 2015 at 3:05 PM, Jeff King <peff@peff.net> wrote:
> On Tue, Sep 01, 2015 at 02:52:54PM -0400, Eric Sunshine wrote:
>> > +       /* Redirect the worktree of the submodule in the superproject's config */
>> > +       if (strbuf_getcwd(&sb))
>> > +               die_errno(_("unable to get current working directory"));
>> > +
>> > +       if (!is_absolute_path(sm_gitdir)) {
>> > +               if (strbuf_getcwd(&sb))
>> > +                       die_errno(_("unable to get current working directory"));
>>
>> Why does this need to call getcwd() on 'sb' when it was called
>> immediately above the conditional and its value hasn't changed?
>
> Even weirder, the next code is:
>
>> > +               strbuf_addf(&sb, "/%s", sm_gitdir);
>> > +               free(sm_gitdir);
>> > +               sm_gitdir = strbuf_detach(&sb, NULL);
>> > +       }
>> > +
>> > +
>> > +       strbuf_addf(&sb, "/%s", path);
>
> So if it _was_ an absolute path, we are adding "/$path" to nothing
> (having just detached the strbuf in the conditional above). That seems
> weird.

Indeed, I saw that too, but didn't mention it since this appears to be
an incomplete refactoring from the previous round, and my hope was
that mentioning the getcwd() oddity would be enough to trigger a
thorough check of the code before sending the next version.
