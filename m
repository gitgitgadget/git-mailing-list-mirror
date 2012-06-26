From: David Aguilar <davvid@gmail.com>
Subject: Re: MERGE_RR droppings
Date: Mon, 25 Jun 2012 21:31:16 -0700
Message-ID: <CAJDDKr7Hj4f-Gww4j89kppR8g1vzmhmydsFnG0ecjzL5WrRP4g@mail.gmail.com>
References: <CABURp0omkVoLrz29GeOjjoZOpN238Rm6Nu5aOKQyVxFVnPihsw@mail.gmail.com>
	<CABURp0os2no40BW0P-biG_fXyi7MHRcLLYWmCbLTdBv1o1OXcg@mail.gmail.com>
	<7v8vfk2pby.fsf@alter.siamese.dyndns.org>
	<7vwr2vfc1c.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Phil Hord <phil.hord@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jun 26 06:32:15 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SjNRk-0006S2-Us
	for gcvg-git-2@plane.gmane.org; Tue, 26 Jun 2012 06:32:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751453Ab2FZEbS convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 26 Jun 2012 00:31:18 -0400
Received: from mail-yw0-f51.google.com ([209.85.213.51]:53403 "EHLO
	mail-yw0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750760Ab2FZEbR convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 26 Jun 2012 00:31:17 -0400
Received: by yhnn12 with SMTP id n12so4099598yhn.10
        for <git@vger.kernel.org>; Mon, 25 Jun 2012 21:31:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=8smY36s5hW0WxzEoQWdH5y/zpNpURfAYsH52cejsuNU=;
        b=KxhfYd4GYF/ePMgBooT1kl3lNZGM1ChHvCHFOAKz6ljSb0BMGRqDjhZsH3aJwklys7
         WLtAaC9Vt21awCR+meNA7cc03paKWO79+s7r929nst/O1FNcvy4ImVrkw5yhtwpxyul0
         zZMdATKcriVnC3UziXEWcHnkao0lgw3dKU987CQBDGFpSBed87nS87ECI+iORYhdb8X3
         IqEQlUxp+7a7jlnT5K5E7eAaB4hWzb8Gxc/qXW17kWT/198oOcJl9cwwawQotcuBalRQ
         bX2jqgODX17+Up7TjIQ0VSz4aZa9r9m2Y4/GvCgjriIfLxgotCpqFmPt1/6MyRenfUpZ
         xXEw==
Received: by 10.236.170.36 with SMTP id o24mr16515521yhl.40.1340685076801;
 Mon, 25 Jun 2012 21:31:16 -0700 (PDT)
Received: by 10.147.41.5 with HTTP; Mon, 25 Jun 2012 21:31:16 -0700 (PDT)
In-Reply-To: <7vwr2vfc1c.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200629>

On Mon, Jun 25, 2012 at 12:04 PM, Junio C Hamano <gitster@pobox.com> wr=
ote:
> Junio C Hamano <gitster@pobox.com> writes:
>
>> Phil Hord <phil.hord@gmail.com> writes:
>>
>>> git mergetool decides to use rerere-remaining based on the existenc=
e
>>> of the .git/MERGE_RR file:
>>>
>>> =C2=A0 =C2=A0 if test -e "$GIT_DIR/MERGE_RR"
>>
>> This is correct, I would probably write it with "test -f" if I were
>> writing this line today, though. =C2=A0After you commit to conclude =
the
>> merge, the MERGE_RR marker should disappear. =C2=A0Isn't it happenin=
g for
>> you?
>
> Oops. =C2=A0It actually does not happen for _me_. An empty MERGE_RR i=
s
> left in the working tree after rerere has dealt with the conflicts.
> There seems to be only three codepaths that explicitly remove
> MERGE_RR that is stale:
>
> =C2=A0- (obviously) "rerere clear"
> =C2=A0- "git reset"
> =C2=A0- "git checkout otherbranch"
>
> Perhaps mergetool should consider a missing MERGE_RR and an empty
> one the same way?

Would that test look (roughly) like this?

    if test -f "$GIT_DIR/MERGE_RR" && test -n "$(cat "$GIT_DIR/MERGE_RR=
")"
    then
	files=3D$(git rerere remaining)
    else
	files=3D$(git ls-files -u | sed -e 's/^[^	]*	//' | sort -u)
    fi
    ...

If so I'll throw together a patch.
--=20
David
