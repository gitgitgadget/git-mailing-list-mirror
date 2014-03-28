From: Marat Radchenko <marat@slonopotamus.org>
Subject: Re: [PATCH] MSVC: link in invalidcontinue.obj for better POSIX compatibility
Date: Fri, 28 Mar 2014 18:46:55 +0000 (UTC)
Message-ID: <loom.20140328T193620-235@post.gmane.org>
References: <53354EE3.2050908@viscovery.net> <1396005570-948-1-git-send-email-marat@slonopotamus.org> <xmqqy4zu9o0j.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 28 19:47:30 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WTboP-0003OI-ST
	for gcvg-git-2@plane.gmane.org; Fri, 28 Mar 2014 19:47:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752383AbaC1SrX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Mar 2014 14:47:23 -0400
Received: from plane.gmane.org ([80.91.229.3]:34596 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751759AbaC1SrV (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Mar 2014 14:47:21 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1WTboF-0003Hs-Ga
	for git@vger.kernel.org; Fri, 28 Mar 2014 19:47:19 +0100
Received: from core-gate-01-v50-x7.possvyaz.ru ([core-gate-01-v50-x7.possvyaz.ru])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 28 Mar 2014 19:47:19 +0100
Received: from marat by core-gate-01-v50-x7.possvyaz.ru with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 28 Mar 2014 19:47:19 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 176.57.72.72 (Mozilla/5.0 (Linux; U; Android 4.0.4; ru-ru; SonyEricssonMK16i Build/4.1.B.0.587) AppleWebKit/534.30 (KHTML, like Gecko) Version/4.0 Mobile Safari/534.30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245412>

Junio C Hamano <gitster <at> pobox.com> writes:

> > This patch fixes crashes caused by quitting from PAGER.
> 
> Can you elaborate a bit more on the underlying cause, summarizing
> what you learned from this discussion, so that those who read "git
> log" output two weeks from now do not have to come back to this
> thread in the mail archive in order to figure out why we suddenly
> needs to link with yet another library?

Without linking to that obj, Windows abort()'s instead of setting
errno=EINVAL when invalid arguments are passed to standard functions.
In this particular case, when PAGER quits and git detects it with
errno=EPIPE on write(), git tries raise(SIGPIPE) but since there is no
SIGPIPE on Windows, it is treated as invalid argument, causing abort()
and crash report window.

Linking in invalidcontinue.obj (provided along with MS compiler) allows
raise(SIGPIPE) to return with errno=EINVAL. While testing MSVC=1 git,
I found several more cases with same sympthoms (and also fixed by
given patch).
