From: Paul J R <me@pjr.cc>
Subject: git clone over http with basic auth bug?
Date: Sat, 22 Sep 2012 09:37:38 +1000
Message-ID: <505CFA42.9090504@pjr.cc>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Sep 22 01:47:46 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TFCwe-0002tw-1G
	for gcvg-git-2@plane.gmane.org; Sat, 22 Sep 2012 01:47:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753804Ab2IUXrS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Sep 2012 19:47:18 -0400
Received: from pjr.cc ([173.230.145.154]:58774 "EHLO ln.pjr.cc"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753217Ab2IUXrO (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Sep 2012 19:47:14 -0400
X-Greylist: delayed 572 seconds by postgrey-1.27 at vger.kernel.org; Fri, 21 Sep 2012 19:47:14 EDT
Received: from iron.pjr.cc (unknown [10.10.0.2])
	by ln.pjr.cc (Postfix) with ESMTP id 5AD1418005
	for <git@vger.kernel.org>; Fri, 21 Sep 2012 23:37:41 +0000 (UTC)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by iron.pjr.cc (Postfix) with SMTP id 2B7AB12F4003
	for <git@vger.kernel.org>; Sat, 22 Sep 2012 09:37:39 +1000 (EST)
Received: from [10.10.0.13] (desk01.pjr.cc [10.10.0.13])
	by iron.pjr.cc (Postfix) with ESMTP id 2ACD930AD53
	for <git@vger.kernel.org>; Sat, 22 Sep 2012 09:37:38 +1000 (EST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:15.0) Gecko/20120827 Thunderbird/15.0
X-DSPAM-Result: Whitelisted
X-DSPAM-Processed: Sat Sep 22 09:37:39 2012
X-DSPAM-Confidence: 0.9934
X-DSPAM-Probability: 0.0000
X-DSPAM-Signature: 505cfa4320677308439038
X-DSPAM-Factors: 27,
	git, 0.00052,
	git, 0.00052,
	User-Agent*x86_64, 0.00084,
	To*git, 0.00178,
	To*vger.kernel.org, 0.00184,
	Received*<git, 0.00209,
	Received*vger.kernel.org>, 0.00209,
	Subject*git, 0.00215,
	Unable, 0.00463,
	repo, 0.00625,
	refs, 0.00653,
	auth, 0.00687,
	logs, 0.00737,
	User-Agent*Linux, 0.00774,
	User-Agent*(X11, 0.00868,
	netrc, 0.01000,
	git/objects/info/packs, 0.01000,
	Subject*bug?, 0.01000,
	Received*(desk01.pjr.cc, 0.01000,
	Subject*auth, 0.01000,
	User-Agent*Thunderbird/15.0, 0.01000,
	git/info/refs?service=git, 0.01000,
	git/info/refs?service=git, 0.01000,
	Fetch, 0.01000,
	git/, 0.01000,
	Subject*basic, 0.01000,
	User-Agent*Gecko/20120827, 0.01000
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206178>

Hi All,

Im not sure if this is a bug, or just "as implemented". But when cloning 
from a repo sitting on a web site that uses basic auth, the git client 
appears to forget its authentication info and ignores the 401's the 
server is sending back. It appears to initially login and get refs and 
HEAD ok, but after that it never authenticates again. Using a .netrc 
file this will work (or a url of the form http://user:pass@host though 
http://user@host wont), but i'm curious if theres a way of doing this 
without having to expose the password in some way?

Im using git 1.7.9.5 and when i clone i get the following:

$ git clone http://host/gitrepo/repo.git/
Cloning into 'repo'...
Username for 'http://host': user
Password for 'http://user@host':
error: The requested URL returned error: 401 (curl_result = 22, 
http_code = 401, sha1 = f7748ec924c30b4472132dabcf318d3c420a1a15)
error: Unable to find f7748ec924c30b4472132dabcf318d3c420a1a15 under 
http://host/gitrepo/repo.git
Cannot obtain needed commit f7748ec924c30b4472132dabcf318d3c420a1a15
while processing commit 1283f0d8043b7aafc4edd1c4627d465a92355a49.
error: Fetch failed.

And on the server side, the logs show:
x.x.x.x - - [22/Sep/2012:09:03:21 +1000] "GET 
/gitrepo/repo.git/info/refs?service=git-upload-pack HTTP/1.1" 401 708 
"-" "git/1.7.9.5"
x.x.x.x - user [22/Sep/2012:09:03:21 +1000] "GET 
/gitrepo/repo.git/info/refs?service=git-upload-pack HTTP/1.1" 200 406 
"-" "git/1.7.9.5"
x.x.x.x - user [22/Sep/2012:09:03:21 +1000] "GET /gitrepo/repo.git/HEAD 
HTTP/1.1" 200 233 "-" "git/1.7.9.5"
x.x.x.x - user [22/Sep/2012:09:03:21 +1000] "GET 
/gitrepo/repo.git/objects/12/83f0d8043b7aafc4edd1c4627d465a92355a49 
HTTP/1.1" 200 415 "-" "git/1.7.9.5"
x.x.x.x - - [22/Sep/2012:09:03:21 +1000] "GET 
/gitrepo/repo.git/objects/f7/748ec924c30b4472132dabcf318d3c420a1a15 
HTTP/1.1" 401 708 "-" "git/1.7.9.5"
x.x.x.x - user [22/Sep/2012:09:03:21 +1000] "GET 
/gitrepo/repo.git/objects/c1/2f6404116fba31590dccad46b9dbb35de615a9 
HTTP/1.1" 200 505 "-" "git/1.7.9.5"
x.x.x.x - - [22/Sep/2012:09:03:21 +1000] "GET 
/gitrepo/repo.git/objects/f7/fc6c45d465000483425bfe5f8d52e561b5e376 
HTTP/1.1" 401 708 "-" "git/1.7.9.5"
x.x.x.x - - [22/Sep/2012:09:03:21 +1000] "GET 
/gitrepo/repo.git/objects/16/2cac064671b4058eab103d697c15f98da14d54 
HTTP/1.1" 401 708 "-" "git/1.7.9.5"
x.x.x.x - - [22/Sep/2012:09:03:21 +1000] "GET 
/gitrepo/repo.git/objects/af/63ba2c594c08f17d1114c1c1cdc6f48d561e59 
HTTP/1.1" 401 708 "-" "git/1.7.9.5"
x.x.x.x - - [22/Sep/2012:09:03:21 +1000] "GET 
/gitrepo/repo.git/objects/7e/2300a52c3dc9ecad58226c4f78f9d091e85a00 
HTTP/1.1" 401 708 "-" "git/1.7.9.5"
x.x.x.x - - [22/Sep/2012:09:03:21 +1000] "GET 
/gitrepo/repo.git/objects/c0/312c337c661aecf299a4a4f5378b1809bd2c44 
HTTP/1.1" 401 708 "-" "git/1.7.9.5"
x.x.x.x - - [22/Sep/2012:09:03:21 +1000] "GET 
/gitrepo/repo.git/objects/97/3e5550bd73275eea820a40067f9da5853c6e5d 
HTTP/1.1" 401 708 "-" "git/1.7.9.5"
x.x.x.x - - [22/Sep/2012:09:03:21 +1000] "GET 
/gitrepo/repo.git/objects/info/packs HTTP/1.1" 401 708 "-" "git/1.7.9.5"
x.x.x.x - - [22/Sep/2012:09:03:21 +1000] "GET 
/gitrepo/repo.git/objects/00/6b5267c3b2f11136aedd8b4698e4c22e6c341c 
HTTP/1.1" 401 708 "-" "git/1.7.9.5"
x.x.x.x - - [22/Sep/2012:09:03:21 +1000] "GET 
/gitrepo/repo.git/objects/55/a5ba763c58c6fa196b97fa5f637198f8e56c07 
HTTP/1.1" 401 708 "-" "git/1.7.9.5"
x.x.x.x - - [22/Sep/2012:09:03:21 +1000] "GET 
/gitrepo/repo.git/objects/66/86a522a4f1d2fb93da34c676de85867fb3ab96 
HTTP/1.1" 401 708 "-" "git/1.7.9.5"
x.x.x.x - - [22/Sep/2012:09:03:21 +1000] "GET 
/gitrepo/repo.git/objects/info/http-alternates HTTP/1.1" 401 708 "-" 
"git/1.7.9.5"
x.x.x.x - - [22/Sep/2012:09:03:21 +1000] "GET 
/gitrepo/repo.git/objects/info/alternates HTTP/1.1" 401 708 "-" 
"git/1.7.9.5"
