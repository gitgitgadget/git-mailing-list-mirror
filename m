From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCHv2 1/2] attr: map builtin userdiff drivers to well-known
 extensions
Date: Mon, 19 Dec 2011 12:07:33 -0600
Message-ID: <20111219180733.GA12200@elie.hsd1.il.comcast.net>
References: <20111217033808.GA8683@elie.hsd1.il.comcast.net>
 <20111219154938.GA19829@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Johannes Sixt <j6t@kdbg.org>,
	Junio C Hamano <gitster@pobox.com>,
	Brandon Casey <drafnel@gmail.com>,
	Philip Oakley <philipoakley@iee.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Dec 19 19:07:53 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rchcu-0002u7-PK
	for gcvg-git-2@lo.gmane.org; Mon, 19 Dec 2011 19:07:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752528Ab1LSSHs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Dec 2011 13:07:48 -0500
Received: from mail-vx0-f174.google.com ([209.85.220.174]:62016 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752140Ab1LSSHq (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Dec 2011 13:07:46 -0500
Received: by vcbfk14 with SMTP id fk14so4222592vcb.19
        for <git@vger.kernel.org>; Mon, 19 Dec 2011 10:07:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=Kgjslq3FDwpKhR1ksX43EZuMW8kQQpH5lx2NfF3kzcs=;
        b=HHC+l99qhOr9QA10f2gTeX9WnmGJUBiXJiO/g1sBp5w8WbK+o82VXMD5uABOUxY2rN
         YabDpH8qj6qYibZn9R42nvXn/iqPR0mXP9G+8hOSeAcoY7rxqfIkfZwbkwKvVylOKO4k
         NhghIOiUuzZAQdTiD7PKGerldBVE74wIRWgtw=
Received: by 10.52.90.145 with SMTP id bw17mr12926796vdb.73.1324318066256;
        Mon, 19 Dec 2011 10:07:46 -0800 (PST)
Received: from elie.hsd1.il.comcast.net (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id em3sm16918626vdc.10.2011.12.19.10.07.44
        (version=SSLv3 cipher=OTHER);
        Mon, 19 Dec 2011 10:07:45 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20111219154938.GA19829@sigill.intra.peff.net>
User-Agent: Mutt/1.5.21+51 (9e756d1adb76) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187462>

Hi,

Two quick thoughts:

Jeff King wrote:

> The C mappings are still here, but see the next patch.

This is adding a regression in order to remove it.  I guess it's
harmless, but I don't see the point.

[...]
> --- a/t/t4012-diff-binary.sh
> +++ b/t/t4012-diff-binary.sh
> @@ -90,4 +90,17 @@ test_expect_success 'diff --no-index with binary creation' '
>  	test_cmp expected actual
>  '
>  
> +test_expect_success 'binary files are not considered text by file extension' '
> +	echo Q | q_to_nul >binary.c &&
> +	git add binary.c &&
> +	cat >expect <<-\EOF &&
> +	diff --git a/binary.c b/binary.c
> +	new file mode 100644
> +	index 0000000..1f2a4f5
> +	Binary files /dev/null and b/binary.c differ
> +	EOF
> +	git diff --cached binary.c >actual &&
> +	test_cmp expect actual

Re the idea of this test: very good idea.

Re the mechanics: I would have been happier to see

	echo Q | q_to_nul >binary.c &&
	git add binary.c &&
	git diff --cached binary.c >diff &&
	grep Binary files diff

since that would avoid hard-coding some assumptions:

 - the blob name of binary.c
 - that [diff] mnemonicprefix defaults to false (I'd like to see the
   default change to true)
 - that [core] abbrev defaults to 7 (it probably won't change, but
   it's a distracting detail, and if we were starting over 8 might be
   a better default)

A bonus comment: :)

[...]
> --- a/t/t4018-diff-funcname.sh
> +++ b/t/t4018-diff-funcname.sh
> @@ -124,7 +124,9 @@ do
>  done
>  
>  test_expect_success 'default behaviour' '
> -	rm -f .gitattributes &&
> +	cat >.gitattributes <<-\EOF &&
> +	*.java diff=default
> +	EOF
>  	test_expect_funcname "public class Beer\$"
>  '

	echo "*.java diff=default" >.gitattributes

would do the same with two lines fewer. :)

Thanks for working on this.  I owe you a beer.

Jonathan
