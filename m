From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v6] format-patch --signature-file <file>
Date: Wed, 21 May 2014 14:58:42 -0700
Message-ID: <xmqqoayqoktp.fsf@gitster.dls.corp.google.com>
References: <1400634170-18266-1-git-send-email-jmmahler@gmail.com>
	<1400634170-18266-2-git-send-email-jmmahler@gmail.com>
	<xmqq61kyq1i5.fsf@gitster.dls.corp.google.com>
	<20140521215059.GB13956@hudson.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jeremiah Mahler <jmmahler@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 21 23:58:53 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WnEXD-0001lK-Q6
	for gcvg-git-2@plane.gmane.org; Wed, 21 May 2014 23:58:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753254AbaEUV6s (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 May 2014 17:58:48 -0400
Received: from smtp.pobox.com ([208.72.237.35]:64554 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752988AbaEUV6r (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 May 2014 17:58:47 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id DCB2018AAD;
	Wed, 21 May 2014 17:58:46 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=3vxkGckgn20SWaYCskRQ5ZopHd4=; b=eoVp8F
	jDJixxcXpVduk+xtOQ/GUbjvaaLlytiQ5UAfZjYDokGah8ObqaK0w2ZJevMUXxtx
	Jy11tv+aa1iXBqYEDJWdrLhJAtSwTVQEwgHVrGAub5XkecBH6km+vzmUjicRz0dG
	hPXM3RwY42FXsz4iyJ1eCDNDL+MYX4uHY+l+U=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=t5XDIwAp3BqQL/Eu2V16q4T9xE/fhxnW
	+1ti2VhcrfWOyEDxISkL0bVud4nmELoLFwrYlDMqneUmHFYbAQh8fWZkMjbbQKSw
	Jt/h9bHEl4FIZMVJ8x8KVD8tTW+wnSajBKYJqRpyHRqBGmwWBi1kTKQ0mxS3nvQe
	alrJv+YaOTQ=
Received: from pb-smtp0. (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id D31A418AAC;
	Wed, 21 May 2014 17:58:46 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 9959718AA4;
	Wed, 21 May 2014 17:58:43 -0400 (EDT)
In-Reply-To: <20140521215059.GB13956@hudson.localdomain> (Jeremiah Mahler's
	message of "Wed, 21 May 2014 14:50:59 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 136755EA-E133-11E3-AEA2-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249841>

Jeremiah Mahler <jmmahler@gmail.com> writes:

> On Wed, May 21, 2014 at 02:13:06PM -0700, Junio C Hamano wrote:
>> Jeremiah Mahler <jmmahler@gmail.com> writes:
>> 
> ...
>> >  	! grep "^-- \$" output
> ...
>> 
>> We have been trying not to do the above in recent test updates.  It
>> would be nice if this set-up did not have to be outside of the usual
>> test_expect_success structure.
>> 
>
> Jeff caught those "! grep" instances in my patch.

Hmm, I didn't mean that one, and I do not offhand what is wrong
about "! grep" that says "output should not contain this string".

The problem is a "cat" you added outside test_expect_*; the recent
push is to have as little executable outside them, especially the
"set-up" code to prepare for the real tests.

i.e. we have been trying to write new tests (and convert old ones)
like this:

        test_expect_success 'I test such and such ' '
                cat >input-for-test <<-\EOF &&
                here comes input
                EOF
                git command-to-be-tested <input-for-test >actual &&
                cat >expected <<-\EOF &&
                here comes expected output
                EOF
                test_cmp expected actual
        '

not like this:

        cat >input-for-test <<-\EOF &&
        here comes input
        EOF
        test_expect_success 'I test such and such ' '
                git command-to-be-tested <input-for-test >actual &&
                cat >expected <<-\EOF &&
                here comes expected output
                EOF
                test_cmp expected actual
        '
