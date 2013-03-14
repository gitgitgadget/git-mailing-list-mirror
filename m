From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 3/3] difftool --dir-diff: symlink all files matching
 the working tree
Date: Thu, 14 Mar 2013 15:31:53 -0700
Message-ID: <7vobelwr3a.fsf@alter.siamese.dyndns.org>
References: <cover.1363206651.git.john@keeping.me.uk>
 <cover.1363291949.git.john@keeping.me.uk>
 <ae17a152cadc650920c6446a4493384cc2e77309.1363291949.git.john@keeping.me.uk>
 <7v620ty8lc.fsf@alter.siamese.dyndns.org>
 <20130314222415.GC4256@serenity.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, David Aguilar <davvid@gmail.com>,
	Matt McClure <matthewlmcclure@gmail.com>,
	Tim Henigan <tim.henigan@gmail.com>
To: John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Thu Mar 14 23:32:31 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UGGhE-0006gp-9T
	for gcvg-git-2@plane.gmane.org; Thu, 14 Mar 2013 23:32:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753488Ab3CNWb5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Mar 2013 18:31:57 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:51020 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753373Ab3CNWb4 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Mar 2013 18:31:56 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 135ACC915;
	Thu, 14 Mar 2013 18:31:56 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=IfogLyx3OhECvZHj8yLpVaa0ob8=; b=cE/xrX
	VDTuVej+Cy0DQZhSJczHPiflCys1yzf3t0tMhl7HuTTD0Y7miAzLVMn9d+Vt+DZn
	83NbEM0BhsAmuIKHhUhLQiaBl8dPIqV6704gLaGVjAf5JSi7Ms+gSLhmLMxql14h
	3N+MvEDq6SYCYUYm+mAGCAY6OUdo/7EXjpjMA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=clPSuk8xMznrMVIBXDnVBpCRDFOBPK3K
	UVCeiJCHf+A6YzPySLo6wfE+pQ/JQUUTWNb0rsnFn84EVLy+HQ7lTTcJ3y3DTbhO
	Lev6w6OIqzNeyfZB1cXszSJbUF82kXiZri+h9Ybgwr7p8rQhpQyC9DzZB3kON0CI
	+Njjblcf7jg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 07DC0C914;
	Thu, 14 Mar 2013 18:31:56 -0400 (EDT)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 761A1C912; Thu, 14 Mar 2013
 18:31:55 -0400 (EDT)
In-Reply-To: <20130314222415.GC4256@serenity.lan> (John Keeping's message of
 "Thu, 14 Mar 2013 22:24:15 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: F9C93C2A-8CF6-11E2-8FC6-4AAA2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218176>

John Keeping <john@keeping.me.uk> writes:

>> > +for f in file file2 sub/sub
>> > +do
>> > +	echo "$f"
>> > +	readlink "$2/$f"
>> > +done >actual
>> > +EOF
>> 
>> When you later want to enhance the test to check a combination of
>> difftool arguments where some paths are expected to become links and
>> others are expected to become real files, wouldn't this helper
>> become a bit awkward to use?  The element that expects a real file
>> could be an empty line to what corresponds to the output from
>> readlink, but still...
>> ...
>
> It looks like t3903 uses "ls -l" for this sort of test, perhaps
> something like this covers these cases better:
> ...
>     grep "-> $workdir/file" file.actual

Writing it without -e would confuse some implementations of grep
into thinking "-" introduces an option, realizing it does not
support the "->" option, and then barfing ;-)

What I had in mind was more along the lines of...

	for f
        do
        	echo "$f"
                readlink "$2/$f" || echo "# not a link $f"
	done

so that your "expect" list can become

	file
        $(pwd)/realdir/file
        modifiedone.txt
        # not a link modifiedone.txt

In any case, this "say blank if you expect a non symlink" is not an
urgent issue that needs to be fixed or anything like that, so let's
queue the v2 for now and see what happens.

Thanks.
