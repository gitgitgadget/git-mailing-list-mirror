From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] Portability: returning void
Date: Tue, 29 Mar 2011 19:42:36 -0500
Message-ID: <20110330004236.GD14578@elie>
References: <71372d7d-dd08-4945-a8bc-c7b981c09fb2-mfwitten@gmail.com>
 <20110329200230.GA377@elie>
 <20110329221652.GB23510@sigill.intra.peff.net>
 <20110329234955.GB14578@elie>
 <20110330001653.GA1161@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Michael Witten <mfwitten@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	David Barr <david.barr@cordelta.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Mar 30 02:42:53 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q4jUq-0002lO-Rd
	for gcvg-git-2@lo.gmane.org; Wed, 30 Mar 2011 02:42:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754757Ab1C3Aml convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 29 Mar 2011 20:42:41 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:58816 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752067Ab1C3Aml convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 29 Mar 2011 20:42:41 -0400
Received: by gyd10 with SMTP id 10so316352gyd.19
        for <git@vger.kernel.org>; Tue, 29 Mar 2011 17:42:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=MWChsnV4rUShYm/5eLpj6DJ0hkNm8tqsqtmWQaTkoFw=;
        b=mz9/D6LMG+kPQWm3MuwtlDwmuQ8bwxTijA/FK9pXRI4Rf4HedbJD0vX1BhQ+K4RVqo
         D/ThZ6QNnXISWJUH73kHei7C8wcGbJj4mV2f2AFK8Cs/GgdcJFfsbREVyHZJPfQeRCGL
         vYhklb6ukItvR5U3w9kCMH1s5DxXpMUwrY22g=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=G5mwzXc8Luqq748psfiyQOjCzx02zSfcMffGDZ3dLBfuyMgXVcuLGih5TmeF3y4Py+
         cFTP4p2BPXwISq9S20tyBies+L0ZjtrwIS1VKrP/odbt7FGMrQX3YgU+57fUGq2VOCw1
         Tc4Crt3fM15TEmMYf86iWm0yQyJa1RaUsiCmU=
Received: by 10.151.21.7 with SMTP id y7mr196544ybi.145.1301445760128;
        Tue, 29 Mar 2011 17:42:40 -0700 (PDT)
Received: from elie (adsl-68-255-111-103.dsl.chcgil.ameritech.net [68.255.111.103])
        by mx.google.com with ESMTPS id 74sm1899321yhl.59.2011.03.29.17.42.38
        (version=SSLv3 cipher=OTHER);
        Tue, 29 Mar 2011 17:42:39 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20110330001653.GA1161@sigill.intra.peff.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170344>

Jeff King wrote:

> No, you misunderstand. It is prove itself that ignores the SIGCHLD. I=
t
> is stuck in the loop in TAP::Parser::Iterator::Process::_next. It has
> gotten SIGCHLD, but it keeps blocking waiting to get EOF on the child=
's
> stdout.

Thanks for clarifying.

> Doesn't that point to an unreaped process? After 100 seconds the slee=
p
> process closes, prove gets EOF, and it completes. Lowering the "100" =
to
> "1" caused a 1-second hang for me.

I guess it's just a matter of terminology.  To me, it points to an
undelivered signal, since the problem is not a zombie waiting to be
wait-ed on but a process still alive and sleeping.

> But instead of realizing its child has died, it
> insists on waiting until the pipe is closed. Nothing has to be adopte=
d
> by init. There are simply still processes with the pipe open.

I meant that the sleep process is not a descendant of prove any
more.

| $ ps ax | egrep 'sleep|prove'
| 20203 pts/3    T      0:00 vim utils/prove
| 22654 pts/1    S+     0:00 /usr/bin/perl /usr/bin/prove --exec=3Dbash
| t0081-line-buffer.sh
| 22688 pts/1    S+     0:00 sleep 100
| 22694 pts/1    S+     0:00 sleep 100
| 22727 pts/3    S+     0:00 egrep sleep|prove
| $ pstree -p 22654
| prove(22654)=E2=94=80=E2=94=80=E2=94=80bash(22655)

> Did you try my 5>/dev/null patch? With it, I get no hang at all.

Now I've tested it and it indeed works as advertised.

Sorry for the lack of clarity.
