From: Benoit Sigoure <tsuna@lrde.epita.fr>
Subject: Re: [PATCH] Fix and improve t7004
Date: Fri, 16 Nov 2007 22:04:57 +0100
Message-ID: <EEE710FA-0408-489F-8128-B4C1F06D34FF@lrde.epita.fr>
References: <7vlk8yx9rp.fsf@gitster.siamese.dyndns.org> <1195244917-25659-1-git-send-email-mh@glandium.org>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: multipart/signed; protocol="application/pgp-signature"; micalg=pgp-sha1; boundary="Apple-Mail-48-44048842"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Mike Hommey <mh@glandium.org>
X-From: git-owner@vger.kernel.org Fri Nov 16 22:06:16 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1It8Nd-0001Nl-V7
	for gcvg-git-2@gmane.org; Fri, 16 Nov 2007 22:05:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758053AbXKPVFU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 Nov 2007 16:05:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757980AbXKPVFU
	(ORCPT <rfc822;git-outgoing>); Fri, 16 Nov 2007 16:05:20 -0500
Received: from 2.139.39-62.rev.gaoland.net ([62.39.139.2]:36661 "EHLO
	kualalumpur.lrde.epita.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757974AbXKPVFT (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Nov 2007 16:05:19 -0500
Received: from quanta.tsunanet.net ([82.229.223.213])
	by kualalumpur.lrde.epita.fr with esmtpsa (TLS-1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.63)
	(envelope-from <tsuna@lrde.epita.fr>)
	id 1It8ND-0006Rb-3g; Fri, 16 Nov 2007 22:05:11 +0100
In-Reply-To: <1195244917-25659-1-git-send-email-mh@glandium.org>
X-Pgp-Agent: GPGMail 1.1.2 (Tiger)
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65246>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--Apple-Mail-48-44048842
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed

On Nov 16, 2007, at 9:28 PM, Mike Hommey wrote:

> Brown paper bag fix to avoid using non portable sed syntax. The
> test by itself didn't catch what it was supposed to, anyways.
>
> The new test first checks whether the user exited the editor
> without editing the file, then whether what the user was
> presented in the editor was any useful to her, which we define
> as the following:
>  * It begins with a single blank line, where the invoked editor
>    would typically place the editing curser at so that the user
>    can immediately start typing;
>
>  * It has some instruction but that comes after that initial
>    blank line, all lines prefixed with "#".
>
>  * And it has nothing else, as the expected behaviour is "Hey
>    you did not leave any message".
>
> Signed-off-by: Mike Hommey <mh@glandium.org>
> ---
>  t/t7004-tag.sh |    9 ++++++++-
>  1 files changed, 8 insertions(+), 1 deletions(-)
>
> diff --git a/t/t7004-tag.sh b/t/t7004-tag.sh
> index 096fe33..42b1f97 100755
> --- a/t/t7004-tag.sh
> +++ b/t/t7004-tag.sh
> @@ -1004,10 +1004,17 @@ test_expect_failure \
>  	'verify signed tag fails when public key is not present' \
>  	'git-tag -v signed-tag'
>
> +test_expect_failure \
> +	'git-tag -a fails if tag annotation is empty' '
> +	GIT_EDITOR=cat git tag -a initial-comment > /dev/null 2>&1
> +'
> +
>  test_expect_success \
>  	'message in editor has initial comment' '
>  	GIT_EDITOR=cat git tag -a initial-comment > actual || true &&
> -	test $(sed -n "/^\(#\|\$\)/p" actual | wc -l) -gt 0
> +	( read empty ;
> +	  [ "$empty" ] && exit 1 ;

What is this meant to do?  Did you mean [ -n "$empty" ] ?

> +	  ! grep -ve "^#" > /dev/null 2>&1 ) < actual

The double negation is harder to read.  May I suggest something along  
these lines (which seems more readable to me):
   while read line; do
     case $line in #(
       '#'*) ;; # Accept comments (
       *) exit 1;;
     esac
   done

Advantages:
   The purpose of the test is more obvious
   The test is more easily extendable
   The test saves a fork ;o

>  '
>
>  get_tag_header reuse $commit commit $time >expect

Cheers,

-- 
Benoit Sigoure aka Tsuna
EPITA Research and Development Laboratory



--Apple-Mail-48-44048842
content-type: application/pgp-signature; x-mac-type=70674453;
	name=PGP.sig
content-description: This is a digitally signed message part
content-disposition: inline; filename=PGP.sig
content-transfer-encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (Darwin)

iD8DBQFHPgX5wwE67wC8PUkRAn/mAJ9bAoFSDGqI9eutEGJ88pbdK9O7MwCgwUzv
2Q6hczbYalEIO3VkO43lMU4=
=Pwde
-----END PGP SIGNATURE-----

--Apple-Mail-48-44048842--
