From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Git grep does not support multi-byte characters (like UTF-8)
Date: Tue, 07 Jul 2015 21:52:30 -0700
Message-ID: <xmqq1tgj1ca9.fsf@gitster.dls.corp.google.com>
References: <2008630603.1189842.1436182096558.JavaMail.apache@nm33.abv.bg>
	<CACsJy8BH_QJss57uMJNE=ojNT5vBWKN=eEdrBBS38g6As-UH6A@mail.gmail.com>
	<775251698.1328032.1436259534851.JavaMail.apache@nm31.abv.bg>
	<xmqqr3ok3qad.fsf@gitster.dls.corp.google.com>
	<663318203.435786.1436292501411.JavaMail.apache@nm32.abv.bg>
	<CACsJy8De6Wt4J5ZFx5rEg2eRBt=7PsLim=31FvtLEKsX-6SMyQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Plamen Totev <plamen.totev@abv.bg>,
	Git Mailing List <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 08 06:52:39 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZChLa-0004qL-Fh
	for gcvg-git-2@plane.gmane.org; Wed, 08 Jul 2015 06:52:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754782AbbGHEwf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Jul 2015 00:52:35 -0400
Received: from mail-ie0-f178.google.com ([209.85.223.178]:33431 "EHLO
	mail-ie0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751564AbbGHEwd (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Jul 2015 00:52:33 -0400
Received: by ieru20 with SMTP id u20so4933770ier.0
        for <git@vger.kernel.org>; Tue, 07 Jul 2015 21:52:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=+tqpj5lDaHLaCW9eirB6lUAUYr0A9rRnTnlhicO3vhA=;
        b=HVtkp3X9sBxHxfxLEFQpCVcXdodGnSj7glDIxbrhMleRfMrt54SQYGX3yLjb658z1N
         fnq2KKYtHk1a+GI0TR0q9qeC6qHp+6BMUjboD5XcbCL79wW4Q8YQXF7d6zOYOFuorVZg
         UjxJYTRsu1yz5SLfHmk1fWWvpCWJGRDzXFLkPVwszYLagwVSju9bGTb5Qf4SHcos0lA/
         cnUj5OzyleAMIvJdgFOmCnLkfUkOyIUB0K+/UWHIsrq9zWpWghRB+h0FFSMYqjfzLtW9
         iAkP+WC3nEpzA0Y0o8H4eZelwVx+f7EHhQasfHvVchYUkI2yoXRTaYF7p/1lqiw+q75J
         KrhA==
X-Received: by 10.107.154.196 with SMTP id c187mr3341575ioe.64.1436331152637;
        Tue, 07 Jul 2015 21:52:32 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:7d74:6f43:1e30:fb1d])
        by smtp.gmail.com with ESMTPSA id q16sm1136434igr.12.2015.07.07.21.52.30
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 07 Jul 2015 21:52:30 -0700 (PDT)
In-Reply-To: <CACsJy8De6Wt4J5ZFx5rEg2eRBt=7PsLim=31FvtLEKsX-6SMyQ@mail.gmail.com>
	(Duy Nguyen's message of "Wed, 8 Jul 2015 09:19:00 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273637>

Duy Nguyen <pclouds@gmail.com> writes:

> On top of this, pickaxe already supports icase even kws is used. But
> it only works for ascii, so either we fix it and support non-ascii, or
> we remove icase support entirely from diffcore_pickaxe(). I vote the
> former.

I think that is a different issue.  The pickaxe has a single very
narrowly-defined intended use case [*1*] and I do not care too much
how any use that is outside the intended use case behaves.  As long
as its intended use case does not suffer (1) correctness-wise, (2)
performance-wise and (3) code-cleanliness-wise, due to changes to
support such enhancements, I am perfectly fine.

Ascii-only icase match is one example of a feature that is outside
the intended use case, and implementation of it using kws is nearly
free if I am not mistaken, not making the primary use case suffer in
any way.

I however am highly skeptical that the same thing can be done with
non-ascii icase.  As long as it can be added without makinng the
primary use case suffer in any way, I do not mind it very much.

Thanks.


[Footnote]

*1* The requirement is very simple.  You get a string that is unique
in a blob that exists at the revision your traversal begins, and you
want to find the point where the blob at the corresponding path does
not have that exact string with minimal effort.  You do not need to
ensure that the input string is unique (it is a user error and the
behaviour is undefined) and for simplicity you are also allowed to
fire when the blob has more than one copies of the string (even
though the expected use is to find the place where the blob has
zero).

Any other cases, e.g. the string was not unique in the blob, the
user specified "ignore-case" and other irrelevant options, are
allowed to be incorrect or slow or both, as $gmane/217 does not need
such uses to implement it ;-)
