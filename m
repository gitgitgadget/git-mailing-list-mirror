From: Florian Achleitner <florian.achleitner.2.6.31@gmail.com>
Subject: Re: [PATCH/RFC v3 14/16] transport-helper: add import|export-marks to fast-import command line.
Date: Wed, 15 Aug 2012 23:06:20 +0200
Message-ID: <1579004.p8CLksap2K@flomedio>
References: <1344971598-8213-1-git-send-email-florian.achleitner.2.6.31@gmail.com> <7vsjbo3pbo.fsf@alter.siamese.dyndns.org> <1501407.T1vfOr6Yzb@flomedio>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Cc: Florian Achleitner <florian.achleitner.2.6.31@gmail.com>,
	git@vger.kernel.org, David Michael Barr <davidbarr@google.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Aug 15 23:06:39 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T1knW-0006gm-8Z
	for gcvg-git-2@plane.gmane.org; Wed, 15 Aug 2012 23:06:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756484Ab2HOVGc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Aug 2012 17:06:32 -0400
Received: from mail-bk0-f46.google.com ([209.85.214.46]:54483 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754251Ab2HOVGb (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Aug 2012 17:06:31 -0400
Received: by bkwj10 with SMTP id j10so683280bkw.19
        for <git@vger.kernel.org>; Wed, 15 Aug 2012 14:06:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:user-agent:in-reply-to
         :references:mime-version:content-transfer-encoding:content-type;
        bh=+t9mk75J4BdUQhg6v9lJ+htIgIXEhU0YUq0MSjGXGmg=;
        b=iqijmjQ3GX9B1UMgqONwaq1+sOBxl0pwbqsbL2zHZataYx+N1yXoS9RcabAV5hC376
         tIGlqmpA0+DaFOdU2+9FdfRcrLI1/QmOKYr/OnpH6fT/eDJdOM1OwtZ5SelnRJI1Tntj
         fjIYSLFPmmzG5/o0bG9QoiJX88wuLt/nYf0Mmnej8vx8wnb+OqH5EtsLQ36ICxV4LTPQ
         wmbxhchSaoan2PnO5hQuOYhLD96gpa6917Z5KeavccI6AjBS92+1XW7qtJ5aLgZs36Y6
         iJaWgaKhxcnMgLpLc7thnZ+n0tWNZl/hVPkYJTNhmo9IH7wzGqaUDsFrnOp5yMr1rZUo
         ogDw==
Received: by 10.205.137.8 with SMTP id im8mr8176754bkc.135.1345064790040;
        Wed, 15 Aug 2012 14:06:30 -0700 (PDT)
Received: from flomedio.localnet (91-115-86-169.adsl.highway.telekom.at. [91.115.86.169])
        by mx.google.com with ESMTPS id t23sm1354246bks.4.2012.08.15.14.06.23
        (version=SSLv3 cipher=OTHER);
        Wed, 15 Aug 2012 14:06:28 -0700 (PDT)
User-Agent: KMail/4.8.4 (Linux/3.0.0-24-generic; KDE/4.8.4; x86_64; ; )
In-Reply-To: <1501407.T1vfOr6Yzb@flomedio>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wednesday 15 August 2012 22:20:45 Florian Achleitner wrote:
> On Wednesday 15 August 2012 12:52:43 Junio C Hamano wrote:
> > Florian Achleitner <florian.achleitner.2.6.31@gmail.com> writes:
> > > fast-import internally uses marks that refer to an object via its sha1.
> > > Those marks are created during import to find previously created
> > > objects.
> > > At exit the accumulated marks can be exported to a file and reloaded at
> > > startup, so that the previous marks are available.
> > > Add command line options to the fast-import command line to enable this.
> > > The mark files are stored in info/fast-import/marks/<remote-name>.
> > > 
> > > Signed-off-by: Florian Achleitner <florian.achleitner.2.6.31@gmail.com>
> > > ---
> > > 
> > >  transport-helper.c |    3 +++
> > >  1 file changed, 3 insertions(+)
> > > 
> > > diff --git a/transport-helper.c b/transport-helper.c
> > > index 7fb52d4..47db055 100644
> > > --- a/transport-helper.c
> > > +++ b/transport-helper.c
> > > @@ -387,6 +387,9 @@ static int get_importer(struct transport *transport,
> > > struct child_process *fasti>
> > > 
> > >  	fastimport->in = helper->out;
> > >  	argv_array_push(&argv, "fast-import");
> > >  	argv_array_push(&argv, debug ? "--stats" : "--quiet");
> > > 
> > > +	argv_array_push(&argv, "--relative-marks");
> > > +	argv_array_pushf(&argv, "--import-marks-if-exists=marks/%s",
> > > transport->remote->name); +	argv_array_pushf(&argv,
> > > "--export-marks=marks/%s", transport->remote->name);
> > 
> > Is this something we want to do unconditionally?
> 
> Good question. It doesn't hurt, but it maybe . We could add another
> capability for remote-helpers, that tells us if it needs masks. What do you
> think?

Btw, for fast-export, there is already such a capability. It specifies a 
filename, in addition.
