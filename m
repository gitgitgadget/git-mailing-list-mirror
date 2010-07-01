From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH] Documentation: 'cherry' does not cope well with merges
 from upstream
Date: Thu, 1 Jul 2010 16:09:19 -0500
Message-ID: <20100701210919.GA4283@burratino>
References: <1278012954-sup-3724@pimlott.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git <git@vger.kernel.org>,
	=?iso-8859-1?B?RnLpZOlyaWMgQnJp6HJl?= <fbriere@fbriere.net>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Jeff King <peff@peff.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
To: Andrew Pimlott <andrew@pimlott.net>
X-From: git-owner@vger.kernel.org Thu Jul 01 23:10:54 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OUR25-0005Wf-Go
	for gcvg-git-2@lo.gmane.org; Thu, 01 Jul 2010 23:10:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932779Ab0GAVJw convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 1 Jul 2010 17:09:52 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:33900 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933009Ab0GAVJu (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Jul 2010 17:09:50 -0400
Received: by iwn7 with SMTP id 7so2445686iwn.19
        for <git@vger.kernel.org>; Thu, 01 Jul 2010 14:09:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=USRvEjdE/pDuJqkcci6aPhlqauHg9TBJ8z1EExG9DEI=;
        b=pjlhBrelFaAQYR+m2xIB930BsL5IyUIU+qf9L6ypVoNeMgUZD9eiwnNYOqLOhKwP+l
         P8LA3C2I7g7cV0eNSVlJtnM7Faeoz3g3DuRwwQ6mT3Mqjx0/iWuMVaAyAyI3AgHA2Jkq
         jUJ/y/+6WfUb+skNr8bziMuk4xgjTNDrX0rhE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=mF9sv5Drzt9CpRfdE654vY2p/WpVZ+riDkS6Y5MGB2iOqYGn6H8mmafo9IlRAyrX9r
         rdK+vtUdYjpUbjygdHjL1FnCutiUi9GbBh3j1cMCvZdgOZ14ggrVVAoU1XPOeG1/5z7p
         8Q6yuPUJbdCX1soyut7HJftZcZD2hlwxOPmUM=
Received: by 10.231.79.74 with SMTP id o10mr81105ibk.36.1278018588049;
        Thu, 01 Jul 2010 14:09:48 -0700 (PDT)
Received: from burratino (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id h8sm23698588ibk.3.2010.07.01.14.09.46
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 01 Jul 2010 14:09:47 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1278012954-sup-3724@pimlott.net>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150083>

Although =E2=80=98git cherry=E2=80=99 is advertised simply to list comm=
its from
<topic> that have not been merged into <upstream>, internally it
works by checking for patches in <upstream>..<topic> that do not
match a patch in <topic>..<upstream>.  This is fast because there
are not many patches to check, and it makes sense semantically
since even if a new patch patches an old patch from <upstream>,
it cannot be said to have been merged upstream unless it was
applied there at some point after the <topic> and <upstream>
branches diverged.

But.  If the <topic> branch later merges from <upstream>, it
throws a spanner in the works and for such a history =E2=80=98git cherr=
y=E2=80=99
is not very useful at all.

Example:

 o---o---F---X'---G---U [upstream]
          \        \
           X----Y---M---T [topic]

Suppose the author of the =E2=80=98topic=E2=80=99 branch starts from up=
stream
commit F and makes a few changes.  One is applied upstream, and
additionally there is some other useful upstream change, so he
performs a merge to include the upstream updates into topic.
The expected output from =E2=80=98cherry=E2=80=99 is:

 + T
 + Y
 - X

Consider the author of a different branch, also called =E2=80=98topic=E2=
=80=99, but
this one starts from commit G.  Some infrastructure from an existing=20
branch is needed, so first she merges that.  Then she adds her own
commit.  The expected output from =E2=80=98cherry=E2=80=99 is:

 + T
 + Y
 + X

since none of the new commits have been applied upstream since
the fork point.

=E2=80=98cherry=E2=80=99 cannot distinguish between these two cases, in=
 part because
it does not distinguish between parents in a merge commit.

Add a BUGS section to explain the problem.

Reported-by: Fr=C3=A9d=C3=A9ric Bri=C3=A8re <fbriere@fbriere.net>
Reported-by: Andrew Pimlott <andrew@pimlott.net>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
Hi Andrew,

Andrew Pimlott wrote:

> The documentation for git-cherry says it marks changes in the current
> checkout that have an "equivalent" change in the upstream branch.  It
> even says it's useful when feeding patches upstream by email instead =
of
> git, which is what I'm doing (with CVS instead of email).  But it
> doesn't seem to work for me.
[...]
>     ~/a% git commit -m 3
>     [master bb13e6c] 3
>      1 files changed, 1 insertions(+), 0 deletions(-)
>     ~/a% cd ../b
>     ~/b% git pull
[...]
>     ~/b% git cherry
>     + 551e90ac390a2a27152661b9cbe73845d237e008

I have not carefully read your example, but maybe this patch might help
explain it.  A correct solution for some cases might include a
=E2=80=98git cherry --full=E2=80=99 option that scans the full upstream=
 history for
equivalents to patches.

Thoughts?  Improvements?

 Documentation/git-cherry.txt |   15 +++++++++++++++
 1 files changed, 15 insertions(+), 0 deletions(-)

diff --git a/Documentation/git-cherry.txt b/Documentation/git-cherry.tx=
t
index fed115a..83e3bdc 100644
--- a/Documentation/git-cherry.txt
+++ b/Documentation/git-cherry.txt
@@ -59,6 +59,21 @@ OPTIONS
 <limit>::
 	Do not report commits up to (and including) limit.
=20
+BUGS
+----
+'git cherry' does not cope well with merges from upstream on the
+working branch.  Any commits after the original fork point and
+before the latest merge from upstream will be reported as not found
+in <upstream>.
+
+                       ____*____*____*_____*__> <upstream>
+                      /                     \
+   original fork point                       \
+                      \__+__+__+__+__+__+__+__*_> <head>
+
+While these commits are part of upstream..head, their upstream
+counterparts are not in head..upstream.
+
 SEE ALSO
 --------
 linkgit:git-patch-id[1]
--=20
1.7.1.1
