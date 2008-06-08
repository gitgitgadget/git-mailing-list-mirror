From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Unfathomable merge conflict
Date: Sun, 08 Jun 2008 02:48:43 -0700
Message-ID: <7v63skl0jo.fsf@gitster.siamese.dyndns.org>
References: <19f34abd0806080057i7ddaff3exbf410879c5b7d031@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Vegard Nossum" <vegard.nossum@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jun 08 11:49:54 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K5HX7-0002HY-06
	for gcvg-git-2@gmane.org; Sun, 08 Jun 2008 11:49:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755858AbYFHJs7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Jun 2008 05:48:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755887AbYFHJs7
	(ORCPT <rfc822;git-outgoing>); Sun, 8 Jun 2008 05:48:59 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:33412 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755746AbYFHJs6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Jun 2008 05:48:58 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 1E94D3DA2;
	Sun,  8 Jun 2008 05:48:55 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 41DBE3DA1; Sun,  8 Jun 2008 05:48:52 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 1BC60628-3540-11DD-AA09-F9737025C2AA-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84260>

"Vegard Nossum" <vegard.nossum@gmail.com> writes:

> So in this specific case, I want to check out v2.6.25 of linux-2.6.git
> and re-apply all the changes that were made to the file
> net/mac80211/rc80211_pid_algo.c between v2.6.25 and v2.6.26-rc4.
>
> In order to determine which commits I need, I used the following command:
>
> $ git log --follow v2.6.25..v2.6.26-rc4 net/mac80211/rc80211_pid_algo.c

The commits given by that will contain ones that are based on the file
from a version way older than v2.6.25, which were merged to the history
after v2.6.25.

    $ git log -m --pretty=oneline --abbrev-commit v2.6.25..v2.6.26-rc4 -- \
      net/mac80211/rc80211_pid_algo.c
    2c8dccc... mac80211: rename files
    d0709a6... mac80211: RCU-ify STA info structure access
    902acc7... mac80211: clean up mesh code
    ee38585... mac80211: mesh data structures and first mesh changes
    6f48422... mac80211: remove STA infos last_ack stuff
    b7c50de... rc80211-pid: fix rate adjustment
    8318d78... cfg80211 API for channels/bitrates, mac80211 and driver conversion

8318d78 has diverged from the mainline way before v2.6.25, and there even
is another patch before v2.6.25 that was applied to the mainline:

    $ git log --pretty=oneline --abbrev-commit --left-right \
      8318d78...v2.6.25 -- net/mac80211/rc80211_pid_algo.c
    >1d60ab0... rc80211-pid: fix rate adjustment
    <8318d78... cfg80211 API for channels/bitrates, mac80211 and driver conversion

So it is _very_ natural that application of 8318d78 to v2.6.25 _will_
have conflicts that you would need to resolve.

All of the above was first merged into the mainline with 334d0945, which
is a merge of d1643d2 into d1a4be6.

An interesting experiment is to start from 334d0945 and revert the above
commits (only for the path you are interested in) in the reverse order:

    $ git checkout 334d0945
    $ for c in 2c8dccc d0709a6 902acc7 ee38585 6f48422 b7c50de 8318d78
      do git show --pretty=email -R $c -- net/mac80211/rc80211_pid_algo.c
      done | git am

Then, the difference between the result and v2.6.25 would show the fixup
you would need to squash into when you apply 8318d78, _if_ you trust what
Linus did when 334d0945 was made:

    $ git diff v2.6.25 -- net/mac80211/rc80211_pid_algo.c >P.diff

This looks as if 1d60ab0 is being reverted.  But the moral equivalent of
that patch is included as b7c50de in the history post v2.6.25, and that is
why the result is Ok.

If you apply P.diff on top of v2.6.25, then apply 8318d78 (only for the
path), and b7c50de (because it is redoing what you are reverting with
P.diff), that would be the forwarded-ported 8318d78 for v2.6.25.

    $ git checkout v2.6.25
    $ git show --pretty=email 8318d78 -- net/mac80211/rc80211_pid_algo.c |
      git am
    $ git reset --hard
    $ git apply --index P.diff
    $ git apply --index .dotest/patch
    $ git show b7c50de -- net/mac80211/rc80211_pid_algo.c |
      git apply --index
    $ git am --resolved

After that, remainder can be picked as before, but in the forward order:

    $ for c in 6f48422 ee38585 902acc7 d0709a6 2c8dccc
      do git show --pretty=email $c -- net/mac80211/rc80211_pid_algo.c
      done | git am

and the resulting net/mac80211/rc80211_pid_algo.c will match the one from
v2.6.26-rc4 exactly.
