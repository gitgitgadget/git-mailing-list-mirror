From: Clemens Buchacher <drizzd@aon.at>
Subject: Re: [PATCH] ignore trailing slash when creating leading directories
Date: Tue, 2 Sep 2008 21:13:22 +0200
Message-ID: <20080902191322.GA11172@localhost>
References: <20080902081909.GA2059@localhost> <7vk5dul7f5.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Sep 02 21:13:58 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KabK9-0002ot-Ay
	for gcvg-git-2@gmane.org; Tue, 02 Sep 2008 21:13:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751739AbYIBTMv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Sep 2008 15:12:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751760AbYIBTMv
	(ORCPT <rfc822;git-outgoing>); Tue, 2 Sep 2008 15:12:51 -0400
Received: from postman.fh-hagenberg.at ([193.170.124.96]:3912 "EHLO
	mail.fh-hagenberg.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751554AbYIBTMu (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Sep 2008 15:12:50 -0400
Received: from darc.dyndns.org ([84.154.73.149]) by mail.fh-hagenberg.at over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Tue, 2 Sep 2008 21:12:47 +0200
Received: from drizzd by darc.dyndns.org with local (Exim 4.69)
	(envelope-from <drizzd@aon.at>)
	id 1KabJa-0003AB-MO; Tue, 02 Sep 2008 21:13:22 +0200
Content-Disposition: inline
In-Reply-To: <7vk5dul7f5.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-OriginalArrivalTime: 02 Sep 2008 19:12:48.0625 (UTC) FILETIME=[E3621610:01C90D2F]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94693>

On Tue, Sep 02, 2008 at 11:38:38AM -0700, Junio C Hamano wrote:
>  (1) Addition of strerror(errno) is a good thing, but it is a separate
>      topic;

Yes indeed. There are many more places that lack proper error reporting. I
wonder if we should introduce some wrapper functions like mkdir_or_die, so
the caller doesn't have check for errors. Such a function could
(optionally?) create leading directories as well.

>  (2) I always thought that it was a clever feature to allow callers that
>      would want to prepare a directory in advance to ask for "xyzzy/" and
>      cause the whole path created.  You are breaking it, which may or may
>      not be a bad thing per-se, because I do not think any existing caller
>      depends on this behaviour;

Yes, I was afraid of that. So I checked all calls to c_l_d and it's not used
that way anywhere.

>  (3) If you *are* to break that feature, then I think you should also
>      handle a user input that is broken in the same fashion as your clone
>      example, namely, "git clone <repo> path//".  It does not make much
>      senseto say "path/" as the last parameter to clone is not a user
>      error but "path//" is.

True enough.

> As a "bugfix" patch meant to apply to 'maint', I'd prefer a fix to the
> caller (builtin-clone.c that calls the function), which should be of much
> less impact.  It is fine to include the change to add strerror(errno) in
> that patch, whose title would be "clone: fix creation of explicitly named
> target directory".

Unfortunately, if we simply add strerror to the error message, in place of

fatal: could not create work tree dir 'path/'.

the new version would print

fatal: could not create work tree dir 'path/': File exists.

which makes things worse IMO. We could of course strip trailing slashes in
builtin-clone.c for now and revert that as soon as the cleanup patch is in,
but I think it's not worth the trouble. I suggest we live with the "bug" for
now. The error reporting cleanups should be done at a greater scope anyways.

> > -		if (!pos)
> > +		if (!pos || !*(pos + 1))
> 
> (minor nit) I think
> 
> 		if (!pos || !pos[1])
> 
> is shorter and easier on the eye.

Will be fixed in the patch to follow.

Clemens
