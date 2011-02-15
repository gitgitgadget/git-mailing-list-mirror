From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH 1/2] Introduce CHERRY_HEAD
Date: Tue, 15 Feb 2011 14:59:18 -0800
Message-ID: <7v4o84nbuh.fsf@alter.siamese.dyndns.org>
References: <1297805034-3512-1-git-send-email-jaysoffian@gmail.com>
 <1297805034-3512-2-git-send-email-jaysoffian@gmail.com>
 <20110215221832.GA826@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jay Soffian <jaysoffian@gmail.com>, git@vger.kernel.org,
	Christian Couder <chriscool@tuxfamily.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 15 23:59:38 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PpTrt-0002MF-Pv
	for gcvg-git-2@lo.gmane.org; Tue, 15 Feb 2011 23:59:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753883Ab1BOW7e (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Feb 2011 17:59:34 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:35038 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752027Ab1BOW7c (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Feb 2011 17:59:32 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id E3D464E52;
	Tue, 15 Feb 2011 18:00:35 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=qEteO80n571H8j4sqvPFMgt3d34=; b=PlZgrN
	qm5hrEY945auHK0YfBYuS0rUueAZgleJIT++cN3d8g2oHKWaIzAKrqupkXLwX2I8
	1xGo06+RNQVfow/r0MHG7jAyrohzRGHvkoqZT0Zs6Dq/bZYDTA/BdMYD39d2zyry
	ghlI8FBdTfgw3Rk+y5q8wqW9ngyucnIfabWck=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Qpn21m+jAYEC8EZQIHwu9Z9GY+7yzGB/
	w8+yKOFe7cwS43FN8yPj7kYWY2/eIAkAYesoLZ3zRvPb3sOmazvIriIETy6u8nMd
	hAQv+hTJlhvdy7Z4ruVUUKeeYrnNE0zN9i2ql8n6OH2OdENhZAFnjpcmJ4efWTtt
	VaE8Rv2sCcg=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id A00BD4E51;
	Tue, 15 Feb 2011 18:00:31 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 3F3D04E50; Tue, 15 Feb 2011
 18:00:25 -0500 (EST)
In-Reply-To: <20110215221832.GA826@elie> (Jonathan Nieder's message of "Tue\,
 15 Feb 2011 16\:18\:32 -0600")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 638BFA9E-3957-11E0-86E4-AF401E47CF6F-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166892>

Jonathan Nieder <jrnieder@gmail.com> writes:

> I wonder if cherry-pick shouldn't also write MERGE_MSG or similar so
> that gets taken care of automatically?  That would also allow options
> like -x and -m to work better.

Hm, that probably is a good idea.

> diff --git a/Documentation/git-cherry-pick.txt b/Documentation/git-cherry-pick.txt
> index 749d68a..e8db99b 100644
> --- a/Documentation/git-cherry-pick.txt
> +++ b/Documentation/git-cherry-pick.txt
> @@ -16,6 +16,25 @@ Given one or more existing commits, apply the change each one
>  introduces, recording a new commit for each.  This requires your
>  working tree to be clean (no modifications from the HEAD commit).
>  
> +When it is not obvious how to apply a change, the following
> +happens:
> +
> +1. The current branch and `HEAD` pointer stay at the last commit
> +   successfully made.
> +2. The `CHERRY_HEAD` ref is set to point at the commit that
> +   introduced the change that is difficult to apply.
> +3. Paths in which the change applied cleanly are updated both
> +   in the index file and in your working tree.
> +4. For conflicting paths, the index file records up to three
> +   versions, as described in the "TRUE MERGE" section of
> +   linkgit:git-merge[1].  The working tree files will include
> +   a description of the conflict bracketed by the usual
> +   conflict markers `<<<<<<<` and `>>>>>>>`.

What happened to the `=======`?  I thought you were copying and pasting
from the said section.
