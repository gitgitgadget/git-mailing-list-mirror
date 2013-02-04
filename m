From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Segmentation fault with latest git (070c57df)
Date: Mon, 04 Feb 2013 01:29:41 -0800
Message-ID: <7vobg04ebe.fsf@alter.siamese.dyndns.org>
References: <12070540.431901359961105650.JavaMail.weblogic@epml10>
 <7vehgw5z7n.fsf@alter.siamese.dyndns.org>
 <20130204083701.GA30835@sigill.intra.peff.net>
 <7vsj5c4exz.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: jongman.heo@samsung.com, Jonathan Nieder <jrnieder@gmail.com>,
	Thomas Rast <trast@student.ethz.ch>, git <git@vger.kernel.org>,
	Antoine Pelisse <apelisse@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Feb 04 10:30:07 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U2INK-0007kX-Tp
	for gcvg-git-2@plane.gmane.org; Mon, 04 Feb 2013 10:30:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752420Ab3BDJ3o (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Feb 2013 04:29:44 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:59737 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751437Ab3BDJ3n (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Feb 2013 04:29:43 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 41AC8B872;
	Mon,  4 Feb 2013 04:29:43 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=eEWDIq3oxkJ5E2rG46BsIIRH30o=; b=gGRK2t
	KPLRDcsapcqercJWqcp6+fppnyrt37tf46z6Hn+lv35Po0QsP1wWs4cnLB2pfRIx
	vGjJIZaxYjnGwrjUggCupKtlzvkfxy3eXdIx0gTF1uVLWdg0dnUNHj8D515H+kOP
	1o1MKYmhJzi4ZkTROZb1KMv8FR2zs0DjHdZ/Y=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=G9UOPgiv2Cg2zO8MTdcp4lI7VeZJ/qxm
	yFCefiBMqWURVbiXLkRbOy3BpYwYwaE1rsjtclH7rrbGozE6GmiHxHj8gMPzJlAA
	6pkGPyr2p2AYP9dER40QbSr6iL161YM2pzXoWPplrs4htJ+muHCzdCvEC/INafHZ
	LHSgu3cIgkY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 34DDEB871;
	Mon,  4 Feb 2013 04:29:43 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 8DA33B86E; Mon,  4 Feb 2013
 04:29:42 -0500 (EST)
In-Reply-To: <7vsj5c4exz.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Mon, 04 Feb 2013 01:16:08 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 67E53686-6EAD-11E2-BC2F-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215371>

Junio C Hamano <gitster@pobox.com> writes:

> As I understand how the current set-up works:
>
>  * Initially, we do not have foo.o but foo.c.  We automatically
>    build foo.o because it depends on foo.c via the "%.o : %.c" rule,
>    and as a side effect, we also build .depend/foo.o.d file;
>
>  * Then, if any real dependency used to build the existing foo.o
>    that is recorded in .depend/foo.o.d file changes, foo.o gets
>    rebuilt, which would update .depend/foo.o.d again for the next
>    invocation.

This is unrelated to the case you mentioned, but I wonder what
happens if you did this:

 * You are on branch 'next', where foo.c includes (perhaps
   indirectly) frotz.h.  Compile and you get foo.o and also the
   dependency recorded for it, "foo.o: foo.c frotz.h", in the
   .depend/foo.o.d file.

 * You check out branch 'master', where foo.c does not include
   frotz.h.  Indeed, the include file does not even exist on the
   branch.

Do we get confused, because Makefile includes the depend file from
the previous build, finds that you need foo.c and frotz.h up to date
in order to get foo.o, but there is no rule to generate frotz.h?
