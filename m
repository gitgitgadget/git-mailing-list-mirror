From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] rev-parse --parseopt: allow [*=?!] in argument hints
Date: Sun, 12 Jul 2015 10:28:47 -0700
Message-ID: <xmqqzj31i8ts.fsf@gitster.dls.corp.google.com>
References: <1436693990-2908-1-git-send-email-ilya.bobyr@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Pierre Habouzit <madcoder@debian.org>
To: ilya.bobyr@gmail.com
X-From: git-owner@vger.kernel.org Sun Jul 12 19:29:08 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZEL3r-00036H-EY
	for gcvg-git-2@plane.gmane.org; Sun, 12 Jul 2015 19:29:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751119AbbGLR2x (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 12 Jul 2015 13:28:53 -0400
Received: from mail-ie0-f195.google.com ([209.85.223.195]:35456 "EHLO
	mail-ie0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750954AbbGLR2w (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 12 Jul 2015 13:28:52 -0400
Received: by iebmx2 with SMTP id mx2so5494267ieb.2
        for <git@vger.kernel.org>; Sun, 12 Jul 2015 10:28:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=gYJbExSV3Gcg7nwtW8u2pi700meBxsE1eeRnQx1CTM0=;
        b=cz0TgZvWO5GeugT8xpBscSDAILeYMUWfXkmVUEwB/4InYDXVt/sjko7Xmns9smlWr7
         E3SX5/hnRv00QPNBwrdpdz9dbnPwOfT+FI/7pZOTiKq+AIRaHAGzNxSUZwsUb/vreDvM
         lHbP6/Ig5T6Am5+aHc/aZoq/17DSPtDBa65EpfF1X65qLBIZCakC/Fk4l9ssZEnO3FtX
         YnKwAd/1sjZ1NGFjaneLDBh4z1UfI0b/UTeW18ZCS52DvIVmrt1Xfy6cE6ZiVDKZX3u9
         fbRg0322soTvMgsLeuWbjQfgUpj9Pj78+21ykPMByy1OrzedN35BoEK5CPKZOoCvvB3E
         +XCg==
X-Received: by 10.107.46.159 with SMTP id u31mr41334612iou.69.1436722132029;
        Sun, 12 Jul 2015 10:28:52 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:b9be:d9fd:18d2:4319])
        by smtp.gmail.com with ESMTPSA id c41sm10863390iod.8.2015.07.12.10.28.50
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Sun, 12 Jul 2015 10:28:50 -0700 (PDT)
In-Reply-To: <1436693990-2908-1-git-send-email-ilya.bobyr@gmail.com> (ilya
	bobyr's message of "Sun, 12 Jul 2015 02:39:50 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273898>

ilya.bobyr@gmail.com writes:

> From: Ilya Bobyr <ilya.bobyr@gmail.com>
>
> It is not very likely that any of the "*=?!" Characters would be useful
> in the argument short or long names.  On the other hand, there are
> already argument hints that contain the "=" sign.  It used to be
> impossible to include any of the "*=?!" signs in the arguments hints
> before.

After reading this three times (without looking at the code), it is
unclear to me what the change wants to achieve.  A few points that
confuse me:

 - "It is not very likely..."; so what does this change do to such
   an unlikely case?  Does it just forbid?  Or does it have escape
   hatches?

 - "... there are already ..."; so an unlikely case already exists?

 - "It used to be impossible..."; hmmmm, it earlier said there are
   already cases there---how they have been working?

Perhaps it would clarify the paragraph if you said upfront that a
parseopt option specification is <opt-spec> (i.e. short and long
names) optionally followed by <flags> (i.e. one or more of these
"*=?!" characters) and the <arg-hint> string to remind the readers
and reviewers, and phrase what you wrote to make the differences
between them stand out?  

    A line in the input to "rev-parse --parseopt" describes an
    option by listing a short and/or long name, optional flags
    [*=?!], argument hint, and then whitespace and help string.

    The code first finds the help string and scans backwards to find
    the flags, which would imply that [*=?!] is allowed in the
    option names but not in argument hint string.

    That is backwards; you do not want these special characters in
    option names, but you may want to be able to include them
    (especially '=', as in 'key=value') in the argument hint string.

    Change the parsing to go from the beginning to find the first
    occurrence of [*=?!] to find the flags and use the remainder as
    argument hint.

or something, perhaps.

> Added test case with equals sign in the argument hint and updated the

"Add a test case with ... and update the test ...".  Write your log
message as if you are giving somebody an order with your commit to
do such and such.

> test to perform all the operations in test_expect_success matching the
> t\README requirements and allowing commands like

t/README.

>
>     ./t1502-rev-parse-parseopt.sh --run=1-2
>
> to stop at the test case 2 without any further modification of the test
> state area.
>
> Signed-off-by: Ilya Bobyr <ilya.bobyr@gmail.com>
> ---
>  builtin/rev-parse.c           | 36 ++++++++--------
>  t/t1502-rev-parse-parseopt.sh | 97 ++++++++++++++++++++++++++-----------------
>  2 files changed, 77 insertions(+), 56 deletions(-)
>
> diff --git a/builtin/rev-parse.c b/builtin/rev-parse.c
> index b623239..205ea67 100644
> --- a/builtin/rev-parse.c
> +++ b/builtin/rev-parse.c
> @@ -423,17 +423,25 @@ static int cmd_parseopt(int argc, const char **argv, const char *prefix)
>  		o->flags = PARSE_OPT_NOARG;
>  		o->callback = &parseopt_dump;
>  
> -		/* Possible argument name hint */
> +		/* parse names, type and the hint */
>  		end = s;
> -		while (s > sb.buf && strchr("*=?!", s[-1]) == NULL)
> -			--s;

I must have overlooked this one long time ago when a patch added
this; it is a horrible way to parse a thing from the tail.  Good to
see the code go ;-)

> -		if (s != sb.buf && s != end)
> -			o->argh = xmemdupz(s, end - s);
> -		if (s == sb.buf)
> -			s = end;
> +		s = sb.buf;
> +
> +		/* name(s) */
> +		while (s < end && strchr("*=?!", *s) == NULL)
> +			++s;

In C, we usually pre-decrement and post-increment, unless the value
is used.

More importantly, can't we write this more concisely by using
strcspn(3)?

	const char *flags_chars = "*=?!";
        size_t leading = strcspn(s, flags_chars);

	if (s + leading < end)
        	... /* s + leading is the beginning of flags */
	else
        	... /* there was no flags before end */

> +
> +		if (s - sb.buf == 1) /* short option only */
> +			o->short_name = *sb.buf;
> +		else if (sb.buf[1] != ',') /* long option only */
> +			o->long_name = xmemdupz(sb.buf, s - sb.buf);
> +		else {
> +			o->short_name = *sb.buf;
> +			o->long_name = xmemdupz(sb.buf + 2, s - sb.buf - 2);
> +		}
>  
> -		while (s > sb.buf && strchr("*=?!", s[-1])) {
> -			switch (*--s) {
> +		while (s < end && strchr("*=?!", *s)) {
> +			switch (*s++) {
>  			case '=':

No need for the strchr() dance, I think, because you will do
different things depending on *s inside the loop anyway.  Just

		while (s < end) {
                	switch (*s++) {
                        case '=':
                        	do the "equal" thing;
                                continue;
			case '*':
                        	do the "asterisk" thing;
                                continue;
                                ...
			}
                        break;
		}

or something.

Yes, I agree that the original is coded very incompetently, but
there is no reason to inherit that to your fixed version ;-).

Thanks.
