From: Jacob Godserv <jacobgodserv@gmail.com>
Subject: git-svn aborts with "Use of uninitialized value $u" when a
 non-svn-backed branch is present in remote
Date: Tue, 22 Sep 2015 14:48:41 -0400
Message-ID: <CALi1mtc8zmOzk-qv4XAg6N=ENasnMAENdJSLHK7EcpxRUk1nTw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 22 20:48:59 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZeScY-0006lb-3y
	for gcvg-git-2@plane.gmane.org; Tue, 22 Sep 2015 20:48:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934347AbbIVSsp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Sep 2015 14:48:45 -0400
Received: from mail-la0-f50.google.com ([209.85.215.50]:33563 "EHLO
	mail-la0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934342AbbIVSsn (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Sep 2015 14:48:43 -0400
Received: by lahh2 with SMTP id h2so138995lah.0
        for <git@vger.kernel.org>; Tue, 22 Sep 2015 11:48:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=zDNAWL10D0OVyRcoAB5vRx63Uowf74dUyN37MxQp9co=;
        b=hzqSJSPaiLsO3x4XrtqqMDe3OyJSBlA5TMvNLVi0nMEttO2OHFNaDdTHeWXRQbMyMN
         WRKLDacNsdD1JkSjxrXQ42HxAKyM6DAN8x4GMgrwnup2y0RNa+Hy+hHfZLuLQOv5BHrS
         e5rKKwwK+5J3OZ2iimAmGefRw8pN5PhI7V8twooXPBfeOJHIze/i2CHfEQeElgUuoKzo
         bLMjMSsWL4pXOmuacj49MKIOmNX37uclp8GHhHSJKMPMB+kL7O+j83UszWjeajq4X11b
         IJUgNo/jNnfLq88+JFusvjPZdStZ8+AYmidyrvxRhGUZwylIyHLMA1cBcI5E8Tx7F2sg
         aFYQ==
X-Received: by 10.152.3.233 with SMTP id f9mr10415226laf.14.1442947721245;
 Tue, 22 Sep 2015 11:48:41 -0700 (PDT)
Received: by 10.112.7.133 with HTTP; Tue, 22 Sep 2015 11:48:41 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278417>

I found a specific case in which git-svn improperly aborts:

1. I created a git-svn repository, named "git-svn repo", by cloned an
svn repository via the git-svn tool.
2. I created a normal git repository, named "configuration repo". I
renamed the master branch to "configuration". The initial commit adds
a README and some utility scripts.
3. I created a bare repository, named "master repo".
4. I pushed from the git-svn repo to the master repo.
5. I pushed from the configuration repo to the master repo.

The idea is the configuration branch, which is detached from any
git-svn history, can contain some useful tools, defaults, etc., that I
can share with teammates who want to use git on this svn project. It's
an odd use of git, but it has been working well.

However, a vanilla distribution of Git for Windows 2.5.2 produces the
following error when running any git-svn command, such as "git svn
info", on the cloned master repo:

Use of uninitialized value $u in substitution (s///) at
/mingw64/share/perl5/site_perl/Git/SVN.pm line 105.
Use of uninitialized value $u in concatenation (.) or string at
/mingw64/share/perl5/site_perl/Git/SVN.pm line 105.
refs/remotes/origin/configuration: 'svn+ssh://10.0.1.1/repos/projectA'
not found in ''

In the mentioned SVN.pm file, after the line:

                        my $u = (::cmt_metadata("$refname"))[0];

I added the following four lines:

                        if (not defined $u) {
                                warn "W: $refname does not exist in
SVN; skipping";
                                next;
                        }

git-svn appears to operate correctly with this patch. This is my first
time ever editing a perl script, so I apologize if I murdered an
adorable animal just now.

I'm sending this in so more knowledgeable git-svn developers can
comment on this and fix this in the official distribution of git,
assuming there is a bug here to fix.

-- 
    Jacob
