From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [GSoC update] git-remote-svn: Week 7
Date: Mon, 14 Jun 2010 18:19:23 +0200
Message-ID: <1276532364-6993-1-git-send-email-artagnon@gmail.com>
Cc: David Michael Barr <david.barr@cordelta.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>, Jonas Gehring <jonas.gehring@boolsoft.org>
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Jun 14 18:18:09 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OOCMR-0006c6-NB
	for gcvg-git-2@lo.gmane.org; Mon, 14 Jun 2010 18:18:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755924Ab0FNQR6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Jun 2010 12:17:58 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:37498 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755879Ab0FNQRx (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Jun 2010 12:17:53 -0400
Received: by wyb40 with SMTP id 40so4014802wyb.19
        for <git@vger.kernel.org>; Mon, 14 Jun 2010 09:17:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=/FeZRLZ3Vb6aDuvHyGwbJHUQoFhmhb19h8HcTWLR6HU=;
        b=B3hLTyzF1XfqoZ8bSVo5b/YrAFNzr8J8RHkH9TuaSgEl9Pls+cAuoXoa5pgbVUsLB/
         KJMaE8rt4jdnulp7ogJgJWOXwdRsD1SCpTMbaGFnij6nEdDcXg0CU7mosnEy6cae9B0E
         EeR+bjn/dJWA4txVLpnjCTLKU0pYiLP/iK8qU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=KWdYX2y5mxD3zW/pFBogwrwtQBm2xxlM+fJvEeHpF4vxm+KDNUrtdwLIs3NdGzTwiO
         76WCOokg8QVMaJUX/8fxGWkuAI/pg6STXluTkNWF1WdTC3go0y2KbrAOdljhXYxF5muJ
         HixG00bSLvCsHo+uron9kK/Q06FS1nwz6YbIU=
Received: by 10.227.72.204 with SMTP id n12mr5782369wbj.217.1276532271611;
        Mon, 14 Jun 2010 09:17:51 -0700 (PDT)
Received: from localhost (adm12-98.itu.dk [130.226.133.98])
        by mx.google.com with ESMTPS id n31sm37984484wba.3.2010.06.14.09.17.49
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 14 Jun 2010 09:17:50 -0700 (PDT)
X-Mailer: git-send-email 1.7.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149122>

Hi,

I suspect that people are confused about what I'm exactly doing and
how to review/ test all the work since I've been posting updates in
rapid bursts, and writing relatively short emails. For a change, this
email is going to be (relatively) long and detailed since things are
finally starting to take shape. So, the project involves the following
components:
1. The remote helper application or remote-svn (90% complete): There's
nothing much to see here; I just stripped down remote-curl.c and
posted a remote-svn.c along with the relevant Makefile rule to build
it a few weeks ago [1]. What this needs: Some infrastructure to do the
importing/ exporting in $GIT_ROOT/vcs-svn/.
2. David's SVN exporter or svn-fe (80% complete): This is quite an
excellent piece of software for turning an SVN dumpfile into a stream
that git-fast-import can import [2]. David has validated it against
940,000 commits of the ASF repository, and it works perfectly. It's
80% complete because there's some room for refactoring certain parts,
and cosmetic beautification before the merge into `next`. I work on
both `master` and a special `git-merge` branch specifically for
merging it into git.git. Jonathan has suggested that two separate
components should be merged into git.git: svn-fe itself as an
independent program in $GIT_ROOT/contrib/ and the `git-merge` branch
for creating infrastructure for the remote helper in
$GIT_ROOT/vcs-svn/. We are currently preparing a series for the
former, while the latter was just merged into pu this week [3].
3. The RA SVN Client or svnclient_ra (15% complete): This piece of
sofware will be invoked by the remote helper and will use the libsvn
API (yuck!) to contact a remote server and produce output in dumpfile
format for the exporter component. Jonas has written a software called
rsvndump which already does this [4], but the codebase is too clunky
and outdated (it doesn't use the replay API); I'm therefore attempting
a complete rewrite, and you can find the latest update in a patch in
the second part of this series. Note that the replay API forces a
server version >= 1.5 restriction, but Sverre and I are alright with
this. The cost of backward compatibility is a LOT of ugly code (seen
in rsvndump).
4. The importer (0% complete): I'll probably only get started with
this after the mid-term evaluations.

[1]: http://article.gmane.org/gmane.comp.version-control.git/147716
[2]: http://github.com/artagnon/svn-dump-fast-export
[3]: Commit 9c55c48
[4]: http://github.com/jgehring/rsvndump

-- Ram

Ramkumar Ramachandra (1):
  Add a skeleton RA SVN client

 Makefile       |    2 +
 delta_editor.c |  112 ++++++++++++++++++++++++++++++++++++++++++++++
 delta_editor.h |   66 +++++++++++++++++++++++++++
 svnclient_ra.c |  135 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 315 insertions(+), 0 deletions(-)
 create mode 100644 Makefile
 create mode 100644 delta_editor.c
 create mode 100644 delta_editor.h
 create mode 100644 svnclient_ra.c
