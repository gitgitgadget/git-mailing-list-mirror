From: Kristian =?ISO-8859-1?Q?H=F8gsberg?= <krh@redhat.com>
Subject: Re: performance problem: "git commit filename"
Date: Mon, 14 Jan 2008 18:46:19 -0500
Message-ID: <1200354379.488.17.camel@gaara.boston.redhat.com>
References: <alpine.LFD.1.00.0801121426510.2806@woody.linux-foundation.org>
	 <alpine.LFD.1.00.0801121735020.2806@woody.linux-foundation.org>
	 <alpine.LFD.1.00.0801121949180.2806@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Tue Jan 15 00:47:14 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JEZ1N-0007Xq-GV
	for gcvg-git-2@gmane.org; Tue, 15 Jan 2008 00:47:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750861AbYANXqh convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 14 Jan 2008 18:46:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750921AbYANXqh
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Jan 2008 18:46:37 -0500
Received: from mx1.redhat.com ([66.187.233.31]:60928 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750852AbYANXqh (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Jan 2008 18:46:37 -0500
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.13.8/8.13.8) with ESMTP id m0ENkPj9026212;
	Mon, 14 Jan 2008 18:46:25 -0500
Received: from pobox.corp.redhat.com (pobox.corp.redhat.com [10.11.255.20])
	by int-mx1.corp.redhat.com (8.13.1/8.13.1) with ESMTP id m0ENkPs4030406;
	Mon, 14 Jan 2008 18:46:25 -0500
Received: from [192.168.1.105] (dhcp83-9.boston.redhat.com [172.16.83.9])
	by pobox.corp.redhat.com (8.13.1/8.13.1) with ESMTP id m0ENkOH4019692;
	Mon, 14 Jan 2008 18:46:24 -0500
In-Reply-To: <alpine.LFD.1.00.0801121949180.2806@woody.linux-foundation.org>
X-Mailer: Evolution 2.21.4 (2.21.4-1.fc9) 
X-Scanned-By: MIMEDefang 2.58 on 172.16.52.254
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70489>

On Sat, 2008-01-12 at 20:04 -0800, Linus Torvalds wrote:

> It makes builtin-commit.c use the same logic that "git read-tree -i -=
m"=20
> does (which is what the old shell script did), and it seems to pass t=
he=20
> test-suite, and it looks pretty obvious.
>=20
> It also brings down the number of open/mmap/munmap/close calls to whe=
re it=20
> should be, although it still does *way* too many "lstat()" operations=
 (ie=20
> it does 4*lstat for each file in the index - one more than the=20
> non-filename one does).
>=20
> With that fixed, performance is also roughly where it should be (ie t=
he=20
> 17-18s for the cold-cache case), because it no longer needs to rehash=
 all=20
> the files!
>=20
> HOWEVER. This was just a quick hack, and while it all looks sane, thi=
s is=20
> some damn core code. Somebody else should double- and triple-check th=
is.

I took a look too, and it looks to me like the it's the exact same code
path in builtin-read-tree.c that the old

        git read-tree --index-output=3D"$TMP_INDEX" -i -m HEAD

part of the shell script would trigger.  So yes, this look like the
right fix to me.

Signed-off-by: Kristian H=C3=B8gsberg <krh@redhat.com>
