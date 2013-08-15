From: Jeff King <peff@peff.net>
Subject: Re: Bug: commit -p breaks with -m
Date: Thu, 15 Aug 2013 08:16:35 -0400
Message-ID: <20130815121635.GB22102@sigill.intra.peff.net>
References: <6EC98F2F-98FC-439B-BD9C-B1D0DB1F5E10@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Matan Nassau <matan.nassau@gmail.com>
X-From: git-owner@vger.kernel.org Thu Aug 15 14:16:45 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V9wTq-0004Px-O9
	for gcvg-git-2@plane.gmane.org; Thu, 15 Aug 2013 14:16:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755516Ab3HOMQj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Aug 2013 08:16:39 -0400
Received: from cloud.peff.net ([50.56.180.127]:46696 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755254Ab3HOMQi (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Aug 2013 08:16:38 -0400
Received: (qmail 21048 invoked by uid 102); 15 Aug 2013 12:16:38 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 15 Aug 2013 07:16:38 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 15 Aug 2013 08:16:35 -0400
Content-Disposition: inline
In-Reply-To: <6EC98F2F-98FC-439B-BD9C-B1D0DB1F5E10@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232344>

On Thu, Aug 15, 2013 at 12:43:39AM -0400, Matan Nassau wrote:

> With git 1.8.3.3,
> 
>  $ seq 5 >data
>  $ git add data
>  $ git commit -mdata
>  $ sed -i '2 d' data
>  $ git commit -pmchange
> 
> At the prompt, type e to edit the hunk. The editor doesn't start, but
> git records a commit.
> 
> I found that builtin/commit.c sets the GIT_EDITOR env var to ":" when
> the user specifies the -m option. This was done in 406400ce4f69.
> Removing these two lines,
> 
>  if (!use_editor)
>      setenv("GIT_EDITOR", ":", 1);
> 
> seems to fix the issue, but I'm not sure this won't break the
> prepare-commit-msg hook. I'd like to submit a patch: can I get a hint
> if this change would break commit hooks or anything else I'm not
> seeing?

Yeah, that is definitely a bug. Just removing those lines would not be the
right fix, though, because the point of them is to let the
prepare-commit-msg hook know whether or not an editor is in use.

Instead, I think you would want to limit the scope of where we have set
GIT_EDITOR. I.e., drop those lines, and then add GIT_EDITOR=: to the
environment that we pass to the hook via the run_hook function.
Unfortunately, I think that will require some refactoring of the
run_hook interface, which does not allow arbitrary environment
parameters to be set.

-Peff
