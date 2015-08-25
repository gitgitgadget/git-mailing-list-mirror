From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 5/8] checkout(-index): do not checkout i-t-a entries
Date: Tue, 25 Aug 2015 10:36:52 -0700
Message-ID: <xmqq8u8z1d8r.fsf@gitster.dls.corp.google.com>
References: <xmqqy4j80wdb.fsf@gitster.dls.corp.google.com>
	<1440205700-19749-1-git-send-email-pclouds@gmail.com>
	<1440205700-19749-6-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, phiggins@google.com, snoksrud@gmail.com
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 25 19:37:02 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZUI9c-0005i0-K3
	for gcvg-git-2@plane.gmane.org; Tue, 25 Aug 2015 19:37:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756041AbbHYRg4 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 25 Aug 2015 13:36:56 -0400
Received: from mail-pa0-f52.google.com ([209.85.220.52]:34653 "EHLO
	mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755785AbbHYRgy (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Aug 2015 13:36:54 -0400
Received: by pabzx8 with SMTP id zx8so39996948pab.1
        for <git@vger.kernel.org>; Tue, 25 Aug 2015 10:36:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type:content-transfer-encoding;
        bh=dyOQ3vFLiMr6ozM99GM1ckm4/BSq2RVRxokBpR+Ft7Q=;
        b=oF9FlNQJ2d17kCSl8FJjpqo3AOM0nwqvBupFaCup13O1zaJinqO2D6heh2k/Ym2agu
         Uent5yJI/JFhDEeMarKxxOqxz3UXrqZboRRS+apXwb2Xj19xWdqk6367EZZlRVkY8aZE
         31sQ7P19tOK55vCGW/bH7f5/6OQHEgU+IiMLUbwi4Eq/P/99wFdohwTCDaOBFiTyEzjh
         l3TbgL+FdB+HdbRfXTn4vruKwuIrRZxKvHBAKCsGyZtbsNbcwvmD00RZpriqycbXYjWg
         +l0HkINhfzzn4wPajuLtWOE0j62hfdn9RuvioPOTzqYTurh8rfRP/4p0FyQTQAzoQHwj
         5Mxw==
X-Received: by 10.66.139.6 with SMTP id qu6mr45067195pab.77.1440524213988;
        Tue, 25 Aug 2015 10:36:53 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:cdc0:fd6d:4069:6223])
        by smtp.gmail.com with ESMTPSA id uz5sm11604062pac.1.2015.08.25.10.36.53
        (version=TLS1_2 cipher=AES128-SHA256 bits=128/128);
        Tue, 25 Aug 2015 10:36:53 -0700 (PDT)
In-Reply-To: <1440205700-19749-6-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Sat, 22
 Aug 2015 08:08:08 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276547>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> The cached blob of i-t-a entries are empty blob. By checkout, we dele=
te
> the content we have. Don't do it.
>
> This is done higher up instead of inside checkout_entry() because we
> would have limited options in there: silently ignore, loudly ignore,
> die. At higher level we can do better reporting. For example, "git
> checkout -- foo" will complain that "foo" does not match pathspec, ju=
st
> like when "foo" is not registered with "git add -N"

Hmm, I am not sure about the example, though.  The user _told_ Git
that 'foo' is a path she cares about so "does not match pathspec" is
a very unfriendly thing to say.  "foo does not exist in the index
hence we cannot check it out" is a very good thing to say, though
(and of course, I agree that not touching the working tree is a good
thing to do).

> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>
> ---
>  builtin/checkout-index.c |  5 ++++-
>  builtin/checkout.c       |  2 ++
>  t/t2203-add-intent.sh    | 34 ++++++++++++++++++++++++++++++++++
>  3 files changed, 40 insertions(+), 1 deletion(-)
>
> diff --git a/builtin/checkout-index.c b/builtin/checkout-index.c
> index 8028c37..eca975d 100644
> --- a/builtin/checkout-index.c
> +++ b/builtin/checkout-index.c
> @@ -56,7 +56,8 @@ static int checkout_file(const char *name, const ch=
ar *prefix)
>  	while (pos < active_nr) {
>  		struct cache_entry *ce =3D active_cache[pos];
>  		if (ce_namelen(ce) !=3D namelen ||
> -		    memcmp(ce->name, name, namelen))
> +		    memcmp(ce->name, name, namelen) ||
> +		    ce_intent_to_add(ce))
>  			break;
>  		has_same_name =3D 1;
>  		pos++;

'pos' here comes from cache_name_pos(), and it is either the
location an entry with the same name exists, or the location a new
entry with the given name would be inserted at.

When we detect that the entry at pos is different from the given
name, we break out of the loop, because we _know_ that an entry with
the same name cannot exist.  Does the same hold for an i-t-a entry
that exactly records the given name?

The answer is yes, as you cannot have an unmerged i-t-a entry.  If a
path marked as i-t-a is in the index, no other entry with the same
name would exist.

So this change is good.  I would actually have introduced another
bool has_i_t_a to make the reporting richer, as it is your primary
reason why you are touching this part of the code instead of
checkout_entry().  The reporting part then would become

	fprintf(stderr, "git checkout-index: %s ", name);
-	if (!has_same_name)
+	if (has_i_t_a)
+       	fprintf(stderr, "is not yet in the cache);
	else if (!has_same_name)
		fprintf(stderr, "is not in the cache");

;-)

> @@ -99,6 +100,8 @@ static void checkout_all(const char *prefix, int p=
refix_length)
>  		if (ce_stage(ce) !=3D checkout_stage
>  		    && (CHECKOUT_ALL !=3D checkout_stage || !ce_stage(ce)))
>  			continue;
> +		if (ce_intent_to_add(ce))
> +			continue;

This one is obviously good ;-)

> diff --git a/builtin/checkout.c b/builtin/checkout.c
> index e1403be..02889d4 100644
> --- a/builtin/checkout.c
> +++ b/builtin/checkout.c
> @@ -300,6 +300,8 @@ static int checkout_paths(const struct checkout_o=
pts *opts,
>  			 * anything to this entry at all.
>  			 */
>  			continue;
> +		if (ce_intent_to_add(ce))
> +			continue;
>  		/*
>  		 * Either this entry came from the tree-ish we are
>  		 * checking the paths out of, or we are checking out

Hmm, while this does prevent the later code from checking it out, I
am not sure how well this interacts with ps_matched[] logic here.
If the user told Git that 'foo' is a path that she cares about with
"add -N foo", and said "git checkout -- foo", should we be somehow
saying that 'foo' did match but there is nothing to check out, or
something?
