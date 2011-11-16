From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] apply: squash consecutive slashes with p_value > 0
Date: Wed, 16 Nov 2011 09:36:42 -0800
Message-ID: <7v62ikq89h.fsf@alter.siamese.dyndns.org>
References: <20111116120403.GA10342@mal.justgohome.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Robie Basak <robie.basak@canonical.com>
X-From: git-owner@vger.kernel.org Wed Nov 16 18:36:53 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RQjPn-0007zI-Un
	for gcvg-git-2@lo.gmane.org; Wed, 16 Nov 2011 18:36:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756278Ab1KPRgq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Nov 2011 12:36:46 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:45440 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753809Ab1KPRgq (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Nov 2011 12:36:46 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0A2056107;
	Wed, 16 Nov 2011 12:36:45 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=xP3bA0s2256MaBirw2SFL+GIPCA=; b=TLjAl6
	3hq8Del788tJYb/ofPuel9l7fZ1EMvrtuWjiltmoNkIeDsoiIs2KvaX3BbKcdMAy
	Hz8wR0Hn2Vl3fJfeovzHpdq/4xqunrGMMrqajdBCKMfUKlOUH8gmJqQJtNLHxIYY
	SEtyTAWbrw6SBhLeT0XC2irMMuMJ/y4wZmtnQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Zcn18yV1mOWtzRMHhtBbV247+023Tb8h
	nF3AwCKTK7vMSLvvoSHxRrjb64oz47HMRlr5M1mVdsGnRBK6H7eBjihV6G4Jpgm5
	pFMfAvR0/Z35W4oX+pY6bX1qDHXa3ny16ijzD/ZtlYiXMMO8R+8iagBChGIigfuI
	KgWUvY+Eoc0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 01D476106;
	Wed, 16 Nov 2011 12:36:45 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 5FEA06104; Wed, 16 Nov 2011
 12:36:44 -0500 (EST)
In-Reply-To: <20111116120403.GA10342@mal.justgohome.co.uk> (Robie Basak's
 message of "Wed, 16 Nov 2011 12:04:03 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 8D35E978-1079-11E1-966A-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185554>

Robie Basak <robie.basak@canonical.com> writes:

> "patch" works with -p1 and diffs in the following form:
>     --- foo.orig//bar
>     +++ foo//bar
>     ...
>
> patch(1) says that "A sequence of one or more adjacent slashes is
> counted as a single slash."

It merely says patch(1) treats duplicate slashes that way; it does not
mean it is a useful thing to do in the real life.

Could you justify why such a change is a good thing in your proposed
commit log message?

>  builtin/apply.c              |    8 ++++++--
>  t/t4153-apply-doubleslash.sh |   29 +++++++++++++++++++++++++++++
>  2 files changed, 35 insertions(+), 2 deletions(-)
>  create mode 100755 t/t4153-apply-doubleslash.sh

Can we avoid wasting a new test number for just a single trivial test by
findign appropriate places in existing tests to add new ones to? I think
4133 may be one of the good places (not just checkint between a/f vs b/f,
you would check a//f vs b/f and somesuch).

> diff --git a/builtin/apply.c b/builtin/apply.c
> index 84a8a0b..78e25fa 100644
> --- a/builtin/apply.c
> +++ b/builtin/apply.c
> @@ -627,9 +627,13 @@ static char *find_name_common(const char *line, char *def, int p_value,
>  			if (name_terminate(start, line-start, c, terminate))
>  				break;
>  		}
> -		line++;
> -		if (c == '/' && !--p_value)
> +		if (c == '/' && !--p_value) {
> +			while (*line == '/')
> +			    line++;
>  			start = line;

I am not sure if this is sufficient or necessarily correct.

You are de-dupling slashes only when p_value hits 0. When working on an
input "a///b//c" with -p3, your loop strips one slash per decrement of
p_value between "a" and "b" and then you notice slashes after "b" are
duplicated and clean them up, which would mean you normalized the input to
"a///b/c", not "a/b/c", no?
