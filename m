From: Erik Faye-Lund <kusmabite@googlemail.com>
Subject: Re: [msysGit] [PATCH/RFC 06/11] run-command: add kill_async() and 
	is_async_alive()
Date: Wed, 2 Dec 2009 16:57:01 +0100
Message-ID: <40aa078e0912020757i3b63ef6eh71c3d4d99047f1f2@mail.gmail.com>
References: <1259196260-3064-1-git-send-email-kusmabite@gmail.com>
	 <200911262246.13342.j6t@kdbg.org>
	 <40aa078e0911270804i1a828ea6we1611047d37869f7@mail.gmail.com>
	 <200911272059.25934.j6t@kdbg.org>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: msysgit@googlegroups.com, git@vger.kernel.org, dotzenlabs@gmail.com
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Wed Dec 02 16:57:09 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NFrZk-0004ea-Ei
	for gcvg-git-2@lo.gmane.org; Wed, 02 Dec 2009 16:57:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754614AbZLBP45 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Dec 2009 10:56:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751688AbZLBP44
	(ORCPT <rfc822;git-outgoing>); Wed, 2 Dec 2009 10:56:56 -0500
Received: from mail-fx0-f221.google.com ([209.85.220.221]:65489 "EHLO
	mail-fx0-f221.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751429AbZLBP44 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Dec 2009 10:56:56 -0500
Received: by fxm21 with SMTP id 21so393467fxm.1
        for <git@vger.kernel.org>; Wed, 02 Dec 2009 07:57:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:reply-to:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=ctxRBYJ/86QZC+yqC9n9Z3HnF6urLhoAb3lYoJ/4yl0=;
        b=LkV8vu0zM65dkLIQQl+Jlv6JlslPI6gm6l1qak7fYWqExwC65Pvg3h0vKlym/iXp6t
         BIByVJaRoXe4tSaW91A27NeXg4b9hq/lH1VGzL45/aMovS004zAavR+gNHV703+r00cE
         e6hESBrW3I12cefMwtqBfKNEFatI3m5EEhdiA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        b=JR3PUR1ZJjh7D9O4RMDX/YNPrQTOcO0I0IZVwcoMVS+bAMELb5yNpHsTsARlUl1zIN
         3jStYTUpPP2zOTjGw6r+fW0zu5KkDFN+mPZ/av4aeoT714XJ8nJAuFnl+CXhiCu16lvc
         bE6pdjNbLm0X/IMNffALZM2Hu/fVVmiMfb1YU=
Received: by 10.216.89.137 with SMTP id c9mr80708wef.228.1259769421453; Wed, 
	02 Dec 2009 07:57:01 -0800 (PST)
In-Reply-To: <200911272059.25934.j6t@kdbg.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134342>

On Fri, Nov 27, 2009 at 8:59 PM, Johannes Sixt <j6t@kdbg.org> wrote:
> On Freitag, 27. November 2009, Erik Faye-Lund wrote:
>> Do you really think it's better to unconditionally take down the
>> entire process with an error, instead of having a relatively small
>> chance of stuff blowing up without any sensible error? I'm not 100%
>> convinced - but let's hope we'll find a proper fix.
>
> "relatively small chance of stuff blowing up"? The docs of
> TerminateThread: "... the kernel32 state for the thread's process could be
> inconsistent." That's scary if we are talking about a process that should run
> for days or weeks without interruption.
>

I think there's a misunderstanding here. I thought your suggestion was
to simply call die(), which would take down the main process. After
reading this explanation, I think you're talking about giving an error
and rejecting the connection instead. Which makes more sense than to
risk crashing the main-process, indeed.

> The reason why we are killing a thread is to prevent keeping lots of
> connections open (to the same IP address). There are two situations to take
> care of:
>
> 1. We are in a lengthy computation without paying attention to the socket.
>
> 2. The client does not send or accept data for a long time.
>
> Case 1 could happen if upload-pack is "counting objects" on a large
> repository. We would need some way to kill upload-pack. Since it is a
> separate process anyway, we could use TerminateProcess().
>

Makes sense. I'll play around a bit with this and see what I come up with.

> Case 2 could be achieved by using setsockopt() with SO_RCVTIMEO and
> SO_SNDTIMEO and a tiny timeout. But notice that we would set a timeout in one
> thread while another thread is waiting in ReadFile() or WriteFile(). Would
> that work?
>

I think it should work fine, but I won't give you a guarantee ;)
Perhaps we should have a configurable global max timeout, and just set
that on all sockets? Or does this open for DDOS attacks?

Anyway, thanks for the sanity :)

-- 
Erik "kusma" Faye-Lund
