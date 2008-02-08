From: Mike Hommey <mh@glandium.org>
Subject: Re: git-fetch in 1.5.4 fails versus 1.5.3.8
Date: Fri, 8 Feb 2008 08:34:56 +0100
Organization: glandium.org
Message-ID: <20080208073456.GA17791@glandium.org>
References: <20080205050741.GA4624@coredump.intra.peff.net> <pan.2008.02.06.21.56.35@progsoc.org> <20080207042332.GA7632@sigill.intra.peff.net> <pan.2008.02.07.10.15.05@progsoc.org> <20080207110601.GA8488@coredump.intra.peff.net> <20080207121042.GA10210@glandium.org> <20080207122842.GA17184@coredump.intra.peff.net> <20080207220243.GA7237@glandium.org> <20080208003239.GA18856@coredump.intra.peff.net> <20080208071835.GA11807@glandium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Anand Kumria <wildfire@progsoc.org>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Feb 08 08:35:07 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JNNlK-0002rE-U8
	for gcvg-git-2@gmane.org; Fri, 08 Feb 2008 08:35:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758289AbYBHHee (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Feb 2008 02:34:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758276AbYBHHee
	(ORCPT <rfc822;git-outgoing>); Fri, 8 Feb 2008 02:34:34 -0500
Received: from vuizook.err.no ([85.19.215.103]:39707 "EHLO vuizook.err.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758180AbYBHHed (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Feb 2008 02:34:33 -0500
Received: from aputeaux-153-1-42-109.w82-124.abo.wanadoo.fr ([82.124.6.109] helo=jigen)
	by vuizook.err.no with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.67)
	(envelope-from <mh@glandium.org>)
	id 1JNNla-0001GT-Ep; Fri, 08 Feb 2008 08:35:28 +0100
Received: from mh by jigen with local (Exim 4.69)
	(envelope-from <mh@jigen>)
	id 1JNNlA-0004fV-N7; Fri, 08 Feb 2008 08:34:56 +0100
Content-Disposition: inline
In-Reply-To: <20080208071835.GA11807@glandium.org>
X-GPG-Fingerprint: A479 A824 265C B2A5 FC54  8D1E DE4B DA2C 54FD 2A58
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
X-Spam-Status: (score 2.2): No, score=2.2 required=5.0 tests=RCVD_IN_PBL,RCVD_IN_SORBS_DUL,RDNS_DYNAMIC autolearn=disabled version=3.2.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73049>

On Fri, Feb 08, 2008 at 08:18:35AM +0100, Mike Hommey wrote:
> On Thu, Feb 07, 2008 at 07:32:39PM -0500, Jeff King wrote:
> > On Thu, Feb 07, 2008 at 11:02:43PM +0100, Mike Hommey wrote:
> > 
> > > Sorry, I've had trouble opening my eyes and actually reading messages I
> > > reply to... anyways, I tried to reproduce with curl-gnutls and...
> > > couldn't... How did you manage that ? Is the server you were trying on
> > > public ? Do you have any http.ssl* variables set in your configuration ?
> > 
> > No, my test repo is not public. I have no special ssl configuration
> > (though I do use GIT_SSL_NO_VERIFY=1 since I just had a test self-signed
> > cert). The exact recipe on my Debian system is:
> > 
> (...)
> 
> Okay, I've been able to reproduce the problem. I don't know what I've
> been doing wrong to have it hidden...
> 
> Anyways, the interesting thing is to look at what curl has to say in its
> verbose mode:
(...)
> 
> So, it looks like either gnutls or curl is doing something wrong and
> can't parse /etc/ssl/certs/ca-certificates.crt a second time. This
> looks like a bug in either curl or gnutls.
> 
> A simplified testcase would probably be to do two requests in a row, but
> I don't have time right now to do this testing.

I'm making myself a liar, but I took some few more minutes to test
something like:
diff --git a/http.c b/http.c
index d2c11ae..001b1c4 100644
--- a/http.c
+++ b/http.c
@@ -186,7 +186,7 @@ static CURL* get_curl_handle(void)
        if (ssl_capath != NULL)
                curl_easy_setopt(result, CURLOPT_CAPATH, ssl_capath);
 #endif
-       if (ssl_cainfo != NULL)
+//     if (ssl_cainfo != NULL)
                curl_easy_setopt(result, CURLOPT_CAINFO, ssl_cainfo);
        curl_easy_setopt(result, CURLOPT_FAILONERROR, 1);
 


And the result is interesting:
GIT_CURL_VERBOSE=1 git fetch
* Couldn't find host localhost in the .netrc file, using defaults
* About to connect() to localhost port 8443 (#0)
*   Trying 127.0.0.1... * connected
* Connected to localhost (127.0.0.1) port 8443 (#0)
*        server certificate verification FAILED
*        common name: localhost (matched)
*        server certificate expiration date OK
*        server certificate activation date OK
*        certificate public key: RSA
*        certificate version: #1
*        subject: C=GB,ST=Some-State,L=Some-Locality,O=One Organization,OU=One Organization Unit,CN=localhost,EMAIL=webmaster@localhost
*        start date: Thu, 07 Feb 2008 21:27:36 GMT
*        expire date: Sat, 08 Mar 2008 21:27:36 GMT
*        issuer: C=GB,ST=Some-State,L=Some-Locality,O=One Organization,OU=One Organization Unit,CN=localhost,EMAIL=webmaster@localhost
*        compression: DEFLATE
*        cipher: AES 256 CBC
*        MAC: SHA
> GET /foo/.git//info/refs HTTP/1.1
User-Agent: git/1.5.4.7.gd8534-dirty
Host: localhost:8443
Accept: */*

< HTTP/1.1 200 OK
< Date: Fri, 08 Feb 2008 07:30:10 GMT
< Server: Apache/2.2.8 (Debian) DAV/2 mod_ssl/2.2.8 OpenSSL/0.9.8g
< Last-Modified: Fri, 08 Feb 2008 06:52:19 GMT
< ETag: "61d82e-3b-445a0080d0ec0"
< Accept-Ranges: bytes
< Content-Length: 59
< Content-Type: text/plain
< 
* Connection #0 to host localhost left intact
* Couldn't find host localhost in the .netrc file, using defaults
* About to connect() to localhost port 8443 (#0)
*   Trying 127.0.0.1... * connected
* Connected to localhost (127.0.0.1) port 8443 (#0)
* gnutls_handshake() failed: ASN1 parser: Element was not found.
* Expire cleared
* Closing connection #0
error: gnutls_handshake() failed: ASN1 parser: Element was not found. (curl_result = 35, http_code = 0, sha1 = e0aa43ffb1a1e7052a936b9ed5e0a1462cfc343e)

So, it looks like either gnutls has a problem reinitializing its ASN1
parser or curl is doing something wrong with gnutls when initializing a
new request.

Mike
