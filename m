From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: [PATCH] Add the --submodule option to the diff option family
Date: Mon, 19 Oct 2009 14:29:43 +0200
Message-ID: <4ADC5BB7.5090207@web.de>
References: <4ADA10FC.40708@web.de> <7v3a5gdr1c.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Oct 19 14:29:52 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MzrN2-0001QQ-07
	for gcvg-git-2@lo.gmane.org; Mon, 19 Oct 2009 14:29:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755699AbZJSM3l (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Oct 2009 08:29:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754880AbZJSM3l
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Oct 2009 08:29:41 -0400
Received: from fmmailgate01.web.de ([217.72.192.221]:55924 "EHLO
	fmmailgate01.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754624AbZJSM3k (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Oct 2009 08:29:40 -0400
Received: from smtp05.web.de (fmsmtp05.dlan.cinetic.de [172.20.4.166])
	by fmmailgate01.web.de (Postfix) with ESMTP id 9C43312F7ED6F;
	Mon, 19 Oct 2009 14:29:44 +0200 (CEST)
Received: from [80.128.88.231] (helo=[192.168.178.26])
	by smtp05.web.de with asmtp (WEB.DE 4.110 #314)
	id 1MzrMt-0007if-00; Mon, 19 Oct 2009 14:29:43 +0200
User-Agent: Thunderbird 2.0.0.23 (X11/20090812)
In-Reply-To: <7v3a5gdr1c.fsf@alter.siamese.dyndns.org>
X-Sender: Jens.Lehmann@web.de
X-Provags-ID: V01U2FsdGVkX1+1Yy6W4vn4sjINBgP6qKy5g2DUK2xOljAOvfy/
	SKFba7u6p5KhTJ57ldAonwJhJB8muCUcTufIWTE/a4gxWFBfIm
	8ENfLW2giPhMpIPcw6+Q==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130695>

Junio C Hamano schrieb:
> I have four patches queued on js/diff-verbose-submodule topic and I think
> this corresponds to the first three, correct?

Yes.


>> +--submodule[=<format>]::
>> +	Chose the output format for submodule differences. <format> can be one of
>> +	'short' and 'left-right-log'. 'short' is the default value for this
>> +	option and and shows pairs of commit names. 'left-right-log' lists the
>> +	commits in that commit range like the 'summary' option of
>> +	linkgit:git-submodule[1] does.
>> +
> 
> Well, while left-right-log may be logically the most correct name for this
> option, I think it is too long to be practical.  Because it is not like we
> would want to have an option to have full log there when we are showing
> "diff", I think it would make sense to making left-right-log the default
> when "--submodule" (without format specification) is given, and possibly
> give "--submodule=log" as the synonym for this format.

O.k., "--submodule=log" it is.


> After all, if you do not give --submodule, we will give the traditional
> short format, no?

Yes. Will make the documentation clearer on this.


>> diff --git a/diff.c b/diff.c
>> index c719ce2..8af1ae2 100644
>> --- a/diff.c
>> +++ b/diff.c
>> @@ -2771,6 +2783,10 @@ int diff_opt_parse(struct diff_options *options, const char **av, int ac)
>>  		DIFF_OPT_CLR(options, ALLOW_TEXTCONV);
>>  	else if (!strcmp(arg, "--ignore-submodules"))
>>  		DIFF_OPT_SET(options, IGNORE_SUBMODULES);
>> +	else if (!prefixcmp(arg, "--submodule=")) {
>> +		if (!strcmp(arg + 12, "left-right-log"))
>> +			DIFF_OPT_SET(options, SUBMODULE_LEFT_RIGHT_LOG);
>> +	}
> 
> I do not see --submodule (without "=<format>") supported here as the
> documentation claims, but this is the logical place to do so.

Will change that.


>> diff --git a/submodule.c b/submodule.c
>> new file mode 100644
>> index 0000000..206386f
>> --- /dev/null
>> +++ b/submodule.c
>> @@ -0,0 +1,112 @@
>> +...
>> +void show_submodule_summary(FILE *f, const char *path,
>> +		unsigned char one[20], unsigned char two[20],
>> +		const char *del, const char *add, const char *reset)
>> +{
>> ...
>> +	fwrite(sb.buf, sb.len, 1, f);
>> +
>> +	if (!message) {
>> +		while ((commit = get_revision(&rev))) {
>> + ...
>> +		}
>> +		clear_commit_marks(left, ~0);
>> +		clear_commit_marks(right, ~0);
>> +	}
>> +}
> 
> I thought we had strbuf_release(&sb) here...  Where did it go?

*blush* ... thanks for catching this, will put it back where it belongs.
