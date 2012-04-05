From: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
Subject: Re: rebase -p loses amended changes
Date: Thu, 5 Apr 2012 09:16:54 -0700
Message-ID: <CAOeW2eHHW6de1qcnajV7DLzWyiSJyh+ZpMbhQU-1WKnRuSeNhg@mail.gmail.com>
References: <592E2EEC-6CBA-48D6-8D44-34A971DD78EC@gmail.com>
	<CAH3Anrqorf481jw6GdHqOPg9WC0rD-OraOHZ7twWRF4+oJ9X4A@mail.gmail.com>
	<87fwcpun95.fsf@thomas.inf.ethz.ch>
	<CAH3AnrpasFU2bLEZsAXRQu4U+=R_YyW+-yRXDfzy2JQpqf9dNw@mail.gmail.com>
	<CADb3U=4Y0njLiYC1qrYbdm+h0h8vLh78yfz_u3B6veEqCX0xCQ@mail.gmail.com>
	<CAH3Anrq_Z0V=DpU1iH-A3F8RFWTG0_C1hEe3iDZYe=AYDTRT3g@mail.gmail.com>
	<CABURp0pnXvnT2=fDJXk-yiGctsJBHiNGSCOZiT4Vo74woi0Zxg@mail.gmail.com>
	<4F7BEA9F.3060805@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Phil Hord <phil.hord@gmail.com>,
	Jon Seymour <jon.seymour@gmail.com>,
	J Robert Ray <jrobertray@gmail.com>,
	Thomas Rast <trast@student.ethz.ch>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Thu Apr 05 18:38:26 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SFphX-00069G-Lp
	for gcvg-git-2@plane.gmane.org; Thu, 05 Apr 2012 18:38:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754647Ab2DEQiS convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 5 Apr 2012 12:38:18 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:38197 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752324Ab2DEQiS convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 5 Apr 2012 12:38:18 -0400
Received: by pbcun15 with SMTP id un15so1735633pbc.19
        for <git@vger.kernel.org>; Thu, 05 Apr 2012 09:38:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=53D1vI5Pz+r/Ekg+pSokE/Pob5n0bj3y2FsTrb6ZMIg=;
        b=G0iOAyx4ZadOljOwUm172JFoTPA0yBXIRypwm7hsHv5lDm4VssiXREgfv7m6QcfoTd
         b7ojEoSoXHk5bigTl7aWmmnoZ9JMHLkX9Vv052yteygAP05qz2oF7INDHKVkImMIwhWA
         jKbMNsOx9CYqNvj6qFER8N7FucvXzaMhKj/GOZ6x2ueX2j8oSjT0DVxRVJ77YQr36CFM
         gLP9XyMqctAx6wpG9IK97HB1dH3HABuB8jjdn+0JXiYjJ5oHZVD3gZiha1S45D8sxCDT
         hoMIVXYKgfHObPhieZfplSWZQ39lwzhUbGHVm+11V0QTlU/bAq+91eNJuC3Aira9Xgc7
         ipHQ==
Received: by 10.68.230.41 with SMTP id sv9mr8249660pbc.72.1333642614374; Thu,
 05 Apr 2012 09:16:54 -0700 (PDT)
Received: by 10.68.224.97 with HTTP; Thu, 5 Apr 2012 09:16:54 -0700 (PDT)
In-Reply-To: <4F7BEA9F.3060805@viscovery.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194786>

On Tue, Apr 3, 2012 at 11:30 PM, Johannes Sixt <j.sixt@viscovery.net> w=
rote:
> IMO, it is a sub-optimal implementation of rebase -p that it attempts=
 to
> redo the merge. A better strategy is to just replay the changes betwe=
en
> the first parent and the merge commit, and then generate a new merge =
commit:
>
> =C2=A0 git diff-tree -p M^ M | git apply --index &&
> =C2=A0 git rev-parse M^2 > .git/MERGE_HEAD &&
> =C2=A0 git commit -c M
>
> This would side-step all the issues discussed here, no?

Maybe. How would it handle the following, though?

With this history

          .-e-.
         /     \
      .-c---d---f
     /
a---b---g

, "git rebase -p --onto g b f" produces


              .-e'.
             /     \
a---b---g---c'--d'--f'

If the merge was interactive (or was made interactive due to merge
conflicts), e'-c' (the diff between c' and e') might be very different
from e-c. Creating f' by replaying f-d on top of d' would lose any
changes done in e'-c' as compared to e-c, no?

Sorry I this has already been said or if I'm missing the point; I have
not been following the conversion completely.

Martin
