From: Jeff King <peff@peff.net>
Subject: [BUG?] google code http auth weirdness
Date: Fri, 15 Mar 2013 07:59:47 -0400
Message-ID: <20130315115947.GA30675@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Fri Mar 15 13:00:23 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UGTJ8-0007cs-GD
	for gcvg-git-2@plane.gmane.org; Fri, 15 Mar 2013 13:00:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754128Ab3COL7y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Mar 2013 07:59:54 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:52447 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754183Ab3COL7y (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Mar 2013 07:59:54 -0400
Received: (qmail 25284 invoked by uid 107); 15 Mar 2013 12:01:34 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 15 Mar 2013 08:01:34 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 15 Mar 2013 07:59:47 -0400
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218237>

I tried pushing to a repository at Google Code for the first time today,
and I encountered some weird behavior with respect to asking for
credentials.

If I use the url "https://code.google.com/r/repo/", everything works; I
get prompted for my username/password.

But if I instead use the url "https://myuser@code.google.com/r/repo/",
it doesn't work. I get:

  $ git push
  fatal: remote error: Invalid username/password.
  You may need to use your generated googlecode.com password; see
  https://code.google.com/hosting/settings

without any prompt at all. I bisected it to 986bbc0 (http: don't always
prompt for password, 2011-11-04), but I think that is a red herring. It
worked before that commit because we always asked for the password,
before we even talked to the server.

After that commit, we should be reacting to an HTTP 401. But it seems that
Google Code's 401 behavior is odd. When t5540 checks this, the
conversation goes something like:

  1. We do a GET with no "Authorization" header.

  2. The server returns a 401, asking for credentials.

  3. Curl repeats the GET request, putting the username into the
     Authorization header.

  4. The server returns a 401, again, as our credential is not
     sufficient.

  5. Curl returns the 401 to git; git prompts for the credential, feeds
     it to curl, and then repeats the request. It works.

But with Google Code, the first three steps are identical. But then for
step 4, the server returns this:

  < HTTP/1.1 200 OK
  < Content-Type: application/x-git-receive-pack-advertisement
  < X-Content-Type-Options: nosniff
  < Date: Fri, 15 Mar 2013 11:43:14 GMT
  < Server: git_frontend
  < Content-Length: 175
  < X-XSS-Protection: 1; mode=block
  < 
  * Connection #0 to host code.google.com left intact
  packet:          git< # service=git-receive-pack
  packet:          git< 0000
  packet:          git< ERR Invalid username/password [...]

That seems kind of crazy to me. It's generating an HTTP 200 just to tell
us the credentials are wrong. Which kind of makes sense; it's the only
way to convince the git client to show a custom message when it aborts
(rather than producing its own client-side "authorization failed"
message). But it takes the retry decision out of the client's hands. And
in this case, it is wrong; the failed credential is a result of curl
trying the username only, and git never even gets a chance to provide
the real credential.

Technically this did work before 986bbc0, so it could be considered a
regression in git, but I really think that Google Code is in the wrong
here. It should either:

  1. Always return a 401 for bad credentials. This means it would lose
     the custom message. But I think that is a good indication that the
     client should be putting more effort into showing the body of the
     401. Probably not all the time, as we do not want to spew HTML at
     the user, but we could perhaps relay error bodies if the
     content-type is "application/x-git-error" or something.

     The downside is that even if we make such a client change and the
     the Google Code server change sit's behavior, people on older git
     clients will lose the benefit of the message.

  2. Treat a credential with a non-empty username and an empty password
     specially, and return a 401. This covers the specific case of
     https://user@host/, but continues to show the custom message when
     the user provides a wrong password. It does mean that the custom
     message will not be shown if the user actually enters a blank
     password at the prompt (but it will still be shown if they get
     prompted for both username and password and leave both blank).

     So it's a little hacky, but I think it would work OK in practice.

What do you think?

-Peff
