From: Sitaram Chamarty <sitaramc@gmail.com>
Subject: [ANNOUNCE] gitolite now has github-like "forking"
Date: Sun, 25 Apr 2010 15:03:10 +0530
Message-ID: <h2x2e24e5b91004250233i22d4b66ew5efabb6ef6492e74@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: gitolite <gitolite@googlegroups.com>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Apr 25 11:33:34 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O5yDQ-0006qF-Uo
	for gcvg-git-2@lo.gmane.org; Sun, 25 Apr 2010 11:33:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752726Ab0DYJdM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 25 Apr 2010 05:33:12 -0400
Received: from mail-vw0-f46.google.com ([209.85.212.46]:44373 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752186Ab0DYJdL (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Apr 2010 05:33:11 -0400
Received: by vws17 with SMTP id 17so837799vws.19
        for <git@vger.kernel.org>; Sun, 25 Apr 2010 02:33:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:date:message-id
         :subject:from:to:content-type;
        bh=xNj5UIEiK2NlcqDI8gSCjM6hKdjH+4SyAOoYiZGps9M=;
        b=m4yBovyagYhR4HlCPZkl7LBGCP8IJgDhr/BniUGEM8s5QWhlgRb4RIf2eMMUV7ET0V
         Je8ltVLzZmlDGnRXsYOeSsi3QQ5nB0X2I4pprhIoq7HoPa/zJPTHS1/PH/P2N+74JUbh
         AwRzZ8Gathtw0hImXMjS2H2TJFs/7OLb3/nbA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        b=Y8MYtZmi3BAEzxVo6Rg12VfscTT1XLETMtGly/8MEAwK/5cNoQcQaZC8e2PDBsGGJR
         MhnzEmVqhXEHjMI8ah96hdCQH2tKgX02VpKtJO/Jkq5rD/kmmtnCU5z4Cn5FvtZGrU5D
         LwLUF3oQxCC7QkSeO8dRb+yxRpiSyVIJuHY8Q=
Received: by 10.220.158.72 with SMTP id e8mr1582659vcx.47.1272187990158; Sun, 
	25 Apr 2010 02:33:10 -0700 (PDT)
Received: by 10.220.76.196 with HTTP; Sun, 25 Apr 2010 02:33:10 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145734>

Hello,

[I'm sending this to the larger git community because I'd like to hear
from people interested in this sort of functionality and willing to help
me test it].

Gitolite's current "pu" branch has acquired some features by which it
can now be used to do things like the "fork" operation of github (and
presumably other similar services).  Gitolite will never be web-based,
or GUI, etc., so it's not even remotely in the same class as github but
for some urgent, simple, needs this can be used to emulate forking
repositories a la github.

What follows is a very short howto, for the curious.  It assumes some
knowledge of basic gitolite usage only because I didn't want to make
this too lengthy; feel free to ask if needed.

Admin tasks (one time):

  * use the "pu" branch; the current tip is the commit called "(adc)
    documentation".  "adc" stands for "admin-defined commands"

  * install it, then edit `~/.gitolite.rc` on the server to
    uncomment/update the following lines as shown (or similar):

        $GL_WILDREPOS = 1;
        $GL_ADC_PATH = "/home/git/adc"; # or any convenient directory

  * copy the files from contrib/adc in the gitolite source to the above
    path on the server.

  * add the following lines to the default gitolite.conf that the
    install gives you:

        repo CREATER/.+
            C       =   @all
            RW+     =   CREATER
            RW      =   WRITERS
            R       =   @all

    All repos created now are public-readable by default.  Replace the
    "@all" in the last line with "READERS" if you want the repos to be
    private by default.

User tasks:

This is how users would use it, once their pubkeys have been added to
the keydir/ and pushed as usual.  We assume this is being done from
user "alice"'s account.

Creating a new repo on the server:

    git clone git@server:alice/foo
        # create and clone an empty repo to start working
    git push [--all] git@server:alice/foo [refspec]
        # or, create and push from an existing repo in one shot

Removing an existing repo that you no longer need (be careful!):

    ssh git@server rmrepo alice/foo

Listing all repos you have access to (will show yours as well as others'
repos that you have been given access to):

    ssh git@server expand [optional-pattern]

Forking user "bob"'s "bar" repo (assuming you have at least read access):

    ssh git@server fork bob/bar alice/bar

Setting permissions for a repo you own:

    ssh git@server setperms alice/bar
    RW bob
    R eve mallory
    <ctrl-d>

Getting permissions for a repo you own:

    ssh git@server getperms alice/bar
    # prints:
    RW bob
    R eve mallory

I'm rather pleased that, after a refactoring of the "query rights" code
that was useful by itself anyway, this feature only added about 25 lines
to the core code.  Many thanks to Eli for sparking this whole thing off.

If anyone else wants to help me test it, I'd very grateful.  Details at
http://github.com/sitaramc/gitolite/blob/pu/doc/admin-defined-commands.mkd

-- 
Sitaram
