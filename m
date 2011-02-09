From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v3 2/3] Add function per_branch_config.
Date: Tue, 8 Feb 2011 19:14:42 -0600
Message-ID: <20110209011441.GA24346@elie>
References: <1297198129-3403-1-git-send-email-jaredhance@gmail.com>
 <1297211028-14382-1-git-send-email-jaredhance@gmail.com>
 <1297211028-14382-3-git-send-email-jaredhance@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Jared Hance <jaredhance@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 09 02:18:01 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pmygy-0001Tn-5N
	for gcvg-git-2@lo.gmane.org; Wed, 09 Feb 2011 02:18:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756025Ab1BIBOu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Feb 2011 20:14:50 -0500
Received: from mail-iy0-f174.google.com ([209.85.210.174]:38835 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755918Ab1BIBOt (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Feb 2011 20:14:49 -0500
Received: by iyj8 with SMTP id 8so3881369iyj.19
        for <git@vger.kernel.org>; Tue, 08 Feb 2011 17:14:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=xSncEyaOdcFjgz5pWTiZlJpKRrYoGssWJbB9ueSyrG4=;
        b=MtX6Fx3ORg1NBRgBMts7pOQ8Q+3KjePfmQX2HaWpG1m7oPFULk2udYZEdZ7roY5Eti
         1gyXT0N3mUG3CSqYCA6AUlpn/yQLy1HtWG1x4KVuqoxY8iZOH7W0fglnh//NZGXnWSjr
         LF5QlqjMa8P8MWr06Vgl95hYqboVLBLV9yWVE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=eBMVG5HzrmLBAmpMOKDSBximbh38I+uXRrI1LXDwoGiR1Hyd0NVrj59HbbVh7mDTqm
         GIdR9L9QTrGGqvEUyF+tdkrTPk2hOBD2JIj9S0jlA5Fud1l6MslhwbNiHvylmokDN4nR
         FndVyxrN7uyKyww5gikLopPh33sfVOn3skInE=
Received: by 10.42.179.132 with SMTP id bq4mr1327555icb.293.1297214088905;
        Tue, 08 Feb 2011 17:14:48 -0800 (PST)
Received: from elie ([76.206.235.233])
        by mx.google.com with ESMTPS id d21sm138362ibg.9.2011.02.08.17.14.46
        (version=SSLv3 cipher=OTHER);
        Tue, 08 Feb 2011 17:14:48 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1297211028-14382-3-git-send-email-jaredhance@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166383>

Jared Hance wrote:

> [PATCH v3 2/3] Add function per_branch_config.
>
> Adds a configuration function to be filled up more in the next patch.

Micronit: subject should be of the form

	subsystem: do something really great

with no full stop.  So the series might be, roughly:

 - merge: introduce setup_merge_commit helper function
 - merge: introduce per-branch configuration helper function
 - merge: add support for merging from upstream by default

Commit message bodies tend to be in the imperative mood, just like the
patches themselves.

Anyway, I like patch 1.  One tiny nit on this one:

> +++ b/builtin/merge.c
> @@ -498,11 +498,15 @@ cleanup:
>  	strbuf_release(&bname);
>  }
>  
> -static int git_merge_config(const char *k, const char *v, void *cb)
> +static int per_branch_config(const char *k, const char *v, void *cb)
>  {
> -	if (branch && !prefixcmp(k, "branch.") &&
> -		!prefixcmp(k + 7, branch) &&
> -		!strcmp(k + 7 + strlen(branch), ".mergeoptions")) {
> +	const char *variable;
> +	if (!branch || prefixcmp(k, "branch.")
> +	   || prefixcmp(k + 7, branch))
> +		return 1; /* not what I handle */

Alignment: isn't the "||" meant to be one space over?

Based on a quick grep[1], it seems the prevailing style is rather

	if (!branch || prefixcmp(k, "branch.") ||
	    prefixcmp(k + 7, branch))
		return 1;

with the || at the end of the line, though I'm not sure I care
much.  :)

With or without an extra space before the ||,
Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>

Thanks for a nice cleanup.
Jonathan

[1]
addup () {
	sum=0
	while read term
	do
		: $((sum = sum + term))
	done
	echo $sum
}

 $ git grep --cached -c -e '||$' | cut -d: -f2 | addup
 730
 $ git grep --cached -c -e '  ||' | cut -d: -f2 | addup
 98
 $ git grep --cached -c -e '	||' | cut -d: -f2 | addup
 79
