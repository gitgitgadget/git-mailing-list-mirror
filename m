From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Git's tests have depended on Perl since at least 2006
Date: Fri, 13 Aug 2010 21:25:10 +0000
Message-ID: <AANLkTim9aNtFdwM5m-FB_LWX96es2DR_9mU3rGcV4dME@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Aug 13 23:25:22 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ok1kd-0003zO-T8
	for gcvg-git-2@lo.gmane.org; Fri, 13 Aug 2010 23:25:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753520Ab0HMVZN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Aug 2010 17:25:13 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:45326 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753174Ab0HMVZK (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Aug 2010 17:25:10 -0400
Received: by iwn7 with SMTP id 7so197902iwn.19
        for <git@vger.kernel.org>; Fri, 13 Aug 2010 14:25:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:date:message-id
         :subject:from:to:content-type;
        bh=vD+Ze50ykcuYROkxZZrDpKI7++JMeaz37Cbcdtjp+0s=;
        b=lZZRBzog48G7R9Y58401Lo9hvw2a5zSWgxIU5uaKoNWL+323rZImtGexokcm8fLTSI
         JnVGwe5sX08wp2ybudrGoobatEBxP0zrv4jpXmTJirqPd40KUI0BZk/vkVL7i1433S0C
         stcenAped7biw+bEYSdX1MzY7z88i0/0n41AA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        b=VzpHueDMuG7aC3FqgV2KE26h2HsuYvYQP8XbNE32lPtRhffKCIeWYbJN1RWWutkRlW
         cYHboWkneMK412/OVWg1f8Y3faRS0xdtfFoiBdKaou5mtYZ5qirVEi+my69QJhpw9kTz
         6C11y8bm34kZsys0gp8odxlaNIxN4+W4y95nY=
Received: by 10.231.16.76 with SMTP id n12mr1944306iba.194.1281734710096; Fri,
 13 Aug 2010 14:25:10 -0700 (PDT)
Received: by 10.231.186.226 with HTTP; Fri, 13 Aug 2010 14:25:10 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153508>

This is just an interesting datapoint, but Git's test suite currently
crashes and burns if you don't have a perl in your $PATH, no matter if
you've compiled with NO_PERL=YesPlease or not. This has been the case
since at least 2006, or v1.3.0-rc1~13^2~34.

The affected tests are:

    ./t0000-basic.sh ./t0025-crlf-auto.sh ./t0080-vcs-svn.sh
    ./t0020-crlf.sh ./t1010-mktree.sh ./t1300-repo-config.sh
    ./t3300-funny-names.sh ./t4012-diff-binary.sh
    ./t4020-diff-external.sh ./t4014-format-patch.sh
    ./t4029-diff-trailing-space.sh ./t4031-diff-rewrite-binary.sh
    ./t4030-diff-textconv.sh ./t4043-diff-rename-binary.sh
    ./t4103-apply-binary.sh ./t4116-apply-reverse.sh ./t4200-rerere.sh
    ./t5303-pack-corruption-resilience.sh ./t5300-pack-object.sh
    ./t6011-rev-list-with-bad-commit.sh
    ./t6013-rev-list-reverse-parents.sh ./t6003-rev-list-topo-order.sh

I have a WIP patch series to tackle this issue:

    http://github.com/avar/git/compare/git:pu...in-progress-dont-depend-on-perl

It adds a PERL dependency to things and changes perl to
"$PERL_PATH". Many things were implicitly depending on perl due to
this bit in test-lib.sh:

    q_to_nul () {
        perl -pe 'y/Q/\000/'
    }

And many other bits do other things with perl but aren't declaring a
PERL dependency.

Anyway, I just thought I'd mention it, that this hasn't been fixed yet
would suggest that nearly everyone has perl anyway, and that maybe we
shouldn't think twice about introducing a perl dependency to things
when it's convenient.
