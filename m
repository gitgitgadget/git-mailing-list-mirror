From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH 1/2] wt-status: turn advice_status_hints into a field of wt_status
Date: Thu, 12 Sep 2013 11:44:30 +0200
Message-ID: <vpqeh8u1iip.fsf@anie.imag.fr>
References: <1378890539-1966-1-git-send-email-Matthieu.Moy@imag.fr>
	<20130911183519.GA24251@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, gitster@pobox.com, javierdo1@gmail.com,
	jrnieder@gmail.com, judge.packham@gmail.com
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Sep 12 11:44:56 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VK3SD-0006u3-1W
	for gcvg-git-2@plane.gmane.org; Thu, 12 Sep 2013 11:44:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757876Ab3ILJop (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Sep 2013 05:44:45 -0400
Received: from mx1.imag.fr ([129.88.30.5]:48907 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751306Ab3ILJoo (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Sep 2013 05:44:44 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id r8C9iUiK029084
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Thu, 12 Sep 2013 11:44:30 +0200
Received: from anie.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1VK3Rv-0001RN-5P; Thu, 12 Sep 2013 11:44:31 +0200
In-Reply-To: <20130911183519.GA24251@sigill.intra.peff.net> (Jeff King's
	message of "Wed, 11 Sep 2013 14:35:20 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Thu, 12 Sep 2013 11:44:30 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: r8C9iUiK029084
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1379583871.76931@3543DVdb7rhTVi9hI8XN4A
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234636>

Jeff King <peff@peff.net> writes:

> On Wed, Sep 11, 2013 at 11:08:58AM +0200, Matthieu Moy wrote:
>
>> No behavior change in this patch, but this makes the display of status
>> hints more flexible as they can be enabled or disabled for individual
>> calls to commit.c:run_status().
>> [...]
>> +static void status_finalize(struct wt_status *s)
>> +{
>> +	determine_whence(s);
>> +	s->hints = advice_status_hints;
>> +}
>
> Is a "finalize" the right place to put the status hint tweak? I would
> expect the order for callers to be:
>
>   wt_status_prepare(&s);
>   /* manual tweaks of fields in "s" */
>   wt_status_finalize(&s);
>
> but the finalize would overwrite any tweak of the hints field. So it
> would make more sense to me for it to go in prepare().

"finalize" is indeed not the right name. I made a separate function to
avoid too much code duplication between status and commit, and looked
for a name comlementary to "prepare" for a function that is ran later to
fill-in some fields.

> The problem is that we are doing two things in that git_config call:
>
>   1. Loading basic git-wide core config.

(Yes. This includes the advice section, so I need it for
advice_status_hints)

> So the "cleanest" thing would be something like:
>
>   git_config(git_diff_ui_config, NULL);
>   wt_status_prepare(&s);

[...]

That is clean, but a bit long and it is essentially duplicated between
status and commit. I went another way: put all the similar code in a
common function status_init_config:

static void status_init_config(struct wt_status *s, config_fn_t fn)
{
	wt_status_prepare(s);
	gitmodules_config();
	git_config(git_status_config, s);
	determine_whence(s);
	s->hints = advice_status_hints; /* must come after git_config() */
}

We could split the git_config call, but that would not bring much
benefit IMHO. In any case, it can be done very simply on top of my patch
if needed later, as there is now only one call site for git_config.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
