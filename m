From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Conditionally define vars to improve portability
Date: Tue, 08 Sep 2015 11:57:24 -0700
Message-ID: <xmqqvbbk7n8r.fsf@gitster.mtv.corp.google.com>
References: <81961DE1-FA30-4E55-8818-9FCA3BC59B81@FreeBSD.org>
	<20150908063034.GF26331@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Renato Botelho <garga@FreeBSD.org>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Sep 08 20:58:25 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZZO5Z-0003V8-28
	for gcvg-git-2@plane.gmane.org; Tue, 08 Sep 2015 20:57:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751355AbbIHS53 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 8 Sep 2015 14:57:29 -0400
Received: from mail-pa0-f49.google.com ([209.85.220.49]:35727 "EHLO
	mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750911AbbIHS51 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Sep 2015 14:57:27 -0400
Received: by pacfv12 with SMTP id fv12so134508073pac.2
        for <git@vger.kernel.org>; Tue, 08 Sep 2015 11:57:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type:content-transfer-encoding;
        bh=Gaiwo6eUptuxGG79TaLevkmQ2u6oA1Id82l0Hn+Ruzw=;
        b=nynEDYn98NSp6siWBV7ayX34TWmQW9PpXXXlkLQx90WgC1XoMd08XieHchvmGnprIe
         ks83vn1g6W24Gfove8DU08+uTY3vQ6mSK8/YLxHudILzrGprkcd3NRxA+/Rs6djJlVAk
         YHO6XWMWuHVu4CHZXTzaYmDw8034vmU8fklMR/Lh3ZMzKEuQapmSro+79les3YKUCWUN
         lRgOQaO5XyXj+VEkb3ggOhEd0een7LLEVOGCeVHdplRh3naBsh+5i3kwrJut28wAd6Sw
         fn8sUFfxzlVSR8MvPukwv4pmjSMlGHIZ/RNnGOYSxjXfpoVN86PqNPcEew3fXRtfQmx7
         KiYA==
X-Received: by 10.68.204.232 with SMTP id lb8mr62579465pbc.146.1441738647022;
        Tue, 08 Sep 2015 11:57:27 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:40ca:ccb5:4636:e6d])
        by smtp.gmail.com with ESMTPSA id le8sm4279215pbc.24.2015.09.08.11.57.24
        (version=TLS1_2 cipher=AES128-SHA256 bits=128/128);
        Tue, 08 Sep 2015 11:57:25 -0700 (PDT)
In-Reply-To: <20150908063034.GF26331@sigill.intra.peff.net> (Jeff King's
	message of "Tue, 8 Sep 2015 02:30:34 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277518>

Jeff King <peff@peff.net> writes:

> On Mon, Sep 07, 2015 at 02:51:42PM -0300, Renato Botelho wrote:
>
>> Default variables used to build are set using =3D on Makefile, (e.g.=
 CC,
>> INSTALL, CFLAGS, =E2=80=A6). GNU make overwrite these values if it=E2=
=80=99s passed as
>> an argument (make CC=3Dclang) and it works as expected.
>>=20
>> Default method of passing arguments for make operations on FreeBSD
>> ports tree is using environment variables instead of make arguments,
>> then we have CC set on env before call gmake. Today these values are
>> ignored by git Makefile, and we ended up patching Makefile replacing=
 =3D
>> by ?=3D on variable assignments [1].
>
> Hmm. I can't really think of a downside to doing so, unless we expect
> users to have things like CC set in the environment and _not_ want th=
em
> to bleed through to our build.

I do think that is the reason behind the choice.  I am not saying I
necessarily personally agree with it, though.

Common things like CC are not so problematic, but more problematic
are various Git build customization in our Makefile that can be left
behind from a previous build.  It is easier for users to forget, as
a "GIT_FOO=3DNoThanks; export GIT_FOO" that was run previously in the
same shell does not leave trace once the shell exits, compared to
other avenues of customization including config.mak and explicit
command line settings given to the 'make' utility (i.e. can be seen
in 'history' as a single entry, without having to trace the sequence
of 'GIT_FOO=3DNoThanks', 'export GIT_FOO' and possible 'unset GIT_FOO'
to find what was in effect when 'make' was run).  So from that point
of view, if you encourage users to be less explicit by keeping them
in the environment, you are making it easier for the users to hurt
themselves.

In an environment to build with a "make world" style propagation of
settings from top-level to down below, "environment bleeding" is a
non-issue.  It is merely a convention in that build environment how
the settings are passed to submakes in a whole system and everybody
in that environment understands the ramifications.  I agree that
your suggestion of using "gmake -e" may be a good workaround for
handling cases like that.
