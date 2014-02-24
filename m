From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] remote: handle pushremote config in any order order
Date: Mon, 24 Feb 2014 12:53:53 -0800
Message-ID: <xmqq38j88c66.fsf@gitster.dls.corp.google.com>
References: <CAMYxyaUwPXXdvGv786_p5n7-biMLOFbur-gQ1pxXOttc0R0=eg@mail.gmail.com>
	<20140224085903.GA10698@sigill.intra.peff.net>
	<xmqqvbw49z0f.fsf@gitster.dls.corp.google.com>
	<xmqq7g8k8d5r.fsf@gitster.dls.corp.google.com>
	<20140224203946.GB25506@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jack Nagel <jacknagel@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Feb 24 21:54:02 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WI2XJ-00060i-QR
	for gcvg-git-2@plane.gmane.org; Mon, 24 Feb 2014 21:54:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752939AbaBXUx6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Feb 2014 15:53:58 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:60911 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752212AbaBXUx5 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Feb 2014 15:53:57 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A963B6F24F;
	Mon, 24 Feb 2014 15:53:56 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=F0edoNGakpi1y/K6siXhUC8+wPY=; b=CcEA1w
	R+5YhJNm6iM2UdEuTi4oZWozi3bCwEBsj0snRkQBVqoFuMoq8OxxdEeYO/a47dcL
	Zs1qK9muqaI9qQPB/EF074GhhOxjRmyjp9nKO+VCSWaemucCLBT9WIP07HBEM/H1
	b7mSTiubMe+6Ln7s9EA7S0s/h0LjYggSy5Leg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=KsbXQEQn3KqpKK61ZY5tYR/T72Lqe41+
	m+t77cyqXwW8VTwod9Z2zxQK8H8N/OoBnep8C6iACSCdTHivv1hEgGyk7VEwzJmX
	7nKDb4t+m7e3c46IFrjqY80+O9wolQzaUri/5TEyGf8fgCjVO9bN+XVnpsiocuUV
	bVEXFENlE6E=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 964D86F24E;
	Mon, 24 Feb 2014 15:53:56 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B9F096F24C;
	Mon, 24 Feb 2014 15:53:55 -0500 (EST)
In-Reply-To: <20140224203946.GB25506@sigill.intra.peff.net> (Jeff King's
	message of "Mon, 24 Feb 2014 15:39:47 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: C687FB0C-9D95-11E3-A3F5-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242646>

Jeff King <peff@peff.net> writes:

> On Mon, Feb 24, 2014 at 12:32:32PM -0800, Junio C Hamano wrote:
>
>> >> +test_expect_success 'branch.*.pushremote config order is irrelevant' '
>> >> +	mk_test one_repo heads/master &&
>> >> +	mk_test two_repo heads/master &&
>> >> +	test_config remote.one.url one_repo &&
>> >> +	test_config remote.two.url two_repo &&
>> >> +	test_config branch.master.pushremote two_repo &&
>> >> +	test_config remote.pushdefault one_repo &&
>> >> +	git push &&
>> >> +	check_push_result one_repo $the_first_commit heads/master &&
>> >> +	check_push_result two_repo $the_commit heads/master
>> >> +'
>> >> +
>> 
>> This test however does not pass in the Git 2.0 world, without having
>> this line:
>> 
>>        test_config push.default matching &&
>> 
>> immediately before "git push".
>> 
>> Am I missing something?
>
> No, you are not missing anything. I was copying and paring down the
> pushremote test above, and I accidentally pared out the push.default
> setting. It should definitely have a
>
>   test_config push.default matching &&
>
> before the "git push" line, as the test above does. Can you mark it up
> as you apply?

Gladly ;-)

I wasn't thinking straight and thought push.default was somehow
affecting the logic to read the configuration files you fixed, which
was a complete nonsense.  The selection of which remote to push to
is affected by the branch.*.pushremote and remote.pushdefault, but
this "git push" still expects that the way the branches are chosen
to be pushed follow the matching semantics, not the simple
semantics, so we need that configuration there.
