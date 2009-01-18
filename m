From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [WIP Patch 02/12] Some cleanup in get_refs_via_curl()
Date: Sun, 18 Jan 2009 22:09:28 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0901182202500.3586@pacific.mpi-cbg.de>
References: <20090118074911.GB30228@glandium.org> <1232265877-3649-1-git-send-email-mh@glandium.org> <1232265877-3649-2-git-send-email-mh@glandium.org> <1232265877-3649-3-git-send-email-mh@glandium.org> <alpine.DEB.1.00.0901182005230.3586@pacific.mpi-cbg.de>
 <alpine.DEB.1.00.0901182010380.3586@pacific.mpi-cbg.de> <20090118193002.GA25134@glandium.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, gitster@pobox.com
To: Mike Hommey <mh@glandium.org>
X-From: git-owner@vger.kernel.org Sun Jan 18 22:10:57 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LOeuz-00026A-Bd
	for gcvg-git-2@gmane.org; Sun, 18 Jan 2009 22:10:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755135AbZARVJ3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 18 Jan 2009 16:09:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754733AbZARVJ3
	(ORCPT <rfc822;git-outgoing>); Sun, 18 Jan 2009 16:09:29 -0500
Received: from mail.gmx.net ([213.165.64.20]:46655 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754697AbZARVJ2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Jan 2009 16:09:28 -0500
Received: (qmail invoked by alias); 18 Jan 2009 21:09:26 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp059) with SMTP; 18 Jan 2009 22:09:26 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+oHhAPndCo7jfoRFE+6gkeBsAU2gq5kQuM9p6slY
	t3AtrVHgMd2xYX
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <20090118193002.GA25134@glandium.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106281>

Hi,

On Sun, 18 Jan 2009, Mike Hommey wrote:

> On Sun, Jan 18, 2009 at 08:11:07PM +0100, Johannes Schindelin wrote:
> > Hi,
> > 
> > On Sun, 18 Jan 2009, Johannes Schindelin wrote:
> > 
> > > On Sun, 18 Jan 2009, Mike Hommey wrote:
> > > 
> > > > diff --git a/transport.c b/transport.c
> > > > index 56831c5..6919ff1 100644
> > > > --- a/transport.c
> > > > +++ b/transport.c
> > > > @@ -508,6 +508,8 @@ static struct ref *get_refs_via_curl(struct transport *transport)
> > > >  		free(ref);
> > > >  	}
> > > >  
> > > > +	http_cleanup();
> > > > +	free(refs_url);
> > > >  	return refs;
> > > >  }
> > > 
> > > You cannot http_cleanup() here, as http-push calls that function, but 
> > > continues to want to use curl.
> > 
> > Worse, a http clone will hit the same issue.
> 
> IIRC, it doesn't break anything because getting refs is going to happen
> at the beginning, and the following http request is going to
> reinitialize the whole thing.
> 
> It is suboptimal, I agree.

>From the output of t5540-http-push.sh (which tests http clone 
as case 2, incidentally):

-- snip --
*   ok 1: setup remote repository

* expecting success:
        cd "$ROOT_PATH" &&
        git clone $HTTPD_URL/test_repo.git test_repo_clone

*** glibc detected *** git: double free or corruption (!prev): 
0x000000000077e090 ***
======= Backtrace: =========
/lib/libc.so.6[0x2ba4f5ac8b0a]
/lib/libc.so.6(cfree+0x8c)[0x2ba4f5acc6fc]
git[0x4d7ef2]
git[0x4d9073]
git[0x4d90b7]
git[0x4d1626]
git[0x4d1b2f]
git[0x4c9abb]
git[0x4ca00d]
git[0x4cad1a]
git[0x41c5f3]
git[0x404ee8]
git[0x405095]
git[0x40517b]
git[0x4053b8]
/lib/libc.so.6(__libc_start_main+0xf4)[0x2ba4f5a74b44]
git[0x404589]
======= Memory map: ========
00400000-00528000 r-xp 00000000 08:01 45859192                  
         /home/schindelin/git/git
00727000-0072d000 rw-p 00127000 08:01 45859192                  
         /home/schindelin/git/git
0072d000-007b9000 rw-p 0072d000 00:00 0                         
         [heap]
2ba4f4e47000-2ba4f4e64000 r-xp 00000000 08:01 54051869          
         /lib/ld-2.6.1.so
2ba4f4e64000-2ba4f4e68000 rw-p 2ba4f4e64000 00:00 0
2ba4f5063000-2ba4f5065000 rw-p 0001c000 08:01 54051869          
         /lib/ld-2.6.1.so
2ba4f5065000-2ba4f50a2000 r-xp 00000000 08:01 49956909          
         /usr/lib/libcurl.so.4.0.0
2ba4f50a2000-2ba4f52a1000 ---p 0003d000 08:01 49956909          
         /usr/lib/libcurl.so.4.0.0
2ba4f52a1000-2ba4f52a3000 rw-p 0003c000 08:01 49956909          
         /usr/lib/libcurl.so.4.0.0
2ba4f52a3000-2ba4f52b9000 r-xp 00000000 08:01 49956837          
         /usr/lib/libz.so.1.2.3.3
2ba4f52b9000-2ba4f54b9000 ---p 00016000 08:01 49956837          
         /usr/lib/libz.so.1.2.3.3
2ba4f54b9000-2ba4f54ba000 rw-p 00016000 08:01 49956837          
         /usr/lib/libz.so.1.2.3.3
2ba4f54ba000-2ba4f5615000 r-xp 00000000 08:01 49957372          
         /usr/lib/libcrypto.so.0.9.8
2ba4f5615000-2ba4f5815000 ---p 0015b000 08:01 49957372          
         /usr/lib/libcrypto.so.0.9.8
2ba4f5815000-2ba4f5838000 rw-p 0015b000 08:01 49957372          
         /usr/lib/libcrypto.so.0.9.8
2ba4f5838000-2ba4f583b000 rw-p 2ba4f5838000 00:00 0
2ba4f583b000-2ba4f5851000 r-xp 00000000 08:01 54051886          
         /lib/libpthread-2.6.1.so
2ba4f5851000-2ba4f5a50000 ---p 00016000 08:01 54051886          
         /lib/libpthread-2.6.1.so
2ba4f5a50000-2ba4f5a52000 rw-p 00015000 08:01 54051886          
         /lib/libpthread-2.6.1.so
2ba4f5a52000-2ba4f5a57000 rw-p 2ba4f5a52000 00:00 0
2ba4f5a57000-2ba4f5ba9000 r-xp 00000000 08:01 54051872          
         /lib/libc-2.6.1.so
2ba4f5ba9000-2ba4f5da8000 ---p 00152000 08:01 54051872          
         /lib/libc-2.6.1.so
2ba4f5da8000-2ba4f5dab000 r--p 00151000 08:01 54051872          
         /lib/libc-2.6.1.so
2ba4f5dab000-2ba4f5dad000 rw-p 00154000 08:01 54051872          
         /lib/libc-2.6.1.so
2ba4f5dad000-2ba4f5db2000 rw-p 2ba4f5dad000 00:00 0
2ba4f5db2000-2ba4f5ddc000 r-xp 00000000 08:01 49957359          
         /usr/lib/libgssapi_krb5.so.2.2
2ba4f5ddc000-2ba4f5fdb000 ---p 0002a000 08:01 49957359          
         /usr/lib/libgssapi_krb5.so.2.2
2ba4f5fdb000-2ba4f5fdd000 rw-p 00029000 08:01 49957359          
         /usr/lib/libgssapi_krb5.so.2.2
2ba4f5fdd000-2ba4f600e000 r-xp 00000000 08:01 49957876          
         /usr/lib/libidn.so.11.5.29
2ba4f600e000-2ba4f620e000 ---p 00031000 08:01 49957876          
         /usr/lib/libidn.so.11.5.29
2ba4f620e000-2ba4f620f000 rw-p 00031000 08:01 49957876          
         /usr/lib/libidn.so.11.5.29
2ba4f620f000-2ba4f6210000 rw-p 2ba4f620f000 00:00 0
2ba4f6210000-2ba4f6212000 r-xp 00000000 08:01 54051875          
         /lib/libdl-2.6.1.so
2ba4f6212000-2ba4f6412000 ---p 00002000 08:01 54051875          
         /lib/libdl-2.6.1.so
2ba4f6412000-2ba4f6414000 rw-p 00002000 08:01 54051875          
         /lib/libdl-2.6.1.so
2ba4f6414000-2ba4f6458000 r-xp 00000000 08:01 49957373          
         /usr/lib/libssl.so.0.9.8
2ba4f6458000-2ba4f6657000 ---p 00044000 08:01 49957373          
         /usr/lib/libssl.so.0.9.8
2ba4f6657000-2ba4f665d000 rw-p 00043000 08:01 49957373          
         /usr/lib/libssl.so.0.9.8
2ba4f665d000-2ba4f66ed000 r-xp 00000000 08:01 49957362          
         /usr/lib/libkrb5.so.3.3
2ba4f66ed000-2ba4f68ed000 ---p 00090000 08:01 49957362          
         /usr/lib/libkrb5.so.3.3
2ba4f68ed000-2ba4f68f1000 rw-p 00090000 08:01 49957362          
         /usr/lib/libkrb5.so.3.3
2ba4f68f1000-2ba4f68f2000 rw-p 2ba4f68f1000 00:00 0
2ba4f68f2000-2ba4f6916000 r-xp 00000000 08:01 49957360          
         /usr/lib/libk5crypto.so.3.1
2ba4f6916000-2ba4f6b15000 ---p 00024000 08:01 49957360          
         /usr/lib/libk5crypto.so.3.1
2ba4f6b15000-2ba4f6b17000 rw-p 00023000 08:01 49957360          
         /usr/lib/libk5crypto.so.3.1
2ba4f6b17000-2ba4f6b19000 r-xp 00000000 08:01 54050832          
         /lib/libcom_err.so.2.1
2ba4f6b19000-2ba4f6d18000 ---p 00002000 08:01 54050832          
         /lib/libcom_err.so.2.1
2ba4f6d18000-2ba4f6d19000 rw-p 00001000 08:01 54050832          
         /lib/libcom_err.so.2.1
2ba4f6d19000-2ba4f6d20000 r-xp 00000000 08:01 49957363          
         /usr/lib/libkrb5support.so.0.1
2ba4f6d20000-2ba4f6f20000 ---p 00007000 08:01 49957363          
         /usr/lib/libkrb5support.so.0.1
2ba4f6f20000-2ba4f6f21000 rw-p 00007000 08:01 49957363          
         /usr/lib/libkrb5support.so.0.1
2ba4f6f21000-2ba4f6f22000 rw-p 2ba4f6f21000 00:00 0
2ba4f6f22000-2ba4f6f24000 r-xp 00000000 08:01 54050958          
         /lib/libkeyutils-1.2.so
2ba4f6f24000-2ba4f7123000 ---p 00002000 08:01 54050958          
         /lib/libkeyutils-1.2.so
2ba4f7123000-2ba4f7124000 rw-p 00001000 08:01 54050958          
         /lib/libkeyutils-1.2.so
2ba4f7124000-2ba4f7136error: Request for 
0c973ae9bd51902a28466f3850b543fa66a6aaf4 aborted
Initialized empty Git repository in 
/home/schindelin/git/t/trash 
directory.t5540-http-push/test_repo_clone/.git/
Aborted
* FAIL 2: clone remote repository

                cd "$ROOT_PATH" &&
                git clone $HTTPD_URL/test_repo.git test_repo_clone
-- snap --

It might be a strange interaction with my patches, though.  valgrind 
pointed to the http_cleanup() call, and after removing that call, the 
message goes away.

Ciao,
Dscho
