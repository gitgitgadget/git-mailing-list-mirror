From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: Test t9500 fails if Time::HiRes is missing
Date: Mon, 23 Jan 2012 10:42:02 +0100
Message-ID: <CACBZZX4cjcY5d3mPJAV+rbSTqCEUOrF=_dd3ny_jSM++G-Bg1Q@mail.gmail.com>
References: <hbf.20120123rqzg@bombur.uio.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Jakub Narebski <jnareb@gmail.com>
To: Hallvard Breien Furuseth <h.b.furuseth@usit.uio.no>
X-From: git-owner@vger.kernel.org Mon Jan 23 10:42:32 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RpGQ1-0005Tb-OE
	for gcvg-git-2@lo.gmane.org; Mon, 23 Jan 2012 10:42:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752713Ab2AWJmZ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 23 Jan 2012 04:42:25 -0500
Received: from mail-lpp01m010-f46.google.com ([209.85.215.46]:65519 "EHLO
	mail-lpp01m010-f46.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752227Ab2AWJmY convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Jan 2012 04:42:24 -0500
Received: by lahc1 with SMTP id c1so1477276lah.19
        for <git@vger.kernel.org>; Mon, 23 Jan 2012 01:42:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=8kMkNPIPOLTfO8Ma6lHEoRD7RdEuENEtHPmLXteiH0Q=;
        b=Hq9hJtJ+VlzwyW8dLFlEsc6/AeiHOjH3fhoimaUSCJEgiGBbFFdtzPsxL+cRCNvEIk
         76E0Mdjg+pY2ZHF1gRw0nibqS3pDjZcuDNPWzS0KgpwzX2L99w6z33icvt9s6PWCRiUt
         2eRNXE6Up0RJrKGMqsttB8RvUcPNG2rbmZrj8=
Received: by 10.152.144.133 with SMTP id sm5mr3897212lab.38.1327311743134;
 Mon, 23 Jan 2012 01:42:23 -0800 (PST)
Received: by 10.112.48.9 with HTTP; Mon, 23 Jan 2012 01:42:02 -0800 (PST)
In-Reply-To: <hbf.20120123rqzg@bombur.uio.no>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188982>

On Mon, Jan 23, 2012 at 05:50, Hallvard Breien Furuseth
<h.b.furuseth@usit.uio.no> wrote:
> t9500-gitweb-standalone-no-errors fails: Git 1.7.9.rc2/1.7.8.4, RHEL
> 6.2, Perl 5.10.1. =C2=A0Reverting 3962f1d756ab41c1d180e35483d1c8dffe5=
1e0d1
> fixes it. =C2=A0The commit expects Time::HiRes to be present, but Red=
Hat
> has split it out to a separate RPM perl-Time-HiRes. =C2=A0Better add =
a
> comment about that, so it doesn't get re-reverted.
>
> Or pacify the test and expect gitweb@RHEL-users to install the RPM:
>
> --- git-1.7.9.rc2/t/gitweb-lib.sh~
> +++ git-1.7.9.rc2/t/gitweb-lib.sh
> @@ -113,4 +113,9 @@
> =C2=A0 =C2=A0 =C2=A0 =C2=A0test_done
> =C2=A0}
>
> +perl -MTime::HiRes -e 0 >/dev/null 2>&1 || {
> + =C2=A0 =C2=A0 =C2=A0 skip_all=3D'skipping gitweb tests, Time::HiRes=
 module not available'
> + =C2=A0 =C2=A0 =C2=A0 test_done
> +}
> +
> =C2=A0gitweb_init

[Adding Jakub to CC]

This doesn't actually fix the issue, it only sweeps it under the rug
by making the tests pass, gitweb will still fail to compile on Red
Hat once installed.

I think the right solution is to partially revert
3962f1d756ab41c1d180e35483d1c8dffe51e0d1, but add a comment in the
code indicating that it's to deal with RedHat's broken fork of Perl.

However even if it's required in an eval it might still fail at
runtime in the reset_timer() function, which'll need to deal with it
too.
