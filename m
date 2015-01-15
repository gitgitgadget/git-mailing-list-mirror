From: "Jason Pyeron" <jpyeron@pdinc.us>
Subject: RE: Advise on a push only repo
Date: Thu, 15 Jan 2015 17:13:27 -0500
Organization: PD Inc
Message-ID: <4C328D132E8343F395AA9A72CC3BD4C1@black>
References: <9782FD24F9FA45659CCE5171E73E49E7@black> <xmqqa91j7sej.fsf@gitster.dls.corp.google.com>
Reply-To: <git@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 8BIT
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Jan 15 23:13:37 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YBsfY-0001ea-68
	for gcvg-git-2@plane.gmane.org; Thu, 15 Jan 2015 23:13:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932364AbbAOWNb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Jan 2015 17:13:31 -0500
Received: from mail.pdinc.us ([67.90.184.27]:56198 "EHLO mail.pdinc.us"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932361AbbAOWN3 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 15 Jan 2015 17:13:29 -0500
Received: from black (nsa1.pdinc.us [67.90.184.2])
	(authenticated bits=0)
	by mail.pdinc.us (8.12.11.20060308/8.12.11) with ESMTP id t0FMDSHf017989
	for <git@vger.kernel.org>; Thu, 15 Jan 2015 17:13:28 -0500
X-Mailer: Microsoft Office Outlook 11
In-Reply-To: <xmqqa91j7sej.fsf@gitster.dls.corp.google.com>
Thread-Index: AdAw+dREN33qi9PYSRav+NTRFwCxuAAFYyUw
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.3790.4913
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262511>

> -----Original Message-----
> From: Junio C Hamano
> Sent: Thursday, January 15, 2015 14:31
> 
> "Jason Pyeron" <jpyeron@pdinc.us> writes:
> 
> > I am setting up a continous integration (CI) system for an 
> open source
> > project and I want to allow forking developers to use the 
> system, but
> > I do not want anyone to do a clone or fetch from the CI git 
> repo, the
> > repo.
> >
> > Any advice on limiting the https smart protocol to push 
> only, blocking clone and fetch?
> >
> > Looking at http-backend.c
> >    542  static struct service_cmd {
> > ...
> >    558  };
> 
> Looking at http-backend.c
> 
>      19 struct rpc_service {
>      20         const char *name;
>      21         const char *config_name;
>      22         signed enabled : 2;
>      23 };
>      24 
>      25 static struct rpc_service rpc_service[] = {
>      26         { "upload-pack", "uploadpack", 1 },
>      27         { "receive-pack", "receivepack", -1 },
>      28 };
> 
> So it would be natural to assume that there must be a way to
> enable/disable these two services, no?
> 
> Looking at http_config() there, I would guess perhaps:
> 
>     [http]
>         uploadpack = false
>         getanyfile = false
> 
> but I am not sure if the latter is needed (or anybody seriously
> tested it, for that matter).

Perfect! Had to add receivepack=true for the anonymous part.

root@twenty-one-100 /opt/git/public
# cat /etc/httpd/conf.d/git.conf
SetEnv GIT_PROJECT_ROOT /opt/git
SetEnv GIT_HTTP_EXPORT_ALL
ScriptAlias /git/ /usr/libexec/git-core/git-http-backend/
<Directory "/usr/lib/git-core*">
   Options ExecCGI Indexes
   Order allow,deny
   Allow from all
   Require all granted
</Directory>

root@twenty-one-100 /opt/git/public
# cat /opt/git/public/config
[core]
        repositoryformatversion = 0
        filemode = true
        bare = true
[http]
        receivepack = true
        uploadpack = false
        getanyfile = false

Test get known object...

root@twenty-one-100 /opt/git/public
# dir objects/bd/e1557acecaf3cebb4775b7b734f095e6010c15
-r--r--r--. 1 apache apache 163 Jan 15 16:56 objects/bd/e1557acecaf3cebb4775b7b734f095e6010c15

root@twenty-one-100 /opt/git/public
# curl http://127.0.0.1/git/public/objects/bd/e1557acecaf3cebb4775b7b734f095e6010c15 -v
* About to connect() to 127.0.0.1 port 80 (#0)
*   Trying 127.0.0.1... connected
* Connected to 127.0.0.1 (127.0.0.1) port 80 (#0)
> GET /git/public/objects/bd/e1557acecaf3cebb4775b7b734f095e6010c15 HTTP/1.1
> User-Agent: curl/7.19.7 (x86_64-redhat-linux-gnu) libcurl/7.19.7 NSS/3.16.2.3 Basic ECC zlib/1.2.3 libidn/1.18 libssh2/1.4.2
> Host: 127.0.0.1
> Accept: */*
>
< HTTP/1.1 403 Forbidden
< Date: Thu, 15 Jan 2015 22:08:48 GMT
< Server: Apache/2.2.15 (CentOS)
< Expires: Fri, 01 Jan 1980 00:00:00 GMT
< Pragma: no-cache
< Cache-Control: no-cache, max-age=0, must-revalidate
< Content-Length: 0
< Connection: close
< Content-Type: text/plain; charset=UTF-8
<
* Closing connection #0

root@twenty-one-100 /opt/git/public
# fg
tail -f /var/log/httpd/*_log    (wd: /opt/git)

==> /var/log/httpd/error_log <==
[Thu Jan 15 17:08:48 2015] [error] [client 127.0.0.1] Unsupported service: getanyfile

==> /var/log/httpd/access_log <==
127.0.0.1 - - [15/Jan/2015:17:08:48 -0500] "GET /git/public/objects/bd/e1557acecaf3cebb4775b7b734f095e6010c15 HTTP/1.1" 403 - "-" "curl/7.19.7 (x86_64-redhat-linux-gnu) libcurl/7.19.7 NSS/3.16.2.3 Basic ECC zlib/1.2.3 libidn/1.18 libssh2/1.4.2"
^Z
[1]+  Stopped                 tail -f /var/log/httpd/*_log  (wd: /opt/git)
(wd now: /opt/git/public)

root@twenty-one-100 /opt/git/public
#


--
-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
-                                                               -
- Jason Pyeron                      PD Inc. http://www.pdinc.us -
- Principal Consultant              10 West 24th Street #100    -
- +1 (443) 269-1555 x333            Baltimore, Maryland 21218   -
-                                                               -
-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
This message is copyright PD Inc, subject to license 20080407P00. 
