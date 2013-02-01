From: TJ <git@iam.tj>
Subject: [BUG] git-clone fails due to GnuTLS recv error (-9), then deletes
 entire local repo
Date: Fri, 01 Feb 2013 09:00:06 +0000
Message-ID: <510B8416.7010802@iam.tj>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 01 10:00:32 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U1CU4-0004VL-6U
	for gcvg-git-2@plane.gmane.org; Fri, 01 Feb 2013 10:00:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755323Ab3BAJAK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 Feb 2013 04:00:10 -0500
Received: from yes.iam.tj ([109.74.197.121]:42397 "EHLO iam.tj"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752905Ab3BAJAJ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Feb 2013 04:00:09 -0500
Received: from [10.254.251.193] (jeeves.iam.tj [82.71.24.87])
	(using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by iam.tj (Postfix) with ESMTPSA id 8ECA118177
	for <git@vger.kernel.org>; Fri,  1 Feb 2013 09:00:07 +0000 (GMT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130106 Thunderbird/17.0.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215220>

Using Ubuntu Precise 12.04 with git version (1.8.0.3) I discovered a bug whereby git-clone deletes the repository
it has just created if there is a GnuTLS error after the final transfer.

I switched to building and using the current git head (1.8.1.2.433.g070c57d.dirty) and found the same issue is still present.

There are two problems here:

1. At the end of the transfer "GnuTLS recv error (-9): A TLS packet with unexpected length was received"
2. git-clone goes on to resolve deltas *then* deletes the entire repository

This is reported as Ubuntu bug #1111882 at https://bugs.launchpad.net/ubuntu/+bug/1111882

The following transcript uses git built with one local patch on top of commit 070c57d which fixes the $(INSTALL) file mode
issue as per my previous list posting "PATCH 1/1] Introduce new build variables INSTALL_MODE_EXECUTABLE and INSTALL_MODE_DATA".

GIT_CURL_VERBOSE=1 git clone -v https://git01.codeplex.com/typescript

the operation fails after the final git pack-file has been received and the already-created repository is deleted from the file system.

...
> POST /typescript/git-upload-pack HTTP/1.1
User-Agent: git/1.8.1.2.433.g9808ce0.dirty
Host: git01.codeplex.com
Accept-Encoding: gzip
Content-Type: application/x-git-upload-pack-request
Accept: application/x-git-upload-pack-result
Content-Length: 611

* upload completely sent off: 611out of 611 bytes
< HTTP/1.1 200 OK
< Cache-Control: no-cache, max-age=0, must-revalidate
< Pragma: no-cache
< Content-Type: application/x-git-upload-pack-result
< Expires: Fri, 01 Jan 1980 00:00:00 GMT
< Server: Microsoft-IIS/7.5
< X-Powered-By: ASP.NET
< Date: Thu, 31 Jan 2013 21:43:55 GMT
< Connection: close
<
remote: Counting objects: 149766, done.
remote: Compressing objects: 100% (10580/10580), done.
* GnuTLS recv error (-9): A TLS packet with unexpected length was received.
* Closing connection #0
remote: Total 149766 (delta 138201), reused 149559 (delta 138077)
Receiving objects: 100% (149766/149766), 198.98 MiB | 361 KiB/s, done.
error: RPC failed; result=56, HTTP code = 200
Resolving deltas: 100% (138201/138201), done.


git exits at this point but it deletes the entire cloned ./typescript directory.

So far as I can tell from watching the ./typescript directory from another terminal and also the ethernet interface activity
the transfer is complete but GnuTLS is expecting something more from the HTTPS server which isn't forthcoming, leading to
the error.

The git bug - if this is accepted as a bug - is the deletion of the entire cloned repository.


I tried building the git binary and including an additional debug option in "http.c" that allowed me to set the protocol version using an environment option:

CURLOPT_SSLVERSION=1 git clone ...

where 1 = TLSv1, 2 = SSLv2, 3 = SSLv3.

I tried each protocol but the result was the same.

I did some experimentation using gnutl-cli-debug but was unable to figure out a way to reproduce the SSL/TLS error without
this particular git-clone operation. However, that is a GnuTLS bug, not a git bug.

I did try to build the latest gnutls but it needs a very recent version of libnettle which has the "rsa_decrypt_tr" function. I stopped at that point since I don't want to get into dependency and
library version issues.

Additional research seems to indicate this is a known intentional gnutls behaviour (that has been modified in very recent gnutls that makes use of a very recent libnettle - as mentioned above). The
issue is, apparently, the random size padding of packets to prevent communications compromise for stream ciphers.

I installed stunnel4 (which depends on openssl rather than gnutls) and created a reverse-proxy (client in stunnel terminology):

$ cat /etc/stunnel/rp-codeplex.com.conf
client = yes

[http]
accept = 8888
connect = git01.codeplex.com:443
TIMEOUTclose = 0

$ sudo sed -i 's/\(ENABLED\).*/\1=1/' /etc/default/stunnel4
$ sudo service stunnel4 restart

$ GIT_CURL_VERBOSE=1 git clone -v http://localhost:8888/typescript

...
> POST http://localhost:8888/typescript/git-upload-pack HTTP/1.1
User-Agent: git/1.8.1.2.433.g9808ce0.dirty
Host: localhost:8888
Accept-Encoding: gzip
Proxy-Connection: Keep-Alive
Content-Type: application/x-git-upload-pack-request
Accept: application/x-git-upload-pack-result
Content-Length: 611

* upload completely sent off: 611out of 611 bytes
< HTTP/1.1 200 OK
< Cache-Control: no-cache, max-age=0, must-revalidate
< Pragma: no-cache
< Content-Type: application/x-git-upload-pack-result
< Expires: Fri, 01 Jan 1980 00:00:00 GMT
< Server: Microsoft-IIS/7.5
< X-Powered-By: ASP.NET
< Date: Thu, 31 Jan 2013 23:38:19 GMT
< Connection: close
<
remote: Counting objects: 149798, done.
remote: Compressing objects: 100% (10612/10612), done.
remote: Total 149798 (delta 138221), reused 149558 (delta 138077)
* Closing connection #0
Receiving objects: 100% (149798/149798), 198.99 MiB | 640 KiB/s, done.
Resolving deltas: 100% (138221/138221), done.
Checking out files: 100% (2851/2851), done.
