From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 8/8] git submodule update: Have a dedicated helper for cloning
Date: Wed, 21 Oct 2015 14:23:01 -0700
Message-ID: <xmqqvb9zudai.fsf@gitster.mtv.corp.google.com>
References: <1445381030-23912-1-git-send-email-sbeller@google.com>
	<1445381030-23912-9-git-send-email-sbeller@google.com>
	<xmqqd1w8uewx.fsf@gitster.mtv.corp.google.com>
	<CAGZ79kaa6b49rDW204ydtY0cf4NugSKOm+sBHKBYYoEsVugVfw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: "git\@vger.kernel.org" <git@vger.kernel.org>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Jacob Keller <jacob.keller@gmail.com>,
	Jeff King <peff@peff.net>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Johannes Schindelin <johannes.schindelin@gmail.com>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Eric Sunshine <ericsunshine@gmail.com>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Wed Oct 21 23:23:14 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zp0qn-0001dZ-Kp
	for gcvg-git-2@plane.gmane.org; Wed, 21 Oct 2015 23:23:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755355AbbJUVXI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Oct 2015 17:23:08 -0400
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:61644 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753273AbbJUVXH (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Oct 2015 17:23:07 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id CB39525D06;
	Wed, 21 Oct 2015 17:23:03 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ckuRRkJkq0E4B2lUOStdgxTdpys=; b=sUlO5z
	C2/7pifia2UlCYVfEY45OBMVgbaLSvUbeSwxX2EWOyDZNu/YlMQTabkPlPqQ2uoi
	w+ms1jXYNmeMjXjEjLplXDmv4yi8bC71tXyLx7LrAGgankXpq97IHS5lqIBszN6X
	0SZzcufD1eZ68kgUqxz76dWYH4spSij3vI5ZA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=locx9N/pz3qsbtUfbfvTqENDL3+Xaj74
	t8BKtSa5jSW0odrpSvh4LKtA1EVmT9TbRf7TuyDwF0+Ta2vpY2ZhHqyText3QPBp
	nPsYUki0M2RzyKmgD0Eqv4DOhypIw3z6z30PPJg50wXwxBjxdPQmOg3JxAQ/9FSr
	oArUx1FbUsM=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id C18F525D05;
	Wed, 21 Oct 2015 17:23:03 -0400 (EDT)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 457B025D04;
	Wed, 21 Oct 2015 17:23:03 -0400 (EDT)
In-Reply-To: <CAGZ79kaa6b49rDW204ydtY0cf4NugSKOm+sBHKBYYoEsVugVfw@mail.gmail.com>
	(Stefan Beller's message of "Wed, 21 Oct 2015 14:06:37 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: E9AE6064-7839-11E5-A6D6-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280024>

Stefan Beller <sbeller@google.com> writes:

> I'd like to counter your argument with quoting code from update_clone
> method:
> 
>      run_processes_parallel(1, get_next_task, start_failure,
> task_finished, &pp);
>
>      if (pp.print_unmatched) {
>          printf("#unmatched\n");
>          return 1;
>      }
>
>      for_each_string_list_item(item, &pp.projectlines) {
>          utf8_fprintf(stdout, "%s", item->string);
>      }
>
> So we do already all the cloning first, and then once we did all of that
> we just put out all accumulated lines of text. (It was harder to come up with
> a sufficient file name than just storing it in memory. I don't think
> memory is an
> issue here, only a few bytes per submodule. So even 1000 submodules would
> consume maybe 100kB)

That does not sound like a counter-argument; two bad design choices
compensating each other's shortcomings, perhaps ;-)

> Having a file though would allow us to continue after human
> interaction fixed one problem.

Yes.  That does sound like a better design.

This obviously depends on the impact to the other part of what
cmd_update() does, but your earlier idea to investigate the
feasibility and usefulness of updating "clone --recurse-submodules"
does sound like a good thing to do, too.  That's an excellent point.
