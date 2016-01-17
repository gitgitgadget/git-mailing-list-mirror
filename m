From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 4/4] ls-remote: add support for showing symrefs
Date: Sun, 17 Jan 2016 14:14:15 -0800
Message-ID: <xmqqwpr7etvs.fsf@gitster.mtv.corp.google.com>
References: <1453028643-13978-1-git-send-email-t.gummerer@gmail.com>
	<1453028643-13978-6-git-send-email-t.gummerer@gmail.com>
	<20160117151510.GC15519@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Thomas Gummerer <t.gummerer@gmail.com>, bturner@atlassian.com,
	pedrorijo91@gmail.com, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Jan 17 23:18:35 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aKveU-0003d6-KU
	for gcvg-git-2@plane.gmane.org; Sun, 17 Jan 2016 23:18:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755473AbcAQWOZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 17 Jan 2016 17:14:25 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:58011 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755464AbcAQWOX (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Jan 2016 17:14:23 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 5159F3C024;
	Sun, 17 Jan 2016 17:14:17 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=wjWl6fUZzpmuy6tERbhbCXOR7Pg=; b=fAl7wU
	qXOnXlfDAYQAfDVfuuR0XW7Yf6peproK9vPTHsG7HGqPikvUW62++dhIOmNwx/XI
	ruZvY+GL3uYL4N8zx1+YCvFQhgvBxqlfJD+AeCtHpjBwq0YQOeQG/rspGEPgvF6/
	XiwW0o52583npoqxI/rAhfYqKzce/6IbAqnhM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=O/iQMHnSHN9AOXKVsRWBfPNb8+K+6wba
	ZrFQuv9AYzRdcg8DhVzbkmTwBXw0feVvrl/RIEB9EYNHTIE+Ohrwb0tPcfL4NfXu
	oY8ZA+K75mRnkgQcF14bCX5E3lG4sGUpOvHY1eCEhOPXPaLgrEj6w+set7HLz7V9
	Xf8GRE+NfTc=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 499653C023;
	Sun, 17 Jan 2016 17:14:17 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id BF1143C022;
	Sun, 17 Jan 2016 17:14:16 -0500 (EST)
In-Reply-To: <20160117151510.GC15519@sigill.intra.peff.net> (Jeff King's
	message of "Sun, 17 Jan 2016 10:15:10 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: A5F0D9C4-BD67-11E5-83AE-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284266>

Jeff King <peff@peff.net> writes:

> We could also do it as:
>
>   ref: refs/heads/master     HEAD
>
> which matches the symref format itself. I guess that doesn't really
> matter here, but somehow it seems more aesthetically pleasing to me.

Yes, I think this should be the way to go.

> The output would look a lot nicer for humans if we right-padded the
> symref destination to match the 40-hex that is on all the other lines
> (so all of the refnames line up).  But that makes machine-parsing a lot
> harder. We could do something clever with isatty(1), but I don't think
> it's worth the effort.

And the target can be longer than 40-hex.  Don't play games with
padding.

>> +test_expect_success 'ls-remote with symrefs and refs combined' '
>> +	cat >expect <<-EOF &&
>> +	symref: refs/heads/master	HEAD
>> +	1bd44cb9d13204b0fe1958db0082f5028a16eb3a	refs/heads/master
>> +	1bd44cb9d13204b0fe1958db0082f5028a16eb3a	refs/remotes/origin/HEAD
>> +	1bd44cb9d13204b0fe1958db0082f5028a16eb3a	refs/remotes/origin/master
>> +	1bd44cb9d13204b0fe1958db0082f5028a16eb3a	refs/tags/mark
>> +	EOF
>
> I expected there to be a:
>
>   1bd44cb9d13204b0fe1958db0082f5028a16eb3a	HEAD
>
> line.

Yes, there should be, as I would imagine the most natural
interpretation of "--symrefs" by end users would be "show me ALSO
the symref information.", not "show me ONLY the symref information"
(if it were the latter we woudln't be seeing refs/tags/mark in the
above output).

I also suspect that this part of the patch is wrong (or at least
misleading):

@@ -98,6 +101,10 @@ int cmd_ls_remote(int argc, const char **argv, const char *prefix)
 	if (!dest && !quiet)
 		fprintf(stderr, "From %s\n", *remote->url);
 	for ( ; ref; ref = ref->next) {
+		if (symrefs && ref->symref)
+			printf("symref: %s	%s\n", ref->symref, ref->name);
+		if (symrefs && !flags)
+			continue;
 		if (!check_ref_type(ref, flags))
 			continue;
 		if (!tail_match(pattern, ref->name))

It looks wrong that the usual filtering with check_ref_type() and
tail_match() are bypassed for symbolic refs.  Even though the server
side currently feeds reflog information for only "HEAD", the code
should be prepared to do the sane thing in a future in which that
server-side limitation is corrected, and allow the user to ask

    ls-remote $there --symref refs/remotes/origin/HEAD

to learn the information on one specific ref, without having to see
the primary branch of $there repository, for example.

Thanks.
