From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Use of a mailmap file with git-log
Date: Mon, 10 Dec 2012 11:43:13 -0800
Message-ID: <7vobi1ae26.fsf@alter.siamese.dyndns.org>
References: <CALKB1SXdNVsQop5VYmShOMx93+j5SPdkGF9yNU5k7nXg87TwMw@mail.gmail.com>
 <7v38zdbv6d.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Rich Midwinter <rich.midwinter@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Dec 10 20:43:51 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ti9GU-0001lP-B2
	for gcvg-git-2@plane.gmane.org; Mon, 10 Dec 2012 20:43:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752294Ab2LJTnU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Dec 2012 14:43:20 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:55655 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751735Ab2LJTnR (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Dec 2012 14:43:17 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 33642A13A;
	Mon, 10 Dec 2012 14:43:16 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=dazF0bQhPqL9izVDmrc3/HXKpe0=; b=WHSyvo
	lSkpBsBmKTuNsJcXH5Am1jG3xfNDjYvdSqvFR6Ccjyz0NYP6Zreqc6tacrG+YEIx
	p7pnQXeOCfWhsZL+MxSobu3M2IxjUPpgNs3dDNtncCjtEJN1CiNWeSFDRuY6InGx
	aNQESRTJ+hSm2tac+P+uyqfrLCNs476tOwbZU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=QnEDgmI8I3GWdMetN04KoNLKOK9vxq9M
	GXa82YmkGkXTrQvMeoRm8JIgg70spbdI+bZvlTiuw2Ci4tXtsgvI96Dq11BrGmHS
	c0n8VISCz0gBJQbiaBMrSSe5vL3ILphJCjSigB+jZz7GHhglkybuRoVmJbzD1DBA
	o3ITeg68NqU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 20142A139;
	Mon, 10 Dec 2012 14:43:16 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 7243BA137; Mon, 10 Dec 2012
 14:43:15 -0500 (EST)
In-Reply-To: <7v38zdbv6d.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Mon, 10 Dec 2012 10:48:10 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: D6F21F6C-4301-11E2-94AD-995F2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211270>

Junio C Hamano <gitster@pobox.com> writes:

> Rich Midwinter <rich.midwinter@gmail.com> writes:
>
>> I'm working on a project for a large organisation that wants to make
>> widespread use of git and the mailmap feature.
>>
>> This seems to be supported by default in git-shortlog but not git-log
>> (and other variants) without specifying custom formats, which isn't
>> really something I want to try and 'fix' across the organisation. Is
>> there a reason for this feature omission or has it just evolved that
>> way and could it be fixed?
>
> I think it was pretty much the latter, but people may already be
> depending on the command to give them the "true as recorded back
> then" names in the output.  A fix may have to involve inventing a
> new option "log --use-mailmap" that is explicitly given from the
> command line.

If somebody wants to do this, I think the overall design should go
like this:

 * We may want to rewrite blame.c::get_ac_line() and the code in
   pretty.c::pp_user_info() that parse author/committer lines by
   using ident.c::split_ident_line() for better code reuse as a
   preparation step before all of the below.

 * We may want to lift the buffer length limit from the implementation
   of mailmap.c::map_user() by using the strbuf API as a preparation
   step before all of the below.

 * We may also want to rethink its signature (we may want to get a
   single strbuf and have the function parse out "Name <mail>"; I
   didn't check the existing callers to see if that would make it
   easier to use, and if it does not, this obviously shouldn't be done)
   as a preparation step before all of the below.

 * Introduce a new "struct string_list *mailmap" member to "struct
   pretty_print_context" and "struct rev_info" (default to NULL);

 * In log-tree.c::show_log(), copy opt->mailmap to ctx.mailmap;

 * Update pretty.c::pp_user_info() to convert the email address on
   "line" (between the beginning and "namelen") by calling
   map_user() immediately after it parses time/tz out, and adjust
   the remainder of the function to use it, when pp->mailmap is
   present;

 * Teach log.c::cmd_log_init_finosh() about "--use-mailmap" option.
   Allocate one "struct string_list" instance and use read_mailmap()
   on it when the option is used, and store it in rev->mailmap.
