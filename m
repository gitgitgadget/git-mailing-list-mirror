From: Stephen Boyd <bebarino@gmail.com>
Subject: Re: [PATCH 11/18] git notes merge: Add automatic conflict resolvers
 (ours, theirs, union)
Date: Sat, 02 Oct 2010 02:14:46 -0700
Message-ID: <4CA6F806.9030209@gmail.com>
References: <1285719811-10871-1-git-send-email-johan@herland.net> <1285719811-10871-12-git-send-email-johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, jrnieder@gmail.com, gitster@pobox.com
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Sat Oct 02 11:15:14 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P1yBW-0002ZT-5Y
	for gcvg-git-2@lo.gmane.org; Sat, 02 Oct 2010 11:15:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753477Ab0JBJO6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 2 Oct 2010 05:14:58 -0400
Received: from mail-px0-f174.google.com ([209.85.212.174]:40612 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752822Ab0JBJO5 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 2 Oct 2010 05:14:57 -0400
Received: by pxi10 with SMTP id 10so950374pxi.19
        for <git@vger.kernel.org>; Sat, 02 Oct 2010 02:14:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=z8yLZHRwFKORf6ZKv2z38AcjNybEKc90Q57In6C6Rrk=;
        b=WF28O95R72s7cNJ9Mse4bAloPbs0fkcrJ5roaI8TQ8SgjJaX0jqV72c51p86TJYhSP
         HaXZxfmy8wzoxI0Wgl2qQXQG1nP7U7ix2LvxoiJJo2sPdpKycBy6y2z7iFTd3wF4i1RS
         wXGnNkqC523eKXdTkWvKiLFlWrhAjMINffAxk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=ZkjEsGI3Lky6TgbOO32d5WTxkC0ukto7GxfgIHZXwNjJcCf+9KpGT+wIn15W2EpCWa
         VX81ncxN9DbpjZ6MsEtsi+nUzsDjzoAJIsmXP+HyepHBtekTg8VJ7nKm3bDo+Zux6/hb
         eiURBGiiTBybJvD4nmWoIbrpnHPdHdXmC4YGc=
Received: by 10.142.51.1 with SMTP id y1mr5887866wfy.193.1286010897139;
        Sat, 02 Oct 2010 02:14:57 -0700 (PDT)
Received: from [192.168.1.100] ([75.85.182.25])
        by mx.google.com with ESMTPS id d10sm2605985wfe.10.2010.10.02.02.14.55
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 02 Oct 2010 02:14:56 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.8) Gecko/20100831 Lightning/1.0b2pre Thunderbird/3.1.2
In-Reply-To: <1285719811-10871-12-git-send-email-johan@herland.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157804>

On 09/28/2010 05:23 PM, Johan Herland wrote:
> @@ -788,6 +792,21 @@ static int merge(int argc, const char **argv, const char *prefix)
>  	expand_notes_ref(&remote_ref);
>  	o.remote_ref = remote_ref.buf;
>  
> +	if (strategy) {
> +		if (!strcmp(strategy, "manual"))
> +			o.strategy = NOTES_MERGE_RESOLVE_MANUAL;
> +		else if (!strcmp(strategy, "ours"))
> +			o.strategy = NOTES_MERGE_RESOLVE_OURS;
> +		else if (!strcmp(strategy, "theirs"))
> +			o.strategy = NOTES_MERGE_RESOLVE_THEIRS;
> +		else if (!strcmp(strategy, "union"))
> +			o.strategy = NOTES_MERGE_RESOLVE_UNION;
> +		else {
> +			error("Unknown -X/--resolve strategy: %s", strategy);

Is it -X/--resolve or -s/--strategy? This error confuses me.

> diff --git a/notes-merge.c b/notes-merge.c
> index f625ebd..6fa59d8 100644
> --- a/notes-merge.c
> +++ b/notes-merge.c
> @@ -262,6 +262,35 @@ static void diff_tree_local(struct notes_merge_options *o,
>  	diff_tree_release_paths(&opt);
>  }
>  
> +static int merge_one_change(struct notes_merge_options *o,
> +			    struct notes_merge_pair *p, struct notes_tree *t)
> +{
> +	/*
> +	 * Return 0 if change was resolved (and added to notes_tree),
> +	 * 1 if conflict
> +	 */
> +	switch (o->strategy) {
> +	case NOTES_MERGE_RESOLVE_MANUAL:
> +		return 1;
> +	case NOTES_MERGE_RESOLVE_OURS:
> +		OUTPUT(o, 2, "Using local notes for %s", sha1_to_hex(p->obj));
> +		/* nothing to do */
> +		return 0;
> +	case NOTES_MERGE_RESOLVE_THEIRS:
> +		OUTPUT(o, 2, "Using remote notes for %s", sha1_to_hex(p->obj));
> +		if (add_note(t, p->obj, p->remote, combine_notes_overwrite))
> +			die("confused: combine_notes_overwrite failed");

This will say:

fatal: confused: combine_notes_overwrite failed

Do we actually need the "confused" part? Heh, maybe we need a confused()
function?
