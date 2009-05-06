From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: Re: [PATCH 4/4] t4200: avoid passing a non-newline terminated file
 to sed
Date: Wed, 06 May 2009 16:12:25 -0500
Message-ID: <RsLiW_EIDQ01u5uSMUrIIMzSbMhkfwGJBEGppONH79Im4WyT76bS5A@cipher.nrlssc.navy.mil>
References: <-ElxRhvpfY_jx1Ps8nJ42rHdrKbR03T1y96WpGK19gM@cipher.nrlssc.navy.mil> <IHOAO7NDkb8K9nkprnkd2cQW6duDZ3aYmQzpqboBi5HibQoO83nGG2Z4562gIb22HVW3ho6Z250@cipher.nrlssc.navy.mil> <IHOAO7NDkb8K9nkprnkd2TGjPUHc5N7wdnoXRYKelDZEem1S0tynQeYlVheR46_5TDmYxS1O9i4@cipher.nrlssc.navy.mil> <IHOAO7NDkb8K9nkprnkd2QibZp-GnWBSpcJ8fxO9NTUsmXbuv4_2x5S6YNLzUogav4gLkrx9ClI@cipher.nrlssc.navy.mil> <IHOAO7NDkb8K9nkprnkd2ZsdySdVG_ssYL84wqJwNHZYBqMWRKBIa_Ni6jJRHumlZvrQcXOEMhQ@cipher.nrlssc.navy.mil> <IHOAO7NDkb8K9nkprnkd2ep5vFgQr-bAuDGJW-OdtSbS6WmpSHl041GRSXpP3OcDP4_PsYKsQDU@cipher.nrlssc.navy.mil> <7vhbzyukyi.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: pclouds@gmail.com, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed May 06 23:12:46 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M1oPw-0005oD-Jo
	for gcvg-git-2@gmane.org; Wed, 06 May 2009 23:12:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755917AbZEFVMa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 May 2009 17:12:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755357AbZEFVM3
	(ORCPT <rfc822;git-outgoing>); Wed, 6 May 2009 17:12:29 -0400
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:58501 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753121AbZEFVM3 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 May 2009 17:12:29 -0400
Received: by mail.nrlssc.navy.mil id n46LCPuV004342; Wed, 6 May 2009 16:12:25 -0500
In-Reply-To: <7vhbzyukyi.fsf@alter.siamese.dyndns.org>
X-OriginalArrivalTime: 06 May 2009 21:12:25.0611 (UTC) FILETIME=[5AD1BDB0:01C9CE8F]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118391>

Junio C Hamano wrote:
> Brandon Casey <casey@nrlssc.navy.mil> writes:
> 
>> Some versions of sed exit non-zero if the file they are supplied is not
>> newline terminated.  Solaris's /usr/xpg4/bin/sed is one such sed.  So
>> rework this test to avoid doing so.
> 
> I think up to your 3/4 is reasonable, but this is not enough for POSIX
> conformance (it is Ok if it is just aiming to fix "Solaris quirk").  POSIX
> sed is only required to work on text files, but .git/MERGE_RR is not a
> text file (it is a sequence of NUL terminated records).
> 
> I think something like this may work better.  Can somebody test?
> 
>> -	sha1=$(sed -e "s/	.*//" .git/MERGE_RR) &&
>> +	sha1=$({ cat .git/MERGE_RR; echo; } | sed -e "s/	.*//") &&
> 
> 	sha1=$(tr "\\000" "\\012" <./git/MERGE_RR | sed -e "s/	.*//") &&

I was about to reply that this fix works fine (actually, I was about to
reply over an hour ago but was interrupted).

But, while testing it I noticed that you had a typo in your version that
_did_not_ cause the test to fail.  You have an extra slash in the path
to '.git/MERGE_RR' which would have caused sha1 to be unset.

The 'sha1' variable that is set here on line 193 is used on the next line
to set 'rr', but 'rr' is never used again.  Unless I'm missing something,
it appears these two lines can be deleted.

-brandon
