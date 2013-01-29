From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 3/4] mergetool--lib: Add functions for finding
 available tools
Date: Tue, 29 Jan 2013 12:22:48 -0800
Message-ID: <7vr4l3oi1z.fsf@alter.siamese.dyndns.org>
References: <1359334346-5879-1-git-send-email-davvid@gmail.com>
 <1359334346-5879-2-git-send-email-davvid@gmail.com>
 <1359334346-5879-3-git-send-email-davvid@gmail.com>
 <1359334346-5879-4-git-send-email-davvid@gmail.com>
 <20130129194846.GD1342@serenity.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: David Aguilar <davvid@gmail.com>, git@vger.kernel.org
To: John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Tue Jan 29 21:23:17 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U0Hi9-0004tj-4N
	for gcvg-git-2@plane.gmane.org; Tue, 29 Jan 2013 21:23:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753372Ab3A2UWy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Jan 2013 15:22:54 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:46575 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753314Ab3A2UWw (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Jan 2013 15:22:52 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 97793C9D9;
	Tue, 29 Jan 2013 15:22:51 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Bhe5JN1HXv4bHCD2TeYQKX2vows=; b=HD6xgf
	ramHrbkjFZnLmdHM1+1RlpNn/9Q+h2CS4eydNcvabT5D/FoF2vbHj/YhAL4Y2x6c
	Lo8iYzB5bnkF3GJ28c2elMEURiH+axKP+aXOrzDjjwLGutzO9mio3Yc6bECRxwpK
	0i5utf6+N8Dl+osN13bqc5YHaG1Gd0p5EuIqA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=kllytQ1OD0VnIHoNghXQ10hOpTJmnAW3
	X6xad9n2UiQvNFS6GlU2VYOpxInNjSliK4h2QXcUnDAkKufGZPQydtv0ssDyFMrO
	0K1nWWO1rPHtkjwUCtDh03TBIJhp4njzLiKmqEpnDJuflTRM+7+P78drUcKkcktm
	3pIw5d4nMFE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8C0AFC9D8;
	Tue, 29 Jan 2013 15:22:51 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id DAB7FC9D7; Tue, 29 Jan 2013
 15:22:50 -0500 (EST)
In-Reply-To: <20130129194846.GD1342@serenity.lan> (John Keeping's message of
 "Tue, 29 Jan 2013 19:48:47 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: A7773804-6A51-11E2-9453-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214969>

John Keeping <john@keeping.me.uk> writes:

> On Sun, Jan 27, 2013 at 04:52:25PM -0800, David Aguilar wrote:
>> --- a/git-mergetool--lib.sh
>> +++ b/git-mergetool--lib.sh
>> @@ -2,6 +2,35 @@
>>  # git-mergetool--lib is a library for common merge tool functions
>>  MERGE_TOOLS_DIR=$(git --exec-path)/mergetools
>>  
>> +mode_ok () {
>> +	diff_mode && can_diff ||
>> +	merge_mode && can_merge
>> +}
>> +
>> +is_available () {
>> +	merge_tool_path=$(translate_merge_tool_path "$1") &&
>> +	type "$merge_tool_path" >/dev/null 2>&1
>> +}
>> +
>> +show_tool_names () {
>> +	condition=${1:-true} per_line_prefix=${2:-} preamble=${3:-}
>> +
>> +	( cd "$MERGE_TOOLS_DIR" && ls -1 * ) |
>
> Is the '*' necessary here?

No, it was just from a bad habit (I have ls aliased to ls -A or ls
-a in my interactive environment, which trained my fingers to this).

I also think you can lose -1, although it does not hurt.
>> +	tool_opt="'git ${TOOL_MODE}tool --tool-<tool>'"
>> +	available=$(show_tool_names 'mode_ok && is_available' '\t\t' \
>> +		"$tool_opt may be set to one of the following:")
>> +	unavailable=$(show_tool_names 'mode_ok && ! is_available' '\t\t' \
>> +		"The following tools are valid, but not currently available:")
>>  	if test -n "$available"
>>  	then
>> -		echo "'git $cmd_name --tool=<tool>' may be set to one of the following:"
>> -		echo "$available" | sort | sed -e 's/^/	/'
>> +		echo "$available"
>>  	else
>>  		echo "No suitable tool for 'git $cmd_name --tool=<tool>' found."
>>  	fi
>>  	if test -n "$unavailable"
>>  	then
>>  		echo
>> -		echo 'The following tools are valid, but not currently available:'
>> -		echo "$unavailable" | sort | sed -e 's/^/	/'
>> +		echo "$unavailable"
>>  	fi
>>  	if test -n "$unavailable$available"
>>  	then
>
> You haven't taken full advantage of the simplification Junio suggested
> in response to v1 here.  We can change the "unavailable" block to be:
>
>     show_tool_names 'mode_ok && ! is_available' "$TAB$TAB" \
>         "${LF}The following tools are valid, but not currently available:"

Actually I was hoping that we can enhance show_tool_names so that we
can do without the $available and $unavailable variables at all.

> If you also add a "not_found_msg" parameter to show_tool_names then the
> "available" case is also simplified:
>
>     show_tool_names 'mode_ok && is_available' "$TAB$TAB" \
>         "$tool_opt may be set to one of the following:" \
>         "No suitable tool for 'git $cmd_name --tool=<tool>' found."
>
> with this at the end of show_tool_names:
>
>     test -n "$preamble" && test -n "$not_found_msg" && \
>         echo "$not_found_msg"

Yes, something along that line.
