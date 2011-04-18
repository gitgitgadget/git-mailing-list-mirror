From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [REGRESSION] git-wrapper to run-commands codepath regression
Date: Mon, 18 Apr 2011 17:17:20 -0500
Message-ID: <20110418221720.GA16977@elie>
References: <7v8vv78eld.fsf@alter.siamese.dyndns.org>
 <7v4o5v8dlp.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Apr 19 00:17:32 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QBwl9-0002Ks-Pu
	for gcvg-git-2@lo.gmane.org; Tue, 19 Apr 2011 00:17:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752697Ab1DRWR2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Apr 2011 18:17:28 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:60627 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751585Ab1DRWR0 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Apr 2011 18:17:26 -0400
Received: by iyb14 with SMTP id 14so4262042iyb.19
        for <git@vger.kernel.org>; Mon, 18 Apr 2011 15:17:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=7pubXNbNaf5W/cOWFQPsvu4oxnWASYw6He+/i9K8xgM=;
        b=U1K7rWQjy94mZeLwIRDE7MHV5+nxHGS3NnwbQKAhtBlj2W35j9A/n4XXoLev3foadc
         xfunfl9JCx8293pZewhdnFbvHMCn1twnp2/g0UMBC859kTWDIWmqDHMjUpm/XKbrIt3Y
         7FjMWN02XwI2kKx4FtCtiBYbSFT5nEuDyZD0A=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=gpHs44ZTKzPhp7RYQZGYk0pjcXockQEuKiwY9V0t3W1X0rkm7Nha1JbnYW/igxQcVz
         mo1Sh1n498nod0c64RrJAK9Hm8BjCWVzjLjEskQehJalXgq6dTdkIY9x9itkbQhkzz/R
         APGnHUsFcfVwILcLJ9WxRg691QrUjQnsRB1f0=
Received: by 10.42.76.69 with SMTP id d5mr6386883ick.236.1303165046096;
        Mon, 18 Apr 2011 15:17:26 -0700 (PDT)
Received: from elie (adsl-69-209-64-141.dsl.chcgil.ameritech.net [69.209.64.141])
        by mx.google.com with ESMTPS id f28sm2998334ibh.16.2011.04.18.15.17.24
        (version=SSLv3 cipher=OTHER);
        Mon, 18 Apr 2011 15:17:24 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <7v4o5v8dlp.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171766>

Junio C Hamano wrote:

>     	if (write(...))
>     		; /* yes, yes, there was an error. */
>
> No, a non-zero return is not an error from the write(2) system call.
> I cannot believe both of us didn't spot it.  What were we smoking?

Yagh.

	if (write(child_err, "fatal: ", 7) ||
	    write(child_err, msg, len) ||
	    write(child_err, "\n", 1))
		; /* yes, gcc -D_FORTIFY_SOURCE, we know there was an error. */

There are two unusual conditions in which this could fail:

 - it doesn't write anything at all, in which case the return value
   is -1.
 - a partial write, for example if writing to an almost-full pipe.

I suppose in a calmer time, a better fix will look like

	if (write_in_full(child_err, "fatal: ", 7) != 7 ||
	    write_in_full(child_err, msg, len) != len ||
	    write_in_full(child_err, "\n", 1) != 1)
		/* yes, yes, ...

and gcc will have told us something potentially useful.

Thanks for catching it.
