From: Abbaad Haider <abbaad@gmail.com>
Subject: [BUG] Push fails with dumb http to SabreDAV
Date: Sat, 5 Jul 2014 20:00:08 -0400
Message-ID: <53b8918c.ca6d320a.7df8.18ac@mx.google.com>
Reply-To: Abbaad Haider <abbaad@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="wRRV7LY7NUeQGEoC"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 06 02:00:26 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X3ZsY-0006Gf-4l
	for gcvg-git-2@plane.gmane.org; Sun, 06 Jul 2014 02:00:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754612AbaGFAAQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 Jul 2014 20:00:16 -0400
Received: from mail-ie0-f182.google.com ([209.85.223.182]:60150 "EHLO
	mail-ie0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751727AbaGFAAO (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Jul 2014 20:00:14 -0400
Received: by mail-ie0-f182.google.com with SMTP id at1so578560iec.41
        for <git@vger.kernel.org>; Sat, 05 Jul 2014 17:00:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:to:subject:reply-to:mime-version:content-type
         :content-disposition:user-agent;
        bh=gzPa0gMHwtf7sTT7H++9fE+wG75iViCUmC4E8jFNp6U=;
        b=L6CSX/XI3ngR/y/8ZpMsbeNLmM8CsMmYyc31FRJ9n2lX11mImB3UL4Prz4kfqt1rEI
         fqASU62e5V/LxikKEeSwtwbG6bfqahQvZ14wBgXwqzJnf6RUTTzvg9u8M0GnS/xKC35r
         POFxFuBvae8wDgrjdfsrDuIBEy4gAUu+YsPTfhH6iNo8o4nw3Ak+yvOVld/cxAnunaaK
         Zr6KcbGqVD9L/Mu5+VVZahvjo3EnJlO2DQ7rti2+3LRl1aqQsABwxlhZ20KRSF3ytvz8
         xb/zZi/pzgfa5rLONPbtjifC3HQ6npR8pjcyvJlNlvSTEKLlM6DVYXF5ogMXjslqVsSH
         sdZg==
X-Received: by 10.50.176.194 with SMTP id ck2mr28707959igc.44.1404604813898;
        Sat, 05 Jul 2014 17:00:13 -0700 (PDT)
Received: from localhost (cpe-71-74-112-172.neo.res.rr.com. [71.74.112.172])
        by mx.google.com with ESMTPSA id hu10sm75866568igb.22.2014.07.05.17.00.11
        for <git@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 05 Jul 2014 17:00:12 -0700 (PDT)
Content-Disposition: inline
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252921>


--wRRV7LY7NUeQGEoC
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Background:
I'm trying to host a git repository at my Box.com account, which
offers DAV access using a server called SabreDAV. I ran into a few
issues along the way. The first is that Box.com apparently doesn't
like it if a directory has a dot in the name. No big deal, just use
"foo" instead of "foo.git" for a bare repository. Next, it gives 404
errors when you try to GET a URL with an extraneous query string.
Solution: use GIT_SMART_HTTP=0. Authentication is handled by libcurl
automatically reading .netrc. I've gotten to the point where I can
clone a repository, but pushing changes back to origin hangs followed
by timeout. I don't know if this bug is in git or libcurl, but I think
it's the former (as explained below).

Problem (see also attachment):
When you try to push changes to the remote, it hangs, followed by
erroring out with "code 52", which is CURLE_GOT_NOTHING. Further
investigation shows that cURL successfully uses basic authentication
to GET a few files before trying a PROPFIND request on the
repository's root directory. The body of the request is in a separate
XML file asking the server about the supportedlock property.

The first time, cURL sends the request without authentication and
receives back 401 Unauthorized. The second time it tries the same
request using Basic authentication (this is the same pattern which
worked on the earlier GET requests). It gets back a 100-Continue, but
fails to upload the XML file like it did before (if you're following
along on the typescript, the verbose cURL output should say "* We are
completely uploaded and fine"). Instead it hangs for 60 seconds and
errors out with "Empty reply from server".

I don't think this bug is in libcurl, since it successfully executes
all the other commands. I will try to investigate further, but I think
it has something to do with the multi-pass authentication. Attached is a
typescript of the behavior (editorial comments are placed inside [[ ]],
and all user info has been scrubbed). In case the attachment doesn't go
through, I have also pasted the typescript to gist [1]. If anyone else
wants to reproduce the bug, Box.com does offer a free account.

[1] https://gist.githubusercontent.com/abbaad/d4a8ba1e36000eeb8e02/raw/dd5b10ae42b1936d8da33bd384c9affdb103f686/typescript.txt

--
Abbaad Haider
abbaad@gmail.com

--wRRV7LY7NUeQGEoC
Content-Type: text/plain; charset=utf-8
Content-Disposition: attachment; filename="typescript.txt"

$ git --version && uname -a && curl-config --version
git version 2.0.1
Linux localhost 3.15.3-1-ARCH #1 SMP PREEMPT Tue Jul 1 07:32:45 CEST 2014 x86_64 GNU/Linux
libcurl 7.37.0
$ mkdir foo; cd foo
$ git --bare init
Initialized empty Git repository in /home/user/foo/
$ git update-server-info
$ cd ..
$ sudo mount -t davfs https://dav.box.com/dav ./box
$ cp -r foo box
$ sudo umount box
$ rm -r foo
$ cat > .netrc << EOF
> machine dav.box.com
> login [[ redacted ]]
> password [[ redacted ]]
> EOF
$ chmod 600 .netrc
$ GIT_SMART_HTTP=0 git clone https://dav.box.com/dav/foo
Cloning into 'foo'...
warning: You appear to have cloned an empty repository.
Checking connectivity... done.
$ cd foo/.git/hooks 
$ mv post-update.sample post-update        
$ cd ../..
$ touch bar
$ git add .
$ git commit -a -m "foo bar"                      
[master (root-commit) 2031b47] foo bar
 1 file changed, 0 insertions(+), 0 deletions(-)
 create mode 100644 bar
$ GIT_SMART_HTTP=0 GIT_CURL_VERBOSE=1 GIT_TRACE=1 git push origin master
trace: built-in: git 'push' 'origin' 'master'
trace: run_command: 'git-remote-https' 'origin' 'https://dav.box.com/dav/foo'
* Hostname was NOT found in DNS cache
*   Trying 74.112.185.70...
* Connected to dav.box.com (74.112.185.70) port 443 (#0)
* successfully set certificate verify locations:
*   CAfile: /etc/ssl/certs/ca-certificates.crt
  CApath: none
* SSL connection using TLSv1.2 / ECDHE-RSA-AES256-GCM-SHA384
* Server certificate:
* 	 subject: serialNumber=jde9iuVneOEaNkFotOvLFaWx0vb5-Qpv; C=US; ST=California; L=Los Altos; O=Box, Inc.; CN=*.box.com
* 	 start date: 2014-04-07 05:14:35 GMT
* 	 expire date: 2017-10-31 20:06:48 GMT
* 	 subjectAltName: dav.box.com matched
* 	 issuer: C=US; O=GeoTrust, Inc.; CN=GeoTrust SSL CA
* 	 SSL certificate verify ok.
> GET /dav/foo/info/refs HTTP/1.1
User-Agent: git/2.0.1
Host: dav.box.com
Accept: */*
Accept-Encoding: gzip
Pragma: no-cache

< HTTP/1.1 401 Unauthorized
* Server nginx is not blacklisted
< Server: nginx
< Date: Fri, 04 Jul 2014 23:34:18 GMT
< Content-Type: application/xml; charset=utf-8
< Content-Length: 242
< Connection: keep-alive
< Vary: Host
< WWW-Authenticate: Basic realm="dav.box.com"
< 
* Ignoring the response-body
* Connection #0 to host dav.box.com left intact
* Issue another request to this URL: 'https://dav.box.com/dav/foo/info/refs'
* Found bundle for host dav.box.com: 0x123ff40
* Re-using existing connection! (#0) with host dav.box.com
* Connected to dav.box.com (74.112.185.70) port 443 (#0)
* Server auth using Basic with user '[[ redacted ]]'
> GET /dav/foo/info/refs HTTP/1.1
Authorization: Basic [[ redacted ]]
User-Agent: git/2.0.1
Host: dav.box.com
Accept: */*
Accept-Encoding: gzip
Pragma: no-cache

< HTTP/1.1 200 OK
* Server nginx is not blacklisted
< Server: nginx
< Date: Fri, 04 Jul 2014 23:34:19 GMT
< Content-Type: application/octet-stream
< Content-Length: 0
< Connection: keep-alive
< Vary: Host
< Cache-control: private
< Accept-Ranges: bytes
< Content-Disposition: attachment;filename="refs";filename*=UTF-8''refs
< X-Content-Type-Options: nosniff
< Last-Modified: Fri, 04 Jul 2014 23:23:51 GMT
< ETag: "da39a3ee5e6b4b0d3255bfef95601890afd80709"
< Accept-Ranges: bytes
< 
* Connection #0 to host dav.box.com left intact
* Found bundle for host dav.box.com: 0x123ff40
* Re-using existing connection! (#0) with host dav.box.com
* Connected to dav.box.com (74.112.185.70) port 443 (#0)
* Server auth using Basic with user '[[ redacted ]]'
> GET /dav/foo/HEAD HTTP/1.1
Authorization: Basic [[ redacted ]]
User-Agent: git/2.0.1
Host: dav.box.com
Accept: */*
Accept-Encoding: gzip
Pragma: no-cache

< HTTP/1.1 200 OK
* Server nginx is not blacklisted
< Server: nginx
< Date: Fri, 04 Jul 2014 23:34:20 GMT
< Content-Type: application/octet-stream
< Content-Length: 23
< Connection: keep-alive
< Vary: Host
< Cache-control: private
< Accept-Ranges: bytes
< Content-Disposition: attachment;filename="HEAD";filename*=UTF-8''HEAD
< X-Content-Type-Options: nosniff
< Last-Modified: Fri, 04 Jul 2014 23:24:12 GMT
< ETag: "acbaef275e46a7f14c1ef456fff2c8bbe8c84724"
< Accept-Ranges: bytes
< 
* Connection #0 to host dav.box.com left intact
trace: run_command: 'http-push' '--helper-status' 'https://dav.box.com/dav/foo/' 'refs/heads/master:refs/heads/master'
trace: exec: 'git' 'http-push' '--helper-status' 'https://dav.box.com/dav/foo/' 'refs/heads/master:refs/heads/master'
trace: exec: 'git-http-push' '--helper-status' 'https://dav.box.com/dav/foo/' 'refs/heads/master:refs/heads/master'
trace: run_command: 'git-http-push' '--helper-status' 'https://dav.box.com/dav/foo/' 'refs/heads/master:refs/heads/master'
* Hostname was NOT found in DNS cache
*   Trying 74.112.184.70...
* Connected to dav.box.com (74.112.184.70) port 443 (#0)
* successfully set certificate verify locations:
*   CAfile: /etc/ssl/certs/ca-certificates.crt
  CApath: none
* SSL connection using TLSv1.2 / ECDHE-RSA-AES256-GCM-SHA384
* Server certificate:
* 	 subject: serialNumber=jde9iuVneOEaNkFotOvLFaWx0vb5-Qpv; C=US; ST=California; L=Los Altos; O=Box, Inc.; CN=*.box.com
* 	 start date: 2014-04-07 05:14:35 GMT
* 	 expire date: 2017-10-31 20:06:48 GMT
* 	 subjectAltName: dav.box.com matched
* 	 issuer: C=US; O=GeoTrust, Inc.; CN=GeoTrust SSL CA
* 	 SSL certificate verify ok.
> PROPFIND /dav/foo/ HTTP/1.1
User-Agent: git/2.0.1
Host: dav.box.com
Accept: */*
Depth: 0
Content-Type: text/xml
Content-Length: 158
Expect: 100-continue

< HTTP/1.1 100 Continue
* We are completely uploaded and fine
< HTTP/1.1 401 Unauthorized
* Server nginx is not blacklisted
< Server: nginx
< Date: Fri, 04 Jul 2014 23:34:21 GMT
< Content-Type: application/xml; charset=utf-8
< Content-Length: 242
< Connection: keep-alive
< Vary: Host
< WWW-Authenticate: Basic realm="dav.box.com"
* the ioctl callback returned 0
< 
* Ignoring the response-body
* Connection #0 to host dav.box.com left intact
* Issue another request to this URL: 'https://dav.box.com/dav/foo/'
* Found bundle for host dav.box.com: 0x20469c0
* Re-using existing connection! (#0) with host dav.box.com
* Connected to dav.box.com (74.112.184.70) port 443 (#0)
* Server auth using Basic with user '[[ redacted ]]'
> PROPFIND /dav/foo/ HTTP/1.1
Authorization: Basic [[ redacted ]]
User-Agent: git/2.0.1
Host: dav.box.com
Accept: */*
Depth: 0
Content-Type: text/xml
Content-Length: 158
Expect: 100-continue

< HTTP/1.1 100 Continue
[[ This is where it hangs for about 60 seconds ]]
* Empty reply from server
* Connection #0 to host dav.box.com left intact
error: Cannot access URL https://dav.box.com/dav/foo/, return code 52
fatal: git-http-push failed
error: failed to push some refs to 'https://dav.box.com/dav/foo'

--wRRV7LY7NUeQGEoC--
