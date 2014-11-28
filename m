From: Jeff King <peff@peff.net>
Subject: tests do not work with gpg 2.1
Date: Fri, 28 Nov 2014 11:50:10 -0500
Message-ID: <20141128165009.GA4728@peff.net>
References: <xmqqr3wpo8yl.fsf@gitster.dls.corp.google.com>
 <20141127213224.GA27443@dispater.uplinklabs.net>
 <54784503.80108@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Steven Noonan <steven@uplinklabs.net>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Fri Nov 28 17:50:20 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XuOkN-0008A7-HZ
	for gcvg-git-2@plane.gmane.org; Fri, 28 Nov 2014 17:50:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751787AbaK1QuN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Nov 2014 11:50:13 -0500
Received: from cloud.peff.net ([50.56.180.127]:45938 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751166AbaK1QuK (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Nov 2014 11:50:10 -0500
Received: (qmail 22662 invoked by uid 102); 28 Nov 2014 16:50:10 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 28 Nov 2014 10:50:10 -0600
Received: (qmail 23533 invoked by uid 107); 28 Nov 2014 16:50:10 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 28 Nov 2014 11:50:10 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 28 Nov 2014 11:50:10 -0500
Content-Disposition: inline
In-Reply-To: <54784503.80108@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260370>

[updated subject, as this is not specific to the v2.2.0 release at all]

On Fri, Nov 28, 2014 at 10:48:51AM +0100, Michael J Gruber wrote:

> Are you running gnome_keyring_deamon by any chance? It think it runs by
> default in Gnome, claims to offer gpg_agent functionality but does not
> seem to do so fully. I.e., its presence may keep gpg2.1 from starting
> its own gpg-agent. But gpg2.1 ("gnupg modern branch") needs a new
> gpg-agent which knows how to handle secret keys for gpg2.1.
> 
> (I may take a shot at trying, but I'm on Fedora - they're slow and
> special in all things gpg/crypto. And compiling gpg2.1 means compiling
> all the bits and pieces that monster consists of these days...)

I'm not running the gnome daemon (I do normally run gpg-agent, though),
and I can reproduce.

I wanted to try experimenting today with making sure GPG_AGENT_INFO was
unset in the environment. But despite nothing changing (i.e., before I
even cleared that variable), I'm getting totally different results.

Now when I run t4202, I get no agent prompt, and just:

    ok 40 - dotdot is a parent directory
    
    expecting success: 
            test_when_finished "git reset --hard && git checkout master" &&
            git checkout -b signed master &&
            echo foo >foo &&
            git add foo &&
            git commit -S -m signed_commit &&
            git log --graph --show-signature -n1 signed >actual &&
            grep "^| gpg: Signature made" actual &&
            grep "^| gpg: Good signature" actual
    
    Switched to a new branch 'signed'
    gpg: skipped "C O Mitter <committer@example.com>": No secret key
    gpg: signing failed: No secret key
    error: gpg failed to sign the data
    fatal: failed to write commit object

And then a subsequent run gives me:

    rm: cannot remove '/home/peff/compile/git/t/trash directory.t4202-log/gpghome/private-keys-v1.d/19D48118D24877F59C2AE86FEC8C3E90694B2631.key': Permission denied
    rm: cannot remove '/home/peff/compile/git/t/trash directory.t4202-log/gpghome/private-keys-v1.d/E0C803F8BC3BCC4990E174E05936A7636E888899.key': Permission denied
    rm: cannot remove '/home/peff/compile/git/t/trash directory.t4202-log/gpghome/private-keys-v1.d/FCFAC48BF12AC0FCC32B69AB90AA7B1891382C29.key': Permission denied
    rm: cannot remove '/home/peff/compile/git/t/trash directory.t4202-log/gpghome/private-keys-v1.d/D50A866904B91C0C49A3F6059584F4A09807D330.key': Permission denied
    FATAL: Cannot prepare test area

It seems that it creates the private-keys directory without the 'x' bit:

    $ ls -ld trash*/gpghome/private-keys-v1.d
    drw------- 2 peff peff 4096 Nov 28 11:45 trash directory.t4202-log/gpghome/private-keys-v1.d/

So that's weird, and doubly so that it is behaving differently than it
was last night. Obviously _something_ must have change. Maybe something
related to the state of my running agent, I guess.

-Peff
