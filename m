From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH] parse-options: always show arghelp when LITERAL_ARGHELP is
 set
Date: Tue, 30 Nov 2010 10:00:59 -0600
Message-ID: <20101130160059.GA31844@burratino>
References: <1287544320-8499-1-git-send-email-pclouds@gmail.com>
 <1287544320-8499-4-git-send-email-pclouds@gmail.com>
 <20101022063837.GA6081@burratino>
 <20101022064258.GB6081@burratino>
 <7v8w1qnkr1.fsf@alter.siamese.dyndns.org>
 <20101024072032.GA23455@burratino>
 <20101024081316.GA29630@burratino>
 <20101130025223.GA5326@burratino>
 <20101130031549.GG5326@burratino>
 <4CF4B234.9060206@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	git@vger.kernel.org, Pierre Habouzit <madcoder@debian.org>
To: Stephen Boyd <bebarino@gmail.com>
X-From: git-owner@vger.kernel.org Tue Nov 30 17:01:29 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PNSdy-0002fz-Ly
	for gcvg-git-2@lo.gmane.org; Tue, 30 Nov 2010 17:01:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754325Ab0K3QBS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Nov 2010 11:01:18 -0500
Received: from mail-vw0-f66.google.com ([209.85.212.66]:58450 "EHLO
	mail-vw0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754250Ab0K3QBR (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Nov 2010 11:01:17 -0500
Received: by vws15 with SMTP id 15so506911vws.1
        for <git@vger.kernel.org>; Tue, 30 Nov 2010 08:01:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=kpjb/87eeCqbEHzZFE2V10yLPp3FLqJ26CF4E5k/CaY=;
        b=WzFP/TIGfs1+BnN1fnz0T5fWbbKKJhDsB4rjAjNy6Qgxgy5dCBdrLqVmHZK8ke9ZZT
         qqBlFXn29os1p/bjpFLZj/3zlmL58pJh7Li8aab2GSdPla5+Y9xmecI/03XBWWwVB/I6
         73PJwZ6GOzNs52o+bxmgIGG59rbz2/InBvbF4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=mVLCXhdskWjNwtW5wTYHEnFGbMPrPESjNiCaxOpYyqZr6NeIVP2DW2Kio/fMmTUXW9
         Ulwq3dzQZ6TSerkHd8K1/BcxzsNi/VGf8jfZApci8S+e8Pl/N8smXyHW+BaGJTLcw9wY
         HU5kYCFaEsDsfm3KhFs6BQezUzMPaavfspxHs=
Received: by 10.220.177.198 with SMTP id bj6mr326603vcb.257.1291132876397;
        Tue, 30 Nov 2010 08:01:16 -0800 (PST)
Received: from burratino (adsl-68-255-109-73.dsl.chcgil.sbcglobal.net [68.255.109.73])
        by mx.google.com with ESMTPS id m10sm1018638vcf.21.2010.11.30.08.01.13
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 30 Nov 2010 08:01:14 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <4CF4B234.9060206@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162485>

The PARSE_OPT_LITERAL_ARGHELP flag allows a program to override the
usual "<argument> for mandatory, [argument] for optional" markup
in its help message.  Extend it by allowing the usual "no text for
disallowed" to be overridden, too (for options with PARSE_OPT_NOARG |
PARSE_OPT_LITERAL_ARGHELP, which was previously an unsupported
combination).

So now a person can impose ugly usage messages like

	--refresh [--] <pathspec>...
	                      don't add, only refresh the index

but more importantly, update-index can correctly advertise

	--cacheinfo <mode> <object> <path>
	                      add the specified entry to the index

without unsetting PARSE_OPT_NOARG and making that '--cacheinfo=<mode>'
'<object>' '<path>'.

Noticed-by: Stephen Boyd <bebarino@gmail.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
Stephen Boyd wrote:
> On 11/29/10 19:15, Jonathan Nieder wrote:
>> +		{OPTION_LOWLEVEL_CALLBACK, 0, "cacheinfo", NULL,
>> +			"<mode> <object> <path>",
>> +			"add the specified entry to the index",
>> +			PARSE_OPT_NOARG | PARSE_OPT_NONEG | PARSE_OPT_LITERAL_ARGHELP,
>> +			(parse_opt_cb *) cacheinfo_callback},
>
> Doesn't this take arguments and thus shouldn't be marked
> PARSE_OPT_NOARG? Confused.

Yes, that deserves a comment.

			PARSE_OPT_NOARG |	/* disallow sticky --cacheinfo=<mode> form */
			PARSE_OPT_NONEG | PARSE_OPT_LITERAL_ARGHELP,

>> @@ -602,151 +799,48 @@ int cmd_update_index(int argc, const char **argv, const char *prefix)
[...]
>> +	parse_options_start(&ctx, argc, argv, prefix,
>> +			    PARSE_OPT_STOP_AT_NON_OPTION);
>
> This will need to take options too, sorry.

That would just be a merge artifact, no? :)  Thanks for a pointer.

If all goes well, I'll reroll the series with your patch later today.

 parse-options.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/parse-options.c b/parse-options.c
index df8299c..71ebd9e 100644
--- a/parse-options.c
+++ b/parse-options.c
@@ -552,7 +552,8 @@ static int usage_with_options_internal(struct parse_opt_ctx_t *ctx,
 		if (opts->type == OPTION_NUMBER)
 			pos += fprintf(outfile, "-NUM");
 
-		if (!(opts->flags & PARSE_OPT_NOARG))
+		if ((opts->flags & PARSE_OPT_LITERAL_ARGHELP) ||
+		    !(opts->flags & PARSE_OPT_NOARG))
 			pos += usage_argh(opts, outfile);
 
 		if (pos <= USAGE_OPTS_WIDTH)
-- 
1.7.2.3
