From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Don't segfault if the given SHA1 name is longer than 40 characters
Date: Wed, 18 Oct 2006 21:13:13 -0700
Message-ID: <7vwt6xvt7q.fsf@assigned-by-dhcp.cox.net>
References: <20061019013441.GB9379@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 19 06:13:24 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GaPHY-00058Q-0d
	for gcvg-git@gmane.org; Thu, 19 Oct 2006 06:13:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1945975AbWJSENP convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Thu, 19 Oct 2006 00:13:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1945977AbWJSENO
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Oct 2006 00:13:14 -0400
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:29633 "EHLO
	fed1rmmtao03.cox.net") by vger.kernel.org with ESMTP
	id S1945975AbWJSENO convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 19 Oct 2006 00:13:14 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao03.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20061019041313.LBTO2704.fed1rmmtao03.cox.net@fed1rmimpo01.cox.net>;
          Thu, 19 Oct 2006 00:13:13 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id c4Cz1V01a1kojtg0000000
	Thu, 19 Oct 2006 00:13:00 -0400
To: pclouds@gmail.com
In-Reply-To: <20061019013441.GB9379@localhost> (pclouds@gmail.com's message of
	"Thu, 19 Oct 2006 08:34:41 +0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29318>

pclouds@gmail.com writes:

> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>
> ---
>  sha1_name.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/sha1_name.c b/sha1_name.c
> index 9b226e3..6ffee22 100644
> --- a/sha1_name.c
> +++ b/sha1_name.c
> @@ -157,7 +157,7 @@ static int get_short_sha1(const char *na
>  	char canonical[40];
>  	unsigned char res[20];
> =20
> -	if (len < MINIMUM_ABBREV)
> +	if (len < MINIMUM_ABBREV || len > 40)
>  		return -1;
>  	hashclr(res);
>  	memset(canonical, 'x', 40);

Thanks.

The patch is correct, but it needs a better explanation in the
proposed commit log message than just "Don't segfault".

get_describe_name() can be fed a string foo-gXXX...XXX with a
very looooooooong hexstring.  It calls get_short_sha1() without
checking if XXX...XXX part is longer than 40-bytes (in which
case it cannot be a valid object name).

get_sha1_1() has the same problem.  Given a hexstring longer
than 40-bytes, it calls the function with it because earlier
ones such as get_sha1_hex() would reject the input.
