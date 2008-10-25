From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 5/5] blame: use xdi_diff_hunks(), get rid of struct patch
Date: Sat, 25 Oct 2008 12:36:28 -0700
Message-ID: <7vhc708o1v.fsf@gitster.siamese.dyndns.org>
References: <1219360921-28529-1-git-send-email-bdowning@lavos.net>
 <1219360921-28529-2-git-send-email-bdowning@lavos.net>
 <48AFC73F.2010100@lsrfire.ath.cx> <20080824081254.GI31114@lavos.net>
 <48BF0FBF.3010104@lsrfire.ath.cx> <49031FB8.8060003@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Brian Downing <bdowning@lavos.net>, git@vger.kernel.org
To: =?utf-8?Q?Ren=C3=A9?= Scharfe <rene.scharfe@lsrfire.ath.cx>
X-From: git-owner@vger.kernel.org Sat Oct 25 21:38:10 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ktoxe-0006rp-A4
	for gcvg-git-2@gmane.org; Sat, 25 Oct 2008 21:38:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750850AbYJYTgj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 25 Oct 2008 15:36:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750830AbYJYTgj
	(ORCPT <rfc822;git-outgoing>); Sat, 25 Oct 2008 15:36:39 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:57175 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750729AbYJYTgi convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 25 Oct 2008 15:36:38 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 3D2CC8FB30;
	Sat, 25 Oct 2008 15:36:37 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 750708FB2E; Sat, 25 Oct 2008 15:36:30 -0400 (EDT)
In-Reply-To: <49031FB8.8060003@lsrfire.ath.cx> (=?utf-8?Q?Ren=C3=A9?=
 Scharfe's message of "Sat, 25 Oct 2008 15:31:36 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 3D0B1068-A2CC-11DD-A5B2-4F5276724C3F-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99123>

Ren=C3=A9 Scharfe <rene.scharfe@lsrfire.ath.cx> writes:

> Based on a patch by Brian Downing, this replaces the struct patch bas=
ed
> code for blame passing with calls to xdi_diff_hunks().  This way we
> avoid generating and then parsing patches; we only let the interestin=
g
> infos be passed to our callbacks instead.  This makes blame a bit fas=
ter:
>
>    $ blame=3D"./git blame -M -C -C -p --incremental v1.6.0"
>
>    # master
>    $ /usr/bin/time $blame Makefile >/dev/null
>    1.38user 0.14system 0:01.52elapsed 100%CPU (0avgtext+0avgdata 0max=
resident)k
>    0inputs+0outputs (0major+12226minor)pagefaults 0swaps
>    $ /usr/bin/time $blame cache.h >/dev/null
>    1.66user 0.13system 0:01.80elapsed 99%CPU (0avgtext+0avgdata 0maxr=
esident)k
>    0inputs+0outputs (0major+12262minor)pagefaults 0swaps
>
>    # this patch series
>    $ /usr/bin/time $blame Makefile >/dev/null
>    1.27user 0.12system 0:01.40elapsed 99%CPU (0avgtext+0avgdata 0maxr=
esident)k
>    0inputs+0outputs (0major+11836minor)pagefaults 0swaps
>    $ /usr/bin/time $blame cache.h >/dev/null
>    1.52user 0.12system 0:01.70elapsed 97%CPU (0avgtext+0avgdata 0maxr=
esident)k
>    0inputs+0outputs (0major+12052minor)pagefaults 0swaps
>
> Signed-off-by: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>

The resulting series reads quite clean.  I like it.

> Brian, your numbers looked much more impressive.  Could you please cl=
ock
> this code with your repository and the file server.c?  I wonder if th=
is
> callback mechanism is just too complicated or if your case simply ben=
efits
> lots more than the two files from git mentioned above.
>
> The patch series ends here without adding xdiff caching, for two reas=
ons.
> It's quite easy to add it; patch 4 from your series applies unchanged=
 and
> patch 5 is just needs a few small changes to account for the absence =
of
> compare_buffer().  More importantly, speed actually went down with ca=
ching
> for the test case.  The common tail optimization (xdi_diff() vs. xdl_=
diff())
> seems to beat caching for cache.h and Makefile..

Perhaps revision.c in our history would be more interesting than cache.=
h
or Makefile, as there are more line migrations from different places to
that file.
