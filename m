From: Thomas Gummerer <t.gummerer@gmail.com>
Subject: Re: [PATCH v3 1/2] diff: move no-index detection to builtin/diff.c
Date: Tue, 10 Dec 2013 19:46:57 +0100
Message-ID: <87eh5kmtlq.fsf@gmail.com>
References: <xmqqwqjdydga.fsf@gitster.dls.corp.google.com> <1386697935-18635-1-git-send-email-t.gummerer@gmail.com> <20131210181655.GB2311@google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Jens Lehmann <Jens.Lehmann@web.de>,
	Junio C Hamano <gitster@pobox.com>,
	Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Dec 10 19:47:07 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VqSKo-0007yW-GM
	for gcvg-git-2@plane.gmane.org; Tue, 10 Dec 2013 19:47:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751865Ab3LJSq7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Dec 2013 13:46:59 -0500
Received: from mail-yh0-f48.google.com ([209.85.213.48]:59836 "EHLO
	mail-yh0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751743Ab3LJSq4 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Dec 2013 13:46:56 -0500
Received: by mail-yh0-f48.google.com with SMTP id f73so4208691yha.35
        for <git@vger.kernel.org>; Tue, 10 Dec 2013 10:46:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:in-reply-to:references:user-agent:date
         :message-id:mime-version:content-type;
        bh=JCgv7jGBQB+o+q5htDIE+IsBLuWzq3CFhAK7ft5diAc=;
        b=oLOnOqutXgGYx0kj1nq0Qc9fRMYRilAcsfczkNj8EZCFyeKbOce/WKlBxxpnRdH7Vd
         FCF2EOe1IjPjNZ180mmNtjBdUjb3Ni+2lLFO2PjC86n7q7DlCNNO/E/ErudiLN+W/ZmD
         bALaS2r5eACG8FH1dCPKQkAKk1KG6Gx5Sl/+YLUsOgW0IeJ20Uqn9JENoe+Lsypbd6Us
         u4HnwoKZwdPlY3I5Xl3J+pDTx//p8cEvWf3rQOC1Q54IYaG90jG0LCNDyllvtyoFs0H0
         gYHFZ8+YhRD5ciJqOlNsDreN7Uyi11iZIl76XoaJ5qLwHW3uL2ZRmKWQNLoOPdj78JQZ
         VAZw==
X-Received: by 10.236.51.232 with SMTP id b68mr8606960yhc.51.1386701216061;
        Tue, 10 Dec 2013 10:46:56 -0800 (PST)
Received: from localhost ([2001:5c0:1400:a::158d])
        by mx.google.com with ESMTPSA id d32sm23858049yhq.27.2013.12.10.10.46.53
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 10 Dec 2013 10:46:54 -0800 (PST)
In-Reply-To: <20131210181655.GB2311@google.com>
User-Agent: Notmuch/0.17~rc1+8~g4a09c1a (http://notmuchmail.org) Emacs/24.3.1 (x86_64-unknown-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239145>

Jonathan Nieder <jrnieder@gmail.com> writes:

> (pruning cc list)
> Hi,
>
> Thomas Gummerer wrote:
>
>> Currently the --no-index option is parsed in diff_no_index().  Move the
>> detection if a no-index diff should be executed to builtin/diff.c
>
> No functional change intended, I assume?

Correct, I thought I'd split the refactoring from the functionality
changes.

> [...]
>> --- a/builtin/diff.c
>> +++ b/builtin/diff.c
>> @@ -283,14 +283,53 @@ int cmd_diff(int argc, const char **argv, const char *prefix)
> [...]
>>  	prefix = setup_git_directory_gently(&nongit);
>> +	/*
>> +	 * Treat git diff with at least one path outside of the
>> +	 * repo the same as if the command would have been executed
>> +	 * outside of a git repository.  In this case it behaves
>> +	 * the same way as "git diff --no-index <a> <b>", which acts
>> +	 * as a colourful "diff" replacement.
>> +	 */
>> +	nongit |= (argc == i + 2) && !(path_inside_repo(prefix, argv[i]) &&
>> +				       path_inside_repo(prefix, argv[i + 1]));
>
> I would find this easier to read as
>
> 	if (argc == i + 2 &&
> 	    (!path_inside_repo(prefix, argv[i]) ||
> 	     !path_inside_repo(prefix, argv[i + 1])))
> 		nongit = 1;
>
> Or maybe using a different variable than 'nongit':
>
>  #define DIFF_NO_INDEX_EXPLICIT 1
>  #define DIFF_NO_INDEX_IMPLICIT 2
>
> 	...
> 	if (argc == i + 2 && ...)
> 		no_index = DIFF_NO_INDEX_IMPLICIT;

Thanks, that makes sense, will change in the re-roll.

> [...]
>>  	gitmodules_config();
>>  	git_config(git_diff_ui_config, NULL);
>>
>>  	init_revisions(&rev, prefix);
>>
>> -	/* If this is a no-index diff, just run it and exit there. */
>> -	diff_no_index(&rev, argc, argv, nongit, prefix);
>> +	if (no_index || nongit) {
> [...]
>> +	}
>
> Ok.
>
> [...]
>> --- a/diff-no-index.c
>> +++ b/diff-no-index.c
>> @@ -181,56 +181,14 @@ static int queue_diff(struct diff_options *o,
>>  	}
>>  }
>>
>> -void diff_no_index(struct rev_info *revs,
>> +int diff_no_index(struct rev_info *revs,
>
> Why the change in return type?

That was an oversight, no change is required.  Will fix in the
re-roll. Thanks for taking the time for reviewing this.

> Hope that helps,
> Jonathan

--
Thomas
