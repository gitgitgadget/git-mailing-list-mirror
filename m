From: Lukas Fleischer <git@cryptocrack.de>
Subject: Re: [PATCH] blame.c: fix garbled error message
Date: Tue, 13 Jan 2015 00:18:49 +0100
Message-ID: <20150112231849.4992.72982@typhoon.lan>
References: <1420925601-21615-1-git-send-email-git@cryptocrack.de>
 <xmqq4mrv95qt.fsf@gitster.dls.corp.google.com>
 <xmqqzj9n623h.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8BIT
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jan 13 00:25:41 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YAoMe-00042B-Qi
	for gcvg-git-2@plane.gmane.org; Tue, 13 Jan 2015 00:25:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752674AbbALXZe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Jan 2015 18:25:34 -0500
Received: from elnino.cryptocrack.de ([46.165.227.75]:7779 "EHLO
	elnino.cryptocrack.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752617AbbALXZb convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 12 Jan 2015 18:25:31 -0500
X-Greylist: delayed 398 seconds by postgrey-1.27 at vger.kernel.org; Mon, 12 Jan 2015 18:25:31 EST
Received: by elnino.cryptocrack.de (OpenSMTPD) with ESMTPSA id 707cb1eb;
	TLS version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO;
	Tue, 13 Jan 2015 00:18:50 +0100 (CET)
In-Reply-To: <xmqqzj9n623h.fsf@gitster.dls.corp.google.com>
User-Agent: alot/0.3.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262301>

On Mon, 12 Jan 2015 at 23:55:30, Junio C Hamano wrote:
> Junio C Hamano <gitster@pobox.com> writes:
> 
> > Lukas Fleischer <git@cryptocrack.de> writes:
> >
> >> The helper functions prepare_final() and prepare_initial() return a
> >> pointer to a string that is a member of an object in the revs->pending
> >> array. This array is later rebuilt when running prepare_revision_walk()
> >> which potentially transforms the pointer target into a bogus string. Fix
> >> this by maintaining a copy of the original string.
> >>
> >> Signed-off-by: Lukas Fleischer <git@cryptocrack.de>
> >> ---
> >> The bug manifests when running `git blame HEAD^ -- nonexistent.file`.
> >
> > Before 1da1e07c (clean up name allocation in prepare_revision_walk,
> > 2014-10-15), these strings used to be non-volatile; they were instead
> > leaked more or less deliberately.  But these days, these strings are
> > cleared, so your patch is absolutely the right thing to do.
> >
> > Thanks for catching and fixing.  This fix needs to go to the 2.2.x
> > maintenance track.
> 
> Sigh, but not so fast.
> 
> With the patch applied on top of 1da1e07c (or the result merged to
> 'next' for that matter), I see test breakages in many places "git
> blame" is used, e.g. t7010.  Did you run the test suite?
> 

No, I didn't.

> This is because it is perfectly normal for prepare_final() to return
> NULL.  Unconditionally running xstrdup() would of course fail.
> [...]

Something like

    return final_commit_name ? xstrdup(final_commit_name) : NULL;

should work, though, right? Calling free() with a null pointer is fine,
so there is nothing else to do here. You can either amend those two
lines or wait for me to resubmit v2 of the patch tomorrow :)
