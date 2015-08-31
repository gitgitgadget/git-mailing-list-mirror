From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] log: diagnose empty HEAD more clearly
Date: Mon, 31 Aug 2015 09:36:51 -0700
Message-ID: <xmqq4mjfxvmk.fsf@gitster.mtv.corp.google.com>
References: <20150829050418.GA23757@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Aug 31 18:37:02 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZWS4q-0004gP-12
	for gcvg-git-2@plane.gmane.org; Mon, 31 Aug 2015 18:37:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753840AbbHaQgz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 31 Aug 2015 12:36:55 -0400
Received: from mail-pa0-f48.google.com ([209.85.220.48]:36620 "EHLO
	mail-pa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753679AbbHaQgx (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 31 Aug 2015 12:36:53 -0400
Received: by pabpg12 with SMTP id pg12so11862320pab.3
        for <git@vger.kernel.org>; Mon, 31 Aug 2015 09:36:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=c7en/qGLrkzjdNh5cgR0q809qA6vH2wLkfKwbRBbQN4=;
        b=I5ZQIb6eSSN3P6yubc8Y/SpM7rfqMXP9P6FFl6EVX8ZDHph1DET//uB0IvRSChv/Jn
         2rTZpsYea6Ukh7nijKCaGjPaiRsmiLuXHu52Uuh/6h2gpIuHYf7mOjFZ/WlyT6+DkglH
         44jb1nfaCPAlvDfAyWPgqrQ36VUBIDAqKLZ/6CF7DX/yinbrgwVG5hSBAqDUHYxqZXuj
         A5cK5xawV5YZWGaYC3ly0sjogcu4/WTYUbK4+ItBs4H+kIMmbTsWrwL4UfKnDQ3qreS8
         Tp4gm2ZYpSxeEsFR8vGQVovgnFfRdS1Rtlt15snmUX21svQ9id6T+ZRz2pf2kX4NjDYE
         QGgQ==
X-Received: by 10.68.114.196 with SMTP id ji4mr38926942pbb.46.1441039013234;
        Mon, 31 Aug 2015 09:36:53 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:1937:16f4:ede1:6d38])
        by smtp.gmail.com with ESMTPSA id kz8sm15238303pab.6.2015.08.31.09.36.52
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 31 Aug 2015 09:36:52 -0700 (PDT)
In-Reply-To: <20150829050418.GA23757@sigill.intra.peff.net> (Jeff King's
	message of "Sat, 29 Aug 2015 01:04:18 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276889>

Jeff King <peff@peff.net> writes:

> On Fri, Aug 28, 2015 at 02:11:01PM -0700, Junio C Hamano wrote:
>
>> * jk/log-missing-default-HEAD (2015-06-03) 1 commit
>>  - log: diagnose empty HEAD more clearly
>> 
>>  "git init empty && git -C empty log" said "bad default revision 'HEAD'",
>>  which was found to be a bit confusing to new users.
>> 
>>  What's the status of this one?
>
> You and I both provided patches, and you queued mine, but I think there
> was some question of whether the error messages were actually much
> better. Here's a re-roll that tries to improve them by avoiding the word
> "HEAD", which the user did not provide in the first place.
>
> -- >8 --
> Subject: log: diagnose empty HEAD more clearly
>
> If you init or clone an empty repository, the initial
> message from running "git log" is not very friendly:
>
>   $ git init
>   Initialized empty Git repository in /home/peff/foo/.git/
>   $ git log
>   fatal: bad default revision 'HEAD'
>
> Let's detect this situation and write a more friendly
> message:
>
>   $ git log
>   fatal: your current branch 'master' does not have any commits yet
>
> We also detect the case that 'HEAD' points to a broken ref;
> this should be even less common, but is easy to see. Note
> that we do not diagnose all possible cases. We rely on
> resolve_ref, which means we do not get information about
> complex cases. E.g., "--default master" would use dwim_ref
> to find "refs/heads/master", but we notice only that
> "master" does not exist. Similarly, a complex sha1
> expression like "--default HEAD^2" will not resolve as a
> ref.
>
> But that's OK. We fall back to a generic error message in
> those cases, and they are unlikely to be used anyway.
> Catching an empty or broken "HEAD" improves the common case,
> and the other cases are not regressed.
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
> Note that this doesn't take us any closer to a world where "git log" on
> an empty HEAD silently exits with success (which your patch did). I
> think it is somewhat orthogonal, though. If we wanted to do that we
> would probably still die for a while (as your patch did), and it would
> make sense to die using this diagnose function.
>
> So I'd be happy if you wanted to resurrect yours on top, or squash them
> together. But I do not really think it is worth dealing with the
> compatibility surprises to make the change.

Thanks, let's take just one baby step and apply this for now.
Others can work on top after the dust settles.



>
>  revision.c     | 17 ++++++++++++++++-
>  t/t4202-log.sh | 14 ++++++++++++++
>  2 files changed, 30 insertions(+), 1 deletion(-)
>
> diff --git a/revision.c b/revision.c
> index 5350139..af2a18e 100644
> --- a/revision.c
> +++ b/revision.c
> @@ -2187,6 +2187,21 @@ static int handle_revision_pseudo_opt(const char *submodule,
>  	return 1;
>  }
>  
> +static void NORETURN diagnose_missing_default(const char *def)
> +{
> +	unsigned char sha1[20];
> +	int flags;
> +	const char *refname;
> +
> +	refname = resolve_ref_unsafe(def, 0, sha1, &flags);
> +	if (!refname || !(flags & REF_ISSYMREF) || (flags & REF_ISBROKEN))
> +		die(_("your current branch appears to be broken"));
> +
> +	skip_prefix(refname, "refs/heads/", &refname);
> +	die(_("your current branch '%s' does not have any commits yet"),
> +	    refname);
> +}
> +
>  /*
>   * Parse revision information, filling in the "rev_info" structure,
>   * and removing the used arguments from the argument list.
> @@ -2316,7 +2331,7 @@ int setup_revisions(int argc, const char **argv, struct rev_info *revs, struct s
>  		struct object *object;
>  		struct object_context oc;
>  		if (get_sha1_with_context(revs->def, 0, sha1, &oc))
> -			die("bad default revision '%s'", revs->def);
> +			diagnose_missing_default(revs->def);
>  		object = get_reference(revs, revs->def, sha1, 0);
>  		add_pending_object_with_mode(revs, object, revs->def, oc.mode);
>  	}
> diff --git a/t/t4202-log.sh b/t/t4202-log.sh
> index 35d2d7c..6ede069 100755
> --- a/t/t4202-log.sh
> +++ b/t/t4202-log.sh
> @@ -894,4 +894,18 @@ test_expect_success 'log --graph --no-walk is forbidden' '
>  	test_must_fail git log --graph --no-walk
>  '
>  
> +test_expect_success 'log diagnoses bogus HEAD' '
> +	git init empty &&
> +	test_must_fail git -C empty log 2>stderr &&
> +	test_i18ngrep does.not.have.any.commits stderr &&
> +	echo 1234abcd >empty/.git/refs/heads/master &&
> +	test_must_fail git -C empty log 2>stderr &&
> +	test_i18ngrep broken stderr &&
> +	echo "ref: refs/heads/invalid.lock" >empty/.git/HEAD &&
> +	test_must_fail git -C empty log 2>stderr &&
> +	test_i18ngrep broken stderr &&
> +	test_must_fail git -C empty log --default totally-bogus 2>stderr &&
> +	test_i18ngrep broken stderr
> +'
> +
>  test_done
