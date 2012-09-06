From: Paolo Bonzini <bonzini@gnu.org>
Subject: Re: poll() emulation in git
Date: Thu, 06 Sep 2012 16:31:44 +0200
Message-ID: <5048B3D0.2070809@gnu.org>
References: <00c001cd8b59$028e41c0$07aac540$@schmitz-digital.de> <50474001.5030407@gnu.org> <00d801cd8b6b$844bbcd0$8ce33670$@schmitz-digital.de> <50476EFD.2000500@gnu.org> <010301cd8c38$4256bb90$c70432b0$@schmitz-digital.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, 'Junio C Hamano' <gitster@pobox.com>,
	'Erik Faye-Lund' <kusmabite@gmail.com>, bug-gnulib@gnu.org,
	rsbecker@nexbridge.com
To: Joachim Schmitz <jojo@schmitz-digital.de>
X-From: git-owner@vger.kernel.org Thu Sep 06 16:32:01 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T9d7h-0001Cb-Gc
	for gcvg-git-2@plane.gmane.org; Thu, 06 Sep 2012 16:32:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756220Ab2IFOby (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Sep 2012 10:31:54 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:55898 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756197Ab2IFObx (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Sep 2012 10:31:53 -0400
Received: by pbbrr13 with SMTP id rr13so2584322pbb.19
        for <git@vger.kernel.org>; Thu, 06 Sep 2012 07:31:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=vkgmdeaENaQ4uuuJ0lNT7po2N6ZthMHZyjIW4pdwT5o=;
        b=x3Lz80+HzNE1y//JoBDRqC5mExRUbfBsKSFzs7gSKryac2xBiP7OFuXt5RC4nQ9fYv
         aoT12BtbMFSC3joJMevM8/xxAua6VXrdjU44rDJuQ8ciA8QguiQFIFCMIgXgd7tu/JXH
         l2Y2AGkT7QtcV2FNv8djwOZOSAz4K9yvKLz0hWJ5NyT57Drf6kYun+qBgMOYEzBSx9d6
         SbRCrTvaKrsbhnRuAYD0XOjH0KbQLH3gqdRBUk0lV2TcSOn5BO8RIQz/4VBcVl+iwj7a
         cCadoIZ1/fWxtyXBsaEpLi3eLUG4dXrMbYEMzVEZVLC0DlnnU6GPbTZrj3g84JPYFMqL
         WmWQ==
Received: by 10.68.228.98 with SMTP id sh2mr4879146pbc.95.1346941912696;
        Thu, 06 Sep 2012 07:31:52 -0700 (PDT)
Received: from yakj.usersys.redhat.com (93-34-169-1.ip50.fastwebnet.it. [93.34.169.1])
        by mx.google.com with ESMTPS id uh7sm1431744pbc.35.2012.09.06.07.31.48
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 06 Sep 2012 07:31:51 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:14.0) Gecko/20120717 Thunderbird/14.0
In-Reply-To: <010301cd8c38$4256bb90$c70432b0$@schmitz-digital.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204890>

Il 06/09/2012 16:02, Joachim Schmitz ha scritto:
> 
> But is there something that could be done to make git work even without poll()?
> It is used in 5 places:
> 
> $ grep -n poll\( *.c */*.c
> credential-cache--daemon.c:175: if (poll(&pfd, 1, 1000 * wakeup) < 0) {
> daemon.c:1018:          if (poll(pfd, socklist->nr, -1) < 0) {
> help.c:361:                     poll(NULL, 0, autocorrect * 100);
> upload-pack.c:232:              if (poll(pfd, pollsize, -1) < 0) {
> builtin/upload-archive.c:125:           if (poll(pfd, 2, -1) < 0) {
> 
> Don't quite understand why in help.c it has that NULL, which should always result in an EFAULT and other than that basically is a
> NOP (at least in the poll() emulation)? Seems a usleep(autocorrect * 100) is meant to happen here instead?
> So I think here a poll() isn't needed at all. But also the 'broken' one shouldn't harm too much.

Yes, it's an usleep(autocorrect * 100000) basically (poll takes
milliseconds, not micro).

> ...
> # else
>       char data[64];
>       r = recv (fd, data, sizeof (data), MSG_PEEK);
>       socket_errno = (r < 0) ? errno : 0;
> # endif
>       if (r == 0)
>         happened |= POLLHUP;
> 
>       /* If the event happened on an unconnected server socket,
>          that's fine. */
>       else if (r > 0 || ( /* (r == -1) && */ socket_errno == ENOTCONN))
>         happened |= (POLLIN | POLLRDNORM) & sought;
> 
>       /* Distinguish hung-up sockets from other errors.  */
>       else if (socket_errno == ESHUTDOWN || socket_errno == ECONNRESET
>                || socket_errno == ECONNABORTED || socket_errno == ENETRESET)
>         happened |= POLLHUP;
> 
> #ifdef __TANDEM /* as we can't recv(...,MSG_PEEK) on a non-socket */
>       else if (socket_errno == ENOTSOCK)
>         happened |= (POLLIN | POLLRDNORM) & sought;
> #endif
>       else
>         happened |= POLLERR;
>     }
> ...
> 
> We won't detect POLLHUP that way I think. However it seems to work, we've been able to clone, push, pull, branch that way with
> NonStop being the (ssh-)server, something that didn't work at all without that hack (and yes, I believe it is just that).
> Someone in for a cleaner way of managing this?

I suppose it works to always handle ENOTSOCK that way, even on
non-__TANDEM systems.

Paolo
