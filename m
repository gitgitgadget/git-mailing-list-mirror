From: James Blackburn <jamesblackburn@gmail.com>
Subject: git log --follow doesn't follow a rename over a merge
Date: Wed, 15 Jun 2011 23:41:50 +0100
Message-ID: <BANLkTimjEp0ntq80qttT9uZN2YGuhsnZBw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 16 00:42:02 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QWyme-0003aA-V3
	for gcvg-git-2@lo.gmane.org; Thu, 16 Jun 2011 00:42:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753573Ab1FOWlv convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 15 Jun 2011 18:41:51 -0400
Received: from mail-qw0-f46.google.com ([209.85.216.46]:39646 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752101Ab1FOWlu convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 15 Jun 2011 18:41:50 -0400
Received: by qwk3 with SMTP id 3so443304qwk.19
        for <git@vger.kernel.org>; Wed, 15 Jun 2011 15:41:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:date:message-id:subject:from:to
         :content-type:content-transfer-encoding;
        bh=u8XLAsn9sZV7VdSZE01Rm2yGC6Zu3bqYE+0yErjC2Dc=;
        b=Ejh9PLDIEeXC5baYfpcFMVmBRPrHq8LYyJEJ1rrN4EymJxZt42J5eUDb5gFjLRivFH
         jn/AQimh9XqmMz4piG64M50HVIEa5NLviO+mtXa1wuhOIVO6UPq9LhU75A0sNjlHH4Bl
         6tkzAIH+gJhISH+URdLw1NzOEtUWqZzPYO8A8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        b=V1JwyeTliVx4gNT9PePGGQT+caEGJCIsbZAW+viRp5wvHaqIH+g2y1H4VIT+pZg6mn
         P1bt++XtWxDrKpiPY+x/SgGUI1wQmj5jI9dNLUVLEGkaVhkNNEjW1m0lPxic5c+FhkAg
         EJQFFWzsnxxAqT7NRs9w0i7O0QYTlzVgLfHKY=
Received: by 10.229.111.98 with SMTP id r34mr218101qcp.3.1308177710114; Wed,
 15 Jun 2011 15:41:50 -0700 (PDT)
Received: by 10.229.214.203 with HTTP; Wed, 15 Jun 2011 15:41:50 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175864>

Hi All,

I'm trying, without success, to get git log to show the history of a
file across a rename. =A0I'm using=A0git version 1.7.5.4, and git blame
has no such issues tracking the source of the lines.

This is part of a CVS migration. =A0In the repo a number of directories
were committed atomically, but they originated from another CVS
repository. =A0During the migration, I've grafted the history from the
originating repository onto the destination repo's commit of the
content. =A0Blame looks good, but log won't find the rename.

Git blame attributes 3 files:
> git blame dsf/org.eclipse.cdt.dsf/src/org/eclipse/cdt/dsf/debug/servi=
ce/IBreakpoints.java | awk '{print $2}' |sort |uniq
dsf/org.eclipse.cdt.dsf/src/org/eclipse/cdt/dsf/debug/service/IBreakpoi=
nts.java
plugins/org.eclipse.dd.dsf/src/org/eclipse/dd/dsf/debug/IBreakpoints.ja=
va
plugins/org.eclipse.dd.dsf.debug/src/org/eclipse/dd/dsf/debug/service/I=
Breakpoints.java

Git log shows:
> git log --oneline dsf/org.eclipse.cdt.dsf/src/org/eclipse/cdt/dsf/deb=
ug/service/IBreakpoints.java
70237c3 Bug 315439 Fix up copyright
6a53ab4 [290074] - [services][breakpoints] IBreakpointDMData interface
should extend IDMData
640102e partial fix for Bugzilla 265882
5b47187 Migrated DSF and DSF-GDB to the CDT project.

And it shows one fewer if I turn on --follow (with as many
combinations of -M -C as I've tried):
> git log -M -C -C --follow =A0--oneline dsf/org.eclipse.cdt.dsf/src/or=
g/eclipse/cdt/dsf/debug/service/IBreakpoints.java
70237c3 Bug 315439 Fix up copyright
6a53ab4 [290074] - [services][breakpoints] IBreakpointDMData interface
should extend IDMData
640102e partial fix for Bugzilla 265882

My new merge commit is=A05b47187 (when the content first arrived in the=
 repo):
>=A0git show 5b47187
commit 5b471873662a87a77cfd854c98fca9c9948aa878
Merge: 4709306 c1e6da2
=2E..

I can see the file in the parent of the merge:
> git show c1e6da2:plugins/org.eclipse.dd.dsf.debug/src/org/eclipse/dd/=
dsf/debug/service/IBreakpoints.java
=2E..
and the renamed file after the merge:
> git show=A05b47187:dsf/org.eclipse.cdt.dsf/src/org/eclipse/cdt/dsf/de=
bug/service/IBreakpoints.java
=2E..
(Neither file exists on the 4709 side)

Interestingly the tricks mentioned here
(http://stackoverflow.com/questions/953481/restore-a-deleted-file-in-a-=
git-repo)
for working out where a file was removed, produce no output:
> git log --follow --diff-filter=3DD --oneline -- plugins/org.eclipse.d=
d.dsf.debug/src/org/eclipse/dd/dsf/debug/service/IBreakpoints.java
> git rev-list -n 1 HEAD -- plugins/org.eclipse.dd.dsf.debug/src/org/ec=
lipse/dd/dsf/debug/service/IBreakpoints.javaJB

But log does work for the file if follow is specified (output with
--diff-filter is empty...):
> git log --follow --oneline -- plugins/org.eclipse.dd.dsf.debug/src/or=
g/eclipse/dd/dsf/debug/service/IBreakpoints.java
10580b5 Updated copyright statements.
17585c3 [218577] Cleaned up IBreakpoints interface.
=2E..

Have I done something wrong in grafting history like this, or is this
just a problem with the way git log --follow tracks renames?

The repo's here if anyone's interested (it's 85M...):
git://github.com/jamesblackburn/org.eclipse.cdt

Many thanks for any insight.
Cheers,
James
