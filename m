From: Patrick Sharp <jakanapes@gmail.com>
Subject: Re: [BUG] having 'plink' anywhere in the GIT_SSH environment variables sets putty = true
Date: Wed, 22 Apr 2015 14:12:53 -0500
Message-ID: <F1AB6016-DA88-446C-84E9-1BD42436843D@gmail.com>
References: <2A6FFC1D-5479-4DCA-A5E5-FF92DE0AA552@gmail.com> <6c2a6b53e8e6e019b145dddc67a9d2ca@www.dscho.org>
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2098\))
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Johannes Schindelin <johannes.schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Apr 22 21:13:24 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yl05K-0007Jf-Pw
	for gcvg-git-2@plane.gmane.org; Wed, 22 Apr 2015 21:13:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757836AbbDVTNB convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 22 Apr 2015 15:13:01 -0400
Received: from mail-ob0-f177.google.com ([209.85.214.177]:33777 "EHLO
	mail-ob0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753710AbbDVTM5 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 22 Apr 2015 15:12:57 -0400
Received: by oblw8 with SMTP id w8so178789961obl.0
        for <git@vger.kernel.org>; Wed, 22 Apr 2015 12:12:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=content-type:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=mv9VxzJJ1yd2YExyOWPjO8AhWToc73D2G6YJ9E4U1p0=;
        b=Jf2CH8TxLa/ymD0LRore4G/TBU5vLU1O31tY6Jqc4xTBoIk1a5WXFa4xPCKrCG+nmO
         BqK5xRYmrXXkAy0NK9FbbRpSDgRAzNqdlsIsEzrKilbiStzGNGmc2TiqyrXInZ82WIZi
         VRxDEG09N6Gf7etayk+jzdlvhudwmHnycmLAv+ziuZo/OlE/3pDD6UmzgtzjdGOjF64l
         eD5WMWaPC05e4TWrmXBvvbkAcozxL5BU/XFksfk/wUNMF1eLb+DylUFRUG9znPXJw8kH
         X8Lxq8XYn240/2pWE79HOydseniMYupzu80+wfYdtIMeTM/dTNoM5GsSRl36PnuQovMs
         ayYQ==
X-Received: by 10.202.217.196 with SMTP id q187mr23919943oig.64.1429729976417;
        Wed, 22 Apr 2015 12:12:56 -0700 (PDT)
Received: from [172.31.57.107] ([199.227.134.115])
        by mx.google.com with ESMTPSA id n1sm3628758obz.21.2015.04.22.12.12.55
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 22 Apr 2015 12:12:55 -0700 (PDT)
In-Reply-To: <6c2a6b53e8e6e019b145dddc67a9d2ca@www.dscho.org>
X-Mailer: Apple Mail (2.2098)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267612>

Johannes,

You=E2=80=99re correct, looking back over it, I was pretty vague.

In truth, we are not using Windows OR putty at all.  Running git on an =
Ubuntu system, but we are setting the GIT_SSH environment variable to p=
oint to a shell script to use.

Upon attempting to run git ls-remote, the system was spitting out getad=
drinfo errors for =E2=80=98atch=E2=80=99 .

Setting GIT_TRACE=3D2 showed that -batch was being added to the git com=
mand.

This was seen on several different servers with git versions 1.8.5.2, 1=
=2E9.1 and 2.3.5

After a bit we realized that it was the string =E2=80=98uplink=E2=80=99=
 in the GIT_SSH variable that was linked to the extra -batch flag.

=46inally, after searching the git source, we narrowed it down to the =E2=
=80=98plink=E2=80=99 portion of the string.

https://github.com/git/git/blob/7c597ef345aed345576de616c51f27e6f4b342b=
3/connect.c#L747-L756


> On Apr 22, 2015, at 12:46 PM, Johannes Schindelin <johannes.schindeli=
n@gmx.de> wrote:
>=20
> Hi Patrick,
>=20
> On 2015-04-22 16:36, Patrick Sharp wrote:
>> The plink string detection in GIT_SSH for setting putty to true is v=
ery broad.
>=20
> Wow. You probably wanted to state that you are using Windows, downloa=
ded Git from [link here], that you are using [version] and that you use=
 PLink [version] (from the Putty package downloaded [link here]) to do =
your ssh business.
>=20
> Without that information, you leave readers who have no idea about Pu=
tty *quite* puzzled.
>=20
>> If plink is anywhere in the path to the shell file then putty gets s=
et
>> to true and ssh will fail trying to parse -batch as the hostname.
>=20
> This is cryptic even for me.
>=20
>> Wouldn=E2=80=99t searching for plink.exe be better?--
>=20
> I invite you to try your hand at improving anything you find flawed. =
=46or example, if you want to improve the PLink detection in Git for Wi=
ndows 1.x, this would be the correct place to start: https://github.com=
/msysgit/msysgit/blob/70f24b4b0f5f86a5e85f7264a4ee2c0fec2d4391/share/Wi=
nGit/install.iss#L232-L253 (yes, you would have to download the develop=
ment environment from https://msysgit.github.com/#download-msysgit and =
rebuild your own installer using `/share/msysGit/WinGit/release.sh 1.9.=
5-patrick` after editing the installer script).
>=20
> Ciao,
> Johannes
