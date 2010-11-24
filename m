From: Dun Peal <dunpealer@gmail.com>
Subject: Re: Inexplicably deteriorating performance of Git repositories on Windows
Date: Wed, 24 Nov 2010 21:00:57 +0000
Message-ID: <AANLkTi=X724OJgUvG0Ggu3OwxyaJprr9CLL+t+x=MbTO@mail.gmail.com>
References: <AANLkTimTh7ka21inpovM=qqdWs6j2OcPXVsFh_CMiZ7N@mail.gmail.com>
	<AANLkTikXkWvHrc7=FjePfX5WyyNF1U=KH2DBCU+CcVu6@mail.gmail.com>
	<AANLkTimky3Ojc5w3PcCoJOs=NMfMpgUWUDcx+ry6h1dF@mail.gmail.com>
	<AANLkTim-1uKTVacr1N=9bhZ+=ngggrJS=GD-YNjkSuBR@mail.gmail.com>
	<4CED488A.2070507@workspacewhiz.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Tay Ray Chuan <rctay89@gmail.com>,
	Wilbert van Dolleweerd <wilbert@arentheym.com>,
	Git ML <git@vger.kernel.org>
To: Joshua Jensen <jjensen@workspacewhiz.com>
X-From: git-owner@vger.kernel.org Wed Nov 24 22:01:06 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PLMSf-0004RO-Mv
	for gcvg-git-2@lo.gmane.org; Wed, 24 Nov 2010 22:01:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756268Ab0KXVA7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Nov 2010 16:00:59 -0500
Received: from mail-qy0-f174.google.com ([209.85.216.174]:53661 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755749Ab0KXVA7 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Nov 2010 16:00:59 -0500
Received: by qyk11 with SMTP id 11so4844834qyk.19
        for <git@vger.kernel.org>; Wed, 24 Nov 2010 13:00:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=lG21DIUTLILCR0m/YhcQohFPW3KNj5GbXq1NWcyewbE=;
        b=ZPiybRWrQBSIhACyAIbz+chfKI9G+fp1OZCv55sUZUfhNcnmMQCy/mA2l1blBU1BZT
         DtAcO/unc6OlpOHCQx7PHgZpf0AWmNDTDCCIFbBkFL49qdtG/C8i4UuTkn58lOcVb2Yt
         TW4Eeuyn8pfodzHuUHKNl0M+1vK6IlTgQoVMY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=cORfkJcBb98Ehe9baolb8RPmqbTY1iDC+L2/LikzZl1R5QSeVzj4njTnhch/MqNDXx
         KzYIPOb3XHnIn0E/dc/kauXv/T82jmKuqakAihpla2GErEKj21PAMmEpm/82n+oMMv8U
         RCxk0bWCLZ3gWGqNyWrHpKz/rHypPGCekR+Js=
Received: by 10.229.215.213 with SMTP id hf21mr7999634qcb.189.1290632457987;
 Wed, 24 Nov 2010 13:00:57 -0800 (PST)
Received: by 10.220.186.198 with HTTP; Wed, 24 Nov 2010 13:00:57 -0800 (PST)
In-Reply-To: <4CED488A.2070507@workspacewhiz.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162085>

On Wed, Nov 24, 2010 at 5:16 PM, Joshua Jensen
<jjensen@workspacewhiz.com> wrote:
> Whenever I want to know exactly what is going on with disk access, I
> download Process Monitor from http://sysinternals.com/.
>
> In order to just show disk access, I filter entries that begin with TCP,
> UDP, and Reg out.
>
> Josh

Thanks, we tried that and we don't see a whole lot of disk activity on
the "fast" machines.

One emerging theory is that the "slow" Windows machines differ from
the "fast" ones by how their disk cache works.

So `git status` on a large tree heavily depends on caching. Without
it, it would be slow; with it, it's much faster.

We verified that part since when we reboot a fast Windows machine, the
first run of `git status` is slow (~30s) but the next one is much
faster (~5s).

We see a similar phenomenon on Linux: the first run is always
significantly slower than the others.

On slow Windows machines, this difference is much less pronounced.

On a typical "slow" machine, if you clone the repo, the first run of
`git status` on it would already be fast (5s). But then your reboot,
and the first run is slow, but then it only gets up to 14s. And you
can't get back the 5s latency unless you re-clone the repo and status
the fresh clone.

So my theory is that there's a cache that on the "fast" machines
aggressively caches the entire tree on a regular `git status` run. On
such a machine, it's enough to run `git status` once, and after that
initial cold run, the rest will be warm... until you reboot the
machine, rinse, repeat.

On a slow machine, however, cache isn't so aggressive. It might be
write-oriented. So when you write out a whole new working tree, that
tree gets cached as it is written. And for the remainder of the
lifetime of that cache, you get the fully-cached performance you see
on the "fast" machines. But then you reboot the machine, and lose the
cache. And since the caching process isn't aggressive, any number of
`git status` runs won't get you back to the fully cached state. You
will only get that on a newly written working copy.

What do you think?

.D
