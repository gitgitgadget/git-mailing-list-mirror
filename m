From: Jonathan Nieder <jrnieder@gmail.com>
Subject: fast-import --report-fd (Re: fast-import tweaks for remote helpers)
Date: Wed, 5 Jan 2011 15:20:18 -0600
Message-ID: <20110105212018.GA22975@burratino>
References: <20101107112129.GA30042@burratino>
 <20101121063149.GA15449@burratino>
 <20101205113717.GH4332@burratino>
 <4CFFCDCD.9060602@dbservice.com>
 <20101212061437.GA17185@burratino>
 <4D049BA5.1060509@vilain.net>
 <20101212171633.GB18847@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Tomas Carnecky <tom@dbservice.com>, git@vger.kernel.org,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	David Barr <david.barr@cordelta.com>,
	Stephen Bash <bash@genarts.com>
To: Sam Vilain <sam@vilain.net>
X-From: git-owner@vger.kernel.org Wed Jan 05 22:21:15 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PaanC-0002Tz-GP
	for gcvg-git-2@lo.gmane.org; Wed, 05 Jan 2011 22:21:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753063Ab1AEVVH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Jan 2011 16:21:07 -0500
Received: from mail-qw0-f46.google.com ([209.85.216.46]:44627 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752937Ab1AEVVG (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Jan 2011 16:21:06 -0500
Received: by qwa26 with SMTP id 26so16106367qwa.19
        for <git@vger.kernel.org>; Wed, 05 Jan 2011 13:21:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=YljfEP9FWaDMyOgnRdabMDjkqBQHV2OJ3vwC1tB1AsU=;
        b=UB2lGuLH1J2rZUcSxSsM3QTDiS50RvX8oP/gTEklnzYw4LHny+bCTfGAmy3qN8wV9a
         Puou4tsvdpw96lNlypUVz/R/tF8F+8reJ1m6xPrL8csy+8w5wYbrV7BWXtLqdNIgELB1
         o1NoliIZ/WKfi16rSG1qTU+ODpHRLB0V+H9vs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=hz9ArESDZCSqb1yjoPB5cv1PhaCJrod1ESC29N/GOpxdo7mbJwyB3HMpq3/YBTRZlU
         WQolKTM9spDk9E+Dex/2NUPvWoSI/Uj9yoYN9q4oNHrSjJoYKaxRfUVkwn+CXXjd88Rz
         dpQIelyRhWt+OzUao/lKiPKpEElv3KVDuEo0I=
Received: by 10.224.2.143 with SMTP id 15mr22148204qaj.179.1294262464863;
        Wed, 05 Jan 2011 13:21:04 -0800 (PST)
Received: from burratino (adsl-69-209-72-219.dsl.chcgil.sbcglobal.net [69.209.72.219])
        by mx.google.com with ESMTPS id q12sm13842023qcu.6.2011.01.05.13.21.01
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 05 Jan 2011 13:21:02 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20101212171633.GB18847@burratino>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164598>

Jonathan Nieder wrote:
> Sam Vilain wrote:

>> What happened to --report-fd ?
>
> The patch still works.  The main problem with report-fd is that it
> introduced a synchronization point after every commit: the frontend
> has to read the commit id before fast-import will continue.

Correction: more precisely, that was and is the main problem with
svn-fe's use of bidirectional communication.  An application like
Tom's remote helper would probably not suffer so much from it, since
commit ids are just queued up as long as the pipe doesn't fill before
the frontend reads any.  It is transactions like

	FI>	r5 = 734987a9878b97c879c798a897c897ac
	FE>	cat 734987a9878b97c879c798a897c897ac
	FI>	734987a9878b97c879c798a897c897ac commit 448
		tree 8d5bcf0f24bdfea1fdab8d39ba3c8ba91a52547c
		parent 84279592b8b5816d00300ba5d4412adf05cc80d6
		parent 3ca7353cab4ed6c7efac0c8d7477c87112fc7350
		author Junio C Hamano <gitster@pobox.com> 1294187068 -0800
		committer Junio C Hamano <gitster@pobox.com> 1294187068 -0800

		Merge branch 'sr/gitweb-hilite-more' into pu

		* sr/gitweb-hilite-more:
		  gitweb: remove unnecessary test when closing file descriptor
		  gitweb: add extensions to highlight feature map

	FE>	cat 8d5bcf0f24bdfea1fdab8d39ba3c8ba91a52547c "main.c"

(i.e., round-trips) that were and are creating overhead in svn-fe.
See [1] if curious about details.

So please don't be dissuaded by the nonsense I sent. :)

[1] http://colabti.org/irclogger/irclogger_log_search/git-devel?search=overhead&action=search
