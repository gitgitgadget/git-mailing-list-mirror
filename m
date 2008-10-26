From: "Mikael Magnusson" <mikachu@gmail.com>
Subject: Weird problem with long $PATH and alternates (bisected)
Date: Sun, 26 Oct 2008 15:46:39 +0100
Message-ID: <237967ef0810260746w10e930c1sf36a2674f49afbe1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <gitster@pobox.com>
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Oct 26 15:47:59 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ku6uL-0001RN-Vd
	for gcvg-git-2@gmane.org; Sun, 26 Oct 2008 15:47:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753197AbYJZOqp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 26 Oct 2008 10:46:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752826AbYJZOqo
	(ORCPT <rfc822;git-outgoing>); Sun, 26 Oct 2008 10:46:44 -0400
Received: from nf-out-0910.google.com ([64.233.182.186]:57423 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752471AbYJZOqo (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 26 Oct 2008 10:46:44 -0400
Received: by nf-out-0910.google.com with SMTP id d3so529447nfc.21
        for <git@vger.kernel.org>; Sun, 26 Oct 2008 07:46:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:mime-version:content-type:content-transfer-encoding
         :content-disposition;
        bh=msuBiDtCCFfl5A2upN5zShnoLX8TUqxw3p//bKFAX44=;
        b=G7h6J4g6o5YXHmmuIADh37GQGIgjpFLFCBMrSqDtKK6zIBzfb99dVRliWOoATRakhJ
         2H2zqsXqLnhqGVOjE5sk8I0FAvbm+Vl4FuUL2XOuTF2pN5knirgL1LlMN9iPk/ALMYfe
         qYDkwf5TX27V5Xj2fbTjtjo/uOMhNu1fAaVbc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:mime-version:content-type
         :content-transfer-encoding:content-disposition;
        b=XGBlMXx4Lcm4fnkruuj23Cbd6z2Yd+A3MIqjuoleUEcC12rLaHQe9dA7YaIXSz466A
         pWcP256442R033QYVwtuYXmmOwb55hvdWx60AkZaBJIEpqpFHPtqHJvL8LCjxv2ET8wt
         d6aaxw4cSX98wukuFenaYd50lmJZl3cL6u5k0=
Received: by 10.210.81.3 with SMTP id e3mr623806ebb.112.1225032399546;
        Sun, 26 Oct 2008 07:46:39 -0700 (PDT)
Received: by 10.210.73.14 with HTTP; Sun, 26 Oct 2008 07:46:39 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99165>

% mkdir 1; cd 1
% echo > a; git add a; git commit -m a
% cd ..
% git clone -s 1 2
% git push . master:master
fatal: Could not switch to
'/tmp/a/1/.git/objects/n:/usr/games/bin:/usr/local/ipod-chain'
fatal: The remote end hung up unexpectedly
% PATH=/bin:/usr/bin git push . master:master
Everything up-to-date

The same thing happens if i try to push from 1 to 2:
% cd ../1
% git push ../2
fatal: Could not switch to
'/tmp/a/1/.git/objects/n:/usr/games/bin:/usr/local/ipod-chain'
fatal: The remote end hung up unexpectedly

% echo $#PATH
196
% echo $PATH
/home/mikaelh/bin:/opt/bin:/usr/local/bin:/usr/bin:/bin:/usr/local/sbin:/usr/sbin:/sbin:/usr/i686-pc-linux-gnu/gcc-bin/4.2.4:/usr/kde/3.5/bin:/usr/qt/3/bin:/usr/games/bin:/usr/local/ipod-chain/bin

d79796bcf05b89774671a75b3285000c43129823 is first bad commit
commit d79796bcf05b89774671a75b3285000c43129823
Author: Junio C Hamano <gitster@pobox.com>
Date:   Tue Sep 9 01:27:10 2008 -0700

    push: receiver end advertises refs from alternate repositories

    Earlier, when pushing into a repository that borrows from alternate object
    stores, we followed the longstanding design decision not to trust refs in
    the alternate repository that houses the object store we are borrowing
    from.  If your public repository is borrowing from Linus's public
    repository, you pushed into it long time ago, and now when you try to push
    your updated history that is in sync with more recent history from Linus,
    you will end up sending not just your own development, but also the
    changes you acquired through Linus's tree, even though the objects needed
    for the latter already exists at the receiving end.  This is because the
    receiving end does not advertise that the objects only reachable from the
    borrowed repository (i.e. Linus's) are already available there.

    This solves the issue by making the receiving end advertise refs from
    borrowed repositories.  They are not sent with their true names but with a
    phoney name ".have" to make sure that the old senders will safely ignore
    them (otherwise, the old senders will misbehave, trying to push matching
    refs, and mirror push that deletes refs that only exist at the receiving
    end).

    Signed-off-by: Junio C Hamano <gitster@pobox.com>

:100644 100644 6d6027ead17b86519d69c3dfc9b98c01e916d277
45e3cd90fd476cdb0a32e5de27739b18e060e031 Mbuiltin-receive-pack.c
:100644 100644 98a742122dbacbb39fa104cdfe909a9a884ed7b6
99af83a0479ef472078afcd288b1f6ba6283a2f0 Mcache.h
:100644 100644 ae550e89c0942bb9e34b252b653c40e869a074a4
12be17b5dace07a2ca71613e4e9093cdb77492ac Msha1_file.c


-- 
Mikael Magnusson
