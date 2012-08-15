From: Florian Achleitner <florian.achleitner.2.6.31@gmail.com>
Subject: Re: [PATCH/RFC v3 14/16] transport-helper: add import|export-marks to fast-import command line.
Date: Wed, 15 Aug 2012 22:20:45 +0200
Message-ID: <1501407.T1vfOr6Yzb@flomedio>
References: <1344971598-8213-1-git-send-email-florian.achleitner.2.6.31@gmail.com> <1344971598-8213-15-git-send-email-florian.achleitner.2.6.31@gmail.com> <7vsjbo3pbo.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Cc: Florian Achleitner <florian.achleitner.2.6.31@gmail.com>,
	git@vger.kernel.org, David Michael Barr <davidbarr@google.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Aug 15 22:21:05 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T1k5L-0000X2-Au
	for gcvg-git-2@plane.gmane.org; Wed, 15 Aug 2012 22:20:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756720Ab2HOUUx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Aug 2012 16:20:53 -0400
Received: from mail-bk0-f46.google.com ([209.85.214.46]:40338 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756673Ab2HOUUv (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Aug 2012 16:20:51 -0400
Received: by bkwj10 with SMTP id j10so669733bkw.19
        for <git@vger.kernel.org>; Wed, 15 Aug 2012 13:20:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:user-agent:in-reply-to
         :references:mime-version:content-transfer-encoding:content-type;
        bh=ZpoyYzr98f3o0Erzt7uB4MwqXUyQhvsnEh+KmaMS8jA=;
        b=Dsh+iVcffEYuu6DV3HA5gJnFRUBUGvgtfwR09ugO37ZksWgdj8afrz90whZcJJxB9l
         MKwaYI7MdZn4QQf8ELVRS7SctN8td306jPH9rOGLpBPkez8yVZmHyWRk+423UO4VyLtp
         R25F7/mfjC+54EFIq+VyqQr/W6LPUJyNnoFuY8LBYvPYseiBsVp1p0hX6HBIC/zf8sm9
         sTBfYeYpRfrsSa/OicDXFN6ruC0Ss8Sih4b03K8eZz1OlFODcZX1XcGRRDyPUgE1tU9S
         6BnNQPFFrZeIsaIIyhFty2QpWac64MsywQpdu+sLA0P0aQZqK001cGgH6xSiNezqiukK
         0wEg==
Received: by 10.205.120.18 with SMTP id fw18mr8499543bkc.64.1345062050474;
        Wed, 15 Aug 2012 13:20:50 -0700 (PDT)
Received: from flomedio.localnet (91-115-86-169.adsl.highway.telekom.at. [91.115.86.169])
        by mx.google.com with ESMTPS id gq2sm1308676bkc.13.2012.08.15.13.20.47
        (version=SSLv3 cipher=OTHER);
        Wed, 15 Aug 2012 13:20:48 -0700 (PDT)
User-Agent: KMail/4.8.4 (Linux/3.0.0-24-generic; KDE/4.8.4; x86_64; ; )
In-Reply-To: <7vsjbo3pbo.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wednesday 15 August 2012 12:52:43 Junio C Hamano wrote:
> Florian Achleitner <florian.achleitner.2.6.31@gmail.com> writes:
> > fast-import internally uses marks that refer to an object via its sha1.
> > Those marks are created during import to find previously created objects.
> > At exit the accumulated marks can be exported to a file and reloaded at
> > startup, so that the previous marks are available.
> > Add command line options to the fast-import command line to enable this.
> > The mark files are stored in info/fast-import/marks/<remote-name>.
> > 
> > Signed-off-by: Florian Achleitner <florian.achleitner.2.6.31@gmail.com>
> > ---
> > 
> >  transport-helper.c |    3 +++
> >  1 file changed, 3 insertions(+)
> > 
> > diff --git a/transport-helper.c b/transport-helper.c
> > index 7fb52d4..47db055 100644
> > --- a/transport-helper.c
> > +++ b/transport-helper.c
> > @@ -387,6 +387,9 @@ static int get_importer(struct transport *transport,
> > struct child_process *fasti> 
> >  	fastimport->in = helper->out;
> >  	argv_array_push(&argv, "fast-import");
> >  	argv_array_push(&argv, debug ? "--stats" : "--quiet");
> > 
> > +	argv_array_push(&argv, "--relative-marks");
> > +	argv_array_pushf(&argv, "--import-marks-if-exists=marks/%s",
> > transport->remote->name); +	argv_array_pushf(&argv,
> > "--export-marks=marks/%s", transport->remote->name);
> Is this something we want to do unconditionally?

Good question. It doesn't hurt, but it maybe . We could add another capability 
for remote-helpers, that tells us if it needs masks. What do you think?
