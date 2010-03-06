From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH 0/6] Pass t5530 on Windows
Date: Sat, 6 Mar 2010 13:50:51 -0800
Message-ID: <20100306215051.GE2529@spearce.org>
References: <cover.1267889072.git.j6t@kdbg.org> <7vk4tpdx9x.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Sixt <j6t@kdbg.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Mar 06 23:23:15 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1No20r-0007UA-1t
	for gcvg-git-2@lo.gmane.org; Sat, 06 Mar 2010 22:58:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752216Ab0CFV6P (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 6 Mar 2010 16:58:15 -0500
Received: from mail-gy0-f174.google.com ([209.85.160.174]:41169 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751484Ab0CFV6O (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Mar 2010 16:58:14 -0500
Received: by gyh3 with SMTP id 3so245371gyh.19
        for <git@vger.kernel.org>; Sat, 06 Mar 2010 13:58:13 -0800 (PST)
Received: by 10.91.164.17 with SMTP id r17mr3349400ago.0.1267912254397;
        Sat, 06 Mar 2010 13:50:54 -0800 (PST)
Received: from localhost (george.spearce.org [209.20.77.23])
        by mx.google.com with ESMTPS id 22sm2814205iwn.12.2010.03.06.13.50.52
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 06 Mar 2010 13:50:53 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <7vk4tpdx9x.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141621>

Junio C Hamano <gitster@pobox.com> wrote:
> Johannes Sixt <j6t@kdbg.org> writes:
> 
> > Quite frankly, I don't quite know what to do with this series. On the
> > one hand, it is a clean-up, but in practice it is not relevant whether
> > die() kills only the async thread or the whole process because all
> > callers of async die() themselves anyway when the async procedure died.
> > On the other hand, it does enable threaded async procedures on POSIX...
...
>    . It must not change the program's state that the caller of the
>      facility also uses.
> 
> And calling die() from async is obviously "change the program's state that
> the caller of the facility also uses".  We didn't uncover this as a bug
> because the above "serious restrictions" go both ways.

I agree with you Junio.  I think that any async helper that is
invoking die() in its code path is wrong.  Just like its also
wrong for an async helper to try and use the sha1_file.c family
of functions.  The helper should return failure and let its caller
handle the process termination.

Hell, its even wrong for an async helper to use xmalloc(), because in
a low-memory situation that xmalloc may try to remove pack windows
*without locking*.  _DOUBLE_PLUS_UNGOOD_
 
> If we make threaded-async the default on any platform that is thread
> capable, we would increase the likelihood of catching bugs that violate
> the latter condition.

I'm in favor of that.  If we have threaded delta search enabled,
we probably can also run these async procedures in a POSIX thread
rather than forking off a child.  Though on our primary target
platform of Linux, the performance difference either way probably
cannot be measured.

-- 
Shawn.
