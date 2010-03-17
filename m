From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3] git checkout -b: unparent the new branch with -o
Date: Wed, 17 Mar 2010 10:17:26 -0700
Message-ID: <7v7hpauau1.fsf@alter.siamese.dyndns.org>
References: <1268763584-14164-1-git-send-email-erick.mattos@gmail.com>
 <7v634v27vf.fsf@alter.siamese.dyndns.org>
 <55bacdd31003161810w1c824570lee1b7d5759568bc1@mail.gmail.com>
 <20100317041307.GA26641@progeny.tock>
 <7v4okfiksh.fsf@alter.siamese.dyndns.org>
 <20100317064034.GA31749@progeny.tock>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Erick Mattos <erick.mattos@gmail.com>, git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 17 18:17:44 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NrwsI-0001rO-Sa
	for gcvg-git-2@lo.gmane.org; Wed, 17 Mar 2010 18:17:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754919Ab0CQRRg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Mar 2010 13:17:36 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:58944 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754094Ab0CQRRg (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Mar 2010 13:17:36 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 46882A28D6;
	Wed, 17 Mar 2010 13:17:35 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=GClVlLNWEczmg2U8JSKqHOHFvg8=; b=SzdSub
	/FkEnsm7aLLiHWp8DCTsUizawL7CG1u+K5A0QLXZkCDHbmREOS60SYqbYrQcApdX
	ziCureFCzaAfwwtQcSpgM1/w9DY35xOpTT9s0wkQdWFFzYUVAkVLp2XhY2iXCLNf
	UB7kyXGTGlPqbXZD15X84PhEPi+z/+y+AFDMs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=pWKQi9Y0kfyqI3S7On8hz0sFjZYqS6OG
	xQkdcEj3kWAklKBJfs3kuXo3PEOcXDkp+jP6LpFqvlTFOZqQSw0dL7bofKpH15xw
	VHFogU1/mebNZAiT2US9NGo9+mnf3HmjfBNh9cHDew3wM62XownbCr0fS8EbCI5Y
	QfOxWcW6sR0=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 15519A28D5;
	Wed, 17 Mar 2010 13:17:32 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 40167A28D4; Wed, 17 Mar
 2010 13:17:28 -0400 (EDT)
In-Reply-To: <20100317064034.GA31749@progeny.tock> (Jonathan Nieder's message
 of "Wed\, 17 Mar 2010 01\:40\:34 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: F8CA51D6-31E8-11DF-B87B-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142418>

Jonathan Nieder <jrnieder@gmail.com> writes:

> Okay, fair enough.  From the point of view of plumbing, what is there
> left to do that
>
> 	git rm -f . &&
> 	git symbolic-ref HEAD refs/heads/new
>
> or
>
> 	git symbolic-ref HEAD refs/heads/new
>
> or
>
> 	git rm --cached . &&
> 	git symbolic-ref HEAD refs/heads/new
>
> does not take care of?

If we have the "just detach, don't touch index nor working tree", which
happens to be the cheapest one in the middle (except that it probably
wants to verify that "new" does not exist yet), the calling script of the
Porcelain suite can use it in conjunction with various forms of "git rm"
without incurring any additional overhead (other than a fork-and-exec),
and I think that would be sufficient.

You could add

	git ls-files |
        while read path
        do
        	case $(choose-keep-drop-nuke "$path") in
                keep) ;;
                drop) git rm --cached -f "$path" ;;
                nuke) git rm -f "$path" ;;
        	esac
	done
	git symbolic-ref HEAD refs/heads/new

and have the caller supply a callback that intelligently choose what to
keep and what to drop, if you want to be really fancy, but at that level
of complexity, I think it is something the Porcelain writer using the
plumbing would want to write himself as part of the Porcelain program.

We might want to add "git branch --switch <branchname>" that is roughly
like this:

    ref="refs/heads/$branch"
    git check-ref-format "$ref" || die "malformed"
    if git rev-parse -q --verify "$ref" >/dev/null
    then
    	# exists
        exec git checkout "$branch"
    else
	# create
	exec git symbolic-ref HEAD "$ref"
    fi
