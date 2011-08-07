From: Jonathan Nieder <jrnieder@gmail.com>
Subject: test z$foo = zbar (and Re: [PATCH 1/3] bisect: relax requirement for
 a working tree.)
Date: Sun, 7 Aug 2011 07:41:50 -0500
Message-ID: <20110807124150.GA20046@elie.gateway.2wire.net>
References: <1312714240-23647-1-git-send-email-jon.seymour@gmail.com>
 <1312714240-23647-2-git-send-email-jon.seymour@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, gitster@pobox.com, chriscool@tuxfamily.org,
	j6t@kdbg.org, jnareb@gmail.com
To: Jon Seymour <jon.seymour@gmail.com>
X-From: git-owner@vger.kernel.org Sun Aug 07 14:42:23 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qq2gQ-0002u7-Qq
	for gcvg-git-2@lo.gmane.org; Sun, 07 Aug 2011 14:42:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752527Ab1HGMmG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 7 Aug 2011 08:42:06 -0400
Received: from mail-iy0-f170.google.com ([209.85.210.170]:45417 "EHLO
	mail-iy0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752259Ab1HGMmD convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 7 Aug 2011 08:42:03 -0400
Received: by iye16 with SMTP id 16so7060475iye.1
        for <git@vger.kernel.org>; Sun, 07 Aug 2011 05:42:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=E5+4jNl8ycWgTNMt301aYF7VMu4Tja8TYXgepohuNmE=;
        b=NpPH2oqa4HuEsEKHKBxPiCKgxqjwY2c9DNloUg5StpVDkEWM8K3KKxvyx43C50OQPm
         KGYkcpby0sKZNr5Sox79uZtDNcJh71OuUegsuSoDWTd3I6DdRZkR1TZsTJUXGqcFUNZd
         gYv81MdzCWc34VfRX0PSZ3r3HA8qpZUrSmv9I=
Received: by 10.42.168.136 with SMTP id w8mr4512227icy.267.1312720922240;
        Sun, 07 Aug 2011 05:42:02 -0700 (PDT)
Received: from elie.gateway.2wire.net ([69.209.49.224])
        by mx.google.com with ESMTPS id q13sm3450552ibi.60.2011.08.07.05.42.00
        (version=SSLv3 cipher=OTHER);
        Sun, 07 Aug 2011 05:42:01 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1312714240-23647-2-git-send-email-jon.seymour@gmail.com>
User-Agent: Mutt/1.5.21+46 (b01d63af6fea) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178908>

Jon Seymour wrote:

> Now that bisection does not require checkout, it can work
> on bare repositories too.

Nice.

> --- a/git-bisect.sh
> +++ b/git-bisect.sh
> @@ -29,7 +29,6 @@ Please use "git help bisect" to get the full man pa=
ge.'
>  OPTIONS_SPEC=3D
>  . git-sh-setup
>  . git-sh-i18n
> -require_work_tree
> =20
>  _x40=3D'[0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f]'
>  _x40=3D"$_x40$_x40$_x40$_x40$_x40$_x40$_x40$_x40"
> @@ -79,7 +78,12 @@ bisect_start() {
>  	orig_args=3D$(git rev-parse --sq-quote "$@")
>  	bad_seen=3D0
>  	eval=3D''
> -	mode=3D''
> +	if test "z$(git rev-parse --is-bare-repository)" !=3D "zfalse"
> +	then
> +		mode=3D'--no-checkout'
> +	else
> +		mode=3D''
> +	fi

Am I the only one who finds this

	test "z$foo" =3D "zbar"

style to be impossibly ugly?  It means every time someone considers
using the "test" utility, they decide "is this expression likely to
looks like an operator" and each time someone reads a use of the
"test" utility, there is a lingering question of whether that choice
was made correctly.  By contrast, if one follows the following simple
rules, everything works fine with the shells git supports:

 - _Do_ use the "z$foo" trick when using expr.
 - Do not use test's '(', '),' -a and -o operators; use && and ||
   instead.

The Autoconf manual says

	Posix also says that =E2=80=98test ! "string"=E2=80=99, =E2=80=98test =
-n "string"=E2=80=99 and
	=E2=80=98test -z "string"=E2=80=99 work with any string, but many shel=
ls (such
	as Solaris, AIX 3.2, UNICOS 10.0.0.6, Digital Unix 4, etc.)
	get confused if string looks like an operator:

Notice that none of the mentioned shells is close enough to POSIX even
to support $( / ).  This is an area in which early POSIX work improved
shells immensely (the "-e" primary was introduced around the same
time).
