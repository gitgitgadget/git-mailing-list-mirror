From: Jeff King <peff@peff.net>
Subject: Re: Bug report: Git 1.8 on Ubuntu 13.10 refs not valid
Date: Thu, 27 Mar 2014 14:49:16 -0400
Message-ID: <20140327184916.GA28668@sigill.intra.peff.net>
References: <5334398E.8090402@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Siggi <siggin@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 27 19:49:25 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WTFMi-0003K8-4J
	for gcvg-git-2@plane.gmane.org; Thu, 27 Mar 2014 19:49:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757201AbaC0StT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Mar 2014 14:49:19 -0400
Received: from cloud.peff.net ([50.56.180.127]:48633 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1756967AbaC0StT (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Mar 2014 14:49:19 -0400
Received: (qmail 24453 invoked by uid 102); 27 Mar 2014 18:49:18 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 27 Mar 2014 13:49:18 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 27 Mar 2014 14:49:16 -0400
Content-Disposition: inline
In-Reply-To: <5334398E.8090402@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245307>

On Thu, Mar 27, 2014 at 03:45:34PM +0100, Siggi wrote:

> and git version
> git:amd64/saucy 1:1.8.3.2-1 uptodate
> 
> my remote repository is on a Chiliprojekt server (a fork of Redmine).
> 
> cloning the repo over http results in following error:
> 
> sneher@sneher-XPS:~/Dokumente/test$ git clone
> http://sneher@git.projects.gwdg.de/xrd-csd.git
> Klone nach 'xrd-csd'...
> Password for 'http://sneher@git.projects.gwdg.de':
> fatal: http://sneher@git.projects.gwdg.de/xrd-csd.git/info/refs not valid:
> is this a git repository?

Hmm.  The only way to trigger that message is if the dumb info/refs
output from the server is not valid. In particular, it is looking for
the tab character between the sha1 and the refs, and making sure that
the sha1 is exactly 40 characters.

I noticed other people having the problem, too:

  https://github.com/kubitron/redmine_git_hosting/issues/106

so I think it is related to the output that the redmine plugin is
producing. But the interesting thing is that the plugin is supposed to
enable git's smart-http protocol. But the error message you are seeing
indicates that the client thinks it is doing a "dumb" http fetch.

The parsing code did not change in the v1.8.x series, but the logic to
determine whether we are using smart/dumb http did change. For example,
we now actually check the content-type returned by the server (which
should be "application/x-git-upload-pack-advertisement").

Can you try running your clone with GIT_CURL_VERBOSE=1 in the
environment? That should show the headers (including content-type). Do
be careful when sharing the output; I believe it will contain
"Authorization" lines that have your base64-encoded password on them.

Also, I would be curious to see the output of:

  curl http://sneher@git.projects.gwdg.de/xrd-csd.git/info/refs | cat -A

My suspicion is that it is really smart-http output, but the client is
parsing it as dumb-http output (and probably because of the content-type
mentioned above).

-Peff
