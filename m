From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: [PATCH] commit: configure submodules
Date: Sun, 23 Sep 2012 20:13:37 +0200
Message-ID: <505F5151.2080208@web.de>
References: <1348385867-17359-1-git-send-email-orgads@gmail.com> <7vr4pt16ep.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Orgad Shaneh <orgads@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Sep 23 20:14:33 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TFqhM-0001OY-0e
	for gcvg-git-2@plane.gmane.org; Sun, 23 Sep 2012 20:14:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754365Ab2IWSNk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 23 Sep 2012 14:13:40 -0400
Received: from mout.web.de ([212.227.17.11]:65495 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751460Ab2IWSNj (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 23 Sep 2012 14:13:39 -0400
Received: from [192.168.178.41] ([91.3.183.9]) by smtp.web.de (mrweb102) with
 ESMTPA (Nemesis) id 0LtWsC-1TfFrx3SdQ-011A9I; Sun, 23 Sep 2012 20:13:37 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:15.0) Gecko/20120907 Thunderbird/15.0.1
In-Reply-To: <7vr4pt16ep.fsf@alter.siamese.dyndns.org>
X-Provags-ID: V02:K0:zPTVqrydkRIJTXwwrTbPOLTMKf+S9OdqBuKvX00tyaa
 bdqLd8ExxWeuR9VkktmigdKDJN8226nBtsF5tHlNPNepSahi93
 sRrMINkUzCQRtdK026DdA5dUCiXNefb9LRLjuQIV54fvH7qN9L
 rUnAEGSXgEDYMBSGAv14cMWbX4kHdSjERRSe45CIqjU8UQkN5Y
 N5LFwFx2IVJVLHbfy++ag==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206250>

Am 23.09.2012 10:37, schrieb Junio C Hamano:
> I see Jens added with 302ad7a (Submodules: Use "ignore" settings
> from .gitmodules too for diff and status, 2010-08-06) the call to
> gitmodules_config() to "git status" and "git diff" family, but I
> suspect that was a huge mistake.  Once a submodule is initialized
> with "submodule init", the default set of configuration should be
> copied to the user's $GIT_DIR/config and subsequent run-time
> invocation should read $GIT_DIR/config and $GIT_DIR/config alone, to
> honor user's customization.

Not honoring the user's customization would be a big mistake, but
this is not what happens here. A setting in $GIT_DIR/config always
overrides the one in .gitmodules (that's why gitmodules_config() is
called before git_config()).

> Instead, I think git_commit_config() and git_status_config() should
> call submodule_config() function to read submodule.$name.ignore not
> from .gitmodules file but from $GIT_DIR/config.
> 
> Jens, what do you think?  I see no reason for anybody other than
> "submodule init" to call gitmodules_config() that reads from the
> in-tree .gitmodules file.

I think the copying on init is not what we should do here because
it sets the user's customization to what ever happened to be in
.gitmodules at the time he initialized the submodule. Later changes
from upstream to such a setting would not be honored unless the
user copies that new setting herself (which I think is The Right
Thing for the URL, but not for the other work tree related settings
like 'ignore').

Imagine you have a submodule containing a huge media file which is
set to be ignored for performance reasons. When upstream later
decides it should rather use .gitattributes to just disable diffing
that file and removes the submodule ignore so the users see changes
to other files of the submodule again, that will just work the way
it is done now, but won't when we copy that setting on init.

So it is either "honor upstream unless the user decides otherwise"
or "take what upstream configured at init time as the users choice
(until he actively changes it)". And I think the former is more
flexible as it allows upstream to change settings without user
intervention, which is why I did it that way.

And as I understand that .gitattributes follow the same principle:
Unless the user configured something different in his
$GIT_DIR/info/attributes file, git will use the settings from the
.gitattributes file of the currently checked out commit.

So I think Orgad's change is sane and should go in.
