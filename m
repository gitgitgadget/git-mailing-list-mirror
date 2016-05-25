From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Why is my git-http-backend solution using WebDAV on push?
Date: Wed, 25 May 2016 15:16:49 -0700
Message-ID: <xmqqiny1zstq.fsf@gitster.mtv.corp.google.com>
References: <CABwKKP958cW3a5Cjxox+1FCtNLetdufJj0rrYBouAUhJSXKKWA@mail.gmail.com>
	<20160525213850.GB13776@sigill.intra.peff.net>
	<CABwKKP89Ncht0MfB7X1x15a6PB-Nm68SDGEDvX1AnQdDucXQkA@mail.gmail.com>
	<CABwKKP-rKSGzdk6E78BMRCVdumtVnj7tysv90c7RL8=059PxoA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Luke Madhanga <lmadhanga@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 26 00:16:59 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b5h6p-0003Rw-2k
	for gcvg-git-2@plane.gmane.org; Thu, 26 May 2016 00:16:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751480AbcEYWQx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 May 2016 18:16:53 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:64192 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751284AbcEYWQx (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 May 2016 18:16:53 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 913AC1F113;
	Wed, 25 May 2016 18:16:51 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=QuxTiSKCLblpUSu6sgVTqSzTsZQ=; b=Cm7jZG
	IDKmw3d9bWn+Hh0V7RqkCZWv7dehjOtXFA3vNOaS6/5myADOlRrOD77TA5fQk9Hu
	byWOJcVK4NlzSQiZt7V7ou/B+dys2Q2S0AjKzFHVeUGANMEjHvLFGb+6Ik932DJn
	n4KYnKifj/TfyX2Hrc78Cf86e4dprbg4L9v+Y=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=TbXa5+L6ehvdTUgdQeJDsp3EOOY5wHP9
	7wygfU0Tlj2rXdVzCALE0THhwWBnpAJULGTQrQWZ+xGsgcocdSnVHzqlVcI9GQxy
	xmZRH+G9Vz3KMPzHtzOoR2iKGNiOG1AoMQoQejcFpR5s2nkWUQ6QJiKDRJdaiFBe
	uAezwc/hsok=
Received: from pb-smtp1. (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 880031F112;
	Wed, 25 May 2016 18:16:51 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 06BCD1F111;
	Wed, 25 May 2016 18:16:50 -0400 (EDT)
In-Reply-To: <CABwKKP-rKSGzdk6E78BMRCVdumtVnj7tysv90c7RL8=059PxoA@mail.gmail.com>
	(Luke Madhanga's message of "Wed, 25 May 2016 22:54:26 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 612A3D48-22C6-11E6-BBC4-9A9645017442-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295598>

Luke Madhanga <lmadhanga@gmail.com> writes:

>> A manual CLI call to git-http-backend doesn't include
>> 'application/x-git-receive-pack-advertisement'
>>
>> REQUEST_METHOD=GET GIT_PROJECT_ROOT=/path/to/core/
>> PATH_INFO=/repo.git/info/refs /usr/lib/git-core/git-http-backend

The request client makes to probe is (taking it from Peff's message
that is quoting from your trace):

> > GET /p/git-backend/run/1/info/refs?service=git-receive-pack HTTP/1.1

Your manual CLI call seems not to have "?service=git-receive-pack"
anywhere.  Where did it go?  QUERY_STRING, perhaps?

Here is what I am observing:

    $ GIT_HTTP_EXPORT_ALL=Yes \
    > REQUEST_METHOD=GET \
    > GIT_PROJECT_ROOT=$(pwd)/.git \
    > PATH_INFO='/info/refs' \
    > QUERY_STRING=service=git-receive-pack \
    > git -c http.receivepack=yes http-backend 2>&1 | sed -e '/^.$/q'
    Expires: Fri, 01 Jan 1980 00:00:00 GMT
    Pragma: no-cache
    Cache-Control: no-cache, max-age=0, must-revalidate
    Content-Type: application/x-git-receive-pack-advertisement


>>
>> The above command outputs
>>
>> Expires: Fri, 01 Jan 1980 00:00:00 GMT
>> Pragma: no-cache
>> Cache-Control: no-cache, max-age=0, must-revalidate
>> Content-Length: 118
>> Content-Type: text/plain
>>
>> f4648182f5f8eee082c37a83a0072cfc4210e5c5 refs/heads/master
>> 8c4efcd77809bc9b94a59cf94653add8007c6b7d refs/heads/zztest
