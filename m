From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC] checkout to notice forks (Re: Minor annoyance with git
 push)
Date: Sat, 16 Feb 2008 20:11:35 -0800
Message-ID: <7v4pc843yg.fsf@gitster.siamese.dyndns.org>
References: <46a038f90802072044u3329fd33w575c689cba2917ee@mail.gmail.com>
 <20080209030046.GA10470@coredump.intra.peff.net>
 <7vtzkihkx5.fsf@gitster.siamese.dyndns.org>
 <46a038f90802090350rc4780d1ted60c03b9abf1fc0@mail.gmail.com>
 <7vwspd5z1d.fsf@gitster.siamese.dyndns.org>
 <7vfxvs75kp.fsf_-_@gitster.siamese.dyndns.org>
 <alpine.LNX.1.00.0802162202310.5496@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Martin Langhoff <martin.langhoff@gmail.com>,
	Jeff King <peff@peff.net>, Steffen Prohaska <prohaska@zib.de>,
	Git Mailing List <git@vger.kernel.org>,
	Johannes Schindelin <johannes.schindelin@gmx.de>
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Sun Feb 17 05:12:57 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JQatb-00007M-Ql
	for gcvg-git-2@gmane.org; Sun, 17 Feb 2008 05:12:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753985AbYBQEMV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 16 Feb 2008 23:12:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754071AbYBQEMV
	(ORCPT <rfc822;git-outgoing>); Sat, 16 Feb 2008 23:12:21 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:48539 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753712AbYBQEMU (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 Feb 2008 23:12:20 -0500
Received: from a-sasl-quonix.pobox.com (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id AE3CF65C9;
	Sat, 16 Feb 2008 23:12:16 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.pobox.com (Postfix) with ESMTP id
 7F45565C7; Sat, 16 Feb 2008 23:12:03 -0500 (EST)
In-Reply-To: <alpine.LNX.1.00.0802162202310.5496@iabervon.org> (Daniel
 Barkalow's message of "Sat, 16 Feb 2008 22:31:26 -0500 (EST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74094>

Daniel Barkalow <barkalow@iabervon.org> writes:

> I like this idea a lot. I'd actually also like it for commit, although (1) 
> and (3a) obviously don't happen there. It would help to combat my tendency 
> to forget to push when I mean to.

Thanks.

>> +/*
>> + * We really should allow cb_data... Yuck
>> + */
>> +static const char *branch_name;
>> +static int branch_name_len;
>> +static char *found_remote;
>> +static char *found_merge;
>> +static int read_branch_config(const char *var, const char *value)
>> +{
>
> ...
>
> I think you want branch_get(), which handles all the config file stuff up 
> to approximately here:

Fixups are very much welcomed.  This was more or less a proof of
concept.

>> +	if (show_log) {
>> +		const char *args[32];
>> +		int ac;
>> +
>> +		ac = 0;
>> +		args[ac++] = "log";
>> +		args[ac++] = "--pretty=oneline";
>> +		args[ac++] = "--abbrev-commit";
>> +		args[ac++] = "--left-right";
>> +		args[ac++] = "--boundary";
>> +		args[ac++] = symmetric;
>> +		args[ac++] = "--";
>> +		args[ac] = NULL;
>> +
>> +		run_command_v_opt(args, RUN_GIT_CMD);
>
> We really should be able to do this in-process, although I'm not sure if 
> we really can.

The code runs in_merge_bases() twice, between our branch head
and the base, but if we really care about the performance, we
can have a single merge-base traversal and the resulting object
pool will have everything necessary to emit the log output
without a separate traversal.

Because I think that is reasonably easy, I just did not bother
to.  This is not a performance critical piece of code anyway.

One thing I thought about was to limit the output to latest N
entries from both sides.  That would also be easier to implement
if we do a single merge-base traversal and reuse the result.
