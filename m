From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] diff: resurrect XDF_NEED_MINIMAL with --minimal
Date: Mon, 3 Oct 2011 07:38:43 -0500
Message-ID: <20111003123843.GA15493@elie>
References: <7voby0j86c.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	=?utf-8?B?UmVuw6k=?= Scharfe <rene.scharfe@lsrfire.ath.cx>,
	Tay Ray Chuan <rctay89@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Oct 03 14:39:08 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RAhnW-00025A-Ks
	for gcvg-git-2@lo.gmane.org; Mon, 03 Oct 2011 14:39:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755736Ab1JCMjB convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 3 Oct 2011 08:39:01 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:38007 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755670Ab1JCMjA convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 3 Oct 2011 08:39:00 -0400
Received: by ywb5 with SMTP id 5so3350656ywb.19
        for <git@vger.kernel.org>; Mon, 03 Oct 2011 05:38:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=cnJBZ/9ny0RWxvlWBDRnly5n4uuQtbpQFkOV05jlRdw=;
        b=bVSfkOEAQ8VTE8cbs6PJY6KR9lyCIsn0VPsObPzEU1/X8uFmjQdv3vx7PFIE8s3NxW
         3Hl0Py1IhcgbKXU1v4FpGx/s5UadsjEot2WknBI1YFiE5Seh9eYVFe4mLgQCyvTJKsKJ
         QXIDWvLgBJ8oeWblYVuoFHcSp7EIdDTgaqQ4Y=
Received: by 10.236.180.168 with SMTP id j28mr50693151yhm.15.1317645539831;
        Mon, 03 Oct 2011 05:38:59 -0700 (PDT)
Received: from elie (99-120-124-35.lightspeed.cicril.sbcglobal.net. [99.120.124.35])
        by mx.google.com with ESMTPS id x12sm15507860yhi.10.2011.10.03.05.38.58
        (version=SSLv3 cipher=OTHER);
        Mon, 03 Oct 2011 05:38:59 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <7voby0j86c.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21+46 (b01d63af6fea) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182658>

Junio C Hamano wrote:

>  * This together with Ren=C3=A9's c5aa906 (Revert removal of multi-ma=
tch
>    discard heuristic in 27af01, 2011-09-25) on top of v1.7.7 seems to=
 give
>    identical diff output as v1.7.1 (e.g. "git diff-tree -p v2.6.39 v3=
=2E0"
>    in the kernel repository, with "--minimal").

Very neat.

> --- a/diff.c
> +++ b/diff.c
> @@ -3511,6 +3511,10 @@ int diff_opt_parse(struct diff_options *option=
s, const char **av, int ac)
>  	}
>  	else if (!strcmp(arg, "--abbrev"))
>  		options->abbrev =3D DEFAULT_ABBREV;
> +	else if (!strcmp(arg, "--minimal"))
> +		DIFF_XDL_SET(options, NEED_MINIMAL);
> +	else if (!strcmp(arg, "--no-minimal"))
> +		DIFF_XDL_CLR(options, NEED_MINIMAL);
>  	else if (!prefixcmp(arg, "--abbrev=3D")) {

I think this would fit well near --patience (the "xdiff options"
section), instead of hidden between the unsticked and sticked forms of
--abbrev. ;-)

Like this:

diff --git i/Documentation/diff-options.txt w/Documentation/diff-option=
s.txt
index b620b3af..4d87256e 100644
--- i/Documentation/diff-options.txt
+++ w/Documentation/diff-options.txt
@@ -48,6 +48,10 @@ endif::git-format-patch[]
 --patience::
 	Generate a diff using the "patience diff" algorithm.
=20
+--minimal::
+	Spend extra time to make sure the smallest possible
+	diff is produced.
+
 --stat[=3D<width>[,<name-width>[,<count>]]]::
 	Generate a diffstat.  You can override the default
 	output width for 80-column terminal by `--stat=3D<width>`.
diff --git i/diff.c w/diff.c
index fcc00780..2282f86f 100644
--- i/diff.c
+++ w/diff.c
@@ -3393,6 +3393,10 @@ int diff_opt_parse(struct diff_options *options,=
 const char **av, int ac)
 		DIFF_XDL_SET(options, IGNORE_WHITESPACE_AT_EOL);
 	else if (!strcmp(arg, "--patience"))
 		DIFF_XDL_SET(options, PATIENCE_DIFF);
+	else if (!strcmp(arg, "--minimal"))
+		DIFF_XDL_SET(options, NEED_MINIMAL);
+	else if (!strcmp(arg, "--no-minimal"))
+		DIFF_XDL_CLR(options, NEED_MINIMAL);
 	else if (!strcmp(arg, "--histogram"))
 		DIFF_XDL_SET(options, HISTOGRAM_DIFF);
=20
