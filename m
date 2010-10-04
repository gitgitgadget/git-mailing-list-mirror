From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 7/7] commit-tree: free commit message before exiting
Date: Sun, 3 Oct 2010 23:18:34 -0500
Message-ID: <20101004041834.GD24884@burratino>
References: <wes62zknmki.fsf@kanis.fr>
 <7v1va760ip.fsf@alter.siamese.dyndns.org>
 <20100810032647.GA2386@burratino>
 <20101002082752.GA29638@burratino>
 <20101002084100.GH29638@burratino>
 <7vlj6edcic.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Sverre Rabbelier <srabbelier@gmail.com>,
	Andreas Ericsson <ae@op5.se>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Oct 04 06:21:58 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P2cYm-00067d-9D
	for gcvg-git-2@lo.gmane.org; Mon, 04 Oct 2010 06:21:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751352Ab0JDEVu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Oct 2010 00:21:50 -0400
Received: from mail-qy0-f181.google.com ([209.85.216.181]:57495 "EHLO
	mail-qy0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751258Ab0JDEVt (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Oct 2010 00:21:49 -0400
Received: by qyk10 with SMTP id 10so574208qyk.19
        for <git@vger.kernel.org>; Sun, 03 Oct 2010 21:21:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=FIRqbZLPB1XZ0yYrQn+tJkqOYd3SCxji67Mg1zYP/K0=;
        b=JQI2T9TfjqrhsqJwgIpJr46nOiq/EIN82WH5wK3Be4bUYvXEB+u/26jjDSwiWFyoDg
         hnj0AHUlo2zL7J4eRIAPFMSxQlzK8R1FuuWyVlWc8APTIjbJhmh01AWxvW+3Rm2cefCp
         NOR+czf2SPLQ3kr7GCZNkD4jHBYvnZb/GfTf8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=tpu4D1BC1//mamxyL2RkEc5L6hwCyYStGVWM0CTyjr+p4ZVFTBxE1x+CKak1sN2MrT
         ZoOZG7FsnJ94GTAWzPwIsf0iWfN18T+idOmfHvVioxOtKMZfxRN10OqAL4ArKmTSKY2I
         sV/n1bn0aiAyFYWWO5rdi8G6EYju88e1Slt44=
Received: by 10.229.224.149 with SMTP id io21mr6516887qcb.160.1286166108780;
        Sun, 03 Oct 2010 21:21:48 -0700 (PDT)
Received: from burratino (adsl-68-255-106-176.dsl.chcgil.ameritech.net [68.255.106.176])
        by mx.google.com with ESMTPS id t18sm4940204qco.32.2010.10.03.21.21.47
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 03 Oct 2010 21:21:47 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <7vlj6edcic.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157973>

Junio C Hamano wrote:

> Read what the code does (e.g. calling
> git-config, showing usage or dying on sick arguments, etc.).  So I have to
> say that the proposed commit log message advertises a benefit that it does
> not bring.

Yep, that was sloppy of me.  commit-tree has already been libified.

> By the way, is there an easy and concise way to tell valgrind to
> 
>  (1) treat allocations made in main() that are not freed as non-issues;
>      and
> 
>  (2) treat functions whose name begin with cmd_ as if they are all their
>      own main(), and apply the above special casing to them?

As long as the term "allocation" is defined clearly.  For example
(written in the modern syntax for conciseness):

	{
		xmalloc from main()
		Memcheck:Leak
		...
		fun:xmalloc
		fun:main
	}
	{
		xmalloc from built-in main
		Memcheck:Leak
		...
		fun:xmalloc
		fun:cmd_*
	}

Even better would be to exit() instead of returning from cmd_
functions.  Valgrind will not consider any memory that still has a
pointer to it at exit time as a leak.
