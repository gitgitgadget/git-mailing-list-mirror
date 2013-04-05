From: Jeff King <peff@peff.net>
Subject: [RFC/PATCH 0/9] friendlier http error messages
Date: Fri, 5 Apr 2013 18:13:31 -0400
Message-ID: <20130405221331.GA21209@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: "Yi, EungJun" <semtlenori@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 06 19:26:22 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UOWPn-0001b9-ST
	for gcvg-git-2@plane.gmane.org; Sat, 06 Apr 2013 18:56:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1162889Ab3DEWNl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Apr 2013 18:13:41 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:58230 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1162879Ab3DEWNk (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Apr 2013 18:13:40 -0400
Received: (qmail 18195 invoked by uid 107); 5 Apr 2013 22:15:30 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 05 Apr 2013 18:15:30 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 05 Apr 2013 18:13:31 -0400
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220209>

The error messages that git generates for routine http problems can
sometimes be a bit verbose or confusing. They also provide no
opportunity for the server to communicate any free-form text, even
though the server knows much better than the git client the reason for
the error or what the next step to suggest to the user might be.

This series provides a channel for those messages, and does some general
cleanup and reformatting of the error messages that git itself produces.

Here are some before-and-after examples with this series (apologies for
the long lines, but they are part of the ugliness I want to address, so
I am leaving them in).

The "remote:" bits are simulated in the output below, as I haven't yet
updated GitHub's server side to produce more useful messages. So you can
repeat the tests, but note that the text you get from the server will
not be the same (e.g., our 404 currently just says "Repository not
found" which is not all that helpful).

  [before]
  $ git ls-remote https://github.com/non/existent
  fatal: https://github.com/non/existent/info/refs?service=git-upload-pack not found: did you run git update-server-info on the server?

  [after]
  $ git ls-remote https://github.com/non/existent
  remote: The remote repository was not found, or you do not have
  remote: permission to access it.
  fatal: repository 'https://github.com/non/existent/' not found

  [before]
  $ GIT_SMART_HTTP=0 git ls-remote https://github.com/git/git.git
  error: The requested URL returned error: 403 Forbidden while accessing https://github.com/git/git.git/info/refs
  fatal: HTTP request failed

  [after]
  $ GIT_SMART_HTTP=0 git ls-remote https://github.com/git/git.git
  remote: Sorry, fetching via dumb http is forbidden.
  remote: Please upgrade your git client to v1.6.6 or greater
  remote: and make sure that smart-http is enabled.
  fatal: unable to access 'https://github.com/git/git.git/': The requested URL returned error: 403

I still really hate the length of the generic http message (which you
can see in the final 403 example). The text "The requested URL returned
error:" comes from curl, though there is actually an opportunity to
munge it, as you will see in the patches. However, I was unable to come
up with a shorter text that sounded any better.

Another option would be to just split it across lines with some
indentation, like:

  fatal: The requested URL returned error: 403
    while accessing https://github.com/git/git.git

I'm open to suggestions.

There are a lot of little patches, as I tried to explain the rationale
for each individual change (and it makes it easy to take or reject
individual patches). If we do take them all, it may make sense to just
squash patches 3-5.

  [1/9]: http: add HTTP_KEEP_ERROR option
  [2/9]: remote-curl: show server content on http errors
  [3/9]: remote-curl: let servers override http 404 advice
  [4/9]: remote-curl: always show friendlier 404 message
  [5/9]: remote-curl: consistently report repo url for http errors
  [6/9]: http: simplify http_error helper function
  [7/9]: http: re-word http error message
  [8/9]: remote-curl: die directly with http error messages
  [9/9]: http: drop http_error function

-Peff
