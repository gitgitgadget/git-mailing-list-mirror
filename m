From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v4] git-p4: add config git-p4.pathEncoding
Date: Wed, 2 Sep 2015 14:13:20 -0400
Message-ID: <CAPig+cSsZnoLNw+vBfHF7h7i=aDhNz0fD_Xd3zRv3RybcGKG2Q@mail.gmail.com>
References: <1441205853-52065-1-git-send-email-larsxschneider@gmail.com>
	<1441205853-52065-2-git-send-email-larsxschneider@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	"luke@diamand.org" <luke@diamand.org>,
	"gitster@pobox.com" <gitster@pobox.com>,
	"tboegi@web.de" <tboegi@web.de>
To: "larsxschneider@gmail.com" <larsxschneider@gmail.com>
X-From: git-owner@vger.kernel.org Wed Sep 02 20:13:26 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZXCXF-0006ai-Ig
	for gcvg-git-2@plane.gmane.org; Wed, 02 Sep 2015 20:13:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755788AbbIBSNW convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 2 Sep 2015 14:13:22 -0400
Received: from mail-yk0-f174.google.com ([209.85.160.174]:34383 "EHLO
	mail-yk0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753774AbbIBSNV convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 2 Sep 2015 14:13:21 -0400
Received: by ykdg206 with SMTP id g206so18709691ykd.1
        for <git@vger.kernel.org>; Wed, 02 Sep 2015 11:13:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type:content-transfer-encoding;
        bh=fEFYaij9MOIyt/9tzD7uG2HL+t2F6swgTAFCpWJY+LE=;
        b=c8cVqT6N6B0JUTL1Yo+m+dzE1m2LlCUR1Ce0EeroZQ90ttjxkK3N+kC1SZhxUAI9oX
         YNrrEV1E6at0dqfNfC4MFwBkY6UTYpvvYh6JbXsSw7vxoNhs9rkAXjiFBG0fgH9d0LKs
         UuJZG8yWfdDXhD2YjCYu+Kdn/fH7RUmIYK78m/3J7YUtu6h+h6Jflm6Mw0gYPPC76+5+
         UH7eKdTeT9Uopm4HWwV3FwToEhDRtd8LFwMAKDthpNuPPFOGNmNWHbTZZJuJdcbTSH4a
         Kd58M3rnA9AOBQFHx/C7PjhM1rB5dSikiT+LH+lnPf2NIrTc5lIDEfCm/zbn2tnU8rX7
         pPiQ==
X-Received: by 10.129.92.8 with SMTP id q8mr35145206ywb.163.1441217600200;
 Wed, 02 Sep 2015 11:13:20 -0700 (PDT)
Received: by 10.37.36.145 with HTTP; Wed, 2 Sep 2015 11:13:20 -0700 (PDT)
In-Reply-To: <1441205853-52065-2-git-send-email-larsxschneider@gmail.com>
X-Google-Sender-Auth: q0zS0Sb3M57Y2XKzDoLm-Us79u8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277115>

On Wednesday, September 2, 2015, <larsxschneider@gmail.com> wrote:
> Perforce keeps the encoding of a path as given by the originating OS.
> Git expects paths encoded as UTF-8. Add a config to tell git-p4 what
> encoding Perforce had used for the paths. This encoding is used to
> transcode the paths to UTF-8. As an example, Perforce on my Windows
> box uses =E2=80=9Ccp1252=E2=80=9D to encode path names.
>
> Signed-off-by: Lars Schneider <larsxschneider@gmail.com>
> ---
> +test_expect_success 'start p4d' '
> +       start_p4d
> +'
> +
> +test_expect_success 'Create a repo containing iso8859-1 encoded path=
s' '
> +       cd "$cli" &&

Torsten, I think, mentioned previously that the 'cd' and code
following should be wrapped in a subshell.

> +       ISO8859=3D"$(printf "$ISO8859_ESCAPED")" &&
> +       echo content123 >"$ISO8859" &&
> +       p4 add "$ISO8859" &&
> +       p4 submit -d "test commit"

And, it's odd that this test doesn't "cd ..", which means that
subsequent tests are running in directory $cli. Is that intentional?
If so, it probably ought to be done in a more explicit and clear
fashion, perhaps by having each test do "cd $cli/$git" rather than
just "cd $git".

> +'
> +
> +test_expect_success 'Clone repo containing iso8859-1 encoded paths w=
ithout git-p4.pathEncoding' '
> +       git p4 clone --destination=3D"$git" //depot &&
> +       test_when_finished cleanup_git &&
> +       (
> +               cd "$git" &&
> +               UTF8=3D"$(printf "$UTF8_ESCAPED")" &&
> +               echo $UTF8 >expect &&
> +               git -c core.quotepath=3Dfalse ls-files >actual &&
> +               test_must_fail test_cmp expect actual
> +       )
> +'
> +
> +test_expect_success 'Clone repo containing iso8859-1 encoded paths w=
ith git-p4.pathEncoding' '
> +
> +       test_when_finished cleanup_git &&
> +       (
> +               cd "$git" &&
> +               git init . &&
> +               git config git-p4.pathEncoding iso8859-1 &&
> +               git p4 clone --use-client-spec --destination=3D"$git"=
 //depot &&
> +               UTF8=3D"$(printf "$UTF8_ESCAPED")" &&
> +               echo $UTF8 >expect &&
> +               git -c core.quotepath=3Dfalse ls-files >actual &&
> +               test_cmp expect actual &&
> +               cat >expect <<-\EOF &&
> +               content123
> +               EOF
> +               cat $UTF8 >actual &&
> +               test_cmp expect actual
> +       )
> +'
> +
> +test_expect_success 'kill p4d' '
> +       kill_p4d
> +'
> +
> +test_done
> --
> 1.9.5 (Apple Git-50.3)
