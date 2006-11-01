X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Problem with git-push
Date: Wed, 1 Nov 2006 12:12:43 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0611011205340.1670@wbgn013.biozentrum.uni-wuerzburg.de>
References: <1162306098.41547.4.camel@mayday.esat.net>
 <7v64e0qclo.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
NNTP-Posting-Date: Wed, 1 Nov 2006 11:13:35 +0000 (UTC)
Cc: Florent Thoumie <flz@xbsd.org>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <7v64e0qclo.fsf@assigned-by-dhcp.cox.net>
X-Y-GMX-Trusted: 0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30631>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GfE2D-0003FB-S7 for gcvg-git@gmane.org; Wed, 01 Nov
 2006 12:13:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1946773AbWKALMt (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 1 Nov 2006
 06:12:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946781AbWKALMs
 (ORCPT <rfc822;git-outgoing>); Wed, 1 Nov 2006 06:12:48 -0500
Received: from mail.gmx.de ([213.165.64.20]:63902 "HELO mail.gmx.net") by
 vger.kernel.org with SMTP id S1946773AbWKALMs (ORCPT
 <rfc822;git@vger.kernel.org>); Wed, 1 Nov 2006 06:12:48 -0500
Received: (qmail invoked by alias); 01 Nov 2006 11:12:46 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2)
 [132.187.25.13] by mail.gmx.net (mp031) with SMTP; 01 Nov 2006 12:12:46 +0100
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org

Hi,

On Tue, 31 Oct 2006, Junio C Hamano wrote:

> So the next thing to see is why adjust_shared_perm() is failing
> for you.
> 
> Oops.
> 
> I think this function is broken at the concept level.  This is
> to work around people's broken umask (when you are working with
> other people, your umask should not be stronger than 007) and
> tries to flip group writability bit on.
> 
> First of all, if the necessary bits are already on, it is not
> necessary to run chmod(),

right

> but more importantly, if the directory in question was created by 
> somebody else, I do not think this chmod() would succeed even if you are 
> in the same group as the owner (i.e. previous creator) of the directory.

But if somebody else created it, it should already have the correct 
permissions in the first place (unless the user played around with them, 
which is not a pilot error, but a willfull pointing of the barrel in the 
general direction of your knee).

> [jc: I am CC'ing Johannes to blame him on commit 457f06d6;
> git-pickaxe is turning out to be quite handy ;-)

I am hating the tool already.

>  	if (dir) {
>  		*dir = 0;
>  		mkdir(filename, 0777);
> -		if (adjust_shared_perm(filename))
> +		if (adjust_shared_perm(filename)) {
> +			*dir = '/';
>  			return -2;
> +		}

How about this instead:

-		mkdir(filename, 0777);
-		if (adjust_shared_perm(filename))
+		if (!mkdir(filename, 0777) && adjust_shared_perm(filename)) {
+			*dir = '/';
 			return -2;
+		}

Ciao,
Dscho
