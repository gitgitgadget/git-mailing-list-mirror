From: Thomas Pasch <thomas.pasch@jentro.com>
Subject: Re: git-http-push / webDAV
Date: Tue, 02 Oct 2007 10:49:07 +0200
Organization: Jentro Technologies GmbH
Message-ID: <47020603.3080000@jentro.com>
References: <4700F6BC.2070701@jentro.com> <20071001155454.GU975@void.codelabs.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=KOI8-R
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Eygene Ryabinkin <rea-git@codelabs.ru>
X-From: git-owner@vger.kernel.org Tue Oct 02 10:49:33 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IcdRd-00012S-8k
	for gcvg-git-2@gmane.org; Tue, 02 Oct 2007 10:49:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753365AbXJBItP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Oct 2007 04:49:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753503AbXJBItP
	(ORCPT <rfc822;git-outgoing>); Tue, 2 Oct 2007 04:49:15 -0400
Received: from mail2.infra.net ([212.89.96.7]:3407 "EHLO gamma.m.infra.net"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752396AbXJBItO (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Oct 2007 04:49:14 -0400
Received: from epsilon.m.infra.net (epsilon.m.infra.net [212.89.96.8])
	by gamma.m.infra.net (8.13.4/8.13.4/Debian-3sarge3) with ESMTP id l928n8th001810;
	Tue, 2 Oct 2007 10:49:08 +0200
Received: from [192.1.1.184] (u19-17.dsl.vianetworks.de [194.231.42.17])
	(authenticated bits=0)
	by epsilon.m.infra.net (8.13.4/8.13.4/Debian-3) with ESMTP id l928n7qJ018687
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Tue, 2 Oct 2007 10:49:08 +0200
User-Agent: Thunderbird 2.0.0.6 (X11/20070801)
In-Reply-To: <20071001155454.GU975@void.codelabs.ru>
X-Enigmail-Version: 0.95.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59674>

Dear Eygene,

I've investigated my problem a little further. The nasty
'UNLOCK HTTP error 400' has come from a proxy that
doesn't accept webDAV stuff. Thus I unset the 'http_proxy'
env variable (looks like cadaver hasn't cared...).

However, the main problem still remains. Using a non empty
remote http repo, modifying and committing, then:

> git push -v
Pushing to http://test@x.x.x.x/git/git.git

still waits for a long time and finally:

Error: no DAV locking support on remote repo http://test@x.x.x.x/git/git.git
error: failed to push to 'http://test@x.x.x.x/git/git.git'

Interestingly apache2 access_log is:

[...]
x.x.x.x - test [02/Oct/2007:10:38:03 +0200] "GET /git/git.git/objects/pack/p
ack-563e2090185692c7d765775569a0ce986840fd17.pack HTTP/1.1" 200 15038211
"-" "gi
t/1.5.3.3"
x.x.x.x - test [02/Oct/2007:10:38:35 +0200] "GET /git/git.git/HEAD HTTP/1.1"
 200 23 "-" "curl/7.15.5 (i686-suse-linux-gnu) libcurl/7.15.5
OpenSSL/0.9.8d zli
b/1.2.3 libidn/0.6.8"
x.x.x.x - test [02/Oct/2007:10:39:27 +0200] "PROPFIND /git/git.git HTTP/1.1"
 301 319 "-" "git/1.5.3.3"

Hence a 'Moved Permanently' Error?!?

I'm using a SuSE 10.2 system here. Apache2 git configuration
is in /etc/apache2/conf.d/git-dav.conf:

--->8--->8--->8--->8--->8--->8--->8--->8--->8
<IfModule mod_alias.c>
Alias /git    /data/git
</IfModule>

DAVLockDB /var/lock/apache2/DAVLock

<Directory /data/git>
        # http://httpd.apache.org/docs/2.0/mod/mod_dav.html
        DAV On

        Options +Indexes

        AuthType Basic
        AuthName "git"
        AuthBasicProvider file
        AuthUserFile /etc/apache2/auth/userfile

        Require valid-user
        Order allow,deny
        Allow from all
</Directory>
--->8--->8--->8--->8--->8--->8--->8--->8--->8

Cheers,

Thomas

Eygene Ryabinkin wrote:
> Thomas, good day.
>
> Mon, Oct 01, 2007 at 03:31:40PM +0200, Thomas Pasch wrote:
>> trying to set up a webDAV enabled http push
>> git server (1.5.3.3) like it is described in
>>
>>
http://www.kernel.org/pub/software/scm/git/docs/howto/setup-git-server-over-http.txt
>>
>> Tested the apache2 (2.2.6) DAV setup with
>> cadaver (and tried the browser as well).
>> With cadaver I could lock files, download
>> and upload content.
>>
>> However,
>>
>>> git push -v upload master
>> Pushing to http://test@x.x.x.x/git/DepTrack.git/
>> Fetching remote heads...
>>   refs/
>>   refs/heads/
>>   refs/tags/
>> updating 'refs/heads/master'
>>   from 0000000000000000000000000000000000000000
>>   to   d75dce3fe0e9ec5915feda5574f214bd432ccb14
>>     sending 89 objects
>>     done
>> Updating remote server info
>> UNLOCK HTTP error 400
>
> And how is your Apache configuration looks like?  I used to
> make 2.2.4 work flawlessly with git.  Perhaps I will get it
> a shot with the 2.2.6.
