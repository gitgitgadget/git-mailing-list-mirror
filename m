From: Enrico Weigelt <enrico.weigelt@vnc.biz>
Subject: filter-branch IO optimization
Date: Thu, 11 Oct 2012 17:39:47 +0200 (CEST)
Message-ID: <fa1e05a5-54b3-47ff-bd28-dc463ebbc4bd@zcs>
References: <7e000a0f-9e4e-4a4d-a8ce-5d017e17939c@zcs>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Oct 11 17:40:04 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TMKrh-0004nD-9h
	for gcvg-git-2@plane.gmane.org; Thu, 11 Oct 2012 17:40:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932837Ab2JKPju convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 11 Oct 2012 11:39:50 -0400
Received: from zcs.vnc.biz ([83.144.240.118]:15864 "EHLO zcs.vnc.biz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754645Ab2JKPjt convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 11 Oct 2012 11:39:49 -0400
Received: from localhost (localhost [127.0.0.1])
	by zcs.vnc.biz (Postfix) with ESMTP id 872006228BF
	for <git@vger.kernel.org>; Thu, 11 Oct 2012 17:39:47 +0200 (CEST)
X-Virus-Scanned: amavisd-new at vnc.biz
Received: from zcs.vnc.biz ([127.0.0.1])
	by localhost (zcs.vnc.biz [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Vn6FF5DEMfs8 for <git@vger.kernel.org>;
	Thu, 11 Oct 2012 17:39:47 +0200 (CEST)
Received: from zcs.vnc.biz (zcs.vnc.biz [172.17.1.118])
	by zcs.vnc.biz (Postfix) with ESMTP id 3D2576228A5
	for <git@vger.kernel.org>; Thu, 11 Oct 2012 17:39:47 +0200 (CEST)
In-Reply-To: <7e000a0f-9e4e-4a4d-a8ce-5d017e17939c@zcs>
X-Originating-IP: [91.43.169.65]
X-Mailer: Zimbra 7.1.3_GA_3346 (ZimbraWebClient - GC20 (Linux)/7.1.3_GA_3346)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207480>

Hi folks,

for certain projects, I need to regularily run filter-branch on quite
large repos (>10k commits), and that needs to be run multiple times,
which takes several hours, so I'm looking for optimizations.

The main goal of this filtering is splitting out many modules from a
large upstream repo into their own downstream repos. This process
should be fully deterministic (IOW: running it twice at the same input,
should produce exactly same output, so commit IDs stay the same after
subsequent runs)

My current approach is most likely yet a bit too naive:

#1: forkoff new branch from current upstream
#2: run a tree-filter which:
    * removes all files not belonging to the wanted module
    * move the module directory under another subdir (./addons/)
    * fix author/comitter name/email if empty (because otherwise fails)
    * fix charater sets and indentions of source files
#3: loop through `git filter-branch --prune-empty` to get rid of empty
    merge nodes (which otherwise remain really a lot), until branch
    remains unchanged
#4: run plain rebase onto initial commit to linearize the history

All that is done is on per-module basis (for now only about 10,
but soon can become much more).

One thing I haven't tried yet is using the -d option to move the .git-r=
ewrite
dir to an tmpfs (have to clarify some operating considerations first) ;=
-o

The next step I have in mind is using --subdirectory-filter, but open
questsions are:

* does it suffer from the same problems w/ empty username/email like --=
tree-filter ?
** if yes: what can I do about it (have an additional pass for fixing t=
hat before
   running the --tree-filter ?
* can I somehow teach the --subdirectory filter to place the result und=
er some
  somedir instead of directly to root ?
* can I use --tree-filter in combination with --subdireectory-filter ?=20
  which one is executed first ?


thanks
--=20
Mit freundlichen Gr=C3=BC=C3=9Fen / Kind regards=20

Enrico Weigelt=20
VNC - Virtual Network Consult GmbH=20
Head Of Development=20

Pariser Platz 4a, D-10117 Berlin
Tel.: +49 (30) 3464615-20
=46ax: +49 (30) 3464615-59

enrico.weigelt@vnc.biz; www.vnc.de=20
