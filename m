From: Elijah Newren <newren@gmail.com>
Subject: git fast-export issue -- anyone know if this is a bug or a feature?
Date: Sun, 8 Feb 2009 22:31:50 -0700
Message-ID: <51419b2c0902082131o512e966l1fb3029c7513b02e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Feb 09 06:33:22 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LWOlj-0000pP-Pa
	for gcvg-git-2@gmane.org; Mon, 09 Feb 2009 06:33:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751607AbZBIFbx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Feb 2009 00:31:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751579AbZBIFbw
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Feb 2009 00:31:52 -0500
Received: from mail-gx0-f21.google.com ([209.85.217.21]:49361 "EHLO
	mail-gx0-f21.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750983AbZBIFbw (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Feb 2009 00:31:52 -0500
Received: by gxk14 with SMTP id 14so1580163gxk.13
        for <git@vger.kernel.org>; Sun, 08 Feb 2009 21:31:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:content-type:content-transfer-encoding;
        bh=RHOukVZokYNz/5Vkx/n+mbGpT7DosH5spdFDRJBZeHk=;
        b=wY8TGlQpIPM/ADhexzUps351YIWtA0vGlA8adsALsz4HCWvH+s+SfSGI1wOte0v+0o
         LN86aY4lEnOn4zdl2b5K+kV7zuJnKd/IH4DN3gjxbDtLipZDky5w6pC7SDQe4sImv1dE
         nkd4KjGayx0fI3Q5I6Bw2q86uBMHqL+zEnvZA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        b=oWMJquc/jzxbFK7dQbfBmH1I6YTu17t0LwrCjX+8RaJcl4tXoOvWJu/f60Ck6Z4suq
         UwMc/pRzMReqTMhIXWOBRQDjaKVKJmHHnRXnQeFsbV3OLF7659bmDwJ/lzS5HGC9sGTC
         4NdohAoNPEpNeGDYQ2uTeohlVMaw/d9uGjM3g=
Received: by 10.151.111.15 with SMTP id o15mr1587281ybm.214.1234157510699; 
	Sun, 08 Feb 2009 21:31:50 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109046>

Hi,

The git-fast-export manpage, under the first example, says that
$ git fast-export --all | (cd /empty/repository && git fast-import)
should create a one-to-one mirror of the source repository (other than
reencoding commits that are not in UTF-8).

Either I am misunderstanding this comment, or it's not quite true:
while I've gotten identical mirrors using this recipe with most
repositories I have tried, I have one which shows some changes under
this process.  The changes I noticed are that, for example, the master
branch has fewer commits in the "mirrored" repository than the source
one, and that the history of commits has changed. (The content at the
heads of all branches do match, so the changes seem restricted to the
history of obtaining that content).  Unfortunately, (a) this
repository is pretty unwieldy, (b) I can't share it, and (c) it's
defied my attempts so far to find a small reproducible testcase.
However, from what I have found, it looks like this could be a
feature, because I actually like one of the changes I noticed so far.

The "source" repository is one that has been created by cvs2git (which
operated on a franken cvs repository munged together from lots of
different places; I'm running git-fast-export & git-fast-import based
on it since I want to do some extra changes outside of cvs2git).  In
the source repository, I noticed that 6 of the earliest commits in one
root of history looked like:

     /--E
    /  /
A--C--D
  /
 B

In the "mirrored" repository, I notice this history had been modified
so that it looked like

        E
       /
A--C--D
  /
 B

The latter history seems much more sane to me; since D is a child of
C, making E a merge of C and D seemed really weird.  I did pour over
the output of git fast-export --all to see if the merge directives
were as expected, in order to see whether git fast-export or git
fast-import were to be credited with the history fix.  It looks to me
like git-fast-export reports no merge parents for E, so this seems to
be on the fast-export side.

Is this, by chance, intentional?  (I'm using git-1.6.0.6, if it matters.)

Thanks,
Elijah
