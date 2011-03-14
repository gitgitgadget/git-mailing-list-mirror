From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 3/3] clone: Free a few paths
Date: Mon, 14 Mar 2011 14:45:01 -0500
Message-ID: <20110314194501.GA30483@elie>
References: <1300130318-11279-1-git-send-email-cmn@elego.de>
 <1300130318-11279-4-git-send-email-cmn@elego.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Carlos =?utf-8?Q?Mart=C3=ADn?= Nieto <cmn@elego.de>
X-From: git-owner@vger.kernel.org Mon Mar 14 20:45:18 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PzDhc-00047U-3r
	for gcvg-git-2@lo.gmane.org; Mon, 14 Mar 2011 20:45:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752631Ab1CNTpJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 14 Mar 2011 15:45:09 -0400
Received: from mail-vx0-f174.google.com ([209.85.220.174]:41000 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751970Ab1CNTpI convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 14 Mar 2011 15:45:08 -0400
Received: by vxi39 with SMTP id 39so4687992vxi.19
        for <git@vger.kernel.org>; Mon, 14 Mar 2011 12:45:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=S3MHmpqdsZ2NCl1GGQSSkFYcuVMVF5FozMn9O+7UMoA=;
        b=tq5A+CBLPXAKmjS1f2hpJlfOcK2atQgPbjy0zMqnl3qRUvWjuEVbHjhxmPZFx2IrHa
         4uNM/l+XQRn56QORgIb6du4LK5s4269uzzxVMrTCx+Uqkc03LDsWX6Aq50+9M0RVn2ad
         ajOU+u72j7MSMa/ffSA5JLx4c2KR2vXf1IM+w=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=RovRMFx9NsD5eDjpBkWS7CBAiG8LNR+c59I9Me29ezovSf73FdYgzF/QdEYyqaMoIi
         KZZyWk9vkLpTFMs89s4d3qeBV2/K6ukEZ/XY/SGH7LURpHbe4RvAnQYXe/DBApIsmMPa
         vkzlF/kWL0k5kegkNWuDTk2g83i87hp1E7Oh8=
Received: by 10.220.117.141 with SMTP id r13mr3642998vcq.30.1300131907631;
        Mon, 14 Mar 2011 12:45:07 -0700 (PDT)
Received: from elie (adsl-69-209-56-53.dsl.chcgil.sbcglobal.net [69.209.56.53])
        by mx.google.com with ESMTPS id r5sm1031059vch.40.2011.03.14.12.45.05
        (version=SSLv3 cipher=OTHER);
        Mon, 14 Mar 2011 12:45:06 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1300130318-11279-4-git-send-email-cmn@elego.de>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169018>

Hi,

Carlos Mart=C3=ADn Nieto wrote:

> Free the path, repo, dir buffers
>=20
> Signed-off-by: Carlos Mart=C3=ADn Nieto <cmn@elego.de>
[...]
> +	free(dir);
> +	free(repo);
> +	free(path);
>  	strbuf_release(&reflog_msg);
>  	strbuf_release(&branch_top);
>  	strbuf_release(&key);

Thanks.  The commit message should probably mention that this is for
the sake of valgrind rather a true memory leak, since the memory is
freed by _exit at the appropriate time already.

The patch itself seems sane, since the performance effect should be
negligible.

But it reminds me: does "valgrind --tool=3Dmemcheck" provide a way to
annotate allocations like these?  In other words, is it be possible to
have functions xmalloc_permanent and xstrdup_permanent that

 * allocate a buffer that is never meant to be freed;
 * do not cause valgrind to complain;
 * could be reimplemented some day by taking allocations from a large
   contiguous pool, to avoid malloc overhead and to take advantage of
   the knowledge that these allocations never need to be freed

?

Curious,
Jonathan
