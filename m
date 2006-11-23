X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: sizeof(struct ...)
Date: Thu, 23 Nov 2006 12:47:51 -0800
Message-ID: <7vpsbdkhzc.fsf@assigned-by-dhcp.cox.net>
References: <20061123101609.1711.qmail@8b73034525b1a6.315fe32.mid.smarden.org>
	<45659781.5050005@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
NNTP-Posting-Date: Thu, 23 Nov 2006 20:48:23 +0000 (UTC)
Cc: git@vger.kernel.org, Gerrit Pape <pape@smarden.org>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <45659781.5050005@lsrfire.ath.cx> (=?iso-8859-1?Q?Ren=E9?=
 Scharfe's message of
	"Thu, 23 Nov 2006 13:43:45 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32157>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GnLUT-0001dE-MP for gcvg-git@gmane.org; Thu, 23 Nov
 2006 21:48:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S933936AbWKWUsK convert rfc822-to-quoted-printable (ORCPT
 <rfc822;gcvg-git@m.gmane.org>); Thu, 23 Nov 2006 15:48:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933934AbWKWUsK
 (ORCPT <rfc822;git-outgoing>); Thu, 23 Nov 2006 15:48:10 -0500
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:53919 "EHLO
 fed1rmmtao01.cox.net") by vger.kernel.org with ESMTP id S933938AbWKWUsG
 convert rfc822-to-8bit (ORCPT <rfc822;git@vger.kernel.org>); Thu, 23 Nov 2006
 15:48:06 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72]) by fed1rmmtao01.cox.net
 (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP id
 <20061123204753.QYHH9173.fed1rmmtao01.cox.net@fed1rmimpo02.cox.net>; Thu, 23
 Nov 2006 15:47:53 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo02.cox.net with bizsmtp id qLo01V00q1kojtg0000000; Thu, 23 Nov 2006
 15:48:01 -0500
To: =?iso-8859-1?Q?Ren=E9?= Scharfe <rene.scharfe@lsrfire.ath.cx>
Sender: git-owner@vger.kernel.org

Ren=E9 Scharfe <rene.scharfe@lsrfire.ath.cx> writes:

> Gerrit Pape schrieb:
>...
>> It's because sizeof(struct zip_local_header) is 32, zip_dir_header 4=
8,
>> and zip_dir_trailer 24, breaking the zip files.  Compiling with
>> -fpack-struct seemed to break other things, so I for now I ended up =
with
>> this (not so nice) workaround.
>
> Hm, yes, this use sizeof() is not strictly correct.  But I'd very muc=
h
> like to keep being lazy and let the compiler to do the summing.  How
> about this patch instead?  Does it work for you, Gerrit?
>...
> @@ -35,6 +35,7 @@ struct zip_local_header {
> 	unsigned char size[4];
> 	unsigned char filename_length[2];
> 	unsigned char extra_length[2];
> +	unsigned char _end[0];
> };

While I think relying on the compiler to add no pad in the
middle of the structure that has only unsigned char array
members, making the compiler to sum the member length using
offsetof() is a reasonable approach to avoid hardcoding the size
of on-disk structure representation, zero-length member is not
portable.

We need to deal with tail padding in any case, and this _end[N]
is essentially a manual tail padding when N > 0, so I think that
the code should work even if you change these to _end[1], and
that would be a reasonably clean solution to this problem.


