From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 0/11] Miscellaneous MinGW port fallout
Date: Wed, 14 Nov 2007 14:50:47 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0711141441530.4362@racer.site>
References: <1194984306-3181-1-git-send-email-johannes.sixt@telecom.at>
 <7vir45hyyn.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Johannes Sixt <johannes.sixt@telecom.at>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Nov 14 15:51:43 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IsJaT-00007K-LG
	for gcvg-git-2@gmane.org; Wed, 14 Nov 2007 15:51:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753538AbXKNOvM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Nov 2007 09:51:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753679AbXKNOvK
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Nov 2007 09:51:10 -0500
Received: from mail.gmx.net ([213.165.64.20]:35274 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753538AbXKNOvJ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Nov 2007 09:51:09 -0500
Received: (qmail invoked by alias); 14 Nov 2007 14:51:07 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp040) with SMTP; 14 Nov 2007 15:51:07 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+J+7VPNgOJazHQYb4lhlfHTMfZzC2QQdy/xVoem9
	PItUGMc7uCCijM
X-X-Sender: gene099@racer.site
In-Reply-To: <7vir45hyyn.fsf@gitster.siamese.dyndns.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64988>

Hi,

On Wed, 14 Nov 2007, Junio C Hamano wrote:

> Johannes Sixt <johannes.sixt@telecom.at> writes:
> 
> > This is a series of smallish, unrelated changes that were necessary
> > for the MinGW port.
> 
> I was _VERY_ afraid of reviewing this series.

Why?  Because we get closer to MinGW integration into git.git for real? 
;-)

> > [PATCH 05/11] Use is_absolute_path() in sha1_file.c.
> > [PATCH 06/11] Move #include <sys/select.h> and <sys/ioctl.h> to
> > 	git-compat-util.h.
> >
> > These two are certainly undisputed.
> 
> Except on esoteric/broken systems there might be some dependency
> on the order the system include files are included, so 06/11
> needs some testing.  But it is a change in the right direction.

The safe thing, of course, would be to move them at the end of the include 
list in git-compat-util.h, since they are now included after cache.h, 
(which includes git-compat-util.h and only strbuf.h, the sha1 header and 
zlib.h).

This way it should be really certainly undisputed.

> > [PATCH 08/11] Close files opened by lock_file() before unlinking.
> >
> > This one was authored by Dscho. It is a definite MUST on Windows.
> 
> This was something we've talked about doing a few times on the
> list but did not.  It is good that this saw some testing in the
> field, as it is easy to get wrong while moving the call site of
> close(2) around.

Note that we are not strictly _moving_ it around. In fact, we are _adding_ 
more close() calls...  And even ignoring the errors when close() was 
already called, so it feels a tad hacky.  But it does the job.

> > [PATCH 09/11] Allow a relative builtin template directory.
> > [PATCH 10/11] Introduce git_etc_gitconfig() that encapsulates access
> > 	of ETC_GITCONFIG.
> > [PATCH 11/11] Allow ETC_GITCONFIG to be a relative path.
> >
> > These need probably some discussion. They avoid that $(prefix) is
> > hardcoded and so allows that an arbitrary installation directory.
> 
> I had to worry a bit about bootstrapping issues in 11/11.  We
> need to ensure that anybody who wants to read the configuration
> data first does setup_path() because git_exec_path() reads from
> argv_exec_path and setup_path() is what assigns to that
> variable.

Just to be safe in the future, we could check for that condition (by 
introducing a static variable setup_path_called) and die() should anybody 
introduce a code path where the order of calls is not maintained.

> But other than that and 08/11, I found everything is trivially correct 
> and it was a pleasant read.

Me, too.

Ciao,
Dscho
