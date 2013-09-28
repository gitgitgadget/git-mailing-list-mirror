From: Jeff King <peff@peff.net>
Subject: [PATCH 0/9] following http redirects
Date: Sat, 28 Sep 2013 04:29:57 -0400
Message-ID: <20130928082956.GA22610@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: "Kyle J. McKay" <mackyle@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Sep 28 10:30:11 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VPpuk-00014i-Ab
	for gcvg-git-2@plane.gmane.org; Sat, 28 Sep 2013 10:30:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754899Ab3I1IaG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 28 Sep 2013 04:30:06 -0400
Received: from cloud.peff.net ([50.56.180.127]:35118 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752514Ab3I1IaA (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 Sep 2013 04:30:00 -0400
Received: (qmail 8467 invoked by uid 102); 28 Sep 2013 08:29:59 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sat, 28 Sep 2013 03:29:59 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 28 Sep 2013 04:29:57 -0400
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235489>

Git's http handling takes care of redirects by setting
CURLOPT_FOLLOWLOCATION, and just assuming curl will handle the details.
For the most part, this works, but there are a few downsides:

  1. We do extra round-trips for subsequent requests, as we
     always feed curl the original URL, and it then has to go hit the
     redirect.

  2. Some redirects are to upgrade http->https. In this case, we end up
     sending the credential over unencrypted http. We do advertise the
     proper unencrypted URL to the credential helpers (and to the user
     when we prompt them), so to some degree this is the user's fault.
     Still, there's no reason not to be friendly and avoid exposing the
     password in plaintext if we know that the server is just going to
     redirect us to an encrypted connection anyway.

  3. Cross-server redirects do not work at all with authentication. If
     we tell curl to go to host X, and it redirects to host Y, it will
     drop the auth credentials to avoid revealing them to Y. This is a
     good thing, because we prompted the user for host X, and curl is
     being safe. However, it means that we have no way to feed curl the
     right password (and the user does not even get a useful error
     message; simply a 401 from Y, since we didn't give it any
     credential).

None of these is fixable at the curl layer; they depend on information
we have outside of curl (e.g., the notion that if info/refs is
redirected, so should the rest of the requests be).

This series gets the redirect information from curl (after the fact),
and uses it update the base URL for the repository for the remainder of
the program run.

Kyle, I didn't call into the urlmatch code at all; we might want another
patch on top to re-check the http.$url.* config after following such a
redirect.

The patches are:

  [1/9]: http_get_file: style fixes
  [2/9]: http_request: factor out curlinfo_strbuf
  [3/9]: http: refactor options to http_get_*
  [4/9]: http: hoist credential request out of handle_curl_result
  [5/9]: http: provide effective url to callers
  [6/9]: http: update base URLs when we see redirects
  [7/9]: remote-curl: make refs_url a strbuf
  [8/9]: remote-curl: store url as a strbuf
  [9/9]: remote-curl: rewrite base url from info/refs redirects

Here is sample output from running a clone against a private repo on
github, which redirects from http to https. Generated with:

  GIT_CURL_VERBOSE=1 git clone http://github.com/github/github 2>&1 |
  egrep '^(< HTTP|< Location|> GET|> POST|^Authorization|\* Connected to)' |
  sed -e 's/\(Authorization\): .*/\1: **redacted**/' 

Here is the output with stock git (I've added numbering for each
connection):

1 * Connected to github.com (192.30.252.129) port 80 (#0)
    > GET /github/github/info/refs?service=git-upload-pack HTTP/1.1
    < HTTP/1.1 301 Moved Permanently
    < Location: https://github.com/github/github/info/refs?service=git-upload-pack

2 * Connected to github.com (192.30.252.129) port 443 (#1)
    > GET /github/github/info/refs?service=git-upload-pack HTTP/1.1
    < HTTP/1.1 401 Authorization Required

3 * Connected to github.com (192.30.252.129) port 80 (#2)
    > GET /github/github/info/refs?service=git-upload-pack HTTP/1.1
    < HTTP/1.1 301 Moved Permanently
    < Location: https://github.com/github/github/info/refs?service=git-upload-pack

4 * Connected to github.com (192.30.252.129) port 443 (#1)
    > GET /github/github/info/refs?service=git-upload-pack HTTP/1.1
    < HTTP/1.1 401 Authorization Required

5 * Connected to github.com (192.30.252.129) port 443 (#1)
    > GET /github/github/info/refs?service=git-upload-pack HTTP/1.1
    Authorization: **redacted**
    < HTTP/1.1 200 OK

6 * Connected to github.com (192.30.252.129) port 80 (#3)
    > POST /github/github/git-upload-pack HTTP/1.1
    Authorization: **redacted**
    < HTTP/1.1 301 Moved Permanently
    < Location: https://github.com/github/github/git-upload-pack

7 * Connected to github.com (192.30.252.129) port 443 (#4)
    [... POST actually happens, and I hit ^C before it finishes ...]

You can see that connections 3 and 6 are extraneous round-trips, and
that we reveal the credential over cleartext in step 6. Curiously, even
though we have fed the credential to curl after step 2, curl does not
share it until the server sends another 401 in step 4. I'm not sure why
that is the case.

Here's the output with these patches applied:

1 * Connected to github.com (192.30.252.129) port 80 (#0)
    > GET /github/github/info/refs?service=git-upload-pack HTTP/1.1
    < HTTP/1.1 301 Moved Permanently
    < Location: https://github.com/github/github/info/refs?service=git-upload-pack

2 * Connected to github.com (192.30.252.129) port 443 (#1)
    > GET /github/github/info/refs?service=git-upload-pack HTTP/1.1
    < HTTP/1.1 401 Authorization Required

3 * Connected to github.com (192.30.252.129) port 443 (#1)
    > GET /github/github/info/refs?service=git-upload-pack HTTP/1.1
    < HTTP/1.1 401 Authorization Required

4 * Connected to github.com (192.30.252.129) port 443 (#1)
    > GET /github/github/info/refs?service=git-upload-pack HTTP/1.1
    Authorization: **redacted**
    < HTTP/1.1 200 OK

5 * Connected to github.com (192.30.252.129) port 443 (#2)
    [... POST actually happens ...]

We do 2 fewer round-trips. That isn't all that exciting, but keep in
mind that it saves one per request after the initial contact. So if we
had more ref negotiation, we'd see more savings. Similarly, dumb http
would see many more savings (since it makes individual requests for each
loose object and pack).

We also go straight to https in steps 3 and 4, meaning the credential
never gets passed in plaintext to the old URL.

I also tested cross-server redirects using a hacky "nc -l" setup as the
server. I confirmed that it does not work at all with stock git (you are
prompted for the password for "localhost", which curl then drops after
following the redirect), and that it does work after the patches.

The one downside I can think of is that we are making the assumption
that if info/refs redirects, the rest of the repo will, too. So you
could not have "info/refs" redirect to another server to get the ref
advertisement, but then expect to get the actual pack from the original
location. I'm OK with making that assumption; I can't imagine the
insanity of the setup that would be required to break it.

-Peff
