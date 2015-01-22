From: Mike Hommey <mh@glandium.org>
Subject: Re: [PATCH] transport-helper: do not request symbolic refs to remote
 helpers
Date: Thu, 22 Jan 2015 16:03:01 +0900
Message-ID: <20150122070301.GA18195@glandium.org>
References: <1421631307-20669-1-git-send-email-mh@glandium.org>
 <xmqqwq4fuxbb.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, srabbelier@gmail.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jan 22 08:03:26 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YEBnX-0000Je-UH
	for gcvg-git-2@plane.gmane.org; Thu, 22 Jan 2015 08:03:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750801AbbAVHDN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Jan 2015 02:03:13 -0500
Received: from ks3293202.kimsufi.com ([5.135.186.141]:48915 "EHLO glandium.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750713AbbAVHDL (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Jan 2015 02:03:11 -0500
Received: from glandium by zenigata with local (Exim 4.84)
	(envelope-from <glandium@glandium.org>)
	id 1YEBnB-0004kN-3m; Thu, 22 Jan 2015 16:03:01 +0900
Content-Disposition: inline
In-Reply-To: <xmqqwq4fuxbb.fsf@gitster.dls.corp.google.com>
X-GPG-Fingerprint: 182E 161D 1130 B9FC CD7D  B167 E42A A04F A6AA 8C72
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262801>

On Wed, Jan 21, 2015 at 10:46:48PM -0800, Junio C Hamano wrote:
> Mike Hommey <mh@glandium.org> writes:
> 
> > A typical remote helper will return a `list` of refs containing a symbolic
> > ref HEAD, pointing to, e.g. refs/heads/master. In the case of a clone, all
> > the refs are being requested through `fetch` or `import`, including the
> > symbolic ref.
> >
> > While this works properly, in some cases of a fetch, like `git fetch url`
> > or `git fetch origin HEAD`, or any fetch command involving a symbolic ref
> > without also fetching the corresponding ref it points to, the fetch command
> > fails with:
> >
> >   fatal: bad object 0000000000000000000000000000000000000000
> >   error: <remote> did not send all necessary objects
> >
> > (in the case the remote helper returned '?' values to the `list` command).
> 
> Hmph.
> 
> Since the most "typical remote helper" I immediately think of is
> remote-curl and "git fetch https://code.googlesource.com/git HEAD"
> does not seem to fail that way, I am not sure what to make of the
> above.  It is unclear if you meant that the above is inherent due to
> the way how remote helper protocol works (e.g. there is only one
> thing we can associate with a ref and we cannot say "HEAD points at
> this commit" at the same time we say "HEAD points at
> refs/heads/master"), or just due to broken or lazy implementation of
> the remote helpers that are invoked by transport-helper.c interface.

Note the most important part is actually between the parens: that only
happens when the remote helper returns '?' to the `list` command, which
non-git remotes helpers (like git-remote-hg or git-remote-bzr) do.
git-remote-testgit also does, so if you only apply the test parts of the
patch, you'll see that the test fails.

remote-curl probably doesn't hit the problem because it's not returning
'?' to `list`.

Mike
