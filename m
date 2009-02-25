From: Josef Wolf <jw@raven.inka.de>
Subject: Re: git with https and client cert asks for password repeatedly
Date: Wed, 25 Feb 2009 22:42:24 +0100
Message-ID: <20090225214224.GB4573@raven.wolf.lan>
References: <ca433830902241911x10b08a4fg8e790000a5cf9f3b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 25 22:52:03 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LcRfI-0004cd-8J
	for gcvg-git-2@gmane.org; Wed, 25 Feb 2009 22:51:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756381AbZBYVuO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Feb 2009 16:50:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752892AbZBYVuM
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Feb 2009 16:50:12 -0500
Received: from quechua.inka.de ([193.197.184.2]:50889 "EHLO mail.inka.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752132AbZBYVuL (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Feb 2009 16:50:11 -0500
Received: from raven.inka.de (uucp@[127.0.0.1])
	by mail.inka.de with uucp (rmailwrap 0.5) 
	id 1LcRdp-0006pw-1G; Wed, 25 Feb 2009 22:50:09 +0100
Received: by raven.inka.de (Postfix, from userid 1000)
	id 7FABD2CAAD; Wed, 25 Feb 2009 22:42:24 +0100 (CET)
Mail-Followup-To: Josef Wolf <jw@raven.inka.de>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <ca433830902241911x10b08a4fg8e790000a5cf9f3b@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111500>

On Tue, Feb 24, 2009 at 10:11:40PM -0500, Mark Lodato wrote:

> When fetching or pushing over https:// with a client certificate
> (http.sslCert / http.sslKey), git asks for a password for every single
> requested file.  For example, here I push three commits with a couple
> changed files each:
[ ... ]
> This problem makes client-side certificates unusable with git.  A
> possible workaround is to leave the key unencrypted, but this is
> usually unacceptable for security reasons.

For the (pretty much standard) Basic authentication over https, it is
even worse: you have to put your password in plain text into .netrc :-(
Check out http://marc.info/?l=git&m=122426078301793&w=2 if you have a
couple of minutes left.

> Ideally, I would just type
> my password once per invocation and git would remember it.  (This is
> how svn works.)

Yeah, that would be great!

> I think the root problem is that git creates a completely new http(s)
> connection for every request, rather than using one persistent
> connection.  Using a persistent connection would theoretically speed
> up the transfers, in addition to fixing the password prompt issue.
> I'm pretty sure that calling `curl_easy_cleanup()' after every request
> is causing this behavior; I don't think this is necessary.
> 
> I tried fixing this myself, but the http/curl code is pretty
> confusing.  Just wondering - why is HTTP_MULTI required for http-push?

The integration of curl into git looks somewhat strange to me, also.
It seems to implement some sort of request-queue on top of curl-multi
and falls back to re-implement some curl-multi functionality in the
case when only curl-easy is available.  Or something like that.  I have
not looked too much into the details, and have already forgotten what I
saw there.

Instead, I looked into curl-lib to implement some sort of credential
caching. The idea was to implement something like get_basic_credentials()
in the LWP::UserAgent perl module.

Once such a retrieval callback/cache would be implemented in curl, it
would be pretty easy to make use of it from git without messing/breaking
too much with the existing code.

So I went to the curl-library list.  Please feel free to read the
discussion on http://curl.haxx.se/mail/lib-2008-10/index.html#286

Check out http://curl.haxx.se/mail/lib-2008-11/index.html#38 for a
first draft of the change I suggested.

Unfortunately, I got stuck implementing the regression tests for this
change.  Then I got short on time to proceed the work on this topic.
Check out http://curl.haxx.se/mail/lib-2008-11/index.html#51 for the
last state of affairs I posted.  Once the regression tests are
implemented, implementing the remaining functionality would be pretty
much straight forward.  But currently, I have no clue when I will get
around to continue working on that.

> Finally, is there interest in refactoring the http code to make it a
> little cleaner?  That is, make a wrapper library around curl so that
> you can just call GET or POST or whatever and not worry about how to
> invoke curl?

As I mentioned above, I figured that implementing the callback method
in curl-lib would probably be easier than understanding the usage of
curl within git.  So I'd say refactoring would be an improvement.  But
I bet the git gurus will flame me for saying that =:-S
