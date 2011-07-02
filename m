From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 09/13] revert: Catch incompatible command-line options early
Date: Sat, 2 Jul 2011 16:49:20 +0530
Message-ID: <BANLkTik2t=qPfJe7JUsoeka79ZYYRmU_MA@mail.gmail.com>
References: <1308661489-20080-1-git-send-email-artagnon@gmail.com>
 <1308661489-20080-10-git-send-email-artagnon@gmail.com> <20110621170416.GN15461@elie>
 <BANLkTinN6KdPnuMWbrdE4jf4ijKDC=35Aw@mail.gmail.com> <20110702095334.GA19090@elie>
 <20110702100436.GB19090@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Daniel Barkalow <barkalow@iabervon.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jul 02 13:19:47 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QcyEk-00066G-Ow
	for gcvg-git-2@lo.gmane.org; Sat, 02 Jul 2011 13:19:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753894Ab1GBLTm convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 2 Jul 2011 07:19:42 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:52207 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753270Ab1GBLTl convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 2 Jul 2011 07:19:41 -0400
Received: by wwe5 with SMTP id 5so3900696wwe.1
        for <git@vger.kernel.org>; Sat, 02 Jul 2011 04:19:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=Fe1hgFfzlAxHAIzbmjqCU5o8b4f9fjkvqtGujVw28+4=;
        b=iLV1OtPIDSLHr7+Bmm5mOyr+vXO4bX+1nmqVdofULIL6pko5Fs3xOB6lxFuLFJk/o/
         2YIpDqCaPFbwTWzU2ZeFjL9DiHHneo3jFBTYqncMnsUbg6C9kecpL8emlOI4w9iBb/4E
         QJxFLKzxuzsp16bwTwniAHLv6b9yZYHzYMLak=
Received: by 10.216.187.65 with SMTP id x43mr2339728wem.62.1309605580071; Sat,
 02 Jul 2011 04:19:40 -0700 (PDT)
Received: by 10.216.134.194 with HTTP; Sat, 2 Jul 2011 04:19:20 -0700 (PDT)
In-Reply-To: <20110702100436.GB19090@elie>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176556>

Hi again,

On Sat, Jul 2, 2011 at 3:34 PM, Jonathan Nieder <jrnieder@gmail.com> wr=
ote:
> =C2=A0 =C2=A0 =C2=A0 =C2=A0cherry-pick/revert: do not create a nonsen=
se "struct opts" when given nonsense argv
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0The --foo and --bar options make no sense =
together, but if I
> =C2=A0 =C2=A0 =C2=A0 =C2=A0run "git cherry-pick --foo --bar" then par=
se_cherry_pick_option
> =C2=A0 =C2=A0 =C2=A0 =C2=A0will return a nonsense struct with both "f=
ooing" and "barring"
> =C2=A0 =C2=A0 =C2=A0 =C2=A0set to true, which makes no sense. =C2=A0C=
urrently it's not a
> =C2=A0 =C2=A0 =C2=A0 =C2=A0problem since the code that cares is prote=
cted by a check:
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (opts.fooin=
g && opts.barring)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0die("cannot foo and bar at the same time");
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0But that is very fragile --- the frob() co=
de-path relies on
> =C2=A0 =C2=A0 =C2=A0 =C2=A0opts.fooing and opts.barring not both bein=
g true without such
> =C2=A0 =C2=A0 =C2=A0 =C2=A0a check and it's only a coincidence that f=
utz() is called
> =C2=A0 =C2=A0 =C2=A0 =C2=A0first and makes that check, protecting it.
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0We can make sure such a nonsensical option=
s struct is never
> =C2=A0 =C2=A0 =C2=A0 =C2=A0created by checking right away that --foo =
and --bar are not
> =C2=A0 =C2=A0 =C2=A0 =C2=A0passed together at option-parsing time. =C2=
=A0Meanwhile, make sure
> =C2=A0 =C2=A0 =C2=A0 =C2=A0regressions in maintaining this invariant =
are caught in the
> =C2=A0 =C2=A0 =C2=A0 =C2=A0future by adding an assertion "assert(!opt=
s->fooing ||
> =C2=A0 =C2=A0 =C2=A0 =C2=A0!opts->barring)" to both frob() and futz()=
=2E
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0The discussion above also applies to --bar=
 and --qux. =C2=A0Fix
> =C2=A0 =C2=A0 =C2=A0 =C2=A0that, too.

Thanks! I wish I could write commit messages like this.  I hope I've
got it right this time:

    revert: Don't create invalid replay_opts in parse_args

    The "--ff" command-line option cannot be used with four other
    command-line options.  However, when these options are specified wi=
th
    "--ff" on the command-line, parse_args will still parse these
    incompatible options into a replay_opts structure for use by the re=
st
    of the program.  Although pick_commits checks the validity of the
    replay_opts strucutre before before starting its operation, this is
    fragile design because the validity of the replay_opts structure
    depends on pick_commits being called before anything else.  Change
    this so that an invalid replay_opts structure is not created by
    parse_args in the first place, and make sure regressions in
    maintaining this invariant are caught in the future by adding an
    assertion in pick_commits.

And yes, adding an "assert" statement in pick_commits does seem like a
great reminder for the future :)

-- Ram
