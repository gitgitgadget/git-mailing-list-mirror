From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCHv3 1/3] diff.c: omit hidden entries from namelen calculation
 with --stat
Date: Fri, 27 May 2011 22:19:33 +0200
Message-ID: <4DE00755.1020404@drmicha.warpmail.net>
References: <4DC0FD3D.9010004@drmicha.warpmail.net> <b47e2f0865bac1ad0e7b777ce9f27493292c502c.1306499600.git.git@drmicha.warpmail.net> <7vvcwwrqd7.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri May 27 22:19:44 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QQ3VW-0003Kh-Q4
	for gcvg-git-2@lo.gmane.org; Fri, 27 May 2011 22:19:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756083Ab1E0UTh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 May 2011 16:19:37 -0400
Received: from out3.smtp.messagingengine.com ([66.111.4.27]:48155 "EHLO
	out3.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752180Ab1E0UTg (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 27 May 2011 16:19:36 -0400
Received: from compute2.internal (compute2.nyi.mail.srv.osa [10.202.2.42])
	by gateway1.messagingengine.com (Postfix) with ESMTP id E3C25207E6;
	Fri, 27 May 2011 16:19:35 -0400 (EDT)
Received: from frontend1.messagingengine.com ([10.202.2.160])
  by compute2.internal (MEProxy); Fri, 27 May 2011 16:19:35 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=l4G1Fpj5Og8JkY96D+tbppoY0/o=; b=ZVGSM1uc3O04BhaglYpEEgY1bDy/k+u2lhBCWgUaHwVfz4pdgDV8mjaKOfGGehx1M2HmG4Gvp9wB8+94MzA+vxPNISQ93byApDRghVagZVfNiAvjBsw4bQtVc913eE2zJoZbPBsHkGMrA1c6NSQSCA0MKkb7n48L4unqNUh3WU0=
X-Sasl-enc: Eq0D1KUN5epHgC6TUlNNwxxP3iZNnC/VWltJZjO5+a1E 1306527575
Received: from localhost.localdomain (p54859233.dip0.t-ipconnect.de [84.133.146.51])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 135D140850D;
	Fri, 27 May 2011 16:19:34 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.17) Gecko/20110428 Fedora/3.1.10-1.fc15 Lightning/1.0b3pre Thunderbird/3.1.10
In-Reply-To: <7vvcwwrqd7.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174646>

Junio C Hamano venit, vidit, dixit 27.05.2011 19:43:
> Michael J Gruber <git@drmicha.warpmail.net> writes:
> 
>> Currently, --stat calculates the longest name from all items but then
>> drops some (mode changes) from the output later on.
>>
>> Instead, drop them from the namelen generation and calculation.
>>
>> Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
>> ---
>> This optimizes (tightens) the display potentially, but we never had tests
>> which are sensitive to that.
> 
> More importantly I think this is a good first step in the right direction
> to reduce the duplicated code that need to implement the same logic.
> 
> However, you missed another instance in show_shortstats() no?

I'm sorry I don't understand this remark. For all different formats, the
respective functions show_stat(), show_shortstats() etc. do their own
formatting, and I did not change this at all. So, what did I miss?

Also, show_shortstats() does not need the names, so what similar change
should one have made there?

> I am wondering if it would make it easier to both read and maintain if you
> add a boolean field "changed" to "struct diffstat_file", and set it at the
> end of builtin_diffstat(), and have these places all check that field.

Sounds fine.

> A possible alternative is not to put such an unchanged entry in the struct
> diffstat_t in the first place so that nobody has to worry about it. Right
> now, show_numstat() does show 0/0 entries (i.e. only mode change), while
> shortstat and normal stat do not, but I somehow have a feeling that this
> difference is not by design but by accident.  Besides, --numstat that only
> says 0/0 is not useful in practice without --summary.
> 
>     $ edit diff.c
>     $ chmod +x Makefile
>     $ git diff --stat
>      diff.c |   26 ++++++++++++++------------
>     $ git diff --numstat
>     0       0       Makefile
>     14      12      diff.c
>     $ git diff --numstat --summary
>     0       0       Makefile
>     14      12      diff.c
>      mode change 100644 => 100755 Makefile
> 
> Getting rid of an unchanged entry from the diffstat array upfront will
> change the behaviour of numstat, but I suspect that it change things in a
> better way, making the result consistent with the textual version.

That sounds good to me.

> The patch below, diff.c shows that approach, while ndiff.c shows the extra
> boolean "changed" approach.
> 
> What do you think?
> 
>  diff.c            |    7 +++++++
>  diff.c => ndiff.c |   26 ++++++++++++++------------
>  2 files changed, 21 insertions(+), 12 deletions(-)
> 
> diff --git a/diff.c b/diff.c
> index 8f4815b..e2ee70a 100644
> --- a/diff.c
> +++ b/diff.c
> @@ -2267,6 +2267,13 @@ static void builtin_diffstat(const char *name_a, const char *name_b,
>  			      &xpp, &xecfg);
>  	}
>  
> +	if (!data->is_renamed && !data->added && !data->deleted) {
> +		diffstat->nr--;
> +		free(data->name);
> +		free(data->from_name);
> +		free(data);
> +	}
> +

I don't know that codepath very well, but hasn't that diffstat been
added earlier in builtin_diffstat() already? But maybe the
diffstat->nr-- takes care of that.

Also, I have no idea how builtin_diffstat() influences show_stat() which
my patch was about, sorry.

>  	diff_free_filespec_data(one);
>  	diff_free_filespec_data(two);
>  }
> diff --git a/diff.c b/ndiff.c
> similarity index 99%
> copy from diff.c
> copy to ndiff.c
> index 8f4815b..1620053 100644
> --- a/diff.c
> +++ b/ndiff.c
> @@ -1222,6 +1222,7 @@ struct diffstat_t {
>  		unsigned is_unmerged:1;
>  		unsigned is_binary:1;
>  		unsigned is_renamed:1;
> +		unsigned changed:1;
>  		uintmax_t added, deleted;
>  	} **files;
>  };
> @@ -1350,6 +1351,9 @@ static void show_stats(struct diffstat_t *data, struct diff_options *options)
>  	for (i = 0; i < data->nr; i++) {
>  		struct diffstat_file *file = data->files[i];
>  		uintmax_t change = file->added + file->deleted;
> +
> +		if (!file->changed)
> +			continue;
>  		fill_print_name(file);
>  		len = strlen(file->print_name);
>  		if (max_len < len)
> @@ -1381,6 +1385,11 @@ static void show_stats(struct diffstat_t *data, struct diff_options *options)
>  		uintmax_t deleted = data->files[i]->deleted;
>  		int name_len;
>  
> +		if (!data->files[i]->changed) {
> +			total_files--;
> +			continue;
> +		}
> +
>  		/*
>  		 * "scale" the filename
>  		 */
> @@ -1415,11 +1424,6 @@ static void show_stats(struct diffstat_t *data, struct diff_options *options)
>  			fprintf(options->file, "  Unmerged\n");
>  			continue;
>  		}
> -		else if (!data->files[i]->is_renamed &&
> -			 (added + deleted == 0)) {
> -			total_files--;
> -			continue;
> -		}

or do this dance only here (with ...->changed) instead of in the first
loop, because in 2/3 (when limited by stat_count), the second loop would
be done all the way up to nr (as 2 separate loops), but the first one
only up to count.

>  
>  		/*
>  		 * scale the add/delete
> @@ -1457,15 +1461,12 @@ static void show_shortstats(struct diffstat_t *data, struct diff_options *option
>  	for (i = 0; i < data->nr; i++) {
>  		if (!data->files[i]->is_binary &&
>  		    !data->files[i]->is_unmerged) {
> -			int added = data->files[i]->added;
> -			int deleted= data->files[i]->deleted;
> -			if (!data->files[i]->is_renamed &&
> -			    (added + deleted == 0)) {
> +			if (!data->files[i]->changed) {
>  				total_files--;
> -			} else {
> -				adds += added;
> -				dels += deleted;
> +				continue;
>  			}
> +			adds += data->files[i]->added;
> +			dels += data->files[i]->deleted;
>  		}
>  	}
>  	if (options->output_prefix) {
> @@ -2266,6 +2267,7 @@ static void builtin_diffstat(const char *name_a, const char *name_b,
>  		xdi_diff_outf(&mf1, &mf2, diffstat_consume, diffstat,
>  			      &xpp, &xecfg);
>  	}
> +	data->changed = data->is_renamed || data->added || data->deleted;
>  
>  	diff_free_filespec_data(one);
>  	diff_free_filespec_data(two);

Does show_stats() get the data as modified by builtin_diffstat()? Then
this is fine.

Again, I'm sorry I'm not seeing through the call chain here.

Michael
