From: Michael Grubb <devel@dailyvoid.com>
Subject: Re: [PATCH v4] Add default merge options for all branches
Date: Tue, 03 May 2011 23:28:53 -0500
Message-ID: <4DC0D605.20204@dailyvoid.com>
References: <20110503090351.GA27862@elie> <4DC0608F.9040208@dailyvoid.com> <20110503204442.GI1019@elie> <7vsjsvgzzf.fsf@alter.siamese.dyndns.org> <7vzkn3f5wo.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	vmiklos@frugalware.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed May 04 06:29:08 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QHThz-0004lJ-1k
	for gcvg-git-2@lo.gmane.org; Wed, 04 May 2011 06:29:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751331Ab1EDE3B (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 May 2011 00:29:01 -0400
Received: from 75.98.162.166.static.a2webhosting.com ([75.98.162.166]:40824
	"EHLO dailyvoid.com" rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org
	with ESMTP id S1751094Ab1EDE3A (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 May 2011 00:29:00 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; s=default; d=dailyvoid.com;
	h=Received:Message-ID:Date:From:User-Agent:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding:X-Source:X-Source-Args:X-Source-Dir;
	b=MTNFxQ03/qlqvtZpQ3qdOk9Iun3pYujZbB+git7Nbjl96sb3iUTvELNic102j2FU/Jo7RRwFHTPiAoo95Qxv4oCoTVhIGTIe9NsRzLSU5QBkpW/FDqmTuy6yo0x+IOd4;
Received: from adsl-99-59-251-170.dsl.ltrkar.sbcglobal.net ([99.59.251.170] helo=macbook.local)
	by a2s24.a2hosting.com with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.69)
	(envelope-from <devel@dailyvoid.com>)
	id 1QHThm-000827-IW; Wed, 04 May 2011 00:28:54 -0400
User-Agent: Mozilla/5.0 (Macintosh; U; Intel Mac OS X 10.6; en-US; rv:1.9.2.17) Gecko/20110414 Thunderbird/3.1.10
In-Reply-To: <7vzkn3f5wo.fsf@alter.siamese.dyndns.org>
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - a2s24.a2hosting.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - dailyvoid.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172713>

I take this to mean that my patch is no longer needed/wanted?

On 5/3/11 11:25 PM, Junio C Hamano wrote:
> Junio C Hamano <gitster@pobox.com> writes:
> 
>> Jonathan Nieder <jrnieder@gmail.com> writes:
>>
>>> I'm starting to suspect it might be simpler to add a new "[merge] no-ff"
>>> configuration item, like the existing "[merge] log".
>>
>> Surely
>>
>> 	[merge]
>>         	log = false
>>               ff = false
>>
>> would be a lot simpler and probably far easier to explain.
> 
> Yes, it is far simpler and easier to explain.  I'll leave the tests and
> the commit log message to people who are more interested in this topic
> than I am ;-)
> 
>  Documentation/merge-config.txt |    6 ++++++
>  builtin/merge.c                |    3 +++
>  2 files changed, 9 insertions(+), 0 deletions(-)
> 
> diff --git a/Documentation/merge-config.txt b/Documentation/merge-config.txt
> index 8920258..2aa4408 100644
> --- a/Documentation/merge-config.txt
> +++ b/Documentation/merge-config.txt
> @@ -16,6 +16,12 @@ merge.defaultToUpstream::
>  	to their corresponding remote tracking branches, and the tips of
>  	these tracking branches are merged.
>  
> +merge.ff::
> +	Do not generate a merge commit if the merge resolved as a
> +	fast-forward; only update the branch pointer instead.  Setting
> +	this to `false` would be equivalent to giving `--no-ff` from
> +	the command line.
> +
>  merge.log::
>  	In addition to branch names, populate the log message with at
>  	most the specified number of one-line descriptions from the
> diff --git a/builtin/merge.c b/builtin/merge.c
> index d171c63..5194f04 100644
> --- a/builtin/merge.c
> +++ b/builtin/merge.c
> @@ -541,6 +541,9 @@ static int git_merge_config(const char *k, const char *v, void *cb)
>  		if (is_bool && shortlog_len)
>  			shortlog_len = DEFAULT_MERGE_LOG_LEN;
>  		return 0;
> +	} else if (!strcmp(k, "merge.ff")) {
> +		allow_fast_forward = git_config_bool(k, v);
> +		return 0;
>  	} else if (!strcmp(k, "merge.defaulttoupstream")) {
>  		default_to_upstream = git_config_bool(k, v);
>  		return 0;
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
