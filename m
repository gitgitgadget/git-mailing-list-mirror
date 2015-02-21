From: David Turner <dturner@twopensource.com>
Subject: Re: Git Scaling: What factors most affect Git performance for a
 large repo?
Date: Fri, 20 Feb 2015 19:41:59 -0500
Organization: Twitter
Message-ID: <1424479319.31528.18.camel@leckie>
References: <20150220065801.7CDC7140BE4@smtp.codeaurora.org>
	 <1424456952.31528.6.camel@leckie> <3770789.lx2BnZ41U2@mfick1-lnx>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>,
	Stephen Morton <stephen.c.morton@gmail.com>,
	Duy Nguyen <pclouds@gmail.com>
To: Martin Fick <mfick@codeaurora.org>
X-From: git-owner@vger.kernel.org Sat Feb 21 01:42:12 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YOy93-0003xM-OU
	for gcvg-git-2@plane.gmane.org; Sat, 21 Feb 2015 01:42:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755376AbbBUAmE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Feb 2015 19:42:04 -0500
Received: from mail-qc0-f178.google.com ([209.85.216.178]:44305 "EHLO
	mail-qc0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755324AbbBUAmD (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Feb 2015 19:42:03 -0500
Received: by qcvs11 with SMTP id s11so3552808qcv.11
        for <git@vger.kernel.org>; Fri, 20 Feb 2015 16:42:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:content-type:mime-version
         :content-transfer-encoding;
        bh=0EvpL6zXInHopTDNM5QGPIqelqIPLV0+xlYJXqACOIQ=;
        b=N8J4f/aUiHOtyn4XD5T8E94TXlG0P0wwOuR2g+0stQbENb/JzbkE/wmYFisY042yuq
         OfbDK6AVvWCArNAOB3kI0hgM+OYciYT1530WGGWE/gybvQd09SwMfHwWTVQS0ll05xvf
         meJH09H6P1ZnwsJKjrXQSiRmfAXVDMn01IyjjfJLtUyY8eJF7iU+fHljwHyI2IZlJWjr
         1PIg1rZ2g6V7q7momMSm29rBbkuAVZz0U1uO0he8RuOOHRT5adSHKrPY2z83Z/+vaj+C
         s71yJ2//y90pSUsnM8s659ftK212QW2UARGqDfFgY8UgnzIK5AEGUr+Uj7U31+cliCfI
         SHCg==
X-Gm-Message-State: ALoCoQn14AMgJo1SVlJk5mmMFxKcJz/w1wLF/dtZ+QFj4W89VAIdri0j3VTlxWpfI35b5TGmS6Az
X-Received: by 10.229.134.200 with SMTP id k8mr1009094qct.13.1424479322022;
        Fri, 20 Feb 2015 16:42:02 -0800 (PST)
Received: from [172.17.131.24] (ip-66-9-26-66.autorev.intellispace.net. [66.9.26.66])
        by mx.google.com with ESMTPSA id f46sm22964074qgd.3.2015.02.20.16.42.00
        (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128/128);
        Fri, 20 Feb 2015 16:42:01 -0800 (PST)
In-Reply-To: <3770789.lx2BnZ41U2@mfick1-lnx>
X-Mailer: Evolution 3.10.4-0ubuntu2 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264197>

On Fri, 2015-02-20 at 13:37 -0700, Martin Fick wrote:
> On Friday, February 20, 2015 01:29:12 PM David Turner wrote:
> >...
> > For a more general solution, perhaps a log of ref updates
> > could be used. Every time a ref is updated on the server,
> > that ref would be written into an append-only log.  Every
> > time a client pulls, their pull data includes an index
> > into that log.  Then on push, the client could say, "I
> > have refs as-of $index", and the server could read the
> > log (or do something more-optimized) and send only refs
> > updated since that index.
> 
> Interesting idea, I like it.
> 
> How would you make this reliable?  It relies on updates 
> being reliably recorded which would mean that you would have 
> to ensure that any tool which touches the repo follows this 
> convention.  That is unfortunately a tough thing to enforce 
> for most people.

I think it only truly relies on the server reliably updating its state
on ref updates. Which of course the server will do because why would you
let arbitrary processes write to your central git repo?  (That is, most
people use git in a roughly-centralized way, and if you turn on this
config option, you promise to only do ref updates that write to the
log).

If the client fails to update its state (on a fetch), it will send
larger-than-necessary packs but not otherwise fail.  And this situation
is sometimes be detectable on the client side -- if
mtime(.git/refs/remotes/$remote ) > mtime
(.git/server-ref-log-index/$remote), then we know our
server-ref-log-index is out-of-date.
