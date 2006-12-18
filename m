X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] git-fetch: Avoid reading packed refs over and over again
Date: Mon, 18 Dec 2006 13:33:28 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0612181329480.3635@wbgn013.biozentrum.uni-wuerzburg.de>
References: <Pine.LNX.4.63.0612172048331.3635@wbgn013.biozentrum.uni-wuerzburg.de>
 <7vslfe3r4d.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
NNTP-Posting-Date: Tue, 19 Dec 2006 00:08:45 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <7vslfe3r4d.fsf@assigned-by-dhcp.cox.net>
X-Y-GMX-Trusted: 0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34771>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GwHgY-0007CV-Iv for gcvg-git@gmane.org; Mon, 18 Dec
 2006 13:33:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1753928AbWLRMdd (ORCPT <rfc822;gcvg-git@m.gmane.org>); Mon, 18 Dec 2006
 07:33:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753929AbWLRMdd
 (ORCPT <rfc822;git-outgoing>); Mon, 18 Dec 2006 07:33:33 -0500
Received: from mail.gmx.net ([213.165.64.20]:60782 "HELO mail.gmx.net"
 rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP id S1753928AbWLRMdc
 (ORCPT <rfc822;git@vger.kernel.org>); Mon, 18 Dec 2006 07:33:32 -0500
Received: (qmail invoked by alias); 18 Dec 2006 12:33:29 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2)
 [132.187.25.13] by mail.gmx.net (mp044) with SMTP; 18 Dec 2006 13:33:29 +0100
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org

Hi,

On Sun, 17 Dec 2006, Junio C Hamano wrote:

> How about this as a replacement?

Makes sense, except for:

> --- a/builtin-show-ref.c
> +++ b/builtin-show-ref.c
> @@ -2,8 +2,9 @@
>  #include "refs.h"
>  #include "object.h"
>  #include "tag.h"
> +#include "path-list.h"
>  
> -static const char show_ref_usage[] = "git show-ref [-q|--quiet] [--verify] [-h|--head] [-d|--dereference] [-s|--hash[=<length>]] [--abbrev[=<length>]] [--tags] [--heads] [--] [pattern*]";
> +static const char show_ref_usage[] = "git show-ref [-q|--quiet] [--verify] [-h|--head] [-d|--dereference] [-s|--hash[=<length>]] [--abbrev[=<length>]] [--tags] [--heads] [--] [pattern*] | --filter-invalid < ref-list";

Here, you want to either not mention it at all, or add 
"--exclude-existing[=<pattern>]" instead of "--filter-invalid".

> +		if (!strcmp(buf + len - 3, "^{}")) {

Here you have to check first, if len > 3. Strictly speaking, there should 
not be any line coming in which is shorter than 42 bytes. But I was 
recentely bitten by such an assuption...

Overall, I like it. I even have the impression that this could actually 
open a way to build in fetch instead of relying on a POSIX conformant and 
fast shell for such a central part of git.

Ciao,
Dscho
