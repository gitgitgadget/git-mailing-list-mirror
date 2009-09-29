From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: clone from url with email address as username?(escaping @ symbol)
Date: Tue, 29 Sep 2009 18:59:17 +0200
Message-ID: <vpq63b1u1p6.fsf@bauges.imag.fr>
References: <970bc7c80909290720i1c5566fer1c1a3db744edc609@mail.gmail.com>
	<fabb9a1e0909290725w616c3ea9vcb1d2c53950f7788@mail.gmail.com>
	<vpq1vlp962h.fsf@bauges.imag.fr>
	<fabb9a1e0909290732h5119170ew133d906b67e49f99@mail.gmail.com>
	<970bc7c80909290831l59b7fc4at4ec0082f42f3ef87@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Sverre Rabbelier <srabbelier@gmail.com>, git@vger.kernel.org
To: Ben Bennett <benbennett@gmail.com>
X-From: git-owner@vger.kernel.org Tue Sep 29 19:41:28 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Msghb-0003Eh-KC
	for gcvg-git-2@lo.gmane.org; Tue, 29 Sep 2009 19:41:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753374AbZI2RlR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Sep 2009 13:41:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753029AbZI2RlR
	(ORCPT <rfc822;git-outgoing>); Tue, 29 Sep 2009 13:41:17 -0400
Received: from mx1.imag.fr ([129.88.30.5]:50765 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752610AbZI2RlR (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Sep 2009 13:41:17 -0400
Received: from archeboc.imag.fr (archeboc.imag.fr [129.88.43.1])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id n8TGsTBI027666
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Tue, 29 Sep 2009 18:54:29 +0200
Received: from bauges.imag.fr ([129.88.43.5])
	by archeboc.imag.fr with esmtp (Exim 4.69)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1Msg2n-0004JL-Ft; Tue, 29 Sep 2009 18:59:17 +0200
In-Reply-To: <970bc7c80909290831l59b7fc4at4ec0082f42f3ef87@mail.gmail.com> (Ben Bennett's message of "Tue\, 29 Sep 2009 10\:31\:30 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/23.1.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Tue, 29 Sep 2009 18:54:29 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: n8TGsTBI027666
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1254848070.57341@tu3qHVaqKKaD8HDG39vobA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129316>

Ben Bennett <benbennett@gmail.com> writes:

> I am attempting to do a https clone. The username is an email address
> but when I do a clone here is what happens.

Hmm, right, it works with ssh, but not http.

I tried a quick fix like this:

diff --git a/http.c b/http.c
index 23b2a19..361a6be 100644
--- a/http.c
+++ b/http.c
@@ -281,9 +281,10 @@ static void http_auth_init(const char *url)
         * "proto://<host>/..."?
         */
        cp += 3;
-       at = strchr(cp, '@');
        colon = strchr(cp, ':');
        slash = strchrnul(cp, '/');
+       for(at = slash-1; *at != '@' && *at != '/'; at--)
+               continue;
        if (!at || slash <= at)
                return; /* No credentials */
        if (!colon || at <= colon) {

Unfortunately, it seems the complete URL is passed to curl, and curl
is the one doing it wrong. Indeed:

$ curl -v https://user@email.com@server.com/path/                                          
* getaddrinfo(3) failed for email.com@server.com:443
* Couldn't resolve host 'email.com@server.com'
* Closing connection #0
curl: (6) Couldn't resolve host 'email.com@server.com'

Now for the good news:

http://curl.haxx.se/mail/lib-2006-02/0134.html
http://sourceforge.net/tracker/index.php?func=detail&aid=2826621&group_id=976&atid=100976

In short, you have to use %40 to escape the @, and curl does it this
way because the RFC doesn't allow @ in usernames.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
