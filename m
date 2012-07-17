From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] Fix notes handling in rev-list
Date: Mon, 16 Jul 2012 22:42:07 -0700
Message-ID: <7vvchnx7tc.fsf@alter.siamese.dyndns.org>
References: <20120325005504.GA27651@sigill.intra.peff.net>
 <1342463409-6919-1-git-send-email-jukka.lehtniemi@gmail.com>
 <20120717034640.GB20945@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jukka Lehtniemi <jukka.lehtniemi@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Jul 17 07:42:37 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sr0YN-0001p9-CL
	for gcvg-git-2@plane.gmane.org; Tue, 17 Jul 2012 07:42:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754075Ab2GQFmT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Jul 2012 01:42:19 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:54976 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754617Ab2GQFmL (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Jul 2012 01:42:11 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 578E64ECE;
	Tue, 17 Jul 2012 01:42:10 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=+uOp8D+5bAycbnpSeb7ZpbWPG24=; b=mhlVoJ
	DBKf5t9dNqCLHgnfCo3NoFS3slRRCQWabFy/oKYdSHoH8fHztSwFxfGcJNYpakYc
	HgHJm0ecBkYoMyJj5ZahnKUN6tCpT094qHiQUDslOgwxi4uI7EjD7vfv/uJcmIKK
	qzJ15bMYFA1BEvGFF6/wx1CZ/eLX2X+b6VkRE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=OuybyXPPDyDOXol+vAFFYBXOhoVdxCKm
	9Oq3sMvi6+sP2ASTDH4XOUKpGPD+XqaiQxXpH+5Ue5MVHhkApkve5+acrLuJw6dr
	d8NXSo76cSYwTXClN3ulSwtr6tRZXcTwD56xstO4/IxWS/leiilOAHCC3lQFfal3
	aNUHgh74Mjo=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 451714ECD;
	Tue, 17 Jul 2012 01:42:10 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 7519B4ECC; Tue, 17 Jul 2012
 01:42:09 -0400 (EDT)
In-Reply-To: <20120717034640.GB20945@sigill.intra.peff.net> (Jeff King's
 message of "Mon, 16 Jul 2012 23:46:40 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 268FF5A6-CFD2-11E1-BD6B-01B42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201590>

Jeff King <peff@peff.net> writes:

> On Mon, Jul 16, 2012 at 09:30:09PM +0300, Jukka Lehtniemi wrote:
>
>> @@ -111,6 +112,7 @@ static void show_commit(struct commit *commit, void *data)
>>  		ctx.date_mode = revs->date_mode;
>>  		ctx.date_mode_explicit = revs->date_mode_explicit;
>>  		ctx.fmt = revs->commit_format;
>> +		ctx.show_notes = revs->show_notes;
>>  		pretty_print_commit(&ctx, commit, &buf);
>>  		if (revs->graph) {
>>  			if (buf.len) {
>
> Makes sense. We were just failing to propagate the show_notes flag to
> the pretty-print code, as log-tree does.
>
>> @@ -159,6 +161,12 @@ static void show_commit(struct commit *commit, void *data)
>>  	} else {
>>  		if (graph_show_remainder(revs->graph))
>>  			putchar('\n');
>> +		if (revs->show_notes_given) {
>> +			struct strbuf buf = STRBUF_INIT;
>> +			format_display_notes(commit->object.sha1, &buf, 0, NOTES_SHOW_HEADER|NOTES_INDENT); 
>> +			fwrite(buf.buf, 1, buf.len, stdout);
>> +			strbuf_release(&buf);
>> +		}
>
> But why are we using show_notes_given here instead of show_notes? The
> former is about "did we get any kind of --notes option on the
> command-line". So doing "git rev-list --no-notes" would trigger it,
> which seems wrong. We should simply be checking show_notes again, no?
>
> Also, it seems odd to me to show the notes after graph_show_remainder.
> Your first hunk is about passing the notes option to the pretty-printer,
> which handles graph output already, and looks like this:
>
>   $ git rev-list --oneline --graph --notes -2 HEAD
>   * f6bbb09 Fix notes handling in rev-list
>   | Notes:
>   |     foobar
>   | 
>   * 31c7954 Update draft release notes for 7th batch
>
> Just like log, the notes are part of the commit information to the right
> of the graph. But this second hunk is for when we are not using the
> pretty-printer at all, and the output looks like this:
>
>   $ git rev-list --graph --notes -2 HEAD
>   * f6bbb09529a4cc73446c7c115ac1468477bd0cc6
>
>   Notes:
>       foobar
>   * 31c79549b85c6393be4f40432f5b86ebc097fc7e
>
> which doesn't make sense

I actually have quite a different feeling about this.  As I said in
the separate message, I think --graph, or anything that makes the
output unparsable or harder to parse for machines for that matter,
in rev-list are not something we have because we wanted to support
them, but that which just happen to work because the large part of
rev-list and log can share building blocks to do similar things.
The key phrase is "can share" here; it does not necessarily mean
they "should" [*1*].

First and foremost, rev-list is a tool for people who hate what our
vanilla "git log" Porcelain does enough that they want to write
their own Porcelain scripts using it.

I do not mind having an option to show the notes text, but I doubt
it is a sane thing to do to make "rev-list --notes" unconditionally
show the payload of the notes blob.  "rev-list --objects" only shows
the object names of trees and blobs, not the payload in these
objects, and this is very much on purpuse.  It allows the downstream
process that reads its output from the pipe to easily parse the
output and choose to do whatever it wants to do using them.

I wonder if we should show the blob object names that store the
notes payload if we were given --notes option in a format that is
easy for readers to mechanically parse its output.

In any case, the use of format_display_notes() that is meant for
human consumption feels very wrong to me, especially it seems to be
placed outside the "if (revs->verbose_header && commit->buffer)"
block in this patch.  I do not have any problem if the patch makes
the notes text shown in the other side of the if block that uses
pretty_print_commit(), though.


[Footnote]

*1* A simple litmus test is to ask this question: if somebody comes
    up with a "better" way to show the same output for the option,
    would we accept that update without worrying about breaking
    existing scripts?  If the answer is yes, that is a secondary
    feature in the context of "rev-list" plumbing like --graph is.
