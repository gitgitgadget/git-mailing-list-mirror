From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v8 3/5] bisect: simplify the addition of new bisect terms
Date: Wed, 24 Jun 2015 10:29:17 -0700
Message-ID: <xmqqegl19frm.fsf@gitster.dls.corp.google.com>
References: <1435064084-5554-1-git-send-email-Matthieu.Moy@imag.fr>
	<1435159062-23468-1-git-send-email-Matthieu.Moy@imag.fr>
	<1435159062-23468-4-git-send-email-Matthieu.Moy@imag.fr>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, antoine.delaite@ensimag.grenoble-inp.fr,
	louis--alexandre.stuber@ensimag.grenoble-inp.fr,
	chriscool@tuxfamily.org, thomasxnguy@gmail.com,
	valentinduperray@gmail.com,
	Louis Stuber <stuberl@ensimag.grenoble-inp.fr>,
	Valentin Duperray <Valentin.Duperray@ensimag.imag.fr>,
	Franck Jonas <Franck.Jonas@ensimag.imag.fr>,
	Lucien Kong <Lucien.Kong@ensimag.imag.fr>,
	Thomas Nguy <Thomas.Nguy@ensimag.imag.fr>,
	Huynh Khoi Nguyen Nguyen 
	<Huynh-Khoi-Nguyen.Nguyen@ensimag.imag.fr>
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Wed Jun 24 19:29:26 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z7oUI-00032C-2J
	for gcvg-git-2@plane.gmane.org; Wed, 24 Jun 2015 19:29:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753908AbbFXR3V (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Jun 2015 13:29:21 -0400
Received: from mail-ig0-f173.google.com ([209.85.213.173]:38778 "EHLO
	mail-ig0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753896AbbFXR3T (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Jun 2015 13:29:19 -0400
Received: by igin14 with SMTP id n14so38700642igi.1
        for <git@vger.kernel.org>; Wed, 24 Jun 2015 10:29:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=3t3NsOGl2B0H02lME1XdRgNJUo/ujQYy3Oq7evnOhfM=;
        b=IG5HwFMPERpXZEXlowbJSVav7e32IIxuyuaotHBCvGdhdsW+aZhUnahM7Xa/azXkxo
         hiS2F2Xfk7uyN6SIsKZQCf0slUXetFQi4JoSYrkSqqb8v5t+gypnjTy6PYV7CEHNRLJH
         b5K4zqoRZtZ9rek/Viz8mEpsRi97WjnjX64ymX5K0+TnkZUtFNnoTd/GLQ76XnaFxLG2
         mGjBS76UxPe8fps3R9Pn03CYeUDqOBoOic9EKSfnhps7tSs00l+csLmDvb/Sw0FxYgf3
         t0ClwlO+OFKcKTH9LQXPDoJwtqrQDgD4mh/2ggwDTWx9fx2u7XyVkvoNU44evBYgJxJi
         M7Mw==
X-Received: by 10.107.148.144 with SMTP id w138mr55054998iod.12.1435166959265;
        Wed, 24 Jun 2015 10:29:19 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:1c05:dbc5:2f2f:d033])
        by mx.google.com with ESMTPSA id c41sm5879233iod.8.2015.06.24.10.29.18
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 24 Jun 2015 10:29:18 -0700 (PDT)
In-Reply-To: <1435159062-23468-4-git-send-email-Matthieu.Moy@imag.fr>
	(Matthieu Moy's message of "Wed, 24 Jun 2015 17:17:40 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272569>

Matthieu Moy <Matthieu.Moy@imag.fr> writes:

> diff --git a/bisect.c b/bisect.c
> index 2d3dbdc..08be634 100644
> --- a/bisect.c
> +++ b/bisect.c
> @@ -747,7 +747,10 @@ static void handle_bad_merge_base(void)
>  				"between %s and [%s].\n",
>  				bad_hex, bad_hex, good_hex);
>  		} else {
> -			die("BUG: terms %s/%s not managed", name_bad, name_good);
> +			fprintf(stderr, "The merge base %s is %s.\n"
> +				"This means the first commit marked %s is "
> +				"between %s and [%s].\n",
> +				bad_hex, name_bad, name_bad, bad_hex, good_hex);
>  		}
>  		exit(3);
>  	}

Before the pre-context of this hunk is

		if (!strcmp(name_bad, "bad")) {
			fprintf(stderr, "The merge base %s is bad.\n"
				"This means the bug has been fixed "

So, after 5/5, the user could do

	git bisect terms bad worse

and get utterly confused.  I think 

-		if (!strcmp(name_bad, "bad")) {
+		if (!strcmp(name_bad, "bad") && !strcmp(name_good, "good") {

needs to be a part of this step.
