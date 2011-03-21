From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Weird behavior of shell variables in git aliases
Date: Mon, 21 Mar 2011 15:33:25 -0700
Message-ID: <7v4o6wnlxm.fsf@alter.siamese.dyndns.org>
References: <d9c38309-c433-476c-bba3-f2c5b7e94a89@k15g2000prk.googlegroups.com>
 <20110321215310.GA2122@sigill.intra.peff.net>
 <7v8vw8nmh2.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Dun Peal <dunpealer@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>, Erik Faye-Lund <kusmabite@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 21 23:33:47 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q1nfX-0006An-2g
	for gcvg-git-2@lo.gmane.org; Mon, 21 Mar 2011 23:33:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754576Ab1CUWdl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Mar 2011 18:33:41 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:43414 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753976Ab1CUWdj (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Mar 2011 18:33:39 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 1E3BA5730;
	Mon, 21 Mar 2011 18:35:17 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=V8+o5+TAg6Us36OnizfV+IKIpAk=; b=V+e86y
	xrpJk6gMjtpodifUb7gS70EwShbyS+HGOItxPyjQAYTedMKMgi/RwW6lZ+EtzOx3
	CvMlt8HMS1s6OwSMYIHPy0x+bN7psS+RKoyWQz/eyYmHaxaout8bpEKcgRqsmDVQ
	I/Dt8wkvYbeggVgvbMdzO7RUBYKELyaJi7IeI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ejsUXn4TN4DOA4vlHQawRN14eOIHWNlz
	ImCd4HcpiDpR3X1fYnKI1W84SDJ96nE5fArrsCLD8QjUyT/PxwrhoqAgT2Ay9+8g
	XOQhA7VPZBNmd3sN598kspJmweAcqogQ4YEQpTRJeUp//wU80eST6bDTbw7OmI8Z
	FKQWBhMYu1c=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id D21C4572F;
	Mon, 21 Mar 2011 18:35:11 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 535A3572E; Mon, 21 Mar 2011
 18:35:06 -0400 (EDT)
In-Reply-To: <7v8vw8nmh2.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Mon, 21 Mar 2011 15:21:45 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 7BB35E22-540B-11E0-9C3A-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169682>

Junio C Hamano <gitster@pobox.com> writes:

> Jeff King <peff@peff.net> writes:
>
>> But interestingly, that's _not_ the behavior as of Erik's 7f51f8b
>> (alias: use run_command api to execute aliases, 2011-01-07), which is in
>> master but not yet released. With that, we end up executing:
>>
>>   sh -c 'echo $1 && echo $1 "$@"' 'echo $1 && echo $1' 'foo'
>>
>> which prints "foo foo". So it is technically a regression. I don't know
>> how much we care; using positional parameters like this was already
>> nonsensical, as shown above.
>>
>> For reference, what you actually want (in either system) is:
>>
>>   $ git config alias.test1
>>   !sh -c 'echo $1 && echo $1' -
>
> Oh, I should have been paying a bit more attention.  I've been assuming
> that we were turning "!anything" into { "sh", "-c", "anything", "-" }
> followed by the user supplied arguments.

The attached quick hack gives

  $ git config alias.silly
  !echo hello $1; echo $# args, bye!
  $ GIT_TRACE=1 ./git silly world funny
  trace: exec: 'git-silly' 'world' 'funny'
  trace: run_command: 'git-silly' 'world' 'funny'
  trace: run_command: 'sh' '-c' 'echo hello $1; echo $# args, bye'\!'' '-' 'world' 'funny'
  trace: exec: 'sh' '-c' 'echo hello $1; echo $# args, bye'\!''
  '-' 'world' 'funny'
  hello world
  2 args, bye!

but it would penalize a properly written alias that uses "sh -c <it> -"
trick itself by double forking, which is not very nice and I am unhappy
about.

 git.c |   11 +++++++----
 1 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/git.c b/git.c
index ef598c3..8d54466 100644
--- a/git.c
+++ b/git.c
@@ -183,11 +183,14 @@ static int handle_alias(int *argcp, const char ***argv)
 			commit_pager_choice();
 
 			/* build alias_argv */
-			alias_argv = xmalloc(sizeof(*alias_argv) * (argc + 1));
-			alias_argv[0] = alias_string + 1;
+			alias_argv = xmalloc(sizeof(*alias_argv) * (argc + 4));
+			alias_argv[0] = "sh";
+			alias_argv[1] = "-c";
+			alias_argv[2] = alias_string + 1;
+			alias_argv[3] = "-";
 			for (i = 1; i < argc; ++i)
-				alias_argv[i] = (*argv)[i];
-			alias_argv[argc] = NULL;
+				alias_argv[i + 3] = (*argv)[i];
+			alias_argv[argc + 3] = NULL;
 
 			ret = run_command_v_opt(alias_argv, RUN_USING_SHELL);
 			if (ret >= 0)   /* normal exit */
