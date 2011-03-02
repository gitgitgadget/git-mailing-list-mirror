From: John Kristian <jkristian@linkedin.com>
Subject: git-svn with big subversion repository
Date: Wed, 2 Mar 2011 02:43:23 +0000
Message-ID: <C992EE5B.CBFB%jkristian@linkedin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
To: "git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Mar 02 03:54:44 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PucD5-0004GN-8C
	for gcvg-git-2@lo.gmane.org; Wed, 02 Mar 2011 03:54:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757201Ab1CBCy3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Mar 2011 21:54:29 -0500
Received: from esv4-mav02.corp.linkedin.com ([69.28.149.24]:44470 "EHLO
	esv4-mav02.corp.linkedin.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756369Ab1CBCy2 convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Tue, 1 Mar 2011 21:54:28 -0500
X-Greylist: delayed 752 seconds by postgrey-1.27 at vger.kernel.org; Tue, 01 Mar 2011 21:54:28 EST
DomainKey-Signature: s=prod; d=linkedin.com; c=nofws; q=dns;
  h=X-IronPort-AV:Received:From:To:Subject:Thread-Topic:
   Thread-Index:Date:Message-ID:Accept-Language:
   Content-Language:X-MS-Has-Attach:X-MS-TNEF-Correlator:
   user-agent:x-originating-ip:Content-Type:Content-ID:
   Content-Transfer-Encoding:MIME-Version;
  b=Enu47WjWRbd6yPlSoYPQjz4lZRSM9Wz2hZ+olnWB4zPrcYCBnBfNWHRY
   Scs4pnfBniJaYF3qLiLh5R9n3CEkLurKIV5RLj+J4CL/fkAz+fGNUCjR+
   +phl+nYVqlOHHwf;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=linkedin.com; i=jkristian@linkedin.com; q=dns/txt;
  s=proddkim; t=1299034462; x=1330570462;
  h=from:sender:reply-to:subject:date:message-id:to:cc:
   mime-version:content-transfer-encoding:content-id:
   content-description:resent-date:resent-from:resent-sender:
   resent-to:resent-cc:resent-message-id:in-reply-to:
   references:list-id:list-help:list-unsubscribe:
   list-subscribe:list-post:list-owner:list-archive;
  z=From:=20John=20Kristian=20<jkristian@linkedin.com>
   |Subject:=20git-svn=20with=20big=20subversion=20repositor
   y|Date:=20Wed,=202=20Mar=202011=2002:43:23=20+0000
   |Message-ID:=20<C992EE5B.CBFB%jkristian@linkedin.com>|To:
   =20"git@vger.kernel.org"=20<git@vger.kernel.org>
   |MIME-Version:=201.0|Content-Transfer-Encoding:=20quoted-
   printable|Content-ID:=20<CA8D7D3D741BF347AAB194C5360C3E4F
   @linkedin.co 
X-IronPort-AV: E=Sophos;i="4.62,251,1297065600"; 
   d="scan'208";a="21244455"
Received: from ESV4-EXC03.linkedin.biz ([fe80::985a:a6b4:f1e1:23b0]) by
 esv4-cas02.linkedin.biz ([172.18.46.142]) with mapi id 14.01.0251.000; Tue, 1
 Mar 2011 18:43:24 -0800
Thread-Topic: git-svn with big subversion repository
Thread-Index: AcvYg1ZGiSO4GnAk+0a6XdOy6VBU6w==
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Microsoft-Entourage/13.5.0.100510
x-originating-ip: [172.18.46.247]
Content-ID: <CA8D7D3D741BF347AAB194C5360C3E4F@linkedin.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168289>

How do you recommend using git to work with branches of a large, busy
subversion repository? In general, how can small teams use git for their
tasks, and use subversion to coordinate with a larger organization?

git-svn has some trouble, I find. For example, this tries to copy the entire
repo starting with revision 1:

git svn clone --stdlayout svn+ssh://server/repo/project

This would take weeks, I estimate for my subversion repository.

Choosing a subset of the repository enables git svn clone to cope, but then
git svn fetch will stall after processing a few revisions.  For example:

git svn clone --no-follow-parent --no-minimize-url \
 --branches=branches \
 --ignore-paths="^(?!branches/(TEAM_|RELEASE_))" \
 -r $BASE svn+ssh://server/repo/project
git svn fetch --no-follow-parent # stalls

I don't why it stalls. I guess it's doing something that requires processing
the entire subversion repository.

The best I can do is clone each subversion branch into a separate svn-remote
section of the .git/config file, for example:

git svn clone --no-follow-parent --no-minimize-url \
 --svn-remote=TEAM_FOO --id=TEAM_FOO \
 -r $BASE svn+ssh://server/repo/project/branches/TEAM_FOO
git svn fetch --no-follow-parent

The clone runs about as long as svn checkout, and the fetch replays the
later revisions briskly. Sadly, the relationship between branches isn't
fetched: git log won't tell me how a given subversion branch was copied from
another. I use svn for that.

I'm using git version 1.7.4, git-svn version 1.7.4 (svn 1.6.5), svn version
1.6.0 (r36650) and Mac OS X version 10.6.5. I got git from MacPorts.

- John Kristian
