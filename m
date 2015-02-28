From: "Kyle J. McKay" <mackyle@gmail.com>
Subject: Re: [RFC/PATCH 2/5] upload-pack: support out of band client capability requests
Date: Fri, 27 Feb 2015 23:47:38 -0800
Message-ID: <AB630BA1-8D48-418D-B576-6495DBE67C52@gmail.com>
References: <CAGZ79ka8Zg86qqvWByNiP3F6a9QggO-bNY3ZZ9g+A-MdKYQ7NQ@mail.gmail.com> <1425085318-30537-1-git-send-email-sbeller@google.com> <1425085318-30537-3-git-send-email-sbeller@google.com>
Mime-Version: 1.0 (Apple Message framework v936)
Content-Type: text/plain; charset=UTF-8;
	format=flowed	delsp=yes
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, pclouds@gmail.com, gitster@pobox.com
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Sat Feb 28 08:47:59 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YRc7x-0004Kz-Ip
	for gcvg-git-2@plane.gmane.org; Sat, 28 Feb 2015 08:47:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750808AbbB1Hrn convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 28 Feb 2015 02:47:43 -0500
Received: from mail-pa0-f42.google.com ([209.85.220.42]:36669 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750756AbbB1Hrm convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 28 Feb 2015 02:47:42 -0500
Received: by padfb1 with SMTP id fb1so2788662pad.3
        for <git@vger.kernel.org>; Fri, 27 Feb 2015 23:47:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:in-reply-to:subject:references:message-id:content-type
         :content-transfer-encoding:mime-version:date:cc;
        bh=vhOxrFjx1/nZKxw697L8QFgP6gFvgjQ8rY4P830lPP0=;
        b=JhUlZ982IbN10bxQ2mkNB8fcG8spC0j4Ja93B5ci1YfPYMWQvi+pB3q9NzVlW/8sw6
         Eu2XXlfTCXFrJIy1TwSNsv4z7G8WhCbzrZJp1Wu7QmefR8gzRWKOW6KJpgviZcOdLt0I
         e6D4Bgm9l6t5guOgn2GhKH0ZWnrzrSf6VKMHzDXb5ctDL9raEq+CuVB7pooJDpEh6q0a
         MNp3n14oP6WmFhQwSQ+7LotbtSUXShTwljYh1jdKxxJ7yAH9TEIj00qV1sigyVvZOLGQ
         4csr5Ruqsf+femx4clzoYn+OIsSaHC1tqmerF2Kc18VsxfDsieIw12TWsihPIEUy+JYA
         1iVw==
X-Received: by 10.67.10.47 with SMTP id dx15mr30616006pad.139.1425109662293;
        Fri, 27 Feb 2015 23:47:42 -0800 (PST)
Received: from ?IPv6:2002:48c0:ad8d::223:12ff:fe05:eebd? ([2002:48c0:ad8d:0:223:12ff:fe05:eebd])
        by mx.google.com with ESMTPSA id qw7sm575776pbc.35.2015.02.27.23.47.40
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Fri, 27 Feb 2015 23:47:41 -0800 (PST)
In-Reply-To: <1425085318-30537-3-git-send-email-sbeller@google.com>
X-Mauler: Craptastic (2.936)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264524>

On Feb 27, 2015, at 17:01, Stefan Beller wrote:
> From: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.com>
>
> The only difference from the original protocol client capabilities ar=
e
> negotiated before initial refs advertisment.
>
> Client capabilities are sent out of band (upload-pack receives it as
> the second command line argument). The server sends one pkt-line back
> advertising its capabilities.
>
> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---
>
> Notes:
>    v1:
>    I am still undecided if the client should then accept/resend
>    the capabilities to confirm them, which would make the client the
>    ultimate decider which capabilities are used.
>
>    My gut feeling is to rather let the server make the final decision
>    for the capabilities, as it will use some requested capabilities
>    already to not send out all the refs.
>
> Documentation/git-upload-pack.txt | 10 +++++++++-
> upload-pack.c                     | 42 ++++++++++++++++++++++++++=20
> +------------
> 2 files changed, 38 insertions(+), 14 deletions(-)
>
> diff --git a/Documentation/git-upload-pack.txt b/Documentation/git-=20
> upload-pack.txt
> index 0abc806..ad3a89d 100644
> --- a/Documentation/git-upload-pack.txt
> +++ b/Documentation/git-upload-pack.txt
> @@ -9,7 +9,7 @@ git-upload-pack - Send objects packed back to git-=20
> fetch-pack
> SYNOPSIS
> --------
> [verse]
> -'git-upload-pack' [--strict] [--timeout=3D<n>] <directory>
> +'git-upload-pack' [--strict] [--timeout=3D<n>] <directory> =20
> [<capabilities>]

Isn't the problem with this that passing the extra argument to ssh =20
servers will cause them to fail?

Having just looked at the upload-pack.c source it looks to me like =20
trying to send "git-upload-pack 'dir' 'capabilities'" to an ssh git =20
server running a current version of the code will just end up =20
failing.  I realize the extra argument is optional, so does that mean =20
there's no out-of-band support for ssh connections since the extra =20
argument would have to be omitted to remain compatible?

On Feb 26, 2015, at 12:13, Junio C Hamano wrote:
> The capability-based sidegrade does not solve the problem
> when the problem to be solved is that the server side needs to spend
> a lot of cycles and the network needs to carry megabytes of data
> before capability exchange happens.


On Feb 27, 2015, at 16:46, Stefan Beller wrote:
> I'll try to present a 'client asks for options first out of band' =20
> instead of the
> way you describe.

On Feb 27, 2015, at 15:44, Stefan Beller wrote:
> For both native git as well as ssh, Duy presented a solution at [1, 2=
]
> a year ago, which essentially presents the desired client capabilites
> 'out of band' to the server via an argument to the server.  So we'd
> only need to examine the http(s) path how to pass in arguments there.


I've looked at those links and it's unclear to me how they support an =20
out-of-band option for ssh, they seem to be targeted at git-daemon.  =20
Maybe there's another reference?

But there does seem to be a way to pass the protocol information out-=20
of-band for each of the HTTP, git and ssh connections to stop the =20
initial ref advertisement.

As already suggested [1, 2], for git: another "Extended attribute" can =
=20
be added after the host=3D...\0 to become host=3D...\0protocol=3Dextend=
ed\0 =20
or similar:

=46or HTTP, just add a second parameter in the query string .../info/=20
refs?service=3Dgit-upload-pack&protocol=3Dextended.  Alternatively an "=
X-=20
Git-Protocol: extended" or similar header can be added by the client.  =
=20
It looks to me like the current http-backend.c already ignores any =20
extra parameters/headers.

That leaves ssh.  A bit more problematic, but if the server side adds =20
"AcceptEnv GIT_PROTOCOL" to its sshd_config and then the client does =20
setenv("GIT_PROTOCOL","extended") and adds a "-o SendEnv=3DGIT_PROTOCOL=
" =20
option to the ssh command line the GIT_PROTOCOL variable will be =20
passed along.  This one might need a config option to always disable =20
adding the "-o ..." option to the command line in case connect.c =20
guesses wrongly about it being OpenSSH and such is not likely to be =20
supported other than with OpenSSH on both ends.  I'm not seeing any =20
other way to pass out-of-band information to an ssh server configured =20
to run git-shell that is safely ignored by current versions of the code=
=2E

Worst case with SSH is the initial ref advertisement is not suppressed =
=20
even though the server does support protocol v2 and a capability-based =
=20
sidegrade is required which is unfortunate.

-Kyle

[1] https://github.com/pclouds/git/commit/e26fa77c4d9ace06b9f2c80091af9=
eb7b63a1c95
[2] https://github.com/pclouds/git/commit/20d048e5fc650b20fdc7dd8bbe35c=
b8510ac9c50
