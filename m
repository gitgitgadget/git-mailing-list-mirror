From: Jeff King <peff@peff.net>
Subject: Re: Error in creating git over http
Date: Wed, 9 Oct 2013 21:06:17 -0400
Message-ID: <20131010010616.GA14429@sigill.intra.peff.net>
References: <51123DD1BF2E03418A1296748DA730927454460F@ibwmbx03>
 <51123DD1BF2E03418A1296748DA730927454504A@ibwmbx03>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Shlomit Afgin <shlomit.afgin@weizmann.ac.il>
X-From: git-owner@vger.kernel.org Thu Oct 10 03:06:28 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VU4hw-0004kx-1b
	for gcvg-git-2@plane.gmane.org; Thu, 10 Oct 2013 03:06:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757345Ab3JJBGV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Oct 2013 21:06:21 -0400
Received: from cloud.peff.net ([50.56.180.127]:46645 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754899Ab3JJBGT (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Oct 2013 21:06:19 -0400
Received: (qmail 25516 invoked by uid 102); 10 Oct 2013 01:06:19 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 09 Oct 2013 20:06:19 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 09 Oct 2013 21:06:17 -0400
Content-Disposition: inline
In-Reply-To: <51123DD1BF2E03418A1296748DA730927454504A@ibwmbx03>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235846>

On Tue, Oct 08, 2013 at 03:05:22PM +0000, Shlomit Afgin wrote:

> I do the following on the git server:
>        cd /var/www/html/
> git clone --bare  /path/to/dir/ gitproject.git
> cd gitproject.git/
> mv hooks/post-update.sample hooks/post-update
> chmod a+x hooks/post-update

OK, so on the next push, the info/refs file should be updated. Note that
this file is only necessary if you want to run the "dumb" http protocol
(i.e., the less efficient one that does not require git on the server).

You didn't say whether you are trying to set up a "dumb" or "smart"
git-http server. These days you almost certainly want to set up a
"smart" one, and you do not need to care about info/refs or running
update-server-info.

> on the local machine run:
> git clone http://server.name/gitproject.git
> 
> I got the error:
> "Initialized empty Git repository in /local/path/gitproject/.git/
> fatal: http://server.name/gitproject.git/info/refs not found: did you run
> git update-server-info on the server?"
> 
> I saw that the file does not exist,  it seem that the file post-update is
> not execute.

Yes, if you didn't push yet, then it won't have been created.

> I run it on the git server:
> git update-server-info
> 
> Now the info/ref is created.

OK, good.

> On local machine I run again :
> git clone http://server.name/gitproject.git
> 
> Now I get the error:
>   Initialized empty Git repository in /local/path/gitproject/.git/
> error: The requested URL returned error: 403 (curl_result = 22, http_code
> = 403, sha1 = 9d83b83df9fbc75ecd754264f95793fca93ccf93)
> error: Unable to find 9d83b83df9fbc75ecd754264f95793fca93ccf93 under
> http://server.name/gitproject.git
> Cannot obtain needed object 9d83b83df9fbc75ecd754264f95793fca93ccf93

403 is an HTTP "Forbidden". Have you configured your web server to allow
access to the project? Have you marked the repository as
git-daemon-export-ok, as described in "git help http-backend" (or set
GIT_HTTP_EXPORT_ALL in the environment)? Is there anything interesting
in the webserver's error logs?

If it is still not working after checking those things, can you show us
how you have configured your webserver (presumably apache?).

-Peff
