From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Remove old forgotten command: whatchanged
Date: Wed, 07 Aug 2013 23:39:17 -0700
Message-ID: <7vpptobsa2.fsf@alter.siamese.dyndns.org>
References: <CALkWK0=zZKTwn7cdrJXsVXH-rF=xWMeD_z2XAOCnuaf2bK_h8Q@mail.gmail.com>
	<52027B17.7040602@googlemail.com>
	<7vtxj1crv6.fsf@alter.siamese.dyndns.org>
	<5202C109.6040209@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Git List <git@vger.kernel.org>
To: Stefan Beller <stefanbeller@googlemail.com>
X-From: git-owner@vger.kernel.org Thu Aug 08 08:39:27 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V7Jsc-0006yq-Ik
	for gcvg-git-2@plane.gmane.org; Thu, 08 Aug 2013 08:39:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932900Ab3HHGjW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Aug 2013 02:39:22 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:38705 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753420Ab3HHGjU (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Aug 2013 02:39:20 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id EFB1332728;
	Thu,  8 Aug 2013 06:39:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=JyuitqRWnQ0awkuOenSCf0ZzmR4=; b=JdbQPS
	RLg/Wh2/9Mr/QkgPEZv1Sz5ykMG0AM3dokulo2C3o3/ZmqoJ0kSspHocyDCbqy7I
	dL9o6fYwbxoJbQTDjqMj9cfg1dJ6wkZve1lzLWLgbK90O7abxHP1Yq8Y2yDZMIze
	0EnXfYh5jjmxYk+UD8mAMns1hsQUcKB3r6LvU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=MUAyDlKgnVwFlWgexIS3eqGOOkW75ee2
	R7jVjC1+yMxqcj/HWyOnkI47zdLjzYo2BVM1dbnRvwqZuuTYjQSsWD9o9VoX6v/T
	JKkMmCvwRzoXisDjsFZ8mtQe4gqCMshalx197+2k2eoEDKpcAuZ6Et2AJDR7KnjW
	P/M5Mmy4T38=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DFDE832725;
	Thu,  8 Aug 2013 06:39:19 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id F359E32723;
	Thu,  8 Aug 2013 06:39:18 +0000 (UTC)
In-Reply-To: <5202C109.6040209@googlemail.com> (Stefan Beller's message of
	"Wed, 07 Aug 2013 23:50:01 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 4094556A-FFF5-11E2-B33D-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231863>

Stefan Beller <stefanbeller@googlemail.com> writes:

> Well if we make sure the whatchanged command can easily be reproduced
> with the log command, we could add the missing parameters to it, hence
> no change for the user. (git whatchanged == git log --raw --no-merges or
> git log --wc [to be done yet]).
>
> So I did not mean to introduce a change for users!

I certainly did *not* read that from between the lines of what you
wrote:

+ int cmd_whatchanged(int argc, const char **argv, const char *prefix)
+ {
+ 	return cmd_log(argc, argv, prefix)
+ }

In principle, I agree that it is a good idea to try to share enough
code, while keeping the flexiblity and clarity of the code for
maintainability.

In the extreme, you could rewrite these two functions like so:

	static int cmd_lw_helper(
		int argc, const char **argv,
        	const char *prefix,
                int whoami)	
        {
		struct rev_info rev;
		struct setup_revision_opt opt;
        
		init_grep_defaults();
                git_config(git_log_config, NULL);
                init_revisions(&rev, prefix);
		if (whoami == 'l') { /* log */
	                rev.always_show_header = always_show_header;
		} else { /* whatchanged */
	                rev.diff = diff;
	                rev.simplify_history = simplify_history;
		}
                memset(opt, 0, sizeof(opt));
                opt.def = "HEAD";
                opt.revarg_opt = REVARG_COMMITTISH;
                cmd_log_init(argc, argv, prefix, &rev, &opt);
		if (whoami == 'w') {
			if (!rev.diffopt.output_format)
				rev.diffopt.output_format = DIFF_FORMAT_RAW;
		}
                return cmd_log_walk(&rev);
	}

        int cmd_log(int argc, const char **argv, const char *prefix)
	{
        	return cmd_lw_helper(argc, argv, prefix, 'l');
	}

        int cmd_whatchanged(int argc, const char **argv, const char *prefix)
	{
        	return cmd_lw_helper(argc, argv, prefix, 'w');
	}

but at that point, the cost you have to pay when you need to update
one of them but not the other becomes higher.

As whatchanged is kept primarily for people who learned Git by word
of mouth reading the kernel mailing list and are used to that
command.  Its external interface and what it does is not likely to
drastically change.  On the other hand, "log" is a primary Porcelain
and we would expect constant improvements.

Between the "share more code for reuse" and "keep the flexibility
and clarity for maintainability", it is a subtle balancing act.
Personally I think the current code strikes a good balance by not
going to the extreme, given that "change one (i.e. log) but not the
other" is a very likely pattern for the evolution of these two
commands.
