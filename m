From: Thomas Gummerer <t.gummerer@gmail.com>
Subject: Re: [PATCH v4 1/2] diff: move no-index detection to builtin/diff.c
Date: Sat, 14 Dec 2013 11:42:18 +0100
Message-ID: <87zjo3lnn9.fsf@gmail.com>
References: <20131210181655.GB2311@google.com> <1386755923-22132-1-git-send-email-t.gummerer@gmail.com> <20131214004347.GZ2311@google.com>
Reply-To: Thomas Gummerer <t.gummerer@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Jens Lehmann <Jens.Lehmann@web.de>,
	Junio C Hamano <gitster@pobox.com>,
	Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sat Dec 14 11:42:22 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vrmfr-0006FB-2j
	for gcvg-git-2@plane.gmane.org; Sat, 14 Dec 2013 11:42:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753486Ab3LNKmP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 14 Dec 2013 05:42:15 -0500
Received: from mail-wi0-f178.google.com ([209.85.212.178]:64472 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753477Ab3LNKmO (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Dec 2013 05:42:14 -0500
Received: by mail-wi0-f178.google.com with SMTP id bz8so298455wib.5
        for <git@vger.kernel.org>; Sat, 14 Dec 2013 02:42:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:in-reply-to:references:user-agent:reply-to:date
         :message-id:mime-version:content-type;
        bh=oQ+ChBybIGoT4wqEd+1IspAPKya5/L1BnM1vzT7pkbo=;
        b=txiyW2bzpbRzAkIz8Dlje8gjKUk8D/mGmmjuuCqRu+P+qFMvesktrFoapuNjeox4Kl
         kR32ZPCn9GnTJR6XVLfWf4Pyo05q80eXOKiz5ZrmlXUMuH22eNHKc31G8VirolyiTl2l
         idybYsfLxDlFnePUGSla/n881t5UDJIb2ojssOVAwR2SSQMuz9ZooSRuGpOHNGPqWBCP
         jhH1C/SEma49p/inE6LGdFse288H+06ONAxdZfG8HeowZlbv8S7WGUzaPSxQOOwtb4BC
         +n+80jjbSosoe7ej1GJ6n4y6tGYtXYVCQbMegW/i3ygy05QDlvlqkAvW2WbSSdlLk9h7
         nMTQ==
X-Received: by 10.180.160.166 with SMTP id xl6mr5849229wib.43.1387017732721;
        Sat, 14 Dec 2013 02:42:12 -0800 (PST)
Received: from goose.tgummerer.com ([2001:5c0:1400:a::103b])
        by mx.google.com with ESMTPSA id w20sm5927234wia.5.2013.12.14.02.42.10
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 14 Dec 2013 02:42:11 -0800 (PST)
In-Reply-To: <20131214004347.GZ2311@google.com>
User-Agent: Notmuch/0.17~rc1+8~g4a09c1a (http://notmuchmail.org) Emacs/24.3.1 (x86_64-unknown-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239281>

Jonathan Nieder <jrnieder@gmail.com> writes:

> Hi,
>
> Thomas Gummerer wrote:
>
>> Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
>
> Thanks, and sorry for the slow follow-up.
>
> [...]
>> --- a/builtin/diff.c
>> +++ b/builtin/diff.c
>> @@ -16,6 +16,9 @@
> [...]
>> @@ -283,14 +286,57 @@ int cmd_diff(int argc, const char **argv, const char *prefix)
>>  	 * Other cases are errors.
>>  	 */
>>
>> +	/* Were we asked to do --no-index explicitly? */
>> +	for (i = 1; i < argc; i++) {
>> +		if (!strcmp(argv[i], "--")) {
>> +			i++;
>> +			break;
>> +		}
>> +		if (!strcmp(argv[i], "--no-index"))
>> +			no_index = DIFF_NO_INDEX_EXPLICIT;
>
> Neat.
>
> [...]
>> +	/*
>> +	 * Treat git diff with at least one path outside of the
>> +	 * repo the same as if the command would have been executed
>> +	 * outside of a git repository.  In this case it behaves
>> +	 * the same way as "git diff --no-index <a> <b>", which acts
>> +	 * as a colourful "diff" replacement.
>> +	 */
>> +	if (nongit || ((argc == i + 2) &&
>> +		       (!path_inside_repo(prefix, argv[i]) ||
>> +			!path_inside_repo(prefix, argv[i + 1]))))
>> +		no_index = DIFF_NO_INDEX_IMPLICIT;
>
> What happens if I run 'git diff --no-index /tmp git.c git.c' from
> within a git repository?  With this, I fear I will get

Thanks, I've missed that one.  It only happens when run outside a git
repository, but the same  comments still apply.  Will fix and send a
re-roll.

> 	Not a git repository
> 	To compare two paths outside a working tree:
> 	usage: git diff [--no-index] <path> <path>
>
> instead of the expected
>
> 	usage: git diff --no-index <path> <path>
>
> Something like
>
> 	if (no_index)
> 		;
> 	else if (nongit)
> 		no_index = DIFF_NO_INDEX_IMPLICIT;
> 	else if (argc != i + 2)
> 		;
> 	else if (!path_inside_repo(prefix, argv[i]) ||
> 		 !path_inside_repo(prefix, argv[i + 1]))
> 		no_index = DIFF_NO_INDEX_IMPLICIT;
>
> should work.  Or:
>
> 	if (!no_index) {
> 		/*
> 		 * Treat git diff with ...
> 		 */
> 		if (nongit || ...)
> 			no_index = DIFF_NO_INDEX_IMPLICIT;
> 	}
>
> Or the '!no_index &&' condition inserted some other way.
>
>> -	/* If this is a no-index diff, just run it and exit there. */
>> -	diff_no_index(&rev, argc, argv, nongit, prefix);
>> +	if (no_index) {
>> +		if (argc != i + 2) {
> [...]
>> +			/* Give the usage message for non-repository usage and exit. */
>> +			usagef("git diff %s <path> <path>",
>> +			       no_index == DIFF_NO_INDEX_EXPLICIT ?
>> +					"--no-index" : "[--no-index]");
>> +
>> +		}
>> +		/* If this is a no-index diff, just run it and exit there. */
>> +		diff_no_index(&rev, argc, argv, prefix);
>> +	}
>
> Perhaps, to avoid some nesting:
>
> 	/* A no-index diff takes exactly two path arguments. */
> 	if (no_index && argc != i + 2) {
> 		...
> 		usagef(...);
> 	}
>
> 	if (no_index)
> 		/* Just run the diff and exit. */
> 		diff_no_index(...);
>
> Jonathan

Thanks, will change in the re-roll.

--
Thomas
