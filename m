From: Frans Klaver <fransklaver@gmail.com>
Subject: Re: [PATCH] run-command: treat inaccessible directories as ENOENT
Date: Fri, 30 Mar 2012 10:23:16 +0200
Message-ID: <CAH6sp9N=JsWp7iQ=AAdXHe0J+aB5L9cBq2_0BJgUO=Y-vgAbNg@mail.gmail.com>
References: <20120330075217.GA8384@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	James Pickens <jepicken@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Mar 30 10:23:29 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SDX7H-0005XJ-4A
	for gcvg-git-2@plane.gmane.org; Fri, 30 Mar 2012 10:23:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759730Ab2C3IXW convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 30 Mar 2012 04:23:22 -0400
Received: from mail-qc0-f174.google.com ([209.85.216.174]:44766 "EHLO
	mail-qc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759610Ab2C3IXR convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 30 Mar 2012 04:23:17 -0400
Received: by qcqw6 with SMTP id w6so208720qcq.19
        for <git@vger.kernel.org>; Fri, 30 Mar 2012 01:23:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=IDYEz4DKTz1c2P/5i5AklnbftswsQnDvh5SUafhWQS0=;
        b=JAhWDUOOzSBWHWcT3RpUPsvXDZGmvIZOSVOiv02RsRnbASer8fOC1GTzNbrZRVu7PR
         qNNXnL7idQEnN7Z7FYy8cagOGgBLo/PfrAstv/w79Z/8KrE4JaRzyEQJJYrjAJvLvs+L
         UfSPacf3W6aWY8b/37Jsh63aRTS+kZjt3vqZ/G/ramcEPjdD2coT0Yji6GEcCfZIsd/A
         OYeYtkav6TBgr3Az8WHF7j+xq34vm4zhI2vMSMcqkZCxhvVUaZVHuTSTCUrLFJuj5MC/
         dGAkRgVlFq+sXar9I/pfr1SDezKHmpX+l8pXz0DWlvAuaHrAHA84eARdS3sz3bO8t+xF
         gkAw==
Received: by 10.229.111.76 with SMTP id r12mr473362qcp.43.1333095796428; Fri,
 30 Mar 2012 01:23:16 -0700 (PDT)
Received: by 10.224.32.19 with HTTP; Fri, 30 Mar 2012 01:23:16 -0700 (PDT)
In-Reply-To: <20120330075217.GA8384@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194340>

On Fri, Mar 30, 2012 at 9:52 AM, Jeff King <peff@peff.net> wrote:

> =C2=A01. I split the find-in-path function so that Frans can build on=
 it
> =C2=A0 =C2=A0 with further checks if he wants. However, note that it =
will need a
> =C2=A0 =C2=A0 little more refactoring; it finds the first entry in th=
e PATH,
> =C2=A0 =C2=A0 whereas I think he would want the first executable entr=
y
> =C2=A0 =C2=A0 (admittedly, having a non-executable entry followed by =
an
> =C2=A0 =C2=A0 executable one which _also_ fails for a different reaso=
n is a
> =C2=A0 =C2=A0 pretty wild corner case).

Thanks. I think this corner case is something to fix when someone is
running into it. Bash doesn't cover this case either (stops looking at
the first found entry) so I would go as far as saying that it doesn't
happen.


> =C2=A02. I pulled the test from what Junio posted earlier. I started =
to
> =C2=A0 =C2=A0 write a full test script that checked each of the cases=
 I
> =C2=A0 =C2=A0 mentioned earlier. However, in all but the alias case (=
which is
> =C2=A0 =C2=A0 what is tested here), the behavior is really only disti=
nguishable
> =C2=A0 =C2=A0 by the error messages, and I didn't want to get into te=
sting what
> =C2=A0 =C2=A0 strerror(EACCES) prints. I can re-roll if we really wan=
t to go
> =C2=A0 =C2=A0 there.

I wouldn't think there is much point in testing strerror output.



> +test_expect_success POSIXPERM 'unreadable directory in PATH' '
> + =C2=A0 =C2=A0 =C2=A0 mkdir local-command &&
> + =C2=A0 =C2=A0 =C2=A0 test_when_finished "chmod u+rwx local-command =
&& rm -fr local-command" &&
> + =C2=A0 =C2=A0 =C2=A0 git config alias.nitfol "!echo frotz" &&
> + =C2=A0 =C2=A0 =C2=A0 chmod a-rx local-command &&
> + =C2=A0 =C2=A0 =C2=A0 (
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 PATH=3D./local-com=
mand:$PATH &&
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 git nitfol >actual
> + =C2=A0 =C2=A0 =C2=A0 ) &&
> + =C2=A0 =C2=A0 =C2=A0 echo frotz >expect &&
> + =C2=A0 =C2=A0 =C2=A0 test_cmp expect actual
> +'
> +
> =C2=A0test_done
> --
> 1.7.9.5.7.g11b89

Hadn't looked into Junio's test earlier (probably missed it entirely),
but isn't it rather more sensible from a unit-test perspective to see
if start_command returns 127 instead of 128 in this specific case?
Aside from that, this test doesn't seem to fit in t0061, looking at
the t???? guidelines.

Rest looks sensible to me.
