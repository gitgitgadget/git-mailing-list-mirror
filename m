From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 04/11] sequencer.c: recognize "(cherry picked from ..."
 as part of s-o-b footer
Date: Wed, 28 Nov 2012 16:02:12 -0800
Message-ID: <7v8v9ltgxn.fsf@alter.siamese.dyndns.org>
References: <1353894359-6733-1-git-send-email-drafnel@gmail.com>
 <1353894359-6733-5-git-send-email-drafnel@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, pclouds@gmail.com,
	Brandon Casey <bcasey@nvidia.com>
To: Brandon Casey <drafnel@gmail.com>
X-From: git-owner@vger.kernel.org Thu Nov 29 01:02:33 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TdraJ-0007Is-SF
	for gcvg-git-2@plane.gmane.org; Thu, 29 Nov 2012 01:02:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932725Ab2K2ACR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Nov 2012 19:02:17 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:61059 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932576Ab2K2ACQ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Nov 2012 19:02:16 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5015F9C05;
	Wed, 28 Nov 2012 19:02:15 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Py4KR1l8FPrVYjNCPqKHH6UOzXE=; b=KyP1Bb
	sM7rGLR9d5J3SG0/QFxfza9QWKtXVIQcc21L1uUYTLnyKK43GEmre5F1IGN1pE95
	XAMPGxy9ShpZi/wUANfbm5dYvj+HTF5PTQFSGd8H9vTbopgP7BV+HJ9gK/MKGF7E
	qrTia2TL9uvSnM/PtqT/9S5if6LeqnAXgSP0I=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=c0fRegiTKlD+7pfqCExDBDZWioa/6ZzP
	BPn93EaTmy4pq0eAqSp6HkgYdVdV+y/plyRudevtFa5jz3JLw7+a/iDXRO7CENeN
	U2KlB9tyZR+sPAsGBebDwDzgFFzh6mwZJGIdW5J4/OwBeA3mMThpmcKyA5l1/KOO
	7s4o/IAFQDs=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3E6F99C04;
	Wed, 28 Nov 2012 19:02:15 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 3CF1B9C01; Wed, 28 Nov 2012
 19:02:14 -0500 (EST)
In-Reply-To: <1353894359-6733-5-git-send-email-drafnel@gmail.com> (Brandon
 Casey's message of "Sun, 25 Nov 2012 17:45:52 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 07D322BE-39B8-11E2-938A-C2612E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210802>

Brandon Casey <drafnel@gmail.com> writes:

> -static int ends_rfc2822_footer(struct strbuf *sb, int ignore_footer)
> +static int is_rfc2822_line(const char *buf, int len)
> +{
> +	int i;
> +
> +	for (i = 0; i < len; i++) {
> +		int ch = buf[i];
> +		if (ch == ':')
> +			break;
> +		if (isalnum(ch) || (ch == '-'))
> +			continue;
> +		return 0;
> +	}
> +
> +	return 1;
> +}
> +
> +static int is_cherry_pick_from_line(const char *buf, int len)
> +{
> +	return (strlen(cherry_picked_prefix) + 41) <= len &&
> +		!prefixcmp(buf, cherry_picked_prefix);
> +}
> +
> +static int has_conforming_footer(struct strbuf *sb, int ignore_footer)
>  {
> -	int ch;
>  	int hit = 0;
> -	int i, j, k;
> +	int i, k;
>  	int len = sb->len - ignore_footer;
>  	const char *buf = sb->buf;
>  
> @@ -1039,15 +1061,9 @@ static int ends_rfc2822_footer(struct strbuf *sb, int ignore_footer)
>  			; /* do nothing */
>  		k++;
>  
> -		for (j = 0; i + j < len; j++) {
> -			ch = buf[i + j];
> -			if (ch == ':')
> -				break;
> -			if (isalnum(ch) ||
> -			    (ch == '-'))
> -				continue;
> +		if (!(is_rfc2822_line(buf+i, k-i) ||
> +			is_cherry_pick_from_line(buf+i, k-i)))
>  			return 0;
> -		}
>  	}
>  	return 1;
>  }

Refactored code looks vastly more readable, but I think the
is_cherry_pick_from_line() function (by the way, shouldn't it be
named is_cherry_picked_from_line()?) shows its ambivalence.  It
insists that the line has to be long enough to hold 40-hex object
name plus a closing parenthesis, but it only makes sure that the
prefix matches, without checking if the line has 40-hex object name,
or the object name is immediately followed by a closing parenthesis.
It also does not care if there are other garbage after it.

If the code is trying to be strict to avoid misidentification, then
the check should be tightened (i.e. require the known fixed length,
make sure get_sha1_hex() is happy, 41st byte is a close parenthesis
that is followed by the end of line).  If the code is trying to be
more lenient to allow people hand-editing the cherry-picked-from
line that was generated, the check could be loosened (people may
truncate the 40-hex down to 12-hex or something).

I cannot read from this code which one was intended; the code must
make up its mind, whichever way (I do not have a strong preference).

> +test_expect_success 'cherry-pick -x -s adds sob when last sob doesnt match committer' '

Is the title of this test appropriate?  It looks like it is making
sure we do not add an extra blank line after the existing footer to
me.

> +	pristine_detach initial &&
> +	sha1=`git rev-parse mesg-with-footer^0` &&
> +	git cherry-pick -x -s mesg-with-footer &&
> +	cat <<-EOF >expect &&
> +		$mesg_with_footer
> +		(cherry picked from commit $sha1)
> +		Signed-off-by: $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL>
> +	EOF
> +	git log -1 --pretty=format:%B >actual &&
> +	test_cmp expect actual
> +'
> +

> +test_expect_success 'cherry-pick -x -s adds sob even when trailing sob exists for committer' '
> +	pristine_detach initial &&
> +	sha1=`git rev-parse mesg-with-footer-sob^0` &&
> +	git cherry-pick -x -s mesg-with-footer-sob &&
> +	cat <<-EOF >expect &&
> +		$mesg_with_footer_sob
> +		(cherry picked from commit $sha1)
> +		Signed-off-by: $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL>
> +	EOF
> +	git log -1 --pretty=format:%B >actual &&
> +	test_cmp expect actual
> +'

For people on the sideline, $mesg_with_footer_sob ends with s-o-b by
the same "$GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL>" we are adding
here.  This is probably a sensible thing to do.

One thing I am not so happy about this whole "(cherry picked from"
thing (and I am again agreeing with Linus who made me change the
default long time ago not to add this line by default) is this.  If
you use "cherry-pick -s -x $commit" to transplant a commit from an
unrelated part of the history, you will get the object name in the
resulting commit.  But you can do the same in at least two different
ways.  The easiest is:

    git format-patch -1 --stdout $commit | git am -s3

and a bit closer to what "cherry-pick" does is:

    git checkout $commit^0 &&
    git rebase --onto @{-1} HEAD^ &&
    git checkout -B @{-1}

i.e. rebase the single commit on top of the branch you were on.

In either way, you don't get "cherry picked from", even though you
just did the moral equivalent of it.  Also we need to realize that
the first one is essentially what happens all the time here; the "|"
is implemented by the mailing list.  And nobody misses "cherry
picked from" to point at the original commit object, which is
useless for the recipient of the resulting commit.

But that is an orthogonal issue.
