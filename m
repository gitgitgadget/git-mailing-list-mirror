From: =?utf-8?b?w5h5c3RlaW4=?= Walle <oystwa@gmail.com>
Subject: Re: [PATCH v2] stash: handle specifying stashes with spaces
Date: Sat, 30 Nov 2013 15:29:57 +0000 (UTC)
Message-ID: <loom.20131130T153012-412@post.gmane.org>
References: <87k3frdlwc.fsf@thomasrast.ch> <1385758845-8627-1-git-send-email-oystwa@gmail.com> <878uw6dha7.fsf@thomasrast.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Nov 30 16:30:25 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VmmUy-0000xO-Li
	for gcvg-git-2@plane.gmane.org; Sat, 30 Nov 2013 16:30:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752046Ab3K3PaV convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 30 Nov 2013 10:30:21 -0500
Received: from plane.gmane.org ([80.91.229.3]:59370 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751579Ab3K3PaU (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Nov 2013 10:30:20 -0500
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1VmmUs-0000qX-3r
	for git@vger.kernel.org; Sat, 30 Nov 2013 16:30:18 +0100
Received: from 80.156.189.109.customer.cdi.no ([109.189.156.80])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 30 Nov 2013 16:30:18 +0100
Received: from oystwa by 80.156.189.109.customer.cdi.no with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 30 Nov 2013 16:30:18 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 109.189.156.80 (Mozilla/5.0 (Windows NT 6.1; WOW64; rv:25.0) Gecko/20100101 Firefox/25.0)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238566>

Thomas Rast <tr <at> thomasrast.ch> writes:

> I wonder what we would lose by dropping the --symbolic in the line I
> quoted above (which is the second parsing pass), so that it resolves
> to a SHA1.  We would gain some robustness, as I'm not sure "$REV:"
> works correctly in the face of weird revision expressions like
> ":/foo".

If I drop --symbolic then all hell breaks loose. Removing it very
naively led to 29 failed tests. I managed to get that down quite a bit
though.

After the function ends $REV is supposed to expand to a symbolic
reference, and the test for whether the given argument is a valid stash
reference is to see if running `git rev-parse --symbolic-full-name
"${REV%@*}"` expands to 'refs/stash' or not. So we have to do both with
and without --symbolic and keep both around. For example `git stash
drop` had problems because git-reflog doesn't let you remove entries in
the log by SHA1:


    $ git reflog delete --updateref --rewrite $(git rev-parse stash@{0}=
)
    error: Not a reflog: 418af27beea220ad8a2fd3b8286959b1ec9c8852

I think a not entirely accurate but succinct way of putting it is that
if foo is a valid ref or valid entry in the reflog then

    git rev-parse --symbolic $(git rev-parse foo)=20

does *not* output 'foo' but the SHA1 of 'foo'. So we cannot simply
convert everything to hashes and proceed from there.

=C3=98sse
