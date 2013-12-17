From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4 2/3] diff: Let "git diff -O" read orderfile from any file, fail properly
Date: Tue, 17 Dec 2013 09:54:21 -0800
Message-ID: <xmqqsitrmkhe.fsf@gitster.dls.corp.google.com>
References: <1387224586-10169-1-git-send-email-naesten@gmail.com>
	<1387224586-10169-3-git-send-email-naesten@gmail.com>
	<xmqqwqj4mqhe.fsf@gitster.dls.corp.google.com>
	<CAJYzjmd_EWcQ5OzuZBQwhkfAtdxbPbvhVxUSsh98SzMzyz=-8w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>,
	Anders Waldenborg <anders@0x63.nu>
To: Samuel Bronson <naesten@gmail.com>
X-From: git-owner@vger.kernel.org Tue Dec 17 18:54:38 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vsyqq-0002a6-3J
	for gcvg-git-2@plane.gmane.org; Tue, 17 Dec 2013 18:54:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755129Ab3LQRyc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Dec 2013 12:54:32 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:53724 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754177Ab3LQRyb (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Dec 2013 12:54:31 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 12DB159C4F;
	Tue, 17 Dec 2013 12:54:25 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=wm1R+K2F03PUg3ARLn2uoJW6VFU=; b=IDlohQ
	amsPDt9zAt6gBRP9LO/PI6EcZL7aXRFD86fduzrqqH5kVwUS9pbmdblKcjuFmCtn
	n7OpnHfNd6LfSWVMtoF9HtS/VREgWBuLk0bUKbmZ0cDx+bJluXod1hgp7jCc8Leg
	3D9uY/+c9csbrj55uMqsMarkkfGULrqvieNnQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=gGNYsRA0G4fvzOEKHftXwtU8khCrOvoI
	1bNrwiVfyi6io/MFR/N4RwsA1AyWCi/VFJ3W1bN3HLT4dfRi6YX8eNr9D40KS3og
	DvXHjl7qxQS01/H5EEMOTHLilU6C5dYZVFHGPdlA21eVIwDqiu578i7UcYXKVW7J
	ahiU0zXR3Jc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 00BF059C4E;
	Tue, 17 Dec 2013 12:54:25 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 3EAD359C48;
	Tue, 17 Dec 2013 12:54:24 -0500 (EST)
In-Reply-To: <CAJYzjmd_EWcQ5OzuZBQwhkfAtdxbPbvhVxUSsh98SzMzyz=-8w@mail.gmail.com>
	(Samuel Bronson's message of "Tue, 17 Dec 2013 00:03:29 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 43B572E0-6744-11E3-BB7C-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239393>

Samuel Bronson <naesten@gmail.com> writes:

> On Mon, Dec 16, 2013 at 4:32 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> Samuel Bronson <naesten@gmail.com> writes:
>>
>>>  for i in 1 2
>>>  do
>>>       test_expect_success "orderfile using option ($i)" '
>>>       git diff -Oorder_file_$i --name-only HEAD^..HEAD >actual &&
>>>       test_cmp expect_$i actual
>>>  '
>>
>> This funny indentation in the previous step needs to be fixed, and
>> the added block below should match.
>
> Even though this results in oddly-indented --verbose output?
>
>>> +     rm -f order_fifo &&
>>> +     mkfifo order_fifo &&
>>> +     cat order_file_$i >order_fifo &
>>> +     git diff -O order_fifo --name-only HEAD^..HEAD >actual &&
>>
>> I think this part can be racy depending on which between cat and
>> "git diff" are scheduled first, no?  Try running this test under
>> load and I think you will see it deadlocked.
>>
>> Besides, the above breaks && chain; even if mkfifo breaks (hence not
>> allowing cat to run), "git diff" will go ahead and run, no?
>
> Hmm.  Well, what I really wanted to put here was a "process substitution":
>
>     git diff -O <(cat order_file_$i) --name-only HEAD^..HEAD >actual &&
>
> but I did not see this feature listed in the dash(1) manpage, so I
> assumed it wasn't allowed by POSIX.  And, having looked, I indeed
> don't see it mentioned in POSIX either.
>
> I'm not terribly surprised that I screwed up the translation to FIFOs;
> how would I really want to do it?

How about not doing a fifo?
