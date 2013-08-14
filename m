From: Martin Fick <mfick@codeaurora.org>
Subject: Re: [RFC PATCH] repack: rewrite the shell script in C.
Date: Wed, 14 Aug 2013 17:25:42 -0600
Organization: CAF
Message-ID: <201308141725.43127.mfick@codeaurora.org>
References: <520BAF9F.70105@googlemail.com> <CALWbr2xuV+V7M354+XoA3HCvLr0Cpx4t3cLVeTCx4xeNmQQX1w@mail.gmail.com> <vpq7gfnj38d.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Cc: Antoine Pelisse <apelisse@gmail.com>,
	Stefan Beller <stefanbeller@googlemail.com>,
	git <git@vger.kernel.org>,
	=?utf-8?q?Nguy=E1=BB=85n_Th=C3=A1i_Ng=E1=BB=8Dc_Duy?= 
	<pclouds@gmail.com>, iveqy@iveqy.com,
	Junio C Hamano <gitster@pobox.com>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Thu Aug 15 01:25:50 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V9kRp-0000Tg-T0
	for gcvg-git-2@plane.gmane.org; Thu, 15 Aug 2013 01:25:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933281Ab3HNXZq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Aug 2013 19:25:46 -0400
Received: from smtp.codeaurora.org ([198.145.11.231]:56868 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932448Ab3HNXZp (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Aug 2013 19:25:45 -0400
Received: from smtp.codeaurora.org (localhost [127.0.0.1])
	by smtp.codeaurora.org (Postfix) with ESMTP id A4FBF13EF2F;
	Wed, 14 Aug 2013 23:25:44 +0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 486)
	id 96B3513EF89; Wed, 14 Aug 2013 23:25:44 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.3.1 (2010-03-16) on
	pdx-caf-smtp.dmz.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.3.1
Received: from mfick-lnx.localnet (mfick-lnx.qualcomm.com [129.46.10.58])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	(Authenticated sender: mfick@smtp.codeaurora.org)
	by smtp.codeaurora.org (Postfix) with ESMTPSA id 2AFA313EF2F;
	Wed, 14 Aug 2013 23:25:44 +0000 (UTC)
User-Agent: KMail/1.13.5 (Linux/2.6.32.49+drm33.21-mfick7; KDE/4.4.5; x86_64; ; )
In-Reply-To: <vpq7gfnj38d.fsf@anie.imag.fr>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232322>

On Wednesday, August 14, 2013 04:51:14 pm Matthieu Moy 
wrote:
> Antoine Pelisse <apelisse@gmail.com> writes:
> > On Wed, Aug 14, 2013 at 6:27 PM, Stefan Beller
> > 
> > <stefanbeller@googlemail.com> wrote:
> >>  builtin/repack.c               | 410
> >>  +++++++++++++++++++++++++++++++++++++++++
> >>  contrib/examples/git-repack.sh | 194
> >>  +++++++++++++++++++ git-repack.sh                  |
> >>  194 -------------------
> > 
> > I'm still not sure I understand the trade-off here.
> > 
> > Most of what git-repack does is compute some file
> > paths, (re)move those files and call git-pack-objects,
> > and potentially git-prune-packed and
> > git-update-server-info.
> > Maybe I'm wrong, but I have the feeling that the
> > correct tool for that is Shell, rather than C (and I
> > think the code looks less intuitive in C for that
> > matter).
> 
> There's a real problem with git-repack being shell (I
> already mentionned it in the previous thread about the
> rewrite): it creates dependencies on a few external
> binaries, and a restricted server may not have them. I
> have this issue on a fusionforge server where Git repos
> are accessed in a chroot with very few commands
> available: everything went OK until the first project
> grew enough to require a "git gc --auto", and then it
> stopped accepting pushes for that project.
> 
> I tracked down the origin of the problem and the
> sysadmins disabled auto-gc, but that's not a very
> satisfactory solution.
> 
> C is rather painfull to write, but as a sysadmin, drop
> the binary on your server and it just works. That's
> really important. AFAIK, git-repack is the only
> remaining shell part on the server, and it's rather
> small. I'd really love to see it disapear.

I didn't review the proposed C version, but how was it 
planning on removing the dependencies on these binaries?  
Was it planning to reimplement mv, cp, find?  Were there 
other binaries that were problematic that you were thinking 
of?  From what I can tell it also uses test, mkdir, sed, 
chmod and naturally sh, that is 8 dependencies.  If those 
can't be depended upon for existing, perhaps git should just 
consider bundling busy-box or some other limited shell 
utils, or yikes!, even its own reimplementation of these 
instead of implementing these independently inside other git 
programs?

-Martin

-- 
The Qualcomm Innovation Center, Inc. is a member of Code 
Aurora Forum, hosted by The Linux Foundation
 
