From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 1/9] transport-helper: add 'force' to 'export' helpers
Date: Sun, 22 Sep 2013 21:39:27 -0500
Message-ID: <523fa9df8ed1b_5c910e3e801fa@nysa.mail>
References: <1377789808-2213-1-git-send-email-felipe.contreras@gmail.com>
 <1377789808-2213-2-git-send-email-felipe.contreras@gmail.com>
 <523FAA59.6040200@bbn.com>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
To: Richard Hansen <rhansen@bbn.com>,
	Felipe Contreras <felipe.contreras@gmail.com>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 23 04:55:32 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VNwJ9-00044m-6O
	for gcvg-git-2@plane.gmane.org; Mon, 23 Sep 2013 04:55:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753153Ab3IWCzX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 22 Sep 2013 22:55:23 -0400
Received: from mail-oa0-f45.google.com ([209.85.219.45]:41811 "EHLO
	mail-oa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753191Ab3IWCzP (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Sep 2013 22:55:15 -0400
Received: by mail-oa0-f45.google.com with SMTP id o17so161652oag.32
        for <git@vger.kernel.org>; Sun, 22 Sep 2013 19:55:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:message-id:in-reply-to:references:subject:mime-version
         :content-type:content-transfer-encoding;
        bh=jega4jXD+UohuQ2TLPsoAtmlUk3pZfmrk6yBUNesDo8=;
        b=bowqmyh8GZ6vpOlRuRYXXYW+eyYwBNu1vwBuNGougPuySVoo3P++lQbCCDJOKdPKzx
         iPlxDPbaihwSqvJWaxXJ1qF9MsSr8SNhz8uORz6yGwUO3UaAFf9RGcpC2wLYXdGJ+ouP
         sXSR9bO+mpl65DdkwWJqXfv0kiWzxgFXKVn1xniCbVr86woYGnfuUwSxQVOkdYDEAasp
         cgBIvv1eSYM11laKqiP5TeCCcfWerHYDiZ7vOqrbgd3SNirYbO+Bobun+3WJllHHHN8j
         jHYy78h6IZKs82DT427G7D1InV9tPNIsJOzJYhY6RPonW7nu/jXYGaJA6sIzhG+rjlnh
         ux6Q==
X-Received: by 10.60.62.101 with SMTP id x5mr17663178oer.24.1379904915214;
        Sun, 22 Sep 2013 19:55:15 -0700 (PDT)
Received: from localhost (187-162-140-241.static.axtel.net. [187.162.140.241])
        by mx.google.com with ESMTPSA id r3sm11346764oep.2.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 22 Sep 2013 19:55:14 -0700 (PDT)
In-Reply-To: <523FAA59.6040200@bbn.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235183>

Richard Hansen wrote:
> On 2013-08-29 11:23, Felipe Contreras wrote:
> > Otherwise they cannot know when to force the push or not (other than
> > hacks).
> > 
> > Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
> > ---
> >  transport-helper.c | 3 +++
> >  1 file changed, 3 insertions(+)
> > 
> > diff --git a/transport-helper.c b/transport-helper.c
> > index 63cabc3..62051a6 100644
> > --- a/transport-helper.c
> > +++ b/transport-helper.c
> > @@ -814,6 +814,9 @@ static int push_refs_with_export(struct transport *transport,
> >  			die("helper %s does not support dry-run", data->name);
> >  	}
> >  
> > +	if (flags & TRANSPORT_PUSH_FORCE)
> > +		set_helper_option(transport, "force", "true");
> 
> Should the return value of set_helper_option() be checked?

Yeah, it would make sense. I guess we want to die() if the user does
'git push -f' and the remote helper doesn't support that.

> Also, should there be a #define TRANS_OPT_FORCE "force" with

I don't see the point of that. Defines are useful when you want to change the
value string, so you don't have to change the string everywhere, but we
definitely don't want to do that, as that would break backwards compatibility,
so TRANS_OPT_KEEP would always be "keep" so it's just a way to tire our
fingers.

> TRANS_OPT_FORCE added to boolean_options[]?

I don't see how that would help us, the only thing that would achieve is to map:


  set_helper_option(transport, "force", 1);

to

  set_helper_option(transport, "force", "true");

But we are already doing that.

Moreover, the code is already doing something similar for all the other options.

  set_helper_option(t, "progress", t->progress ? "true" : "false");
  set_helper_option(t, "verbosity", buf);
  set_helper_option(transport, "servpath", exec);
  set_helper_option(transport, "dry-run", "true");

-- 
Felipe Contreras
