From: Jon Seymour <jon.seymour@gmail.com>
Subject: Re: [PATCH v4 2/9] stash: extract stash-like check into its own function
Date: Sat, 14 Aug 2010 09:55:24 +1000
Message-ID: <AANLkTimDoRHGgQz70P9SZuFQzdUJqPQFY-+3qLvii3gy@mail.gmail.com>
References: <1281242771-24764-1-git-send-email-jon.seymour@gmail.com>
	<1281398688-21008-3-git-send-email-jon.seymour@gmail.com>
	<7v8w4bnxpj.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, j6t@kdbg.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Aug 14 01:55:31 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ok45z-0007il-4I
	for gcvg-git-2@lo.gmane.org; Sat, 14 Aug 2010 01:55:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932123Ab0HMXz0 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 13 Aug 2010 19:55:26 -0400
Received: from mail-qy0-f174.google.com ([209.85.216.174]:36901 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932112Ab0HMXzZ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 13 Aug 2010 19:55:25 -0400
Received: by qyk9 with SMTP id 9so1372798qyk.19
        for <git@vger.kernel.org>; Fri, 13 Aug 2010 16:55:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=0ox5vPgZN/X2cSeC64i/l5Oeq4u0RYjDH6T7RvjQCQk=;
        b=qIv6Pqv5CDX5I2siKhI70+TemCXZXWHaqgUFwz/jSctrDYNS/4mujiJQSHV+kRycDh
         Mb406ggwwvWNlVaqiosrDDQkTaXc8HK4es39rLHoAYxirnVwceft4Es5qeoKuPGAC2Db
         7t5GE2bhNSLVsqGHZsHgyzBhANOL4kpgW0cs4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=Zk1lUkGJKu/TsHWg8+p74NfqFDIz9I7bgLnNItV04sSHqjX/3vRGJ8d3IM30E2qjGq
         y6JnqC6JfCiJngvw6if70Y7fVKf7AYIo3Ul5ANToFljbgF0aan5PQfEYpQPC59DHidc+
         mvGhOtWtDh/+kc3BM97gC+HmOi2EW21EsiMRw=
Received: by 10.224.19.140 with SMTP id a12mr1442766qab.217.1281743724766;
 Fri, 13 Aug 2010 16:55:24 -0700 (PDT)
Received: by 10.229.231.199 with HTTP; Fri, 13 Aug 2010 16:55:24 -0700 (PDT)
In-Reply-To: <7v8w4bnxpj.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153529>

On Fri, Aug 13, 2010 at 10:49 AM, Junio C Hamano <gitster@pobox.com> wr=
ote:
> Jon Seymour <jon.seymour@gmail.com> writes:
>
>> A similar code block is used in three places; this change
>> factors the stash-like check into a separate function so that
>> it can be used in these and other places.
>
> "git stash show" used to be able to show a single-parent commit, and =
we
> are forbidding that "feature". =C2=A0I'd actually call that a bugfix =
though ;-)
>
>> +# if this function returns, then:
>> +# =C2=A0 s is set to the stash commit
>> +# =C2=A0 w_commit is set to the commit containing the working tree
>> +# =C2=A0 b_commit is set to the base commit
>> +# =C2=A0 i_commit is set to the commit containing the index tree
>> +# otherwise:
>> +# =C2=A0 the function exits via die
>> +#
>> +assert_stash_like() {
>> + =C2=A0 =C2=A0 # stash records the work tree, and is a merge betwee=
n the
>> + =C2=A0 =C2=A0 # base commit (first parent) and the index tree (sec=
ond parent).
>> + =C2=A0 =C2=A0 s=3D$(git rev-parse --revs-only --quiet --verify --d=
efault $ref_stash "$@") &&
>> + =C2=A0 =C2=A0 w_commit=3D$(git rev-parse --quiet --verify "$s:") &=
&
>> + =C2=A0 =C2=A0 b_commit=3D$(git rev-parse --quiet --verify "$s^1:")=
 &&
>> + =C2=A0 =C2=A0 i_commit=3D$(git rev-parse --quiet --verify "$s^2:")=
 ||
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 die "$*: no valid stashe=
d state found"
>
> Don't these "rev-parse" calls return tree objects? =C2=A0It is too co=
nfusing to
> call them x_commit if that is the case.
>

My bad. You are quite correct. I was a little _too_ eager to remove a
redundancy. This also explains my misconceived "Note tor reviewers"!
I'll fix in the next round.
