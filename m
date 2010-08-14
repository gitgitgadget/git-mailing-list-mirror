From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: [BUG RFC/PATCH] git-cvsimport
Date: Sat, 14 Aug 2010 15:33:07 +0000
Message-ID: <AANLkTikxxqgNpmqfFQq+5GVd7VAW2DTaro5anRHcx6Tt@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Git Mailing List <git@vger.kernel.org>,
	Martin Langhoff <martin@catalyst.net.nz>
X-From: git-owner@vger.kernel.org Sat Aug 14 17:33:15 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OkIjS-0007Ue-UV
	for gcvg-git-2@lo.gmane.org; Sat, 14 Aug 2010 17:33:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756803Ab0HNPdJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 14 Aug 2010 11:33:09 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:38064 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754539Ab0HNPdI (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Aug 2010 11:33:08 -0400
Received: by gwj17 with SMTP id 17so433621gwj.19
        for <git@vger.kernel.org>; Sat, 14 Aug 2010 08:33:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:date:message-id
         :subject:from:to:content-type;
        bh=8kR/GHBEn7YvZaiPZ5c26rKrXJfRqlYereCPexABoNk=;
        b=jJlV9d8T5owcxvqutFasyrsEJic1+x+6zvfRDVP8ocWe/EIRdsInJChWHksEyDk4I9
         lBAK80Ckr6g1z757JhQMO8c41iMLsNBDSfQVVT0pMcfs+pGwsUZut2pUvu9cQ4g2/JXS
         9odYlQgWBtk45/6BzQMwfj8KtJ8KKuK57QSFI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        b=OpFaCg8iGx6TXWj1Zip1UmqmRdxqYXQoAlyRMmRu12zU4px5bU9i+/dd4FwSkKp8L6
         /n8p8UKnAI2m2dlNksDxGBB84Ozk75gCjCsoguipQyTBTRDxiBCz7GLevUywUftRPf6l
         jWO+icGMTe/BUpBsVVU2/nZJUZKp4aZ/x9qoo=
Received: by 10.231.32.75 with SMTP id b11mr3022132ibd.162.1281799987316; Sat,
 14 Aug 2010 08:33:07 -0700 (PDT)
Received: by 10.231.186.226 with HTTP; Sat, 14 Aug 2010 08:33:07 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153564>

This is more of a BUG than a RFC/PATCH.

Now that Junio has applied my patch to not write test results under
harness I can:

    sudo chown -R root t

And run the tests with --root=/dev/shm under prove, except for 3
git-cvsimport tests. I have pending patches to these, after they'll
get in I'll fix that.

But the reason they hang is interesting:

    rm -rf /tmp/meh;
    git init /tmp/meh &&
    cd /tmp/meh &&
    sudo chown -R root /home/avar/g/git/t/t9601/cvsroot &&
    cvsps --norc -q --cvs-direct -u -A --root
/home/avar/g/git/t/t9601/cvsroot module
    Initialized empty Git repository in /tmp/meh/.git/

cvsps will just hang due to the unfriendly chmod. Maybe we want
something like the below to deal with that.

However, even then it'll still hang on something else, I haven't
looked into what. I'm just going to fix this by having it copy the
things it needs to the --root directory.

 git-cvsimport.perl |   21 +++++++++++++++++++--
 1 files changed, 19 insertions(+), 2 deletions(-)

diff --git a/git-cvsimport.perl b/git-cvsimport.perl
index 9e03eee..1a93fb4 100755
--- a/git-cvsimport.perl
+++ b/git-cvsimport.perl
@@ -688,8 +688,25 @@ unless ($opt_P) {
        }
        ($cvspsfh, $cvspsfile) = tempfile('gitXXXXXX', SUFFIX => '.cvsps',
                                          DIR => File::Spec->tmpdir());
-       while (<CVSPS>) {
-           print $cvspsfh $_;
+       # Alarm because "cvsps --norc -q --cvs-direct -u -A --root
+       # /home/avar/g/git/t/t9601/cvsroot module" will hang forever if
+       # the "t9601/cvsroot" directory isn't writable by us.
+       {
+               my $got_input;
+               my $start = time;
+               local $SIG{ALRM} = sub {
+                       unless ($got_input) {
+                               die sprintf "cvsps left us hanging for
%d seconds, do you have permission to write to %s?",
+                                   time() - $start,
+                                   $opt_d;
+                       }
+               };
+               alarm 10;
+               while (<CVSPS>) {
+                       $got_input = 1;
+                       print $cvspsfh $_;
+               }
+               alarm 0;
        }
        close CVSPS;
        $? == 0 or die "git cvsimport: fatal: cvsps reported error\n";
