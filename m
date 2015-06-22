From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v6 18/19] fsck: git receive-pack: support excluding
 objects from fsck'ing
Date: Sun, 21 Jun 2015 21:21:05 -0700
Message-ID: <CAPc5daV2P_vR-wjuU-0W81F9_phawHaQM1HHpOqNTsNDyQ5NHQ@mail.gmail.com>
References: <cover.1434657920.git.johannes.schindelin@gmx.de>
 <cover.1434720655.git.johannes.schindelin@gmx.de> <e843f9f1defca543d3f2eb3143cf9fee8c72f695.1434720655.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Jeff King <peff@peff.net>
To: Johannes Schindelin <johannes.schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Jun 22 06:21:35 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z6tEi-0000Xx-5F
	for gcvg-git-2@plane.gmane.org; Mon, 22 Jun 2015 06:21:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752593AbbFVEV0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Jun 2015 00:21:26 -0400
Received: from mail-ob0-f176.google.com ([209.85.214.176]:33282 "EHLO
	mail-ob0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751661AbbFVEVZ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Jun 2015 00:21:25 -0400
Received: by obpn3 with SMTP id n3so22869101obp.0
        for <git@vger.kernel.org>; Sun, 21 Jun 2015 21:21:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=HrPHczbhll9QISct15oGOYGVrjfimBd1ur9tbXDW06I=;
        b=wSOErOtzg74LQ9X5oaNanRjqD8e/DhVz6yOaMDOkfaDeJwvZuFXa1Qn48gd3cCR8IL
         +NjiX9ruWBu5QXeu+Ua9xHGmWBRjkO60zu7p9f98PbJ8FfE7j+aW1mFZ7u4Ox1wBkpzn
         P0n6bnic3sQ0EBDinWfuL62+NZBi2o75hHkjvMZdyz33UjfHhTtNjOW0F70s5JzwVUaH
         XqAMjB6enVhk8yNUfZ0Wg8AsaRmWytnAOyOSNPiDN1TwdywN85A/1dzXkK5obUPucXM8
         Mq6iohZ4TguGRQzd5uw0Cf+2j13/99McBuUG9li4TV2Mqs6jesUTDRtihvYcUrYXSNjO
         dUEw==
X-Received: by 10.202.200.131 with SMTP id y125mr21739365oif.20.1434946884856;
 Sun, 21 Jun 2015 21:21:24 -0700 (PDT)
Received: by 10.202.202.129 with HTTP; Sun, 21 Jun 2015 21:21:05 -0700 (PDT)
In-Reply-To: <e843f9f1defca543d3f2eb3143cf9fee8c72f695.1434720655.git.johannes.schindelin@gmx.de>
X-Google-Sender-Auth: qMFuFCsRI-6J0Jwvcv4ktJ-narM
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272314>

On Fri, Jun 19, 2015 at 6:35 AM, Johannes Schindelin
<johannes.schindelin@gmx.de> wrote:
>
> @@ -227,6 +277,10 @@ static int report(struct fsck_options *options, struct object *object,
>         if (msg_type == FSCK_IGNORE)
>                 return 0;
>
> +       if (options->skiplist && object &&
> +                       sha1_array_lookup(options->skiplist, object->sha1) >= 0)
> +               return 0;
> +
>         if (msg_type == FSCK_FATAL)
>                 msg_type = FSCK_ERROR;
>         else if (msg_type == FSCK_INFO)

I just double checked this patch because I wanted to make sure this
was applied in the
report() function (i.e. behave as if FSCK_IGNORE was specified for
specific objects on
the skip list), and I am happy to see that it indeed is the case.

That was because I briefly feared that skip could be done before going
through the usual
verification chain, which would have been very wrong (e.g. we may want
not to hear about
missing tagger in v2.6.11-tree tag, but nevertheless we would want to
check all the tree
contents pointed at by that tag, as that tree may not be reachable by
any other way).

So this one looks good.
