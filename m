From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] [GSoC Microproject]Adding "-" shorthand for "@{-1}" in RESET command
Date: Sun, 08 Mar 2015 14:59:09 -0700
Message-ID: <xmqqpp8j882a.fsf@gitster.dls.corp.google.com>
References: <loom.20150308T120618-983@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Sundararajan R <dyoucme@gmail.com>
X-From: git-owner@vger.kernel.org Sun Mar 08 22:59:18 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YUjED-000481-L3
	for gcvg-git-2@plane.gmane.org; Sun, 08 Mar 2015 22:59:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752649AbbCHV7N (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Mar 2015 17:59:13 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:55621 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752609AbbCHV7M (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Mar 2015 17:59:12 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 830703E667;
	Sun,  8 Mar 2015 17:59:11 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=3mrLM/EJsNCwA2p75szWtuVlFBE=; b=X8ynyV
	v/EMXa5DMihHD9rZS8WS0P8jYYxYfnx2ypAaWze+2EJ0l63z7NSEnAfocUT7Ex2M
	0WaSODt9R1nQgkIMMYncPZvtgeGSLejMhQ1Py6LAQO3WOud8gwwMe3SgSdJTGfP5
	wBab1S+ySpktn/1WtkQqS6joLZTmFDskZSkVM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=N/UGXoLry/pDgbPjmD8PXpG4nWyMHf8P
	xaE+88TgnpOeAbZ23BoT7SctWlTlgZ7yRBDqg32o5Wlar6WqPcwEHHlk00fS13e9
	Rx9dxiQf2SNAkmr0qUGAaEzfmYNDPYaSOCtILboIpTmDQBuo6VGTVfyvBugRb50U
	hO760DNvnvo=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 7AE473E666;
	Sun,  8 Mar 2015 17:59:11 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 05D543E665;
	Sun,  8 Mar 2015 17:59:10 -0400 (EDT)
In-Reply-To: <loom.20150308T120618-983@post.gmane.org> (Sundararajan R.'s
	message of "Sun, 8 Mar 2015 11:09:45 +0000 (UTC)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 59F11772-C5DE-11E4-8C41-29999F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265112>

Sundararajan R <dyoucme@gmail.com> writes:

> I am sorry for the mistakes in the code formatting. It was because I was in 
> a hurry that day and I wanted to submit a working patch.

No need to apologize for mistakes.  Mistakes are expected part of
being human and the review process is designed to catch exactly
that.

The development is not a race to see who gets there first.  It is a
collaborative process to get to a better place together.  Once you
got something "working", stop and review your work to see if your
definition of "working" is sensible.  Is there a corner case you
missed?  Is the code formatted in a similar way as the existing code
around the area you are touching?  Are there better ways to do what
you did?  Take your time to make sure you would be happy with what
you are sending out.

> In the new patch I 
> am making, I am using check_filename() to see if there are files named "-" 
> and "@{-1}" in the working tree . Is this an appropriate way to check or is 
> there something else suggested? 

I think you are making it unnecessarily hard.  With your patch, the
code would look like this:

 	if (argv[0]) {
+		if (!strcmp(argv[0], "-") && !argv[1])  /* "-" is the only argument */
+		{
+			argv[0]="@{-1}";
+			flag=1;
+		}
 		if (!strcmp(argv[0], "--")) {
 			argv++; /* reset to HEAD, possibly with paths */
 		} else if (argv[1] && !strcmp(argv[1], "--")) {
 			rev = argv[0];
 			argv += 2;
 		}
 		/*
 		 * Otherwise, argv[0] could be either <rev> or <paths> and
 		 * has to be unambiguous. If there is a single argument, it
 		 * can not be a tree
 		 */
 		else if ((!argv[1] && !get_sha1_committish(argv[0], unused)) ||
 			 (argv[1] && !get_sha1_treeish(argv[0], unused))) {
 			/*
 			 * Ok, argv[0] looks like a commit/tree; it should not
 			 * be a filename.
 			 */
 			verify_non_filename(prefix, argv[0]);
 			rev = *argv++;
 		} else {
 			/* Otherwise we treat this as a filename */
+			if(flag)
+				argv[0]="-";
 			verify_filename(prefix, argv[0], 1);
 		}
 	}

I was wondering what you are passing to verify_non_filename() that
you did not touch.  It would see "@{-1}", try to make sure that the
working tree does not have a file with that name, and if there is
the end user would be warned about ambiguity.

If the user typed "git reset @{-1}", then that warning is very
sensible, but when the end user only typed "git reset -", is there
any ambiguity?
