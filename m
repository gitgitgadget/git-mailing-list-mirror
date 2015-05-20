From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PUB]corrupt repos does not return error with `git fsck`
Date: Wed, 20 May 2015 13:39:36 -0700
Message-ID: <xmqqlhgjm19z.fsf@gitster.dls.corp.google.com>
References: <alpine.DEB.2.11.1505202142540.9343@orwell.homelinux.org>
	<vpq382rkvzf.fsf@anie.imag.fr>
	<d21002e0fa92b03c3d417c8996328563@www.dscho.org>
	<CAGZ79kZY68HFDipxLVas9Dg9+NfpOGmywpWfwFL31A0EpLmJFw@mail.gmail.com>
	<20150520182218.GD14561@peff.net> <20150520183115.GB7142@peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Stefan Beller <sbeller@google.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Faheem Mitha <faheem@faheem.info>,
	"git\@vger.kernel.org" <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed May 20 22:39:44 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YvAmF-0002VV-HS
	for gcvg-git-2@plane.gmane.org; Wed, 20 May 2015 22:39:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753826AbbETUjj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 May 2015 16:39:39 -0400
Received: from mail-ie0-f182.google.com ([209.85.223.182]:33209 "EHLO
	mail-ie0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753178AbbETUji (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 May 2015 16:39:38 -0400
Received: by iebgx4 with SMTP id gx4so48553423ieb.0
        for <git@vger.kernel.org>; Wed, 20 May 2015 13:39:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=4p9Y3JHQd/MHepPR/PWXjGf8bfWOE0bp/8gIcdoN/+Q=;
        b=I2B/dPlIZR68Cvzl04IfjpdY/qplP5RsA0itgfGhhZm2iR+r7bNC8peNx9gZhU/bF8
         4Glof/BfGCRp/QedeEj77YOOCbA4TE20MiDF5lXeq5u0ey+AYYWxkmLnbScT3HaLj/i5
         RldVD182IHFwVYUYt/BHkPmo/nlfY1FAEvif6zKm83p6mGJHLbx7rG3Ui+2CS90uhbpD
         1inggeg3STqBxzT9n2s1wh/1AV/XvcvqXPCDJTE2lsUivbvR8Mdbkzvhvx5CCRicQjoC
         M2TzejURuK8pFFLDNGTbLhCufS2uYDlYdqeVvctNBjRZ18/uqFSURvqI0bObOFki11OQ
         sGyQ==
X-Received: by 10.107.35.203 with SMTP id j194mr45926326ioj.45.1432154378000;
        Wed, 20 May 2015 13:39:38 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:c1e1:e830:c078:d79d])
        by mx.google.com with ESMTPSA id e69sm13168576ioe.11.2015.05.20.13.39.37
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 20 May 2015 13:39:37 -0700 (PDT)
In-Reply-To: <20150520183115.GB7142@peff.net> (Jeff King's message of "Wed, 20
	May 2015 14:31:15 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269518>

Jeff King <peff@peff.net> writes:

> I should have looked before replying. It would indeed break "cat-file
> -e" horribly. So the right answer may be to just improve the "bad
> object" message (probably by checking has_sha1_file there and diagnosing
> it either as missing or corrupted).

I should have looked before replying, too ;-)

Yeah, "bad object" sounds as if we tried to parse something that
exists and it was corrupt.  So classifying "a file or a pack index
entry exists where a valid object with that name should reside in"
as "bad object" and "there is no such file or a pack index entry
that would house the named object" as "missing object" _might_ make
things better.

But let's think about it a bit more.  Would it have prevented the
original confusion if we said "missing object"?  I have a feeling
that it wouldn't have.  Faheem was so convinced that the object
named with the 40-hex *must* exist in the cloned repository, and if
we told "missing object" to such a person, it will just enforce the
(mis)conception that the repository is somehow corrupt, when it is
not.

So...
