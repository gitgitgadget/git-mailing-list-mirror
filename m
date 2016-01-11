From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH 2/2] interpret-trailers: add option for in-place editing
Date: Mon, 11 Jan 2016 17:33:56 +0100
Message-ID: <vpqziwc3wjv.fsf@anie.imag.fr>
References: <1452519213-1819-1-git-send-email-tklauser@distanz.ch>
	<1452519213-1819-3-git-send-email-tklauser@distanz.ch>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Junio C Hamano <gitster@pobox.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Eric Sunshine <sunshine@sunshineco.com>, git@vger.kernel.org
To: Tobias Klauser <tklauser@distanz.ch>
X-From: git-owner@vger.kernel.org Mon Jan 11 17:40:37 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aIfWE-0005nQ-Jb
	for gcvg-git-2@plane.gmane.org; Mon, 11 Jan 2016 17:40:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761185AbcAKQkb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Jan 2016 11:40:31 -0500
Received: from mx1.imag.fr ([129.88.30.5]:52408 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1761168AbcAKQka (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Jan 2016 11:40:30 -0500
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id u0BGXsHi022388
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Mon, 11 Jan 2016 17:33:55 +0100
Received: from anie (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id u0BGXudD002414;
	Mon, 11 Jan 2016 17:33:56 +0100
In-Reply-To: <1452519213-1819-3-git-send-email-tklauser@distanz.ch> (Tobias
	Klauser's message of "Mon, 11 Jan 2016 14:33:33 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Mon, 11 Jan 2016 17:33:55 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: u0BGXsHi022388
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1453134838.30094@qOQGN5bSG3Q+XYk3mYObag
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283668>

Tobias Klauser <tklauser@distanz.ch> writes:

> @@ -843,7 +844,9 @@ static void free_all(struct trailer_item **first)
>  	}
>  }
>  
> -void process_trailers(const char *file, int trim_empty, struct string_list *trailers)
> +static struct tempfile trailers_tempfile;

Does this need to be a static global? I'd rather have this be a local
variable of process_trailers.

> +			die_errno(_("could not fdopen tempfile"));

I think you should spell it "could not open temporary file" to be more
user-friendly.

> @@ -872,5 +900,10 @@ void process_trailers(const char *file, int trim_empty, struct string_list *trai
>  	/* Print the lines after the trailers as is */
>  	print_lines(outfile, lines, trailer_end, INT_MAX);
>  
> +	if (in_place) {
> +		if (rename_tempfile(&trailers_tempfile, file))
> +			die_errno(_("could not rename tempfile"));
> +	}

When this happens, I think you also want to try removing the temporary
file. Not sure, though: it may be nice to leave the tempfile for the
user to debug. What do we do in other places of the code?

It may help the user to get "could not rename temporary file %s to %s"
in case this happens.

On overall, the split makes the series much more pleasant to review, and
other than these details, this sounds good to me. Thanks!

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
