From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH 03/10] lazily load core.sharedrepository
Date: Thu, 3 Mar 2016 20:00:03 +0700
Message-ID: <CACsJy8DM4sG5MztfQnZHpaj3NAveS9S4-qLtSCmLEWhFyfKwTw@mail.gmail.com>
References: <20160301143546.GA30806@sigill.intra.peff.net> <20160301143954.GC12887@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>,
	David Turner <dturner@twopensource.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Mar 03 14:00:58 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1abSs8-0002Zd-Do
	for gcvg-git-2@plane.gmane.org; Thu, 03 Mar 2016 14:00:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757271AbcCCNAi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Mar 2016 08:00:38 -0500
Received: from mail-lb0-f181.google.com ([209.85.217.181]:36663 "EHLO
	mail-lb0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755662AbcCCNAf (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Mar 2016 08:00:35 -0500
Received: by mail-lb0-f181.google.com with SMTP id x1so22279851lbj.3
        for <git@vger.kernel.org>; Thu, 03 Mar 2016 05:00:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=b5nBGHqK4W4WxahgAjdRAXoflNRfIV1VVa+RZwrFVpU=;
        b=IiGS5ZM3utdtNAEOeNJnV27RxSqOk+D9nol188ew/YYOp31q7xogpA2LWo8e/VUZTx
         d8iaH3C6vEJxfJ6y9EAKdwVolRg+/Aw7iUZRN+MBblL2rkaZE8jg1KS9+SlMZAwPh4eU
         HS2JyG0zQrgdujotm8YH2/tsFkUk0Gm9rZiL+be+Ro8zGTFVXpokrnkPGW/X6oqQp/r3
         3isB9fusfVBFuxUe8RWYBcPsBSkspLJWI5QETpP9k8S46O4JtD+cmvOpUspfD3vrWqUD
         7NBSPFmBrvPLfrUGHoLFD5ATmXDYieUxG0uj6ZfRUYwWY2wPMECXEktOyL/g9IFtcjou
         Da3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=b5nBGHqK4W4WxahgAjdRAXoflNRfIV1VVa+RZwrFVpU=;
        b=D8FSFyl1QTG3K9CnOUbDY7L5zKwwG9c9gVaocrTeytqeY//xuPsc68iDuoVyhDBaBd
         Qq8GNhKshXSMsbp76JDFucqMqwBPZuNcs7ywTffLDt4HPbyx9PKuEOVwmYq0Jqhgeamd
         mFgLqH7s8YNcxzvC6WVjAb7bGl37hg7GUEyj2EqNZ5mcgkSQ1bKNZCAGuYbOnBSYzqRU
         0rL1mXjO40NaHCispFnrO+rVZqR4xBUsstDoIGK/cX3ljsrKbJ46r6gfSD76yd1Lu1U8
         e03QcKiPcexFiWyZuy7So219y6qFJp+5KRx2xtm5eNEng+akxgBc+r+IHcSScxSksoie
         Zv2g==
X-Gm-Message-State: AD7BkJIWIRuLE1x9lQPRuUzvCcr01cAv+JOU4nrjz2ty13t/ORFj5YHHtqrjH7XCbPzawpCEqCjinG5w4bmj6Q==
X-Received: by 10.112.171.163 with SMTP id av3mr958152lbc.145.1457010033241;
 Thu, 03 Mar 2016 05:00:33 -0800 (PST)
Received: by 10.112.34.162 with HTTP; Thu, 3 Mar 2016 05:00:03 -0800 (PST)
In-Reply-To: <20160301143954.GC12887@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288175>

On Tue, Mar 1, 2016 at 9:39 PM, Jeff King <peff@peff.net> wrote:
> +       if (need_shared_repository_from_config) {
> +               const char *var = "core.sharedrepository";
> +               const char *value;
> +               if (!git_config_get_value(var, &value))
> +                       the_shared_repository = git_config_perm(var, value);
> +               need_shared_repository_from_config = 0;
> +       }

If config cache is invalidated and reloaded by some crazy code (alias
code, most likely, but I didn't check), we could be in trouble. Is
there any clean way we could hook in git_config_clear() and reset
need_shared..  back  to 1 (or something of similar effect)? Or perhaps
maintain a "clear counter", increased at every clear, and we keep a
copy here, so we know if any more clear() has been called between
get_shared..() calls.

>         return the_shared_repository;
>  }

-- 
Duy
