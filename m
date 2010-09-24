From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 03/24] t9300 (fast-import): guard "export large marks"
 test setup
Date: Fri, 24 Sep 2010 15:08:52 +0530
Message-ID: <20100924093847.GE22658@kytes>
References: <20100701031819.GA12524@burratino>
 <20100701054849.GA14972@burratino>
 <20100817170216.GA14491@kytes>
 <20100905031528.GA2344@burratino>
 <20100905032253.GB2344@burratino>
 <20100924065900.GA4666@burratino>
 <20100924070950.GD4666@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	David Barr <david.barr@cordelta.com>,
	Sam Vilain <sam@vilain.net>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Fri Sep 24 11:40:29 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oz4lT-0008TI-To
	for gcvg-git-2@lo.gmane.org; Fri, 24 Sep 2010 11:40:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753237Ab0IXJkR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Sep 2010 05:40:17 -0400
Received: from mail-px0-f174.google.com ([209.85.212.174]:32952 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752168Ab0IXJkQ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Sep 2010 05:40:16 -0400
Received: by pxi10 with SMTP id 10so729059pxi.19
        for <git@vger.kernel.org>; Fri, 24 Sep 2010 02:40:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=k8OPPBYXXnFvvXWrowZO+fLC4eRhqQC890knVCpyDtw=;
        b=n7Dp9nQSfWpUzodrC2zse8trF/LKJNJYEq/WcJFIUo7Psm4M1bRNP8kvLEcb9z1wad
         IlUbVT2AtLvw5hDUObq5GVP9rwZXJQXNI2WcJi0FA6+/pwgZwIZj/zIEqoWhalySHYny
         M7ya12zLC+1LelCZ4WaBW3zHoalW60V1ZdHpE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=akdSsR2AiTY7AFiqOA9BSSeVH14USGlxMYduIglIZTPC56u+QaIfbRFMfUKaXvG5mI
         DmbV8QpQCgdpU4eNfzsUd8ih03BHs6O77QHLt3tFWduuXPi5F8YbtxaVfui7LRcU45s0
         4s3fwKWk862MHW+IurLOoRTtFGE40KLTuXoT4=
Received: by 10.114.52.2 with SMTP id z2mr3251941waz.84.1285321215938;
        Fri, 24 Sep 2010 02:40:15 -0700 (PDT)
Received: from kytes ([203.110.240.41])
        by mx.google.com with ESMTPS id s5sm3208025wak.0.2010.09.24.02.40.11
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 24 Sep 2010 02:40:14 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100924070950.GD4666@burratino>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156966>

Hi,

Jonathan Nieder writes:
>  test_expect_success 'A: export marks with large values' '
> +	test_tick &&
> +	mt=$(git hash-object --stdin </dev/null) &&
> +	>input.blob &&
> +	>marks.exp &&
> +	>tree.exp &&
> +
> +	cat >input.commit <<-EOF &&
> +	commit refs/heads/verify--dump-marks
> +	committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
> +	data <<COMMIT
> +	test the sparse array dumping routines with exponentially growing marks

Ok, so we want marks to grow exponentially.

> +	COMMIT
> +	EOF
> +
> +	(
> +		i=0 &&
> +		l=4 &&
> +		m=6 &&
> +		n=7 &&

Maybe use slightly less cryptic variable names?

> +		while test "$i" -lt 27

Something like for i in `seq 1 10` will atleast make it clear that i
is just a loop variable. That's one arbitrary variable less.

> +		do
> +			cat >>input.blob <<-EOF &&
> +			blob
> +			mark :$l
> +			data 0
> +			blob
> +			mark :$m
> +			data 0
> +			blob
> +			mark :$n
> +			data 0
> +			EOF
> +			{
> +				echo "M 100644 :$l l$i" &&
> +				echo "M 100644 :$m m$i" &&
> +				echo "M 100644 :$n n$i"
> +			} >>input.commit &&
> +			{
> +				echo ":$l $mt" &&
> +				echo ":$m $mt" &&
> +				echo ":$n $mt"
> +			} >>marks.exp &&
> +			{
> +				printf "100644 blob $mt\tl$i\n" &&
> +				printf "100644 blob $mt\tm$i\n" &&
> +				printf "100644 blob $mt\tn$i\n"
> +			} >>tree.exp &&
> +			l=$(($l + $l)) &&
> +			m=$(($m + $m)) &&
> +			n=$(($l + $n)) &&

Maybe l=$(($l * 2)) and similarly for m to emphasize that they're
doubling in every loop iteration?

-- Ram
