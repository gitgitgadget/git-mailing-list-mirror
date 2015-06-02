From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFCv2 10/16] transport: connect_setup appends protocol version number
Date: Tue, 02 Jun 2015 15:27:44 -0700
Message-ID: <xmqqa8whzqxr.fsf@gitster.dls.corp.google.com>
References: <1433203338-27493-1-git-send-email-sbeller@google.com>
	<1433203338-27493-11-git-send-email-sbeller@google.com>
	<xmqq8uc123n5.fsf@gitster.dls.corp.google.com>
	<CAGZ79kbnX_kyuvj73PGcO7OBOj7CfdouARrqNWEkCnUfdN=DqQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: "git\@vger.kernel.org" <git@vger.kernel.org>,
	Duy Nguyen <pclouds@gmail.com>, Jeff King <peff@peff.net>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Wed Jun 03 00:28:00 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yzuf1-0006CC-Sr
	for gcvg-git-2@plane.gmane.org; Wed, 03 Jun 2015 00:27:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751986AbbFBW1s (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Jun 2015 18:27:48 -0400
Received: from mail-ig0-f178.google.com ([209.85.213.178]:38843 "EHLO
	mail-ig0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751605AbbFBW1q (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Jun 2015 18:27:46 -0400
Received: by igblz2 with SMTP id lz2so704508igb.1
        for <git@vger.kernel.org>; Tue, 02 Jun 2015 15:27:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=jPwoDXdfOt7hMbykHPJyI+zEkHGbUoOz92hnp/c0tlk=;
        b=UpaHKxwCP42gyg31N05pkazpJO3qwSXP4TNnXLBu8FwF10em/EEgdd2iMJBkOFjoDi
         PPUrmBrnbL6uvzgVauadoe0TFUUTiZDm6mstTqL7Bn4x6AN4L3WJBdc6Zj6DCUNnKW6r
         kSFP/Z2IcIa5H8zE9gP9q2LMYw+tJE3lb7oxhClUsiaH/FxVSn2enAoGebeMeZ2jLz5f
         BNvQ1KPJCoMR4nSv23iLZ2mgtfNXgf1IQ6Pcd/T9YQhkofEthq9v3osMgU8pRpVvFie6
         t5PJuJ+dJRvqrX/msmELyJ6n/oi3Yr0LtckoyLVF03l4vd0Cej7elh5xIjInwKuAbPo7
         /qMg==
X-Received: by 10.50.49.46 with SMTP id r14mr23363339ign.45.1433284066140;
        Tue, 02 Jun 2015 15:27:46 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:3140:53f3:e8c0:89b0])
        by mx.google.com with ESMTPSA id qt1sm10900360igb.5.2015.06.02.15.27.45
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 02 Jun 2015 15:27:45 -0700 (PDT)
In-Reply-To: <CAGZ79kbnX_kyuvj73PGcO7OBOj7CfdouARrqNWEkCnUfdN=DqQ@mail.gmail.com>
	(Stefan Beller's message of "Tue, 2 Jun 2015 15:09:23 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270618>

Stefan Beller <sbeller@google.com> writes:

>> Hmph, so everybody else thinks it is interacting with 'upload-pack',
>> and this is the only function that knows it is actually talking with
>> 'upload-pack-2'?
>
> Yes.
>>
>> I am wondering why there isn't a separate helper function that
>> munges data->options.{uploadpack,receivepack} fields based on
>> the value of transport_version that is called _before_ this function
>> is called.
>
> That makes sense.

Hmph, but then everybody would know that it is now interacting with
upload-pack-2; I think it probably is a better way to go.

In any case, all codepaths other than what actually runs exec()
should not be basing their decision on the program names---that is
what you added transport_version field for, and they should look
at that field if they want to switch behaviour between protocol
versions anyway, so I think we can live with either way.

>> Also, how does this interact with the name of the program the end
>> user can specify via "fetch --upload-pack=<program name>" option?
>
> You'd specify --upload-pack=foo-frotz and --transport-version=2
> and it would look for foo-frotz-2 instead.

Hmm, that's an unfortunate interaction.  If you wrote a new protocol
driver that talks v2, it may be natural to say

	git fetch --upload-pack=a.out --transport-version=2

when you want to test it, and we do not want to invoke a.out-2 in
that case.

> The problem IMHO is we have quite a few places where the
> upload-pack binary path can be configured. Either as a command line
> option or as a repository configuration.

At least shouldn't you be able to tell if we are using compiled-in
default or user specified value (whether configuration/command line)?

Does the code that initialise data->options.{upload,receive}pack
fields with the compiled-in default values know what protocol
version is going to be used at that point?  I think that is where
the appending of "-2" should be done; in other words, I think
addition of "-2" should be done _ONLY_ for compiled-in default
values, and it should be done not just for exec() but should be
visible to everybody, including those who are debugging and inspect
data->options.uploadpack field.  What we spawn must match what is
stored there.
