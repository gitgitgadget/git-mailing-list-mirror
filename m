From: karthik nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v8 2/4] cat-file: teach cat-file a '--literally' option
Date: Thu, 16 Apr 2015 12:56:33 +0530
Message-ID: <552F6429.9050304@gmail.com>
References: <552E9816.6040502@gmail.com>	<1429117174-4968-1-git-send-email-karthik.188@gmail.com>	<xmqqtwwhjg8b.fsf@gitster.dls.corp.google.com> <xmqqiocxjeqn.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, sunshine@sunshineco.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Apr 16 09:26:44 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YieCB-0007Yp-JI
	for gcvg-git-2@plane.gmane.org; Thu, 16 Apr 2015 09:26:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756788AbbDPH0j (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Apr 2015 03:26:39 -0400
Received: from mail-pd0-f195.google.com ([209.85.192.195]:35723 "EHLO
	mail-pd0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752251AbbDPH0i (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Apr 2015 03:26:38 -0400
Received: by pdjg10 with SMTP id g10so19929499pdj.2
        for <git@vger.kernel.org>; Thu, 16 Apr 2015 00:26:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=b2Jd47RZkATJA6mbobWejZweN+cW5GS6FIwq2mRU5oY=;
        b=Gqmy4YovDkZWHYO3vBkSG7VyTJGhJm82HTVqgjA8VB7fcM4mvqypr1oQprtMq++OlM
         Ivh1W8QA6lMhW2dbFAIs2FV+vGlpOubPdgzH1miOmLBsTmWdCxeyeKifysMMpMoJ3uPe
         J64vYDDnFZtmCVGtbWwu42XdDtb9nulpqskyUqR16ni6rIiFmiUY/jGcvFJJgKGMxCzm
         Q73c62ZgSW2K7tNXZ3Gd/Zu9MhlcMVuwCZyiFrBB0jhuy+CN/MfIM/UGYTjuMRzz4nr0
         rsA56+RLOvkdU+dQvrEto1pPCazzjBrE40Drf41ICirhuNc8jpWeR8FvbvbJXrdnEkUt
         akhw==
X-Received: by 10.66.66.166 with SMTP id g6mr54594003pat.88.1429169197739;
        Thu, 16 Apr 2015 00:26:37 -0700 (PDT)
Received: from [192.168.0.103] ([103.227.98.178])
        by mx.google.com with ESMTPSA id za6sm6169167pac.48.2015.04.16.00.26.35
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 16 Apr 2015 00:26:36 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.6.0
In-Reply-To: <xmqqiocxjeqn.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267259>



On 04/16/2015 02:22 AM, Junio C Hamano wrote:
> Junio C Hamano <gitster@pobox.com> writes:
>
>> Karthik Nayak <karthik.188@gmail.com> writes:
>> ...
>>> -	if (argc != 3 && argc != 2)
>>> +	if (argc < 2 || argc > 4)
>>>   		usage_with_options(cat_file_usage, options);
>>
>> Hmm, why this change?
>>
>> By allowing 4 args blindly like this, you will let something like
>> these to pass:
>>
>>      $ git cat-file --textconv -t HEAD
>>      commit
>>      $ git cat-file -p -t HEAD
>>      commit
>>      $ git cat-file -s -t HEAD
>>      commit
>>      $ git cat-file -t -s HEAD
>>      879
>>
>> It is fine if you are declaring that the last one wins when these
>> mutually-exclusive options are given. "git cat-file -e -s -t HEAD"
>> should also say "commit" if that is what you are doing, but instead
>> the code with this patch complains, which is bad.
>>
>> It also is fine and is more in line with the spirit of the original
>> code if you keep the rule tight and only one of these mutually
>> exclusive options is allowed.
>>
>> In either case, this check needs to be rethought.
>
> I wonder if we want to do something like this as a preliminary step
> before your [PATCH 2/4].  Everything after the parse_options() call
> seems to protect against leftover argc depending on what they need
> already, so the only thing existing "we take only 2 or 3 args" check
> is doing is to protect against giving more than one command mode
> options, I think.  And OPT_CMDMODE() should do a much better job at
> that that kind of thing, by giving a more informative error message
> e.g.
>
>      $ git cat-file -p -e HEAD
>      error: switch 'e': incompatible with -p
>
> This is a tangent, but while we are in the vicinity, we may want to
> rethink the help message we attach to the '-e' option.  Technically
> the current message is _not_ wrong per-se, but it misses the point.
> The primary thing the option does is to check the (e)xistence of the
> named object, and the fact that it does so silently is merely a
> detail of the operation.  The current help text omits the more
> important part of what the option is.

Would you rather check '-e' and go on to check '-p' or do you merely 
just want a different message.
As far as I see whenever any option other than a '-e' is given it 
indirectly has to check for the existence of the object.

eg:
$ git cat-file -t asdfghjkl
fatal: Not a valid object name asdfghjkl

$ git cat-file -e asdfghjkl
fatal: Not a valid object name asdfghjkl

So when a user is giving the '-e' option he just expects a silent output 
if the object exists, hence we rather have the option '-e' behave as a 
mutually exclusive option and output the error message like.

$ git cat-file -p -e HEAD
error: switch 'e': incompatible with -p

what do you think?
>
>   builtin/cat-file.c | 13 +++++--------
>   1 file changed, 5 insertions(+), 8 deletions(-)
>
> diff --git a/builtin/cat-file.c b/builtin/cat-file.c
> index 1ec7190..534991d 100644
> --- a/builtin/cat-file.c
> +++ b/builtin/cat-file.c
> @@ -372,12 +372,12 @@ int cmd_cat_file(int argc, const char **argv, const char *prefix)
>
>   	const struct option options[] = {
>   		OPT_GROUP(N_("<type> can be one of: blob, tree, commit, tag")),
> -		OPT_SET_INT('t', NULL, &opt, N_("show object type"), 't'),
> -		OPT_SET_INT('s', NULL, &opt, N_("show object size"), 's'),
> -		OPT_SET_INT('e', NULL, &opt,
> +		OPT_CMDMODE('t', NULL, &opt, N_("show object type"), 't'),
> +		OPT_CMDMODE('s', NULL, &opt, N_("show object size"), 's'),
> +		OPT_CMDMODE('e', NULL, &opt,
>   			    N_("exit with zero when there's no error"), 'e'),
> -		OPT_SET_INT('p', NULL, &opt, N_("pretty-print object's content"), 'p'),
> -		OPT_SET_INT(0, "textconv", &opt,
> +		OPT_CMDMODE('p', NULL, &opt, N_("pretty-print object's content"), 'p'),
> +		OPT_CMDMODE(0, "textconv", &opt,
>   			    N_("for blob objects, run textconv on object's content"), 'c'),
>   		OPT_BOOL( 0, "literally", &literally,
>   			  N_("allow -s and -t to work with broken/corrupt objects")),
> @@ -392,9 +392,6 @@ int cmd_cat_file(int argc, const char **argv, const char *prefix)
>
>   	git_config(git_cat_file_config, NULL);
>
> -	if (argc < 2 || argc > 4)
> -		usage_with_options(cat_file_usage, options);
> -
>   	argc = parse_options(argc, argv, prefix, options, cat_file_usage, 0);
>
>   	if (opt) {
>
Thanks! Didn't know about the OPT_CMDMODE option.
