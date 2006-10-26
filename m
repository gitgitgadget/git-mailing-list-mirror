X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,
	DATE_IN_PAST_06_12,HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
From: Eran Tromer <git2eran@tromer.org>
Subject: Re: fetching packs and storing them as packs
Date: Thu, 26 Oct 2006 16:45:32 +0200
Message-ID: <4540CA0C.6030300@tromer.org>
References: <Pine.LNX.4.64.0610252333540.12418@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Thu, 26 Oct 2006 22:10:59 +0000 (UTC)
Cc: Junio C Hamano <junkio@cox.net>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Injected-Via-Gmane: http://gmane.org/
Original-Lines: 28
Original-X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: line108-16.adsl.actcom.co.il
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.7) Gecko/20060913 Fedora/1.5.0.7-1.fc5 Thunderbird/1.5.0.7 Mnenhy/0.7.4.0
In-Reply-To: <Pine.LNX.4.64.0610252333540.12418@xanadu.home>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30265>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GdDQr-0000ci-6S for gcvg-git@gmane.org; Fri, 27 Oct
 2006 00:10:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1945961AbWJZWKe (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 26 Oct 2006
 18:10:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1945962AbWJZWKd
 (ORCPT <rfc822;git-outgoing>); Thu, 26 Oct 2006 18:10:33 -0400
Received: from main.gmane.org ([80.91.229.2]:40398 "EHLO ciao.gmane.org") by
 vger.kernel.org with ESMTP id S1945961AbWJZWKd (ORCPT
 <rfc822;git@vger.kernel.org>); Thu, 26 Oct 2006 18:10:33 -0400
Received: from root by ciao.gmane.org with local (Exim 4.43) id
 1GdDQL-0000T7-SN for git@vger.kernel.org; Fri, 27 Oct 2006 00:10:06 +0200
Received: from line108-16.adsl.actcom.co.il ([192.117.108.16]) by
 main.gmane.org with esmtp (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00 for
 <git@vger.kernel.org>; Fri, 27 Oct 2006 00:10:05 +0200
Received: from git2eran by line108-16.adsl.actcom.co.il with local (Gmexim
 0.1 (Debian)) id 1AlnuQ-0007hv-00 for <git@vger.kernel.org>; Fri, 27 Oct 2006
 00:10:05 +0200
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

On 2006-10-26 05:44, Nicolas Pitre wrote:
> diff --git a/receive-pack.c b/receive-pack.c
> index 1fcf3a9..7f6dc49 100644
> --- a/receive-pack.c
> +++ b/receive-pack.c
> @@ -7,7 +7,7 @@
>  
>  static const char receive_pack_usage[] = "git-receive-pack <git-dir>";
>  
> -static const char *unpacker[] = { "unpack-objects", NULL };
> +static const char *unpacker[] = { "index-pack", "-v", "--stdin", "--fix-thin", NULL };
>  
>  static int report_status;

This creates a race condition w.r.t. "git repack -a -d", similar to the
existing race condition between "git fetch --keep" and
"git repack -a -d". There's a point in time where the new pack is stored
but not yet referenced, and if "git repack -a -d" runs at that point it
will eradicate the pack. When the heads are finally updated, you get a
corrupted repository.

(That's for the shell implementation of git-repack, at least. I assume
the new builtin preserves the old semantics.)

Since people run the supposedly safe "git repack -a -d" on regular
basis, this is going to bite.

  Eran
