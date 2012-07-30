From: Florian Achleitner <florian.achleitner.2.6.31@gmail.com>
Subject: Re: [RFC 1/4 v2] Implement a basic remote helper for svn in C.
Date: Mon, 30 Jul 2012 10:12:29 +0200
Message-ID: <2324454.rWiRnly2JJ@flomedio>
References: <1338830455-3091-1-git-send-email-florian.achleitner.2.6.31@gmail.com> <20120726090842.GA4999@burratino> <7vlii68m7k.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Florian Achleitner <florian.achleitner.2.6.31@gmail.com>,
	git@vger.kernel.org, David Michael Barr <davidbarr@google.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Jeff King <peff@peff.net>, Johannes Sixt <j.sixt@viscovery.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jul 30 10:12:48 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Svl5p-0001ee-6z
	for gcvg-git-2@plane.gmane.org; Mon, 30 Jul 2012 10:12:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754103Ab2G3IMl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Jul 2012 04:12:41 -0400
Received: from mail-bk0-f46.google.com ([209.85.214.46]:34827 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754079Ab2G3IMk (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Jul 2012 04:12:40 -0400
Received: by mail-bk0-f46.google.com with SMTP id j10so2693719bkw.19
        for <git@vger.kernel.org>; Mon, 30 Jul 2012 01:12:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:user-agent:in-reply-to
         :references:mime-version:content-transfer-encoding:content-type;
        bh=P2usB5VnFZvEauOjAp13qtivlrqQVMnzeVDlassqD/k=;
        b=M8/kQKGpK3DFmkN43Z9F3hRITrr4NxtzZmDqY4HPlALDJlcTgTwz4DxYsxXaPUc491
         W8U9lWk9Od17RQPMe4Urxm9/YrJxFfyS4QNjJ59597xYHDVKPqDRpZJMurOQ5g3fsrGu
         DkwtYg5EeZe5Ed4yC8p+g380Tx2+XOHDFVMKXupYeiF1Y/Kcqh1/vDYl2YwPapfFEYAd
         GrIDDYsqUSshsiQByNfr5Zv5SrkpFxmz1hmziMjvARvZ3T2lF8gjlUIr/PbzbpL2ld4+
         rsmWf4ukZT9qrE1pRsMReTQ6yYdmefgN+M00CzNCXGJV+Z1cX36tGmG+rdlY9BmdRpsa
         WNpQ==
Received: by 10.205.127.77 with SMTP id gz13mr3688265bkc.17.1343635959504;
        Mon, 30 Jul 2012 01:12:39 -0700 (PDT)
Received: from flomedio.localnet (cm56-227-93.liwest.at. [86.56.227.93])
        by mx.google.com with ESMTPS id hg13sm3166607bkc.7.2012.07.30.01.12.37
        (version=SSLv3 cipher=OTHER);
        Mon, 30 Jul 2012 01:12:38 -0700 (PDT)
User-Agent: KMail/4.8.4 (Linux/3.2.0-27-generic; KDE/4.8.4; x86_64; ; )
In-Reply-To: <7vlii68m7k.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202527>

On Thursday 26 July 2012 10:29:51 Junio C Hamano wrote:
> Of course, if the dispatch loop has to be rewritten so that a
> central dispatcher decides what to call, individual input handlers
> do not need to say NOT_HANDLED nor TERMINATE, as the central
> dispatcher should keep track of the overall state of the system, and
> the usual "0 on success, negative on error" may be sufficient.
> 
> One thing I wondered was how an input "capability" (or "list")
> should be handled after "import" was issued (hence batch_active
> becomes true).  The dispatcher loop in the patch based on
> NOT_HANDLED convention will happily call cmd_capabilities(), which
> does not have any notion of the batch_active state (because it is a
> function scope static inside cmd_import()), and will say "Ah, that
> is mine, and let me do my thing."  If we want to diagnose such an
> input stream as an error, the dispatch loop needs to become aware of
> the overall state of the system _anyway_, so that may be an argument
> against the NOT_HANDLED based dispatch system the patch series uses.

That's a good point. The current implementation allows other commands to 
appear during import batches. This shouldn't be possible according to the 
protocol, I think. But it doesn't do harm. Solving it will require a global 
state and go towards a global displatcher.
