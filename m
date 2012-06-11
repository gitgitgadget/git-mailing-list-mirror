From: Junio C Hamano <gitster@pobox.com>
Subject: Re: branch --contains is unbearably slow [Re: [PATCHv2] Warnings
 before rebasing -i published history]
Date: Mon, 11 Jun 2012 09:16:49 -0700
Message-ID: <7vvcix7rim.fsf@alter.siamese.dyndns.org>
References: <1339104053-7782-1-git-send-email-Lucien.Kong@ensimag.imag.fr>
 <1339409091-28150-1-git-send-email-Lucien.Kong@ensimag.imag.fr>
 <87r4tmhy12.fsf_-_@thomas.inf.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Lucien Kong <Lucien.Kong@ensimag.imag.fr>, <git@vger.kernel.org>,
	Valentin Duperray <Valentin.Duperray@ensimag.imag.fr>,
	Franck Jonas <Franck.Jonas@ensimag.imag.fr>,
	Thomas Nguy <Thomas.Nguy@ensimag.imag.fr>,
	Huynh Khoi Nguyen Nguyen 
	<Huynh-Khoi-Nguyen.Nguyen@ensimag.imag.fr>,
	"Matthieu Moy" <Matthieu.Moy@grenoble-inp.fr>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Mon Jun 11 18:17:03 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Se7IW-0002sf-R3
	for gcvg-git-2@plane.gmane.org; Mon, 11 Jun 2012 18:16:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754169Ab2FKQQw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Jun 2012 12:16:52 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:45068 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753452Ab2FKQQv (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Jun 2012 12:16:51 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3E4E19EBB;
	Mon, 11 Jun 2012 12:16:51 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Th65HLld0cbgY0zjLjHP70MqaSg=; b=rwkees
	2P8t0vDz+6W5zM/lWMcZcTbEJ4ykXrazs4SSanuUJtrtkm5KoTyvranPsQl9qxzn
	VTY3UKtspPoloEeOFo/RdTlq/w+7JKktTHoE8hxfvccrWYRYHnuIDGHAwx4KgSXK
	aLHeORmNiQtSymTiPXykfIh9mSB11B2oNXBIk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=X8qJT9N0X6EEt5pvTZtcvlgz2MmuyJOi
	fdPw6VtUFme6XF7U2MQTQgMpn8T+Sg3VxltDM37vDGJEnyFID4ItLbiJO2Yu7VlE
	26XkdpZNWXY/l71dJnJZZlRlIA8GUS8Q/N1FymdOBQqXneyS5ldC7WN11r/SBCYW
	OcVlYoRrJiA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2F0B69EBA;
	Mon, 11 Jun 2012 12:16:51 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B11369EB8; Mon, 11 Jun 2012
 12:16:50 -0400 (EDT)
In-Reply-To: <87r4tmhy12.fsf_-_@thomas.inf.ethz.ch> (Thomas Rast's message of
 "Mon, 11 Jun 2012 13:46:01 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: D9E7B890-B3E0-11E1-9000-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199670>

Thomas Rast <trast@student.ethz.ch> writes:

>   $ time git branch -r --contains origin/next
>     origin/next
>
>   real    0m32.060s
>   user    0m31.895s
>   sys     0m0.036s
>
> I think an upper bound for the runtime of any 'git branch --contains'
> should be generating the *complete* topology like this:
>
>   $ time git log --graph --oneline --all >/dev/null
>
>   real    0m2.637s
>   user    0m2.246s
>   sys     0m0.364s

Hrm, there must be something I am doing wrong.

    $ time git log --graph --oneline --all >/dev/null

    real    0m3.896s
    user    0m3.476s
    sys     0m0.416s

Ok, so my disk is slower than yours, perhaps.  But

    $ time git branch -r --contains next
      github2/next
      gph/next
      ko/next
      repo/next

    real    0m3.853s
    user    0m3.804s
    sys     0m0.048s
