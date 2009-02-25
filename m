From: Mark Lodato <lodatom@gmail.com>
Subject: git with https and client cert asks for password repeatedly
Date: Tue, 24 Feb 2009 22:11:40 -0500
Message-ID: <ca433830902241911x10b08a4fg8e790000a5cf9f3b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 25 04:13:23 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LcAD2-00084P-Qd
	for gcvg-git-2@gmane.org; Wed, 25 Feb 2009 04:13:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753974AbZBYDLn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Feb 2009 22:11:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753911AbZBYDLn
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Feb 2009 22:11:43 -0500
Received: from qw-out-2122.google.com ([74.125.92.27]:29326 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753554AbZBYDLn (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Feb 2009 22:11:43 -0500
Received: by qw-out-2122.google.com with SMTP id 5so2360458qwi.37
        for <git@vger.kernel.org>; Tue, 24 Feb 2009 19:11:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:content-type:content-transfer-encoding;
        bh=w8dpO37yB6eD4RIBbvpM+AiJI4P+3nhb+hn/sPtb5/U=;
        b=R2Bn6N5hbeqfQELxv5kP6OzVp4QHuHtKmQBxgrwQJICc2HLBe2ebiGMZwqgl5bBJm1
         6ToGUt+sHe1XfVUQU4ycaRjOMucXQjw3x7LozBzvq2zAl4tTR6zYjwHWg7u6dUCIhzSl
         rim7ZmMLe9Fnf0zkHLPZ6pGVQXwcBRNFsT02Y=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        b=MlXoIhfFmBG1f2qgSdC3ypy2Tu4F19BkDepY89gs+bkSY5dWt5JSwcRWDCualcuRXk
         appkoEu0kY/Pn6aRE9yrTSBOqMG30PH3/l/SpC6FgdsovQ8Cjj2Vg8rDrReh3zZF37Xb
         wm3QmMhhPtR4ZhZu0xAOH9neG5JanOL+Y3ABU=
Received: by 10.229.84.82 with SMTP id i18mr2458231qcl.90.1235531500703; Tue, 
	24 Feb 2009 19:11:40 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111367>

First off, I am fairly new to git, so let me apologize in advance if I
suggest anything stupid.

When fetching or pushing over https:// with a client certificate
(http.sslCert / http.sslKey), git asks for a password for every single
requested file.  For example, here I push three commits with a couple
changed files each:

> git push origin master
Enter PEM pass phrase:
Enter PEM pass phrase:
Fetching remote heads...
  refs/
  refs/tags/
  refs/heads/
updating 'refs/heads/master'
  from 1df865db590b4a7d4991c13053437ac90b2780e4
  to   05e856a6a5ce9b05a5a7d10cb5d10010467eea72
Enter PEM pass phrase:
Enter PEM pass phrase:
Enter PEM pass phrase:
Enter PEM pass phrase:
Enter PEM pass phrase:
Enter PEM pass phrase:
Enter PEM pass phrase:
Enter PEM pass phrase:
Enter PEM pass phrase:
Enter PEM pass phrase:
Enter PEM pass phrase:
Enter PEM pass phrase:
Enter PEM pass phrase:
    sending 12 objects
Enter PEM pass phrase:
Enter PEM pass phrase:
Enter PEM pass phrase:
Enter PEM pass phrase:
Enter PEM pass phrase:
    done
Updating remote server info

To make matters worse, when you try to CTRL-C from the "Enter PEM pass
phrase" prompt, it just re-prompts you!  If you want to see this in
action, set up a webdav server on https://localhost with a copy of
git.git and try cloning it with a password-protected client
certificate.

This problem makes client-side certificates unusable with git.  A
possible workaround is to leave the key unencrypted, but this is
usually unacceptable for security reasons.  Ideally, I would just type
my password once per invocation and git would remember it.  (This is
how svn works.)

I think the root problem is that git creates a completely new http(s)
connection for every request, rather than using one persistent
connection.  Using a persistent connection would theoretically speed
up the transfers, in addition to fixing the password prompt issue.
I'm pretty sure that calling `curl_easy_cleanup()' after every request
is causing this behavior; I don't think this is necessary.

I tried fixing this myself, but the http/curl code is pretty
confusing.  Just wondering - why is HTTP_MULTI required for http-push?
 I saw a thread from Jan '08 about this, but it never said *why*
HTTP_MULTI is required, only that the push doesn't work without it.
It doesn't appear to me that git uses concurrent connections in any
useful way, so I don't know why having a single connection would not
work.


Finally, is there interest in refactoring the http code to make it a
little cleaner?  That is, make a wrapper library around curl so that
you can just call GET or POST or whatever and not worry about how to
invoke curl?


--
Mark Lodato
