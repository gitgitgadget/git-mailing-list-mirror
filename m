From: Christian Couder <christian.couder@gmail.com>
Subject: Re: [PATCH v10 7/7] bisect: allow any terms set by user
Date: Fri, 26 Jun 2015 22:29:04 +0200
Message-ID: <CAP8UFD1Donr4v3Z8bpawv0_heDUQ+-EkepZF6UvuXOed7TQBXA@mail.gmail.com>
References: <1435337896-20709-1-git-send-email-Matthieu.Moy@imag.fr>
	<1435337896-20709-8-git-send-email-Matthieu.Moy@imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, git <git@vger.kernel.org>,
	Antoine Delaite <antoine.delaite@ensimag.grenoble-inp.fr>,
	louis--alexandre stuber 
	<louis--alexandre.stuber@ensimag.grenoble-inp.fr>,
	Christian Couder <chriscool@tuxfamily.org>,
	Thomas Nguy <thomasxnguy@gmail.com>,
	Valentin Duperray <valentinduperray@gmail.com>
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Fri Jun 26 22:29:15 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z8aFM-00061w-7l
	for gcvg-git-2@plane.gmane.org; Fri, 26 Jun 2015 22:29:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752104AbbFZU3H (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Jun 2015 16:29:07 -0400
Received: from mail-wg0-f51.google.com ([74.125.82.51]:34710 "EHLO
	mail-wg0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751897AbbFZU3F (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Jun 2015 16:29:05 -0400
Received: by wgqq4 with SMTP id q4so97169029wgq.1
        for <git@vger.kernel.org>; Fri, 26 Jun 2015 13:29:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=y6YXzn1u8dtqV0JyxZXS3F2n0QZ6yvNxrPFX06yBWhQ=;
        b=DDCrOf7f94NPo76N10kmlSmc7MAe98BXc7sZUd1BIBx//f8jTTMhlNJteMHffwD/Qc
         2T51sWfdtxBw6L+XTawWH1ggAI/FryrxY1PY2AszGr+AqxnfuZ5/PEWjxu9m/Bzb4scg
         ubF6Dx7+4VDjIVy1neRVUdhj0vPy4WZBjib+vcvbvA3mYBWf1mtV40axghs9ikhX1d6W
         BDh1GptnYb9B+2JbDAzvs0B8QOvQc5Qcle/EpS86TsXx795wCvI3KR//7hQFmzjeBNPZ
         x1vxaGe8zDuPRUmjDQwsXIsSbCEWw5qpMwD5K7AZzsqCS1/D55ssfathDDbDUMEpmO5N
         6plQ==
X-Received: by 10.181.25.234 with SMTP id it10mr7929909wid.41.1435350544499;
 Fri, 26 Jun 2015 13:29:04 -0700 (PDT)
Received: by 10.194.221.229 with HTTP; Fri, 26 Jun 2015 13:29:04 -0700 (PDT)
In-Reply-To: <1435337896-20709-8-git-send-email-Matthieu.Moy@imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272820>

On Fri, Jun 26, 2015 at 6:58 PM, Matthieu Moy <Matthieu.Moy@imag.fr> wrote:
> From: Antoine Delaite <antoine.delaite@ensimag.grenoble-inp.fr>
>
> Introduction of the git bisect terms command. The user can set his own
> terms. It will work exactly like before. The terms must be set before the
> start.

After looking a bit at the code, I think that for now existing
predefined terms ("bad", "good", "new" and "old") as well as some
other terms that look like bisect subcommands like "skip", "start" and
"terms" should be disallowed as arguments to "git bisect terms", and
this should be stated in the commit message and in the documentation
as well as checked and tested.

For example a user might want to search for a fix by using "git bisect
terms good bad" (which should swap "good" and "bad"), but we should
not at least for now allow that.

> @@ -185,7 +197,12 @@ bisect_start() {
>         eval "$eval true" &&
>         if test $must_write_terms -eq 1
>         then
> -               write_terms "$NAME_BAD" "$NAME_GOOD"
> +               write_terms "$NAME_BAD" "$NAME_GOOD" &&
> +               if test $must_log_terms -eq 1
> +               then
> +                       echo "git bisect terms $NAME_BAD $NAME_GOOD" \
> +                           >>"$GIT_DIR/BISECT_LOG"
> +               fi

Maybe you could move appending to the log into write_terms() though
you might need to pass an additional argument to enable or disable
logging.
