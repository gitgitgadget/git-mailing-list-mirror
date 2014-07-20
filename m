From: =?ISO-8859-1?Q?Torsten_B=F6gershausen?= <tboegi@web.de>
Subject: Re: git_inetd_server: run git-http-backend using inetd
Date: Sun, 20 Jul 2014 08:10:44 +0200
Message-ID: <53CB5D64.9060801@web.de>
References: <43923BC7-08AF-4900-AC5E-B2F0FE7CD5AC@gmail.com> <20140717221056.GO12427@google.com> <53CA0E59.5030103@web.de> <20140719170623.GA29072@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Kyle J. McKay" <mackyle@gmail.com>,
	Git mailing list <git@vger.kernel.org>
To: Jonathan Nieder <jrnieder@gmail.com>,
	=?ISO-8859-1?Q?Torsten_B=F6ge?= =?ISO-8859-1?Q?rshausen?= 
	<tboegi@web.de>
X-From: git-owner@vger.kernel.org Sun Jul 20 08:15:57 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X8kPc-00005C-4u
	for gcvg-git-2@plane.gmane.org; Sun, 20 Jul 2014 08:15:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751670AbaGTGKx convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 20 Jul 2014 02:10:53 -0400
Received: from mout.web.de ([212.227.17.12]:52166 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751164AbaGTGKw (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Jul 2014 02:10:52 -0400
Received: from [192.168.1.87] ([178.165.128.72]) by smtp.web.de (mrweb102)
 with ESMTPSA (Nemesis) id 0LkhBY-1WamYm2NTo-00aX8L; Sun, 20 Jul 2014 08:10:49
 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:24.0) Gecko/20100101 Icedove/24.6.0
In-Reply-To: <20140719170623.GA29072@google.com>
X-Provags-ID: V03:K0:2UZnoMX20f5ly3H0S9LkkKazZI302iWn3Us5XD+8BPmMhHbSvTE
 LKFeZuQ0EZ1nMiT1sLZGJq7GnxmfS+nbqq9sBqJUWprkwRc+fUsVWhfjU27n9HNZBd70XMr
 SWJ46gAvAjM/gA7h5JtIE37tMZv6wClJ419206qZjAEwxa4+50ON//4hnfhM4gQHai4140R
 VPvP/8SAQkU/TKSJehfnw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253911>

On 07/19/2014 07:06 PM, Jonathan Nieder wrote:
> Torsten B=F6gershausen wrote:
>
>> Jonathan, (I'm good in searching, but bad in finding)
>> could you point out where the source code for the git package for
>> debian is ?
>>
>> I recently learned about mDNS, and will probably do some tests
>> and experiments later, and would like to test the lookup feature
>> of "0010".
> Thanks.  It's at git://git.debian.org/~jrnieder-guest/git branch
> release+patches and mirrored at http://repo.or.cz/r/git/debian
With my limited reading of the RFC and the code, and without having
test environment, my spontanous (and probably incomplete) change could=20
look like this:
- Treat "host:9418" the same as "host"
- When the hosts ends with .local, do not use DNS.

static int git_tcp_connect_sock(char *host, int flags)
{
     struct strbuf error_message =3D STRBUF_INIT;
     int sockfd =3D -1, gai =3D 0;
     const char *port =3D NULL;
     struct host *hosts =3D NULL;
     int j, n =3D 0;

     get_host_and_port(&host, &port);
     if (!port)
         port =3D STR(DEFAULT_GIT_PORT);

     n =3D get_srv(host, &hosts);
     if ((n <=3D 0) && ends_with(host, ".local")) {
         /*
           host.local is really local, do not send it to a DNS resolver
           The user may try host without .local
          */
         die("Unable to look up %s", host);
     }
     if (!n) {
         hosts =3D xmalloc(sizeof(*hosts));
         hosts[0].hostname =3D xstrdup(host);
         hosts[0].port =3D xstrdup(port);
[snip]
