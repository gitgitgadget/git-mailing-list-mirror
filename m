From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC PATCH 2/1] Make request-pull able to take a refspec of form local:remote
Date: Thu, 23 Jan 2014 11:43:22 -0800
Message-ID: <xmqqlhy6trfp.fsf@gitster.dls.corp.google.com>
References: <alpine.LFD.2.11.1401221535140.18207@i7.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Tejun Heo <tj@kernel.org>, Git Mailing List <git@vger.kernel.org>,
	Jeff King <peff@peff.net>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Thu Jan 23 20:43:35 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W6QBZ-0000O8-NM
	for gcvg-git-2@plane.gmane.org; Thu, 23 Jan 2014 20:43:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753403AbaAWTna (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 Jan 2014 14:43:30 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:59683 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752868AbaAWTn2 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Jan 2014 14:43:28 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E29B064FC7;
	Thu, 23 Jan 2014 14:43:27 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=a1PIM8Om7DN460srisZ3T+9RHb4=; b=j4qjH/
	9FwuqvLQNwnGr0QBMSKFXXS8UnsZZP+Glel5QU2QuGUtdPlKuz3ufIHmhKqNib92
	/jvzHhLjAYa92DX9+/5oPMj3MXKqPj58W1d9E545lax8oVTf+tAgtrEqzDjrgTz9
	SRzOYq837CUPqqwlowvZIDmJRDB4OmC68Rbc8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Y9S45qNzybmFABbxhzCtge9OTZaRguVX
	7BEdgXV3qOxhXquemiq0jAoKZyvy9laNrG/G7sF+u71R8jxipN1cOcaJ3k+YQ5Hk
	SeMXQDoJZ4oBlcnfzCn6e+0UNpdpQup5XYP4Lv0/tkwCWn+sXryMKjfgiNRAicq1
	keMJ9gI9NFA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C9D9C64FC5;
	Thu, 23 Jan 2014 14:43:27 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B1EE564FC4;
	Thu, 23 Jan 2014 14:43:25 -0500 (EST)
In-Reply-To: <alpine.LFD.2.11.1401221535140.18207@i7.linux-foundation.org>
	(Linus Torvalds's message of "Wed, 22 Jan 2014 16:06:32 -0800 (PST)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: A003BFAE-8466-11E3-AF76-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240929>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> So this relaxes the remote matching, and allows using the "local:remote" 
> syntax to say that the local branch is differently named from the remote 
> one.
>
> It is probably worth folding it into the previous patch if you think this 
> whole approach is workable.

Haven't thought enough to decide on that part, yet.

>  # $3 must be a symbolic ref, a unique ref, or
> -# a SHA object expression
> +# a SHA object expression. It can also be of
> +# the format 'local-name:remote-name'.
>  #
> -head=$(git symbolic-ref -q "${3-HEAD}")
> -head=${head:-$(git show-ref "${3-HEAD}" | cut -d' ' -f2)}
> -head=${head:-$(git rev-parse --quiet --verify "$3")}
> +local=${3%:*}
> +local=${local:-HEAD}
> +remote=${3#*:}
> +head=$(git symbolic-ref -q "$local")
> +head=${head:-$(git show-ref --heads --tags "$local" | cut -d' ' -f2)}
> +head=${head:-$(git rev-parse --quiet --verify "$local")}
>  
>  # None of the above? Bad.
> -test -z "$head" && die "fatal: Not a valid revision: $3"
> +test -z "$head" && die "fatal: Not a valid revision: $local"
>  
>  # This also verifies that the resulting head is unique:

I am not sure if it is a good idea to hand-craft "resulting head is
unique" constraint here.  We already have disambiguation rules (and
warning mechanism) we use in other places---this part should use the
same rule, I think.

A short experiment tells me that we are almost there:

  $ git init && git commit --allow-empty -m initial
  $ git branch other && git tag master
  $ git -c core.warnambiguousrefs=true \
      rev-parse --symbolic-full-name other
  refs/heads/other
  $ git -c core.warnambiguousrefs=true \
      rev-parse --symbolic-full-name master; echo $?
  warning: refname 'master' is ambiguous.
  error: refname 'master' is ambiguous
  0

We say "error" but we do not actually error out, but that shouldn't
be too hard to fix.

>  # "git show-ref" could have shown multiple matching refs..
>  headrev=$(git rev-parse --verify --quiet "$head"^0)
> -test -z "$headrev" && die "fatal: Ambiguous revision: $3"
> +test -z "$headrev" && die "fatal: Ambiguous revision: $local"
>  
>  # Was it a branch with a description?
>  branch_name=${head#refs/heads/}
> @@ -69,9 +73,6 @@ then
>  	branch_name=
>  fi
>  
> -prettyhead=${head#refs/}
> -prettyhead=${prettyhead#heads/}
> -
>  merge_base=$(git merge-base $baserev $headrev) ||
>  die "fatal: No commits in common between $base and $head"
>  
> @@ -81,30 +82,37 @@ die "fatal: No commits in common between $base and $head"
>  #
>  # Otherwise find a random ref that matches $headrev.
>  find_matching_ref='
> +	my ($head,$headrev) = (@ARGV);
> +	my ($found);
> +
>  	while (<STDIN>) {
> +		chomp;
>  		my ($sha1, $ref, $deref) = /^(\S+)\s+([^^]+)(\S*)$/;
> +		my ($pattern);
> +		next unless ($sha1 eq $headrev);
> +
> +		$pattern="/$head\$";

I think $head is constant inside the loop, so lift it outside?

> +		if ($ref eq $head) {
> +			$found = $ref;
> +		}
> +		if ($ref =~ /$pattern/) {
> +			$found = $ref;
>  		}
> +		if ($sha1 eq $head) {

I think this is $headrev ($head may be $remote or HEAD), but then
anything that does not point at $headrev has already been rejected
at the beginning of this loop, so...?

>  			$found = $sha1;
>  		}
>  	}
> +	if ($found) {
>  		print "$found\n";
>  	}
>  '

I somehow feel that this is inadequate to catch the "delayed
propagation" error in the opposite direction.  The publish
repository may have an unrelated ref pointing at the $headrev and we
may guess that is the ref to be fetched by the integrator based on
that, but by the time the integrator fetches from the repository,
the ref may have been updated to its new value that does not match
$headrev.  But I do not think of a way to solve that one.

In any case, shouldn't we be catching duplicate matches here, if the
real objective is to make it less likely for the users to make
mistakes?  Otherwise, if there are two 'master' over there
(e.g. refs/heads/master and refs/remotes/origin/master), it seems to
me that $ref =~ /$pattern/ will trigger twice in your loop and ends
up reporting the last match.

In other words,

	my (@found) = ();
        my (@guessed) = ();
	while (<STDIN>) {
		next unless ($sha1 eq $headrev);
        	...
                if ($ref =~ /$pattern/) {
                	push @found, $ref;
		} else {
                	push @guessed, $ref;
		}
	}
        if (@found == 1) {
        	print "$found[0]\n";
	} else if (@guessed == 1) {
        	print "$guessed[0]\n";
        }

or something like that?

> -ref=$(git ls-remote "$url" | @@PERL@@ -e "$find_matching_ref" "$head" "$headrev")
> +ref=$(git ls-remote "$url" | @@PERL@@ -e "$find_matching_ref" "${remote:-HEAD}" "$headrev")

There are three cases as far as ${remote:-HEAD} aka $head in the
script is concerned:

 1. The user said $3=local:remote; we do not want to guess, and we
    pass it thru, e.g. 'master:for-linus' will give 'for-linus',
    likely to mean 'refs/heads/for-linus' or 'refs/tags/for-linus'.
    The loop must find it if it is there and is a unique match.

 2. The user said $3=branch.

   a) It may have been pushed to the branch of the same name over
      there.  The loop must find it if it is there and is a unique
      match.

   b) It may have been pushed out as 'for-linus' branch or tag over
      there.  The loop must find it based on $headrev.

 3. The user said $3="", implying HEAD.

    Passing HEAD does not sound like a good way to handle this
    case, as the loop in find_matching_ref script would try to use
    it literally.

    With "git symbolic-ref HEAD | sed -e 's|^refs/heads/||" or an
    equivalent of it is used instead, we can reuse the logic in the
    second case fully, no?

It is too early to include in the discussion, but Peff's B@{publish}
notation may play a role in the future to convert 'local' to 'remote'
without the user having to say 'local:remote'.

Thanks.
