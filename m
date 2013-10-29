From: Jim Garrison <jim.garrison@nwea.org>
Subject: Migrate svn non-standard layout to git
Date: Tue, 29 Oct 2013 20:04:56 +0000
Message-ID: <0C723FEB5B4E5642B25B451BA57E273041FD42F6@S1P5DAG3C.EXCHPROD.USA.NET>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
To: "git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Oct 29 21:05:17 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VbFXQ-0002mr-NI
	for gcvg-git-2@plane.gmane.org; Tue, 29 Oct 2013 21:05:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752329Ab3J2UFK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Oct 2013 16:05:10 -0400
Received: from gwo3.mbox.net ([165.212.64.25]:34814 "EHLO gwo3.mbox.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751345Ab3J2UFJ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 29 Oct 2013 16:05:09 -0400
Received: from gwo3.mbox.net (localhost [127.0.0.1])
	by gwo3.mbox.net (Postfix) with ESMTP id 3d8P0h2sykzfj3PB
	for <git@vger.kernel.org>; Tue, 29 Oct 2013 20:05:08 +0000 (UTC)
X-USANET-Received: from gwo3.mbox.net [127.0.0.1] by gwo3.mbox.net via mtad (C8.MAIN.3.82G) 
	with ESMTP id 914RJCuFB4848Mo3; Tue, 29 Oct 2013 20:05:02 -0000
X-USANET-Routed: 5 gwsout-gwsd Q:gwsd
X-USANET-Routed: 3 gwsout-vs Q:bmvirus
X-USANET-GWS2-Tenant: nwea.org
X-USANET-GWS2-Tagid: NWEA
Received: from S1P5HUB3.EXCHPROD.USA.NET [165.212.120.254] by gwo3.mbox.net via smtad (C8.MAIN.3.93K) 
	with ESMTPS id XID891RJCuFc3836Xo3; Tue, 29 Oct 2013 20:05:02 -0000
X-USANET-Source: 165.212.120.254 OUT  jim.garrison@nwea.org S1P5HUB3.EXCHPROD.USA.NET
X-USANET-MsgId: XID891RJCuFc3836Xo3
Received: from S1P5DAG3C.EXCHPROD.USA.NET ([169.254.3.33]) by
 S1P5HUB3.EXCHPROD.USA.NET ([10.120.223.33]) with mapi id 14.03.0158.001; Tue,
 29 Oct 2013 20:04:56 +0000
Thread-Topic: Migrate svn non-standard layout to git
Thread-Index: Ac7U3KLqy70Jb10wQXawXpJJuY5iXA==
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [70.98.171.2]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236947>

I have the following SVN setup:

    Repository: http://svn-server:81/svn/DevJava
    Trunk: trunk/etl_app
    Branches: branches/etl_app
    Tags: tags/etl_app

After reading the manual and git-svn man page I tried the following command in ~/src

    git svn clone -T trunk/etl_app -b branches/etl_app -t tags/etl_app --authors-file=users.txt --no-metadata http://svn-server:81/svn/DevJava etl_app

This results in outputting this

    Initialized empty Git repository in /home/jim.garrison/git/etl_app/.git/

And then.... nothing. It appears to hang, but is consuming about 10% CPU and no I/O as far as I can determine.  I let it run for 30 minutes and checked the contents of the etl_app subdirectory from another terminal session but it never produced any more terminal output or wrote anything to the local disk.

Then I tried using full URLs for -T -t and -b and got:

    Initialized empty Git repository in /home/jim.garrison/git/etl_app/.git/
    Using higher level of URL: http:// svn-server:81/svn/DevJava/trunk/etl_app => http:// svn-server:81/svn/DevJava
    perl: subversion/libsvn_subr/path.c:115: svn_path_join: Assertion `svn_path_is_canonical(component, pool)' failed.
    error: git-svn died of signal 6

By accident, I discovered that the following command gets farther:

    git svn clone -T trunk/etl_app -b branches/etl_app -t tags/etl_app --authors-file=users.txt --no-metadata http:// svn-server:81/svn/DevJava/trunk/etl_app etl_app
    Initialized empty Git repository in /home/jim.garrison/git/etl_app/.git/
    Using higher level of URL: http:// svn-server:81/svn/DevJava/trunk/etl_app => http:// svn-server:81/svn/DevJava
    W: Ignoring error from SVN, path probably does not exist: (160013): Filesystem has no item: File not found: revision 100, path '/trunk/etl_app'
    W: Do not be alarmed at the above message git-svn is just searching aggressively for old history.
    This may take a while on large repositories
    Checked through r40200

This takes a few minutes but finally completes "successfully". 

In the Git online book's migration chapter it then says to execute a couple of commands to move the svn tags and branches to proper Git tags and branches.

    git for-each-ref refs/remotes/tags | cut -d / -f 4- | grep -v @ | while read tagname; do git tag "$tagname" "tags/$tagname"; git branch -r -d "tags/$tagname"; done
    git for-each-ref refs/remotes | cut -d / -f 3- | grep -v @ | while read branchname; do git branch "$branchname" "refs/remotes/$branchname"; git branch -r -d "$branchname"; done

However, neither of the "for-each-ref" commands produces any output, so these are effectively no-ops.

Can someone explain what's going on? How do I get the svn tags and branches fetched so I can migrate the svn repository to git without losing them?

Thanks
