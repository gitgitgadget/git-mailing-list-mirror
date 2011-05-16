From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Bikeshedding advice on the ab/i18n-scripts series
Date: Mon, 16 May 2011 18:03:30 +0200
Message-ID: <BANLkTi==pxyy7OeZT0mn33iJHrc5R7vHBw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Erik Faye-Lund <kusmabite@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon May 16 18:03:38 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QM0Gf-0000hS-3D
	for gcvg-git-2@lo.gmane.org; Mon, 16 May 2011 18:03:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756547Ab1EPQDc convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 16 May 2011 12:03:32 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:62647 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756299Ab1EPQDb convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 16 May 2011 12:03:31 -0400
Received: by fxm17 with SMTP id 17so3182495fxm.19
        for <git@vger.kernel.org>; Mon, 16 May 2011 09:03:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:date:message-id:subject:from:to:cc
         :content-type:content-transfer-encoding;
        bh=p0PtILcUXcfr7xvWjm3h1y3x7cTTqPLBwUyQmYzxoVI=;
        b=KzI0Lle+uI2X43aEqHYKy54f8z2Yf757LS9vOA+L18bPcllX1PGVl/0B3HMV+WLAfZ
         nFJB55GKIIJ2iq4F/7sX1uMPKiJsu3uBu6bg2WYYIh74WQ5ZAb186r45H3uqwWJmNVb/
         MJ8pA2bwZVtLS0z/6RE32zuGOY4O9lgMquueE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        b=X45aRw2qNVvVSNQKtXKx2uvITQyTGUP+Ap3YGtuOuClzhIQlL1bej1aVxoG6Gekh8m
         P6wGXkyjrFtLMZdXSwjIVxbEFPdVursIMVn35vuZ6b/BWW0c0WlQR1xn0crPzc3DwC2y
         kRyrBw1AJ/gqPr/g+pd0wjI7JbqGu4xfvndPU=
Received: by 10.223.38.149 with SMTP id b21mr837555fae.18.1305561810132; Mon,
 16 May 2011 09:03:30 -0700 (PDT)
Received: by 10.223.117.72 with HTTP; Mon, 16 May 2011 09:03:30 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173743>

On Wed, May 11, 2011 at 22:24, Junio C Hamano <gitster@pobox.com> wrote=
:

> Will merge to "master" by the end of week #3.
>
> * ab/i18n-scripts (2011-05-08) 48 commits
> =C2=A0- i18n: git-bisect bisect_next_check "You need to" message
> =C2=A0- i18n: git-bisect [Y/n] messages
> =C2=A0- i18n: git-bisect bisect_replay + $1 messages

I'm now mostly done solving all the bugs noted in this series, aside
from the case insensitive env vars on win32 issue.

I know how to fix these, but some people may have issues with my style
of doing so, so I'd like to ask in advance to save me extra work.

Basically for code like this:

        while [ $# -gt 0 ]; do
            arg=3D"$1"
            case "$arg" in
            --)
                shift
                break
                ;;
            *)
                rev=3D$(git rev-parse -q --verify "$arg^{commit}") || {
                    test $has_double_dash -eq 1 &&
                        die "$(eval_gettext "'\$arg' does not appear
to be a valid revision")"
                    break

I was thinking of just doing:

    WHATEVER_arg=3D$arg
    die "$(eval_gettext "'\$WHATEVER_arg' does not appear to be a
valid revision")"

Where WHATEVER is a sufficiently unique prefix. E.g.:

    WINDOWS_ME_HARDER
    GIT_I18N_VARIABLE
    YOUR_MOM
    DUDE_WHERES_MY_POSIX_COMPLIANCE

I'll just pick one at my discretion (not necessarily from that list)
unless someone has some strong preference. I don't care, I just don't
want to re-send it over that.

I could also change all occurances of "arg" (including arg=3D"$1" etc.)
to WHATEVER_arg, but that seems like overkill, and would make the code
hard to read, since you'd have WHATEVER all over the place.

Oh, and for all the convertion of:

    echo >&2 "$(gettext "foobar")"

I've already done:

    (
        gettext "foobar" &&
        echo
    ) >&2

Is that OK, or does someone have a strong preference (and wants me to
waste time on converting it) for:

    gettext "foobar" >&2
    echo >&2

Or something else?

Your friendly neighborhood i18n maintainer.
