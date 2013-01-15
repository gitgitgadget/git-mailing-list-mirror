From: Michal Privoznik <mprivozn@redhat.com>
Subject: Re: [PATCH v2 3/3] diff: Introduce --diff-algorithm command line
 option
Date: Tue, 15 Jan 2013 11:07:23 +0100
Message-ID: <50F52A5B.4030609@redhat.com>
References: <cover.1358193364.git.mprivozn@redhat.com> <1b9015bb45f2ece54dae7baee3cbcdc54b9c7ee9.1358193364.git.mprivozn@redhat.com> <7vvcaz8of4.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, peff@peff.net, trast@student.ethz.ch
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jan 15 11:08:10 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tv3R5-0007Gh-7l
	for gcvg-git-2@plane.gmane.org; Tue, 15 Jan 2013 11:08:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755012Ab3AOKHm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Jan 2013 05:07:42 -0500
Received: from mx1.redhat.com ([209.132.183.28]:34553 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750963Ab3AOKHl (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Jan 2013 05:07:41 -0500
Received: from int-mx10.intmail.prod.int.phx2.redhat.com (int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id r0FA7QPa022228
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK);
	Tue, 15 Jan 2013 05:07:26 -0500
Received: from [10.34.27.249] (dhcp-27-249.brq.redhat.com [10.34.27.249])
	by int-mx10.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id r0FA7NGl024660;
	Tue, 15 Jan 2013 05:07:24 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130114 Thunderbird/17.0.2
In-Reply-To: <7vvcaz8of4.fsf@alter.siamese.dyndns.org>
X-Scanned-By: MIMEDefang 2.68 on 10.5.11.23
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213629>

On 14.01.2013 22:06, Junio C Hamano wrote:
> Michal Privoznik <mprivozn@redhat.com> writes:
> 
>> +--diff-algorithm={patience|minimal|histogram|myers}::
>> +	Choose a diff algorithm. The variants are as follows:
>> ++
>> +--
>> +`myers`;;
>> +	The basic greedy diff algorithm.
>> +`minimal`;;
>> +	Spend extra time to make sure the smallest possible diff is
>> +	produced.
>> +`patience`;;
>> +	Use "patience diff" algorithm when generating patches.
>> +`histogram`;;
>> +	This algorithm extends the patience algorithm to "support
>> +	low-occurrence common elements".
>> +--
>> ++
>> +For instance, if you configured diff.algorithm variable to a
>> +non-default value and want to use the default one, then you
>> +have to use `--diff-algorithm=myers` option.
>> +
>> +You should prefer this option over the `--minimal`, `--patience` and
>> +`--histogram` which are kept just for backwards compatibility.
> 
> Much better; I'd drop the last paragraph, though.
> 
> I also think we really should consider "default" synonym for
> whichever happens to be the built-in default (currently myers).
> 
>> diff --git a/diff.c b/diff.c
>> index e9a7e4d..3e021d5 100644
>> --- a/diff.c
>> +++ b/diff.c
>> @@ -144,7 +144,7 @@ static int git_config_rename(const char *var, const char *value)
>>  	return git_config_bool(var,value) ? DIFF_DETECT_RENAME : 0;
>>  }
>>  
>> -static long parse_algorithm_value(const char *value)
>> +long parse_algorithm_value(const char *value)
>>  {
>>  	if (!value || !strcasecmp(value, "myers"))
>>  		return 0;
>> @@ -3633,6 +3633,16 @@ int diff_opt_parse(struct diff_options *options, const char **av, int ac)
>>  		options->xdl_opts = DIFF_WITH_ALG(options, PATIENCE_DIFF);
>>  	else if (!strcmp(arg, "--histogram"))
>>  		options->xdl_opts = DIFF_WITH_ALG(options, HISTOGRAM_DIFF);
>> +	else if (!prefixcmp(arg, "--diff-algorithm=")) {
>> +		long value = parse_algorithm_value(arg+17);
>> +		if (value < 0)
>> +			return error("option diff-algorithm accepts \"myers\", "
>> +				     "\"minimal\", \"patience\" and \"histogram\"");
>> +		/* clear out previous settings */
>> +		DIFF_XDL_CLR(options, NEED_MINIMAL);
>> +		options->xdl_opts &= ~XDF_DIFF_ALGORITHM_MASK;
>> +		options->xdl_opts |= value;
> 
> This makes me wonder if other places that use DIFF_WITH_ALG() also
> need to worry about clearing NEED_MINIMAL?
> 

Not really. In my approach, --minimal looks at yet another algorithm.
However, current code sees it as orthogonal to the myers algorithm. The
flag doesn't have any effect on --patience or --histogram at all.

So I think we need to clear the flag only when using --diff-algorithm.

Michal
