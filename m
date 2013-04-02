From: Mikko Rapeli <mikko.rapeli@iki.fi>
Subject: git https transport and wrong password
Date: Tue, 2 Apr 2013 18:54:40 +0300
Message-ID: <20130402155440.GT30514@lakka.kapsi.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Shawn Pearce <spearce@spearce.org>, Jeff King <peff@peff.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 02 17:55:19 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UN3YM-0003Wt-1c
	for gcvg-git-2@plane.gmane.org; Tue, 02 Apr 2013 17:55:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761198Ab3DBPyp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Apr 2013 11:54:45 -0400
Received: from mail.kapsi.fi ([217.30.184.167]:56704 "EHLO mail.kapsi.fi"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932324Ab3DBPym (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Apr 2013 11:54:42 -0400
Received: from lakka.kapsi.fi ([2001:1bc8:1004::1] ident=Debian-exim)
	by mail.kapsi.fi with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.72)
	(envelope-from <mikko.rapeli@iki.fi>)
	id 1UN3Xk-0001fF-6t; Tue, 02 Apr 2013 18:54:40 +0300
Received: from mcfrisk by lakka.kapsi.fi with local (Exim 4.72)
	(envelope-from <mikko.rapeli@iki.fi>)
	id 1UN3Xk-0005Ot-4X; Tue, 02 Apr 2013 18:54:40 +0300
Content-Disposition: inline
X-SA-Exim-Connect-IP: 2001:1bc8:1004::1
X-SA-Exim-Mail-From: mikko.rapeli@iki.fi
X-SA-Exim-Scanned: No (on mail.kapsi.fi); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219784>

Hi,

I have a problem with git (1.7.9 and 1.8.2.357.gcc3e4eb) and https transport
to gerrit server (2.5.1-3-g719dfc7). I'm producing the problem on Cygwin but my
colleagues have same issue on Linux as well.

Gerrit server is matching corporate policies with single sign on, so after
three failed login attempts the account gets locked until a password reset.

Git amplifies this problem by asking for users password only once, and if
user made a typo git is still re-using the wrong password enough times to
get an account immediately locked.

I have client side logs with GIT_CURL_VERBOSE=1 but from intranet so can't
publish them directly. Here's roughly what the log shows:

---------------------------------------------------------------

$ GIT_CURL_VERBOSE=1 git fetch
...
> GET /gerrit/.../info/refs?service=git-upload-pack HTTP/1.1
...
< HTTP/1.1 401 Authorization Required
...

---------- I guess git prompts for password here. --------------

* Issue another request to this URL: 'https://..info/refs?service=git-upload-pack'
...
* Re-using existing connection! ...
...
* Server auth using Basic with user '...'
> GET /gerrit/.../info/refs?service=git-upload-pack HTTP/1.1
Authorization: Basic ...
...
< HTTP/1.1 401 Authorization Required
< Date: ...
* Authentication problem. Ignoring this.
...
* The requested URL returned error: 401
* Closing connection 0
...
* About to connect() to ...
...
* Connected to ...
...
* STATE: PROTOCONNECT => DO handle...
* Server auth using Basic with user '...'
> GET /gerrit/.../info/refs?service=git-upload-pack HTTP/1.1
Authorization: Basic ...
...
* STATE: DO => DO_DONE handle...
* STATE: DO_DONE => WAITPERFORM handle...
* STATE: WAITPERFORM => PERFORM handle...
...
< HTTP/1.1 302 Found
...
< Location: ...funnylongurl
...
* Ignoring the response-body
* Connection #1 to host ... left intact
* Issue another request to this URL: '...funnylongurl'
...
* Server auth using Basic with user '...'
> GET ...funnylongurl
Authorization: Basic ...
...
* The requested URL returned error: 500 Internal Server Error
* Closing connection 1
...
* About to connect()...
...
* Server auth using Basic with user '...'
> GET /gerrit/.../info/refs HTTP/1.1
Authorization: Basic ...
...
< HTTP/1.1 302 Found
< Date...
< Set-Cookie...
< Cache-Control: no-store
< Location: ...funnylongurl
...
* Re-using existing connection! (#2)...
> GET ...funnylongurl
...
* The requested URL returned error: 500 Internal Server Error
* Closing connection 2
...
error: The requested URL returned error: 500 Internal Server Error while accessing ...
fatal: HTTP request failed

---------------------------------------------------------------

Any idea what could be wrong here? Is git client really retrying with the
bad password?

Regards,

-Mikko
