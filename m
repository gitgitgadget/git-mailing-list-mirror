From: Vitor Antunes <vitor.hda@gmail.com>
Subject: Re: [PATCH v0] fast-import: Add drop command
Date: Tue, 27 Sep 2011 09:57:02 +0100
Message-ID: <CAOpHH-WSyD23GKtZ2nLiSsJfLU-+7ibyGhGccyvtAhKQ-jffBw@mail.gmail.com>
References: <1316878065-11782-1-git-send-email-vitor.hda@gmail.com>
 <1316878065-11782-2-git-send-email-vitor.hda@gmail.com> <20110924193733.GB10955@elie>
 <CA+gfSn8Z7Xn1hdpqNHiP3bd2KGRqcAc6O683Z4O+G=jNNYJtBA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	Sverre Rabbelier <srabbelier@gmail.com>,
	David Barr <davidbarr@google.com>
To: Dmitry Ivankov <divanorama@gmail.com>
X-From: git-owner@vger.kernel.org Tue Sep 27 10:57:38 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R8TTu-0006P2-43
	for gcvg-git-2@lo.gmane.org; Tue, 27 Sep 2011 10:57:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751540Ab1I0I5d convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 27 Sep 2011 04:57:33 -0400
Received: from mail-vw0-f46.google.com ([209.85.212.46]:60954 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751327Ab1I0I5c convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 27 Sep 2011 04:57:32 -0400
Received: by vws1 with SMTP id 1so6360938vws.19
        for <git@vger.kernel.org>; Tue, 27 Sep 2011 01:57:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=+SsEJcMUXJPi3xlZxgE8nkV1Qcf4YbKaSFhnLk05JXY=;
        b=WIj5gyLwtmo/bxn223zQT+fGQ2JExNCswxkBGAVd3m2M3KPp3MwifhRwbwXjiDEEWD
         ddsN3Z+bKUrUDOu+/nMQjHyYBMM3oqXC68UZIrcOuFZPCqhZQ4l9S/k6L+gOtA2FHV/H
         dy9PboxNDea+CnczntKgmFUCUuTRyLQ/c/uaw=
Received: by 10.52.27.140 with SMTP id t12mr7721135vdg.156.1317113852100; Tue,
 27 Sep 2011 01:57:32 -0700 (PDT)
Received: by 10.220.171.200 with HTTP; Tue, 27 Sep 2011 01:57:02 -0700 (PDT)
In-Reply-To: <CA+gfSn8Z7Xn1hdpqNHiP3bd2KGRqcAc6O683Z4O+G=jNNYJtBA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182222>

On Sat, Sep 24, 2011 at 10:19 PM, Dmitry Ivankov <divanorama@gmail.com>=
 wrote:
> On Sun, Sep 25, 2011 at 1:37 AM, Jonathan Nieder <jrnieder@gmail.com>=
 wrote:
>> Thanks. =A0I must have missed the earlier discussion. =A0What are th=
e
>> semantics of this command and its intended purpose?
> My guess is that if fast-import is used to manage a set of "remote"
> branches, it should be able to delete branches. Then, it should
> be allowed to do non-fastforward updates too (--force). Why can't
> it just ignore branches deletion (considering --force)?

I started by using --force, but I did not want to completely disable
these checks. The idea of the drop command is to add support to the
exceptions that require non-fastforward updates.

> Random thoughts:
> 1. once 'drop' is executed, fast-import can't tell if the branch was
> actually deleted. And moreover any attempt to read this branch
> head becomes illegal (either it's missing in .git or fast-import is
> instructed to use a dropped branch).
> 2. 'reset' command is a bit like proposed 'drop' but it never deletes
> a branch ref. Consider following imports:
> 1) import branch topic
> 2) reset topic
> 3) import branch topic2 starting at topic (incorrect import)
> If 1-3) is done in one fast-import process, the error is reported.
> If 3) is done separately, it succeeds but the result is strange:
> topic2 isn't started from scratch but from old "erased" topic.
> So, maybe, reset should be fixed to erase branches on --force.

I think you are not considering the possibility that checkpoints could
have been done along the way. I use them frequently to be able to
analyse branches with diff-tree. As soon as a checkpoint is done,
update-branches will issue an error (commit A is not part of branch A')=
=2E

> One more scenario is:
> 1) import topic
> 2) reset topic
> 3) import topic
> If 1-3) go together - no error
> If 3) goes separate - no error, but non-fastforward update.
> Much more harmless, but still may look strange.

Not exactly true if there is a checkpoint done after step 1.

My scenario is:

1) import topic
2) checkpoint
3) diff-tree and processing
4) exit if processing returns ok
5) reset topic to another HEAD
6) goto 1)

--=20
Vitor Antunes
