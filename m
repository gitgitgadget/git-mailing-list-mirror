From: Mariusz Gronczewski <xani666@gmail.com>
Subject: Re: [BUG] Veryfing signatures in git log fails when language is not english
Date: Thu, 14 Feb 2013 13:42:41 +0100
Message-ID: <CAJ9Ak2pLqUesOWKNtjwG7P_BW7-EqJP4Kaj0FF_+72Wn=oGoew@mail.gmail.com>
References: <20130214011837.04880b3e@hydra.devrandom.pl>
	<511CC288.30607@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Thu Feb 14 13:43:10 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U5y9b-000768-8Y
	for gcvg-git-2@plane.gmane.org; Thu, 14 Feb 2013 13:43:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759740Ab3BNMmo convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 14 Feb 2013 07:42:44 -0500
Received: from mail-vb0-f48.google.com ([209.85.212.48]:35351 "EHLO
	mail-vb0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755302Ab3BNMmn convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 14 Feb 2013 07:42:43 -0500
Received: by mail-vb0-f48.google.com with SMTP id fc21so1407279vbb.7
        for <git@vger.kernel.org>; Thu, 14 Feb 2013 04:42:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type:content-transfer-encoding;
        bh=/0BDtO6knDK7Hr1/K1NtvaxsxyWGMB2ioK5HBxqPTAg=;
        b=d/Idd6GK7VaeLGAzdi+uY9U2XlnwHlWMxunxFcWqSAWRQNCcFAc+wYAnbdT8Ia/aW7
         lZkEiDnjiGkJHBeg+xQs2Q4NwJptMV9KO70R+T1tu08+WLUY+Y7tjJLD0eZzzTj9ahRu
         vVNT/23sm23qfP1rzGOEbqyPGw6Uh2mkVEexI2jHgdpX3s5FuzNGwQFfRblPoinMPAJt
         McP2VeSH8g8MTx/NJqVFXRovumdBMdbXXD61/mBHMtilUMzMjCeH2o7pZeTspUG1GPMt
         dBxCoHiDi0kjwUxNjNmH/KuMYhvaj5F8w68+hrGjTIjRTFx0jVnD9oZ8v4XGbFQm22p0
         2ZAg==
X-Received: by 10.220.119.147 with SMTP id z19mr34993577vcq.69.1360845761462;
 Thu, 14 Feb 2013 04:42:41 -0800 (PST)
Received: by 10.58.235.199 with HTTP; Thu, 14 Feb 2013 04:42:41 -0800 (PST)
In-Reply-To: <511CC288.30607@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216305>

2013/2/14 Michael J Gruber <git@drmicha.warpmail.net>:
> XANi venit, vidit, dixit 14.02.2013 01:18:
>> Hi,
>>
>> any functionality that depends on exact exit msg of program
>>  can potentially fail because of that
>> =E1=9B=AF export |grep LANG
>> declare -x LANG=3D"pl_PL.UTF-8"
>>
>> =E1=9B=AF ~/src/os/git/git log --format=3D"%G? %h" |head -2
>>  0d19377
>>  5b9d7f8
>>
>> =E1=9B=AF unset LANG
>> =E1=9B=AF ~/src/os/git/git log --format=3D"%G? %h" |head -2
>> G 0d19377
>> G 5b9d7f8
>>
>> tested against maint (d32805d) and master (5bf72ed)
>>
>> maybe git should set up some output-changing variables before callin=
g
>> external programs? I think setting LC_ALL=3DC should be enougth.
>>
>
> There are really multiple problems here:
>
> 1. git calls gpg without setting LANG but expects output in LANG=3DC
>
> 2. git looks at the textual output from gpg to check the validity.
>
> 3. In fact, it does so only for %G and the display of signed merge
> commits, in all other cases it checks the return code only.
>
> gpg is not supposed to be used like that.
>
> Since the callers of verify_signed_buffer do that craziness there is
> some refactoring to be done.
>
> A false hotfix would be to set LANG=3DC when calling gpg from git, bu=
t
> that wouldn't solve the real problem. Besides, we do want LANG depend=
ent
> output for the user.
>
> I'll have a closer look.
>
> BTW: Thanks for the clear report :)
>
> Michael

What is really missing is an ability to display used key ID without
hammering git log output with regexps, it would be much easier to
validate incoming commits if there was format option to just display
key ID instead of signer name. %GS isn't really good solution for that
because it will show only one of email addresses used in the key and
script checking signatures would have to always pick "right" one.

--=20
Mariusz Gronczewski (XANi) <xani666@gmail.com>
GnuPG: 0xEA8ACE64
