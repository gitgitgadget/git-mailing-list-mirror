From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v2] git-pull.sh --rebase: overhaul error handling when
 no candidates are found
Date: Thu, 12 Nov 2009 22:07:54 -0600
Message-ID: <20091113040754.GA3255@progeny.tock>
References: <1257945756.26362.79.camel@heerbeest>
 <48B54636-1825-48B3-BECD-4150A55B013F@dbservice.com>
 <1257965806.26362.132.camel@heerbeest>
 <D6B0AE61-6CA3-4F79-BB50-B8795415BAB7@dbservice.com>
 <1257968052.26362.155.camel@heerbeest>
 <AC99BA30-A36D-4798-8E7D-9D69EFE99D55@dbservice.com>
 <1258035449.26362.273.camel@heerbeest>
 <20091112155310.7836c388@perceptron>
 <20091112150626.GA24848@coredump.intra.peff.net>
 <20091112170814.1858aba4@perceptron>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>,
	Jan Nieuwenhuizen <janneke-list@xs4all.nl>,
	Tomas Carnecky <tom@dbservice.com>,
	git list <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Jan =?iso-8859-1?Q?Kr=FCger?= <jk@jk.gs>
X-From: git-owner@vger.kernel.org Fri Nov 13 04:57:46 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N8nI9-0008HK-CK
	for gcvg-git-2@lo.gmane.org; Fri, 13 Nov 2009 04:57:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755485AbZKMD5e convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 12 Nov 2009 22:57:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755456AbZKMD5d
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Nov 2009 22:57:33 -0500
Received: from mail-yx0-f187.google.com ([209.85.210.187]:63223 "EHLO
	mail-yx0-f187.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755339AbZKMD5c (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Nov 2009 22:57:32 -0500
Received: by yxe17 with SMTP id 17so2613029yxe.33
        for <git@vger.kernel.org>; Thu, 12 Nov 2009 19:57:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=c++fIhPV+Mtq8/JlgGg9uBhEQ0G4ZuFQWhQQSVUtwOg=;
        b=kJ+t7rhHQJ8gm0IPx5wr/RJdKnWAlePv1P/tdpTUuFxPTnH+Ne59z0FAc/dcn+v7NF
         5mAtXpNgcuDjwG7NWkh/aBs1rWRWUed81o8AMjtzcOE33EA2+Q7fWG8msMykBUfqS/kI
         Hq2w+YoByMujUr/DGXtoEp5WEzGm1/BBx4XD4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=GO+m5GUFz4ZIZ8yCrH2vtGtFq3s2y2aTc+Xlk2C98ajs6lgNLhSjh5zQn+iHFr8qpC
         SIKFpBXKiDm4Uzo1sZ16oEqT7QNduWKRxB6Dkld2OICPhsbuXBgSt6Bs4m8JZ26dU5ti
         IYcKUgd1Anlhmj9W0iTyhoSIg5+GeWivvn81U=
Received: by 10.101.179.5 with SMTP id g5mr4171601anp.89.1258084658401;
        Thu, 12 Nov 2009 19:57:38 -0800 (PST)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id 39sm159489yxd.27.2009.11.12.19.57.36
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 12 Nov 2009 19:57:37 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20091112170814.1858aba4@perceptron>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132814>

Jan Kr=C3=BCger wrote:

> Subject: [PATCH v2] git-pull.sh --rebase: overhaul error handling whe=
n no candidates are found

s/error handling/error message/. :)

> --- a/git-pull.sh
> +++ b/git-pull.sh
> @@ -91,45 +91,56 @@ error_on_no_merge_candidates () {
[...]
>  	if [ $# -gt 1 ]; then
> -		echo "There are no candidates for merging in the refs that you jus=
t fetched."
> +		echo "There are no candidates for using the refs that you just fet=
ched."
>  		echo "Generally this means that you provided a wildcard refspec wh=
ich had no"
>  		echo "matches on the remote end."

This sounds a little awkward to me, maybe because all the remote refs
are being used to populate the remotes/<remote>/* hierarchy.

I=E2=80=99m trying to come up with an alternative wording, but it is ha=
rd:

 * Merging and rebasing are about incorporating the remote history
   into our own, so how about something like "... no candidates for
   incorporating from the refs ..."? =20

 * Maybe one is using 'git pull' to update.  "There are no
   candidates to use for an update among the refs that you just
   fetched."

 * Or: "There are no upstreams to local branches among the refs that
   you just fetched."

I like the third of these best, but I hope you can do better.

>  	elif [ $# -gt 0 ] && [ "$1" !=3D "$remote" ]; then
>  		echo "You asked to pull from the remote '$1', but did not specify"
> -		echo "a branch to merge. Because this is not the default configure=
d remote"
> +		echo "a branch to use. Because this is not the default configured =
remote"

Maybe just "... did not specify a branch."?

>  		echo "for your current branch, you must specify a branch on the co=
mmand line."
>  	elif [ -z "$curr_branch" ]; then
>  		echo "You are not currently on a branch, so I cannot use any"
>  		echo "'branch.<branchname>.merge' in your configuration file."
> -		echo "Please specify which branch you want to merge on the command=
"
> +		echo "Please specify which branch you want to use on the command"

s/branch/remote branch/?  The reader might worry that the command is
going to try to re-attach his HEAD.

The rest of your patch looks good to me.  Thanks for working on this.

Jonathan
