From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 01/10] strbuf: Add strbuf_read_noblock
Date: Thu, 17 Sep 2015 09:44:19 -0700
Message-ID: <CAPc5daVY=t27wkX2x7DSfObwxZuv37VYxi1XD-RKiS1mv4=6KA@mail.gmail.com>
References: <1442453948-9885-1-git-send-email-sbeller@google.com>
 <1442453948-9885-2-git-send-email-sbeller@google.com> <xmqqtwqtja6j.fsf@gitster.mtv.corp.google.com>
 <20150917163012.GB25837@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Stefan Beller <sbeller@google.com>,
	Git Mailing List <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Johannes Schindelin <johannes.schindelin@gmail.com>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Vitali Lovich <vlovich@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Sep 17 18:44:46 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZccIf-00034D-2U
	for gcvg-git-2@plane.gmane.org; Thu, 17 Sep 2015 18:44:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752122AbbIQQok (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Sep 2015 12:44:40 -0400
Received: from mail-ig0-f176.google.com ([209.85.213.176]:33539 "EHLO
	mail-ig0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752032AbbIQQok (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Sep 2015 12:44:40 -0400
Received: by igbkq10 with SMTP id kq10so16859605igb.0
        for <git@vger.kernel.org>; Thu, 17 Sep 2015 09:44:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=xfu2yey5zNAs4CofEHslJYopSFyrs3i9UdV/nV4jLMY=;
        b=mq/l5EHgNb23V1qs0Gf/v0NoAV1plX1MkFnA9chSF+vt9LIxGCZ0kSFpokqDPuGjZl
         jPN985D9jxMqqi8yOjI2uM97R0sAVmQNwAGERMzEjnkHL5Jc9RGTkxipEYr0uZHNNThM
         ydCaVBQT4uZhJYZUsPFKWAMsC2EqSIboavlJGrxME+NwezB+rIK8Qd4Pbn/5UyeKroKW
         Sztj3e2ZoqZhfkxST8MTtiKXlJqJeeDsQN6mFFnqAbb7Jr70z5OrTNGYwFjwImS1MCB1
         g7XNiN3IAGdR18udsI38VtsXW2nqGay/kJO11+ZPozC+76zdLRh9Do+mErlsyepUoId8
         CXew==
X-Received: by 10.50.117.100 with SMTP id kd4mr7584706igb.75.1442508279239;
 Thu, 17 Sep 2015 09:44:39 -0700 (PDT)
Received: by 10.36.79.69 with HTTP; Thu, 17 Sep 2015 09:44:19 -0700 (PDT)
In-Reply-To: <20150917163012.GB25837@sigill.intra.peff.net>
X-Google-Sender-Auth: dzu-nNeTdefd_YGCB7-hwgla6_4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278135>

On Thu, Sep 17, 2015 at 9:30 AM, Jeff King <peff@peff.net> wrote:
>
> So I think we would probably want to treat EAGAIN specially: return -1
> to signal to the caller but _don't_ truncate the strbuf.

Yeah, "don't truncate" is needed.

> Arguably we should actually return the number of bytes we _did_ read,
> but then caller cannot easily tell the difference between EOF and
> EAGAIN.

Why can't it check errno==EAGAIN/EWOULDBLOCK?
