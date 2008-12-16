From: "Stefan Karpinski" <stefan.karpinski@gmail.com>
Subject: Re: git-diff should not fire up $PAGER if there is no diff
Date: Tue, 16 Dec 2008 17:43:28 -0500
Message-ID: <d4bc1a2a0812161443k62e4b53s841ac32f653037fe@mail.gmail.com>
References: <874p15x94i.fsf@jidanni.org>
	 <20081216005658.GB3679@coredump.intra.peff.net>
	 <d4bc1a2a0812152235l14ec80bbr130a7ab152ad6b8@mail.gmail.com>
	 <20081216074414.GB2468@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: jidanni@jidanni.org, git@vger.kernel.org
To: "Jeff King" <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Dec 16 23:44:58 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LCiet-0006WA-52
	for gcvg-git-2@gmane.org; Tue, 16 Dec 2008 23:44:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758200AbYLPWna (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Dec 2008 17:43:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758205AbYLPWna
	(ORCPT <rfc822;git-outgoing>); Tue, 16 Dec 2008 17:43:30 -0500
Received: from rv-out-0506.google.com ([209.85.198.230]:18440 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752682AbYLPWn3 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Dec 2008 17:43:29 -0500
Received: by rv-out-0506.google.com with SMTP id k40so3193043rvb.1
        for <git@vger.kernel.org>; Tue, 16 Dec 2008 14:43:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=MEFE5nHuqPlMSyEI5WXv6SdwHGiSkXwjAnpBGLGb6JI=;
        b=CO7V39bEyF4HDYKYXaVq8GOf+ZROv4QWH/b/UUtu3L1/xwLgr2W55icXKXpKf4zWQO
         hPhIBZ1hDe5iQ+hPatx++0ZVfAJ6zIkhrKdc/RDLXGQjCsqA0Wzht25fg2d4HjHzzFyH
         lGhhSaeplv09MARbvZmKtmSnk8KboG7mnGCrw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=bGGe+b/OVGclTOlcOSVOo8+bdCY6dVIKmNZr++A9MnQtq0qadhla8YVTeRiweixs7Z
         LUz9nMo5GvFvhJ+q5+jedaNMUNsA6CT9P9Fgl20Boe0lzJ1AXnJs0lqpE/X6xXlqRU3N
         nIBQ1rFjBH9GAT+/Es3gWb9LIBI1CSIKMbWeI=
Received: by 10.140.136.5 with SMTP id j5mr4549857rvd.39.1229467408108;
        Tue, 16 Dec 2008 14:43:28 -0800 (PST)
Received: by 10.114.134.5 with HTTP; Tue, 16 Dec 2008 14:43:28 -0800 (PST)
In-Reply-To: <20081216074414.GB2468@coredump.intra.peff.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103293>

On Tue, Dec 16, 2008 at 2:44 AM, Jeff King <peff@peff.net> wrote:
> On Tue, Dec 16, 2008 at 01:35:53AM -0500, Stefan Karpinski wrote:
>
>> > On Mon, Dec 15, 2008 at 7:56 PM, Jeff King <peff@peff.net> wrote:
>> >  2. detect EOF before starting the pager. We in fact already delay
>> >     running the pager in the forked process until we have some activity
>> >     on the pipe, but I don't know if there is a portable way of
>> >     detecting that that activity is EOF without performing an actual
>> >     read() call (which is undesirable, since it eats the first byte of
>> >     output that should go to the pager).
>>
>> Wouldn't ungetc work? Or is that not portable enough? (It would only
>> work here because the EOF has to be the first character.)
>
> No, it won't work. ungetc works on the buffered stdio object, so it is
> useful for pushing back characters onto the buffer to be read later in
> the program from the same buffer. But in this case, we are going to
> execv() (or on Windows, spawn) the pager, meaning it will throw away
> anything that has been read() from the pipe and put in the buffer.
>
> So we would need a system call to push a character back to the OS, so
> that it was available for read() by the pager process.

Yeah, I realized that after I sent the message. Late night sending bad!
