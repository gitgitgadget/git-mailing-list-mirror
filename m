From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH 8/9] branch: use ref-filter printing APIs
Date: Sat, 03 Oct 2015 14:41:44 +0200
Message-ID: <vpqvbao86pj.fsf@grenoble-inp.fr>
References: <1443807546-5985-1-git-send-email-Karthik.188@gmail.com>
	<1443807546-5985-9-git-send-email-Karthik.188@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, christian.couder@gmail.com, gitster@pobox.com
To: Karthik Nayak <karthik.188@gmail.com>
X-From: git-owner@vger.kernel.org Sat Oct 03 14:42:04 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZiM8W-00064y-Io
	for gcvg-git-2@plane.gmane.org; Sat, 03 Oct 2015 14:42:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752628AbbJCMl4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 3 Oct 2015 08:41:56 -0400
Received: from mx1.imag.fr ([129.88.30.5]:34105 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752610AbbJCMly (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 Oct 2015 08:41:54 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id t93CfhQ2018003
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Sat, 3 Oct 2015 14:41:43 +0200
Received: from anie (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id t93Cfiqi003592;
	Sat, 3 Oct 2015 14:41:44 +0200
In-Reply-To: <1443807546-5985-9-git-send-email-Karthik.188@gmail.com> (Karthik
	Nayak's message of "Fri, 2 Oct 2015 23:09:05 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Sat, 03 Oct 2015 14:41:43 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: t93CfhQ2018003
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1444480908.26551@jx37pvH9um+c8cAe0Ii+iw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278970>

Karthik Nayak <karthik.188@gmail.com> writes:

> -	if (upstream_is_gone) {
> -		if (show_upstream_ref)
> -			strbuf_addf(stat, _("[%s: gone]"), fancy.buf);

The old string was translated, and you're replacing it with one which
isn't.

I'm not a big fan of translation, so that change doesn't disturb me, but
people used to having "git branch" talk their native language here may
care.

Be careful: translation should happen only in porcelain. Typicall,
"for-each-ref" should anyway continue saying "gone" in english whatever
the configuration is.

See e.g. 7a76c28 (status: disable translation when --porcelain is used,
2014-03-20) for an example of translation only for porcelain (that was
for status, but also for ahead/behind/gone).

> +static char *get_format(struct ref_filter *filter, int maxwidth, const char *remote_prefix)

I'd call that "build_format", since "get_..." usually implies that the
value exists already and you're retrieving it.

> +{
> +	char *remote = NULL;
> +	char *local = NULL;
> +	char *final = NULL;
> +
> +	if (filter->verbose) {
> +		if (filter->verbose > 1)
> +			local = xstrfmt("%%(if)%%(HEAD)%%(then)* %s%%(else)  %%(end)%%(align:%d,left)%%(refname:short)%%(end)%s"
> +					" %%(objectname:short,7) %%(if)%%(upstream)%%(then)[%s%%(upstream:short)%s] %%(end)"
> +					"%%(if)%%(upstream:track)%%(then)%%(upstream:track) %%(end)%%(contents:subject)",
> +					branch_get_color(BRANCH_COLOR_CURRENT), maxwidth, branch_get_color(BRANCH_COLOR_RESET),
> +					branch_get_color(BRANCH_COLOR_UPSTREAM), branch_get_color(BRANCH_COLOR_RESET));

OK, that is a hell of a block of code ;-).

You should factor the common portions out of these if/else. C allows you
to write several string litteral next to each other, so you can eg.

#define STAR_IF_HEAD "%%(if)%%(HEAD)%%(then)* %s%%(else)  %%(end)"
#define ALIGNED_REFNAME "%%(align:%d,left)%%(refname:short)%%(end)"

and then

STAR_IF_HEAD ALIGNED_REFNAME ...

Actually, this is not a performance-cricical piece of code at all, so I
think it's even better to build an strbuf little by little using
repeated strbuf_addf calls. This way you can do things like

strbuf_addf(fmt, "%%(if)%%(HEAD)%%(then)* %s%%(else)  %%(end)",
	    branch_get_color(BRANCH_COLOR_CURRENT));
strbuf_addf(fmt, "%%(align:%d,left)%%(refname:short)%%(end)", maxwidth);

which makes it much easier to pair the %s and the corresponding
branch_get_color() or the %d and maxwidth.

But fundamentally, I think this function is doing the right thing. The
function is a bit complex (I think it will be much nicer to read when
better factored), but 1) it allows getting rid of a lot of specific code
and 2) it's a proof that --format is expressive enough.

> @@ -58,11 +58,11 @@ test_expect_success 'branch -v' '
>  '
>  
>  cat >expect <<\EOF
> -b1 [origin/master: ahead 1, behind 1] d
> -b2 [origin/master: ahead 1, behind 1] d
> -b3 [origin/master: behind 1] b
> -b4 [origin/master: ahead 2] f
> -b5 [brokenbase: gone] g
> +b1 [origin/master] [ahead 1, behind 1] d
> +b2 [origin/master] [ahead 1, behind 1] d
> +b3 [origin/master] [behind 1] b
> +b4 [origin/master] [ahead 2] f
> +b5 [brokenbase] [gone] g

This corresponds to this part of the commit message:

> Since branch.c is being ported to use ref-filter APIs to print the
> required data, it is constricted to the constraints of printing as per
> ref-filter. Which means branch.c can only print as per the atoms
> available in ref-filter. Hence the "-vv" option of 'git branch' now
> prints the upstream and its tracking details separately as
> "[<upstream>] [<tracking info>]" instead of "[<upstream>: <tracking
> info>]".
> 
> Make changes in /t/t6040-tracking-info.sh to reflect the change.

nit: /t/t... -> t/t... (remove leading /)

That is a behavior change, and I actually prefered the previous one.

I actually don't understand why you can't get the old syntax: the []
around the refname come from the format string it get_format(), so you
could decide to change "[%s%%(upstream:short)%s]" to
"[%s%%(upstream:short)%s: ". The brackets around the status are a bit
more tricky, since they were here before your series. But we could have
a %(upstream:track,nobracket) to display just the status without the
brackets around.

Then, the code must deal with up-to-date branches for which no
" :ahead/behind" must be displayed. Probably one more if/then/else
nested in the first one.

So, it seems feasible to me to keep the old behavior with the new
system, even though it's going to be a bit tricky.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
