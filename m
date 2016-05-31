From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH 2/2] strbuf: allow to use preallocated memory
Date: Tue, 31 May 2016 17:54:59 +0200
Message-ID: <vpq4m9eql2k.fsf@anie.imag.fr>
References: <20160530103642.7213-1-william.duclot@ensimag.grenoble-inp.fr>
	<20160530103642.7213-3-william.duclot@ensimag.grenoble-inp.fr>
	<xmqqbn3m7n25.fsf@gitster.mtv.corp.google.com>
	<20160531154503.GA24895@Messiaen>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	simon.rabourg@ensimag.grenoble-inp.fr,
	francois.beutin@ensimag.grenoble-inp.fr,
	antoine.queru@ensimag.grenoble-inp.fr, mhagger@alum.mit.edu
To: William <william.duclot@ensimag.grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Tue May 31 17:55:36 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b7m0y-0004Z1-99
	for gcvg-git-2@plane.gmane.org; Tue, 31 May 2016 17:55:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755159AbcEaPzM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 31 May 2016 11:55:12 -0400
Received: from mx1.imag.fr ([129.88.30.5]:51719 "EHLO mx1.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754364AbcEaPzK (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 31 May 2016 11:55:10 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by mx1.imag.fr (8.13.8/8.13.8) with ESMTP id u4VFsvXe007854
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Tue, 31 May 2016 17:54:57 +0200
Received: from anie (anie.imag.fr [129.88.42.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id u4VFsxwb001863;
	Tue, 31 May 2016 17:54:59 +0200
In-Reply-To: <20160531154503.GA24895@Messiaen> (William's message of "Tue, 31
	May 2016 17:45:03 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (mx1.imag.fr [129.88.30.5]); Tue, 31 May 2016 17:54:58 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: u4VFsvXe007854
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1465314900.86247@PStgVlbB7hjTVwHyvXa1eQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295989>

William <william.duclot@ensimag.grenoble-inp.fr> writes:

> On Mon, May 30, 2016 at 11:34:42PM -0700, Junio C Hamano wrote:
>
>> As long as your "on stack strbuf" allows lengthening the string
>> beyond the initial allocation (i.e. .alloc, not .len), the user of
>> the API (i.e. the one that placed the strbuf on its stack) would not
>> know when the implementation (i.e. the code in this patch) decides
>> to switch to allocated memory, so it must call strbuf_release()
>> before it leaves.  Which in turn means that your implementation of
>> strbuf_release() must be prepared to be take a strbuf that still has
>> its string on the stack.
>
> Well, my implementation does handle a strbuf that still has its
> string on the stack: the buffer won't be freed in this case (only a
> reset to STRBUF_INIT).
> Unless I misunderstood you?

I think Junio meant:

void f()
{
	struct strbuf sb;
	char buf[N];
	strbuf_wrap_preallocated(&sb, buf, ...);
	strbuf_add(&sb, ...);

	// is it safe to just let sb reach the end of its scope?
}

To answer the last question, the user would need to know too much about
the allocation policy, so in this case the user should call
strbuf_release(), and let it chose whether to call "free()"
(OWNS_MEMORY) or not. This is OK with your implementation, but the doc
needs to reflect this.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
