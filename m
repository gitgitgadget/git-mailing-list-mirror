From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Using clean/smudge filters with difftool
Date: Thu, 18 Jun 2015 13:00:36 -0700
Message-ID: <xmqqsi9oeqhn.fsf@gitster.dls.corp.google.com>
References: <CAGA3++LiX9NyK94RPiuiG83X8FSRN4EkaxMchir51hGSQY90Tw@mail.gmail.com>
	<5582BA1F.1030409@drmicha.warpmail.net>
	<CAGA3++LrVSs3rMkg=S2Og48pz1yEBxwpcRsPt7sNLENRh1ooAg@mail.gmail.com>
	<20150618132622.GJ18226@serenity.lan>
	<CAGA3+++_mx=O=Un0pip8Q41X5PZBLmES=Hd=U=aSowryx5r=8w@mail.gmail.com>
	<20150618141116.GK18226@serenity.lan>
	<CAGA3+++ibw=8Q1LtM6yJrZ7Q4eVs_MEHmPAzctSVSREXMmBiMQ@mail.gmail.com>
	<20150618142852.GL18226@serenity.lan>
	<CAGA3+++LqZ8Qv6tpuoqQwi37kO5LLODwcbFQtvneorjiV4KARw@mail.gmail.com>
	<20150618160133.GO18226@serenity.lan>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Florian Aspart <florian.aspart@gmail.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	git@vger.kernel.org
To: John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Thu Jun 18 22:00:48 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z5fzS-00040R-4v
	for gcvg-git-2@plane.gmane.org; Thu, 18 Jun 2015 22:00:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756765AbbFRUAm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Jun 2015 16:00:42 -0400
Received: from mail-ig0-f181.google.com ([209.85.213.181]:37598 "EHLO
	mail-ig0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755521AbbFRUAl (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Jun 2015 16:00:41 -0400
Received: by igbsb11 with SMTP id sb11so3263141igb.0
        for <git@vger.kernel.org>; Thu, 18 Jun 2015 13:00:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=5SKzhHqbseWzYvffKA8JHinKgPRjdvN6xVyzXvORo0E=;
        b=OjEWWo4gzf8IuyPir32A+0OM8WuxSipbijWYstRPIG68cBtl8pHAlsM7N/nK+MNXd8
         SYUo1rw6U3EyvdhKYufmuCeqdPi6ScCYSiqPdj/sx3zJf9oz4aV26mDclQ/iQ2e0g890
         Vba1VGKlP6JBiyE//02vGPkW9nu5JhTNxbi96nnGUoPsLW0sd2gcOmHSD13WkytgQgUs
         pg9DkArDj8C/Gb9vKKwAusTh7sjQwGojGiGnWQQej8/yQ0Q9m4O8WbRbMu+x8JjiZGmE
         5riNw5zmmZ5RergMIqlDUHpdoeGx6mMpkfzlLaWk0bUzBFrCH72vFOyCw19ZpN4vBp+K
         d6Nw==
X-Received: by 10.50.78.232 with SMTP id e8mr34348939igx.32.1434657638145;
        Thu, 18 Jun 2015 13:00:38 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:e04a:861:67b3:9e25])
        by mx.google.com with ESMTPSA id i185sm5584669ioi.24.2015.06.18.13.00.37
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 18 Jun 2015 13:00:37 -0700 (PDT)
In-Reply-To: <20150618160133.GO18226@serenity.lan> (John Keeping's message of
	"Thu, 18 Jun 2015 17:01:33 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272039>

John Keeping <john@keeping.me.uk> writes:

> I think this is a difference between git-diff's internal and external
> diff modes which is working correctly, although possibly not desirably
> in this case.  The internal diff always uses clean files (so it runs the
> working tree file through the "clean" filter before applying the diff
> algorithm) but the external diff uses the working tree file so it
> applies the "smudge" filter to any blobs that it needs to checkout.
>
> Commit 4e218f5 (Smudge the files fed to external diff and textconv,
> 2009-03-21) was the source of this behaviour.

The fundamental design to use smudged version when interacting with
external programs actually predates that particular commit, I think.

The caller of the function that was updated by that commit, i.e.
prepare_temp_file(), reuses what is checked out to the working tree
when we can (i.e. it hasn't been modified from what we think is
checked out) and when it is beneficial to do so (i.e. on a system
with FAST_WORKING_DIRECTORY defined), which means the temporary file
given by the prepare_temp_file() that is used by the external tools
(both --ext-diff program and textconv filter) are designed to be fed
and work on the smudged version of the file.  4e218f5 did not change
that fundamental design; it just made things more consistent between
the case where we do create a new temporary file out of blob and we
allow an unmodified checked out file to be reused.
