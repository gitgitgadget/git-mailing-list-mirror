From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH 04/11] ref-filter: add 'ifexists' atom
Date: Wed, 29 Jul 2015 11:00:41 -0700
Message-ID: <xmqqy4hy973q.fsf@gitster.dls.corp.google.com>
References: <CAOLa=ZT3_DMJWFN62cbF19uxYBFsE69dGaFR=af1HPKsQ42otg@mail.gmail.com>
	<1438066594-5620-1-git-send-email-Karthik.188@gmail.com>
	<1438066594-5620-4-git-send-email-Karthik.188@gmail.com>
	<xmqq8ua0f9lk.fsf@gitster.dls.corp.google.com>
	<CAOLa=ZTUJHnXWJyr0wp0CZgR9S1pBxCEsGRiDPsJdUyzTZaZUw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Git <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: Karthik Nayak <karthik.188@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 29 20:00:49 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZKVeq-0004Yf-Vq
	for gcvg-git-2@plane.gmane.org; Wed, 29 Jul 2015 20:00:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752585AbbG2SAp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Jul 2015 14:00:45 -0400
Received: from mail-pd0-f175.google.com ([209.85.192.175]:35852 "EHLO
	mail-pd0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751775AbbG2SAo (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Jul 2015 14:00:44 -0400
Received: by pdjr16 with SMTP id r16so9821274pdj.3
        for <git@vger.kernel.org>; Wed, 29 Jul 2015 11:00:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=S6OYuSek6vArmGcHa3mtY8iwKgv1QXLi+ekR9z4bFa4=;
        b=w+HW5//27qD1kyTIUqzye3Cguto2+wPt32SIydH4WfhuNBvVRIhtjfmeOhpWHQ3LGP
         cCChL1R2rRn6HJzo8olszpHA7+iifxXIvsBl7qjBoU9TksfnFAOZ13vfmHg70RSLY8jR
         shkFoqM0zvAGDXn+jLulzOJO/1OH7JHy97Nbq6JTEugXj54fqADewZCWyjLFSFPuIMHg
         UsJuu/3xAqEfIqFoVGn6FibiKSNHMkrEIM0mKuVe3ljK1HNJdqe+xuZbYaNl2on5K2oE
         TqdtCMXmGbGT9IS6tqvCp7ULceFJjeKUw9QJ/cbq/Et1BBOlxSxSOvUa15vpHcIIc95W
         79wA==
X-Received: by 10.70.92.41 with SMTP id cj9mr96366136pdb.64.1438192843771;
        Wed, 29 Jul 2015 11:00:43 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:4c0b:2701:e242:17dc])
        by smtp.gmail.com with ESMTPSA id bq3sm41982734pdb.14.2015.07.29.11.00.42
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 29 Jul 2015 11:00:42 -0700 (PDT)
In-Reply-To: <CAOLa=ZTUJHnXWJyr0wp0CZgR9S1pBxCEsGRiDPsJdUyzTZaZUw@mail.gmail.com>
	(Karthik Nayak's message of "Wed, 29 Jul 2015 23:18:16 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274933>

Karthik Nayak <karthik.188@gmail.com> writes:

>> A handful of "huh?" on the design.
>>
>>  - The atom says "if *exists*" and explanation says "has a value".
>>    How are they related?  Does an atom whose value is an empty
>>    string has a value?  Or is "ifexists" meant to be used only to
>>    ignore meaningless atom, e.g. %(*objectname) applied to a ref that
>>    refers to an object that is not an annotated tag?
>
> It's meant to ignore meaningless atom. atom's whose values are empty
> strings are ignored.

That is a self-contradicting answer.

If you ask for "%(*objectname)" on a commit, that request truly is
meaningless, as a commit is not an annotated tag that points at another
object whose objectname is being asked for.

But if a commit has an empty log message (you should be able to
create such an object with commit-tree), then "%(subject)" would be
an empty string.  The fact that the commit happens to have an empty
string as its message is far from meaningless.

Either you ignore an empty string, or you ignore meaningless one.
Which does "ifexists" mean?

>>  - That %s looks ugly.  Are there cases where a user may want to say
>>    %(ifexists:[%i]) or something other than 's' after that per-cent?
>
> Couldn't think of a better replacer, any suggestions would be welcome :)

See below.

> Its given as example, is that misleading?

Othewise I wouldn't be asking.

>>  - What, if anything, is allowed to come between %(ifexists...) and
>>    the next atom like %(refname)?  For example, are these valid
>>    constructs?
>>
>>     . %(ifexists...)%(padright:20)%(refname)
>
> Doesn't work ...
> ...
>>  - This syntax does not seem to allow switching on an attribute to
>>    show or not to show another, e.g. "if %(*objectname) makes sense,
>>    then show '%(padright:20)%(refname:short) %(*subject)' for it".
>
> Yes this doesn't do that,

One way to do all of the above is to make it

    %(ifexists:atom:expansionString)

That is, for example:

 "%(ifexists:*objectname:tag %(color:blue)%(refname:short)%(color:reset))"

would give you a string "tag v1.0" with "v1.0" painted in blue for
refs/tags/v1.0 but nothing for refs/heads/master.

Obviously expansionString part needs some escaping mechanism to
allow it to include an unmatched ")".
