From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 1/3] Fix sparse checkout not removing files from index
Date: Fri, 30 Jul 2010 14:50:22 -0500
Message-ID: <20100730195022.GB2448@burratino>
References: <1280135310-2347-1-git-send-email-pclouds@gmail.com>
 <20100730013534.GB2182@burratino>
 <AANLkTi=3pX=k=Pf5SnWt8s=hbvwAXcZdmcqP_+kgCyE5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jul 30 21:51:45 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OevcP-00064o-0b
	for gcvg-git-2@lo.gmane.org; Fri, 30 Jul 2010 21:51:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758994Ab0G3Tvi convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 30 Jul 2010 15:51:38 -0400
Received: from mail-qy0-f174.google.com ([209.85.216.174]:48784 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754192Ab0G3Tvg (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Jul 2010 15:51:36 -0400
Received: by qyk7 with SMTP id 7so4160755qyk.19
        for <git@vger.kernel.org>; Fri, 30 Jul 2010 12:51:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=DjI0gglbTCkxo7jefabUyoKtE6+AcTCWcJiLIWgEck4=;
        b=SlNhUGM79sJTCHSZDtbk8xWFzqGucLdIDRLLr5li2/G5ewGiRU/VsFyNyVpSNuMQki
         ab7VuqXrBV7lrY2JN3Jvvq+KXJtzaC93dBkSrIg8VqvcxXboG05BImHCTKVJpmUOizPV
         PedM38j4Woe/6K7q4Q7enNLNdCAsUvsA7FapU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=ljdg5SA4PDivFX+Kp3nsdZWii8TuOaFq+dinxz66XbQmk7O2aU3GjXQfvY3FKO8te9
         yaxH9eU9XiyBRSWpgMZpXRZjaIrASQYcMVtzrts/Lstz6KQStKbKC08rQ55RDZSY0OAg
         NHKsaAVrNQgTz/buiLytrXYzwsh/1rbPN2WX8=
Received: by 10.224.20.72 with SMTP id e8mr368334qab.7.1280519495382;
        Fri, 30 Jul 2010 12:51:35 -0700 (PDT)
Received: from burratino (dhcp-11-17.cs.uchicago.edu [128.135.11.176])
        by mx.google.com with ESMTPS id js14sm2981792qcb.42.2010.07.30.12.51.31
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 30 Jul 2010 12:51:32 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <AANLkTi=3pX=k=Pf5SnWt8s=hbvwAXcZdmcqP_+kgCyE5@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152263>

Nguyen Thai Ngoc Duy wrote:

> For unpack_trees() only, yes.

Ah, that is what I was missing.

So would the following be correct?

	Subject: unpack-trees: let read-tree -u remove index entries outside s=
parse area

	To avoid touching the worktree outside a sparse checkout,
	when the update flag is enabled unpack_trees() clears the
	CE_UPDATE and CE_REMOVE flags on entries that do not match the
	sparse pattern before actually committing any updates to the
	index file or worktree.

	The effect on the index was unintentional; sparse checkout was
	never meant to prevent index updates outside the area checked
	out.  And the result is very confusing: for example, after a
	failed merge, currently "git reset --hard" does not reset the
	state completely but an additional "git reset --mixed" will.

	So stop clearing the CE_REMOVE flag.  Instead, maintain a
	CE_WT_REMOVE flag to separately track whether a particular
	file removal should apply to the worktree in addition to the
	index or not.

	The CE_WT_REMOVE flag is used already to mark files that
	should be removed because of a narrowing checkout area.  That
	usage will still apply; do not clear the CE_WT_REMOVE flag
	in that case (detectable because the CE_REMOVE flag is not
	set).

	This bug masked some other bugs illustrated by the test
	suite, which will be addressed by later patches.

	Reported-by: Fr=E9d=E9ric Bri=E8re <fbriere@fbriere.net>
	Fixes: http://bugs.debian.org/583699

> It'd better be done in one place.

I think I understand better now, and now I agree.  (This patch is not
a change in the semantics of CE_REMOVE, but just some new unpack-trees
bookkeeping.)

> 2010/7/30 Jonathan Nieder <jrnieder@gmail.com>:

>> This is a little tricky: the CE_WT_REMOVE case (without CE_REMOVE)
>> represents a narrowing of the checkout and should be preserved,
>> while CE_WT_REMOVE|CE_REMOVE represents a removed index entry and
>> should be changed to just CE_REMOVE.
>
> Yeah. I did wonder if it's worth a comment to explain. I forget why I
> did not add that comment now.

What happens if an index entry is removed at the same time as the
checkout is narrowed?
