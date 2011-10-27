From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [PATCH 2/2] pack-objects: optimize "recency order"
Date: Thu, 27 Oct 2011 23:01:50 +0200
Message-ID: <CACBZZX6Ss4jLtdrDhLUNKCUjEHjHHKzfv-LMkOyTPDhRUXm4sQ@mail.gmail.com>
References: <1310084657-16790-1-git-send-email-gitster@pobox.com> <1310084657-16790-3-git-send-email-gitster@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Oct 27 23:02:20 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RJX5f-0001DG-FI
	for gcvg-git-2@lo.gmane.org; Thu, 27 Oct 2011 23:02:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754781Ab1J0VCN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 27 Oct 2011 17:02:13 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:56895 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750795Ab1J0VCL convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 27 Oct 2011 17:02:11 -0400
Received: by bkbzt19 with SMTP id zt19so2355615bkb.19
        for <git@vger.kernel.org>; Thu, 27 Oct 2011 14:02:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=h6DZPzHvgjwyopjeqgrLNN6HQCxcj52Y80d2BSVySsY=;
        b=NtYUsdPufrcrUNEmtrL7OzK1sdy1qqF2Pvmc9+BKBW6r5gDFGTOsMT95aH12LWm1Tq
         PR25lvw1apjDvu9QPkoUsPY44y4WrQ41PGXsotWfaNCKrmhbehKr9ZkMtNgG4+Ar2Qy/
         mgyHtC7FKMmQO55fBUb6Y560gpmRZpZPqaFYY=
Received: by 10.204.10.81 with SMTP id o17mr772455bko.78.1319749330130; Thu,
 27 Oct 2011 14:02:10 -0700 (PDT)
Received: by 10.204.112.79 with HTTP; Thu, 27 Oct 2011 14:01:50 -0700 (PDT)
In-Reply-To: <1310084657-16790-3-git-send-email-gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184319>

On Fri, Jul 8, 2011 at 02:24, Junio C Hamano <gitster@pobox.com> wrote:

> =C2=A0- Commits at the tip of tags are written together, in the hope =
that
> =C2=A0 revision traversal done in incremental fetch (which starts by
> =C2=A0 putting them in a revision queue marked as UNINTERESTING) will=
 see a
> =C2=A0 better locality of these objects;

We recently upgraded to 1.7.7 and I've traced a very large slowdown in
packing down to this commit.

On our repository packing used to take around 30 seconds, it now takes
about 4 minutes. Which means that cloning the repository went from
being slightly slow to pretty intolerable.

I haven't dug into why this is but I'm pretty sure it's because this
patch makes Git behave pathologically on repositories with a large
amount of tags. git.git itself has ~27k revs / and ~450 tags, or a tag
every ~60 revisions.

Try it on e.g. a repository with a couple of hundred thousand revs and
a tag every 10-20 revisions.
