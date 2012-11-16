From: Enrico Weigelt <enrico.weigelt@vnc.biz>
Subject: Re: Local clones aka forks disk size optimization
Date: Fri, 16 Nov 2012 19:04:35 +0100 (CET)
Message-ID: <ccb8680a-97ad-4cf8-95d0-5e21f60494f4@zcs>
References: <50A622A9.4040709@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Andrew Ardill <andrew.ardill@gmail.com>,
	Javier Domingo <javierdo1@gmail.com>, git@vger.kernel.org,
	Sitaram Chamarty <sitaramc@gmail.com>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Fri Nov 16 19:04:54 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TZQHb-0005Bw-RT
	for gcvg-git-2@plane.gmane.org; Fri, 16 Nov 2012 19:04:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752807Ab2KPSEh convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 16 Nov 2012 13:04:37 -0500
Received: from zcs.vnc.biz ([83.144.240.118]:43179 "EHLO zcs.vnc.biz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752407Ab2KPSEh convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 16 Nov 2012 13:04:37 -0500
Received: from localhost (localhost [127.0.0.1])
	by zcs.vnc.biz (Postfix) with ESMTP id 09BDF62289E;
	Fri, 16 Nov 2012 19:04:36 +0100 (CET)
X-Virus-Scanned: amavisd-new at vnc.biz
Received: from zcs.vnc.biz ([127.0.0.1])
	by localhost (zcs.vnc.biz [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id fHN1Js-Vf6EP; Fri, 16 Nov 2012 19:04:35 +0100 (CET)
Received: from zcs.vnc.biz (zcs.vnc.biz [172.17.1.118])
	by zcs.vnc.biz (Postfix) with ESMTP id 8FC11622259;
	Fri, 16 Nov 2012 19:04:35 +0100 (CET)
In-Reply-To: <50A622A9.4040709@drmicha.warpmail.net>
X-Originating-IP: [91.43.211.84]
X-Mailer: Zimbra 7.1.3_GA_3346 (ZimbraWebClient - GC20 (Linux)/7.1.3_GA_3346)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209890>


> Provide one "main" clone which is bare, pulls automatically, and is
> there to stay (no pruning), so that all others can use that as a
> reliable alternates source.

The problem here, IMHO, is the assumption, that the main repo will
never be cleaned up. But what to do if you dont wanna let it grow
forever ?

hmm, distributed GC is a tricky problem.

maybe it could be easier having two kind of alternates:

a) classical: gc+friends will drop local objects that are=20
   already there
b) fallback: normal operations fetch objects if not accessible
   from anywhere else, but gc+friends do not skip objects from there.

And extend prune machinery to put some backup of the dropped objects
to some separate store.

This way we could use some kind of rotating archive:

* GC'ed objects will be stored in the backup repo for some while
* there are multiple active (rotating) backups kept for some time,
  each cycle, only the oldest one is dropped (and maybe objects
  in a newer backup are removed from the older ones)
* downstream repos must be synced often enough, so removed objects
  are fetched back from the backups early enough

You could see this as some heap:

* the currently active objects (directly referenced) are always
  on the top
* once they're not referenced, they sink a lever deeper
* when the're referenced again, they immediately jump up to the top
* at some point in time unreferenced objects sink too deep that
  they're dropped completely



cu
--=20
Mit freundlichen Gr=C3=BC=C3=9Fen / Kind regards=20

Enrico Weigelt=20
VNC - Virtual Network Consult GmbH=20
Head Of Development=20

Pariser Platz 4a, D-10117 Berlin
Tel.: +49 (30) 3464615-20
=46ax: +49 (30) 3464615-59

enrico.weigelt@vnc.biz; www.vnc.de=20
