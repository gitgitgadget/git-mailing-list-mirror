From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] grep: do not do external grep on skip-worktree entries
Date: Sat, 02 Jan 2010 10:44:57 -0800
Message-ID: <7vtyv4cpna.fsf@alter.siamese.dyndns.org>
References: <1262182304-19911-1-git-send-email-pclouds@gmail.com>
 <7v637nzky0.fsf@alter.siamese.dyndns.org>
 <7vzl4zy5z3.fsf@alter.siamese.dyndns.org> <20100102115041.GA32381@do>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jan 02 19:45:19 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NR8yT-0003Fe-NO
	for gcvg-git-2@lo.gmane.org; Sat, 02 Jan 2010 19:45:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751513Ab0ABSpH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 2 Jan 2010 13:45:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751500Ab0ABSpH
	(ORCPT <rfc822;git-outgoing>); Sat, 2 Jan 2010 13:45:07 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:32829 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751298Ab0ABSpE (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 2 Jan 2010 13:45:04 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 01CDB8DAC9;
	Sat,  2 Jan 2010 13:45:04 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=nLrtmIJcKiH45K42almigxTtWlE=; b=f65F/d3pjCYZG61MmSPwTCg
	TMxo+ywIHspb5n3VX+xq7c9AETfvTfzSsWgMyhxpMCLExqws0CndtbifBdLddj9C
	hlAd+Ul7MLTpwtCK98JJ4HvFU8eDGACbgzF0LyEtDeWLOPhHLxI8Pu/dyzuv1pj8
	+6y1poGE7Aj0tvFQJlmM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=gahRNFxqsD9ei08VG2tWKGbo+E9xhwZ7mPITNPoMZwMB7AEui
	T/bMDN8N8rhh2d7OpbrMHJ45KewolCQks9KVVuk+H5BCy/rCKDb6YKZ2jrLov+cG
	/41nFz57Q4zB53k7cbzjxBlJ4BoxNAYZNVCvV+zsoGBYpnLue0Zcb2/w3w=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id D2F7F8DAC8;
	Sat,  2 Jan 2010 13:45:01 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 2AFBA8DAC7; Sat,  2 Jan
 2010 13:44:59 -0500 (EST)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: EF552724-F7CE-11DE-BCC8-9D59EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136039>

Nguyen Thai Ngoc Duy <pclouds@gmail.com> writes:

> On Wed, Dec 30, 2009 at 11:09:52PM -0800, Junio C Hamano wrote:
>> Junio C Hamano <gitster@pobox.com> writes:
>> 
>> > This looks a bit wrong for a couple of reasons:
>> >
>> >  - external_grep() is designed to return negative without running external
>> >    grep when it shouldn't be used (see the beginning of the function for
>> >    how it refuses to run when opt->extended is set and other conditions).
>> >    The new logic seems to belong there, i.e. "in addition to the existing
>> >    case we decline, if ce_skip_worktree() entry exists in the cache, we
>> >    decline";
>> 
>> IOW, something like this instead of your patch.  You would want to tests
>> to demonstrate the original breakage, perhaps?
>
> Your patch works great. By the way I think we should move "cached"
> check from grep_cache() into external_grep() too, for consistency.

I think what I gave you is more consistent.

"cached" is about "are we searching in the index or in the work tree?" and
"external_grep()" is about "it often is faster to run external grep when
we are searching in the work tree, so do that if the other constraints
allow us to".  An example of such a constraint is that we must be able to
express the operation on the command line of a traditional grep, and use
of git extended grep synatx makes it unfeasible, hence the function says
"I can't" in such a case.

You can change the definition of "external_grep()" to "try to use external
grep somewhere, if the other constraints allow us to", and have the caller
and the function do an "this time, please grep for this pattern in the
index---I can't" exchange, but I don't see much point.  We _know_ no
external grep will ever be able to read from the index.

We should simply drop "cached" argument from external_grep().

> I thought of tests when I wrote the patch, but it was hard to find a
> reliable way to detect if a git build supports external grep.

Ah, you are right.  I forgot about that issue.

> diff --git a/t/t7002-grep.sh b/t/t7002-grep.sh
> index abd14bf..f77970c 100755
> --- a/t/t7002-grep.sh
> +++ b/t/t7002-grep.sh
> @@ -8,6 +8,14 @@ test_description='git grep various.
>  
>  . ./test-lib.sh
>  
> +support_external_grep() {
> +	case "$(git grep -h 2>&1 >/dev/null|grep -e --ext-grep)" in
> +	*"(default)"*)  return 0;;
> +	*"(ignored by this build)"*) return 1;;
> +	*) test_expect_success 'External grep check is broken' 'false';;
> +	esac
> +}

Heh, clever.

	git grep -h 2>&1 | grep 'allow calling of grep.*default' >/dev/null

may be sufficient, though.
