From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RFC] Do not show "diff --git" metainfo with --no-prefix
Date: Tue, 15 Jan 2008 17:46:07 -0800
Message-ID: <7vir1ubl0g.fsf@gitster.siamese.dyndns.org>
References: <c0f2d4110801150559x155ffabaj6bea52715522a070@mail.gmail.com>
	<alpine.DEB.1.00.0801151444180.5289@eeepc-johanness>
	<c0f2d4110801150758t68714570y83e1e74acbb67325@mail.gmail.com>
	<alpine.LNX.1.00.0801151728120.13593@iabervon.org>
	<7vhched3kw.fsf@gitster.siamese.dyndns.org>
	<7v4pded1rk.fsf_-_@gitster.siamese.dyndns.org>
	<alpine.LSU.1.00.0801160133150.17650@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Daniel Barkalow <barkalow@iabervon.org>,
	Chris Ortman <chrisortman@gmail.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Jan 16 02:46:56 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JExMg-0005Mh-Iv
	for gcvg-git-2@gmane.org; Wed, 16 Jan 2008 02:46:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754511AbYAPBqW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Jan 2008 20:46:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753967AbYAPBqW
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Jan 2008 20:46:22 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:47563 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752759AbYAPBqV (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Jan 2008 20:46:21 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 19EBB2F37;
	Tue, 15 Jan 2008 20:46:19 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 51C7B2F36;
	Tue, 15 Jan 2008 20:46:14 -0500 (EST)
In-Reply-To: <alpine.LSU.1.00.0801160133150.17650@racer.site> (Johannes
	Schindelin's message of "Wed, 16 Jan 2008 01:37:48 +0000 (GMT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70598>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> diff --git a/diff.c b/diff.c
>> index b18c140..8126a74 100644
>> --- a/diff.c
>> +++ b/diff.c
>> @@ -1246,30 +1258,46 @@ static void builtin_diff(const char *name_a,
>>  	char *a_one, *b_two;
>>  	const char *set = diff_get_color_opt(o, DIFF_METAINFO);
>>  	const char *reset = diff_get_color_opt(o, DIFF_RESET);
>> +	int is_git_diff = with_standard_prefix(o);
>>  
>>  	a_one = quote_two(o->a_prefix, name_a + (*name_a == '/'));
>>  	b_two = quote_two(o->b_prefix, name_b + (*name_b == '/'));
>>  	lbl[0] = DIFF_FILE_VALID(one) ? a_one : "/dev/null";
>>  	lbl[1] = DIFF_FILE_VALID(two) ? b_two : "/dev/null";
>> -	printf("%sdiff --git %s %s%s\n", set, a_one, b_two, reset);
>> +
>> +	if (!is_git_diff)
>> +		printf("%sIndex: %s%s\n", set, b_two, reset);
>> +	else
>> +		printf("%sdiff --git %s %s%s\n", set, a_one, b_two, reset);
>> +
>
> Hmm.  AFAICT plain diff outputs "diff ...", not "Index: ...".  IMHO doing 
> half of what SVN does, and half what GNU diff does, but not completely 
> what something else does, does not help anybody.
>
> So I'm mildly negative on this hunk.

You misread the intention of the patch.

This whole point of this RFC patch is about not labelling a
non-git patch that results from --no-prefix with "diff --git".
As I said in my reply to Daniel, I do not like "Index:" myself,
and doing printf("diff %s %s\n", a_one, b_two) instead would be
perfectly fine by me.

I do not mind keeping the metainformation such as rename/deleted
labels in the output of non-git case (iow, dropping all the
other hunks that pay attention to is_git_diff in the RFC patch).
As long as the patch is not labelled with "diff --git", stricter
checks in git-apply will not trigger, and it knows to skip these
non-patch lines.  Also a plain GNU patch would ignore those
metainformation lines, so there is no strong reason to remove
them from the output, unless somebody wants to use non patch non
git tool that is stricter for no good reason (and I'd agree with
you that the solution to such a tool is a postprocessing filter
outside of git).
