From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 7/7] mergetool--lib: Improve show_tool_help() output
Date: Fri, 25 Jan 2013 12:56:37 -0800
Message-ID: <7vlibh2d8a.fsf@alter.siamese.dyndns.org>
References: <1359107034-14606-1-git-send-email-davvid@gmail.com>
 <1359107034-14606-8-git-send-email-davvid@gmail.com>
 <20130125195446.GA7498@serenity.lan> <20130125200807.GB7498@serenity.lan>
 <7vpq0t2f2t.fsf@alter.siamese.dyndns.org>
 <20130125204619.GC7498@serenity.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: David Aguilar <davvid@gmail.com>, git@vger.kernel.org
To: John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Fri Jan 25 21:57:07 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TyqKd-0002wD-BB
	for gcvg-git-2@plane.gmane.org; Fri, 25 Jan 2013 21:57:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752908Ab3AYU4m (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Jan 2013 15:56:42 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:55331 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751448Ab3AYU4k (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Jan 2013 15:56:40 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1DE42CF79;
	Fri, 25 Jan 2013 15:56:40 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=AvmRM1JIt/Lrcy6RW9Yv3PRSBw0=; b=k705hu
	0TC6cJM9G45GyMwpF9Xu/jlLnSbPFR45hgNJFjjMJIQiiuF+gFdCzhtwwJWf3/nY
	MXGFjwrpqLLWussKytn23j3nStwZAMn3uSZ5SFfppfyw+NYNwZn7tIST8zNuwb3j
	AQ8UtbRTs1V+76THkmf+93EEB8wjvfweWdiBM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=FAgLJqwegDH8/tiIfT7FbknLDH0OZP8+
	s4mHfmzRAG5aUtlKr4JkQnnG7uLlCVMR7dTAu910pM82y2MCcmv72oIqrBq8dOrJ
	Z+Ssz9KFVAqdPu05ATIHSor2dhNjvyKSHf5yBtrTyBWa39uuRcFrnkaWlqmffS2B
	ZWAJCrm2St4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 12476CF78;
	Fri, 25 Jan 2013 15:56:40 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 6B209CF74; Fri, 25 Jan 2013
 15:56:39 -0500 (EST)
In-Reply-To: <20130125204619.GC7498@serenity.lan> (John Keeping's message of
 "Fri, 25 Jan 2013 20:46:19 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: B6EB3182-6731-11E2-9EAF-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214582>

John Keeping <john@keeping.me.uk> writes:

> On Fri, Jan 25, 2013 at 12:16:42PM -0800, Junio C Hamano wrote:
>> John Keeping <john@keeping.me.uk> writes:
>> 
>> > Actually, can we just change all of the above part of the loop to:
>> >
>> > 	test "$tool" = defaults && continue
>> >
>> > 	merge_tool_path=$(
>> > 		setup_tool "$tool" >/dev/null 2>&1 &&
>> > 		translate_merge_tool_path "$tool"
>> > 	) || continue
>> 
>> Meaning "setup_tool ought to know which mode we are in and should
>> fail if we are in merge mode and it does not support merging"?  That
>> line of reasoning makes tons of sense to me, compared to this script
>> implementing that logic for these scriptlets.
>
> Yes, that's part of what setup_tool does.  It actually calls "exit" if
> the "mode? && can_mode" test fails, which is why we need to call it in
> the subshell.
>
> I think this would get even better if we add a preparatory patch like
> this, so we can just call setup_tool and then set merge_tool_path:
>
> -- >8 --
>
> diff --git a/git-mergetool--lib.sh b/git-mergetool--lib.sh
> index 888ae3e..4644cbf 100644
> --- a/git-mergetool--lib.sh
> +++ b/git-mergetool--lib.sh
> @@ -67,11 +67,11 @@ setup_tool () {
>  	if merge_mode && ! can_merge
>  	then
>  		echo "error: '$tool' can not be used to resolve merges" >&2
> -		exit 1
> +		return 1
>  	elif diff_mode && ! can_diff
>  	then
>  		echo "error: '$tool' can only be used to resolve merges" >&2
> -		exit 1
> +		return 1
>  	fi
>  	return 0
>  }
> @@ -100,7 +100,7 @@ run_merge_tool () {
>  	status=0
>  
>  	# Bring tool-specific functions into scope
> -	setup_tool "$1"
> +	setup_tool "$1" || return
>  
>  	if merge_mode
>  	then
>
> -- 8< --
>  
>> How/when does translate_merge_tool_path fail?
>
> It doesn't - the "|| continue" is to catch errors from setup_tool.

Ugh.
