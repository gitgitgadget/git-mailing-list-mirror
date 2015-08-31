From: David Turner <dturner@twopensource.com>
Subject: Re: [PATCH v6 1/2] worktree: add 'for_each_worktree' function
Date: Mon, 31 Aug 2015 15:54:17 -0400
Organization: Twitter
Message-ID: <1441050857.25570.21.camel@twopensource.com>
References: <1440961839-40575-1-git-send-email-rappazzo@gmail.com>
	 <1440961839-40575-2-git-send-email-rappazzo@gmail.com>
	 <CAPig+cTHZrQn8LpfftcsAQhFAykgDorbR97tkcuSCFYD_ngs9g@mail.gmail.com>
	 <1441046674.25570.15.camel@twopensource.com>
	 <CAPig+cTwtKgm4U64nZhRY+F5HuQvKk1RLdyAsS6sJfYp85go2A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Michael Rappazzo <rappazzo@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Git List <git@vger.kernel.org>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Mon Aug 31 21:54:28 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZWV9v-00015n-0Z
	for gcvg-git-2@plane.gmane.org; Mon, 31 Aug 2015 21:54:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753667AbbHaTyW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 31 Aug 2015 15:54:22 -0400
Received: from mail-qk0-f172.google.com ([209.85.220.172]:35646 "EHLO
	mail-qk0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751901AbbHaTyV (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 31 Aug 2015 15:54:21 -0400
Received: by qkcj187 with SMTP id j187so14334465qkc.2
        for <git@vger.kernel.org>; Mon, 31 Aug 2015 12:54:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:content-type:mime-version
         :content-transfer-encoding;
        bh=4KCg+JOAujGsOezx0IrqEWqadA7/l/IBvk6fkPwBJco=;
        b=nLdAkfpPEESnm8E6zwLl5l2piZ3dPqeBky/ZytXrnNK//VsapaNrCVPqtG2uFXPZaU
         3g0wMtuts9cwFxDWQ57GNnNrsoUA9CB4JyV27ErhCcckgf6Zl4balBrHfZnL+fJwZQKy
         3w5A3K5SO3ATmMlxwhGczHTLEWdSer/VmoqIGMdSMIoh9XYUeLataQC7tvRScG7Plpix
         pjVjYEeea+/dfWeGeeNkNCJjusCrnbYVzQgJAwwEzZq2nmFB5tGH5nLiX8Z7XTuB0R9T
         34xQ7vZE08cMze5DmmMVO458Gwn4s4r8uduJL9khllHZX/MUSTKR40sX+vh94S4rEEPP
         lH9w==
X-Gm-Message-State: ALoCoQlGBZ4KG7Cj+L6llTtKzDpr/zuGFkt+UsRKg3Dj+xVpp+Xn7pAyVVpCT9rh0lAn7MWr1Fn+
X-Received: by 10.55.41.10 with SMTP id p10mr12365002qkh.28.1441050860963;
        Mon, 31 Aug 2015 12:54:20 -0700 (PDT)
Received: from ubuntu ([192.133.79.145])
        by smtp.gmail.com with ESMTPSA id o96sm9421001qgd.23.2015.08.31.12.54.19
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 31 Aug 2015 12:54:20 -0700 (PDT)
In-Reply-To: <CAPig+cTwtKgm4U64nZhRY+F5HuQvKk1RLdyAsS6sJfYp85go2A@mail.gmail.com>
X-Mailer: Evolution 3.12.11-0ubuntu3 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276926>

On Mon, 2015-08-31 at 15:03 -0400, Eric Sunshine wrote:
> On Mon, Aug 31, 2015 at 2:44 PM, David Turner <dturner@twopensource.com> wrote:
> > On Mon, 2015-08-31 at 01:11 -0400, Eric Sunshine wrote:
> >> Stepping back a bit, is a for-each-foo()-style interface desirable?
> >> This sort of interface imposes a good deal of complexity on callers,
> >> demanding a callback function and callback data (cb_data), and is
> >> generally (at least in C) more difficult to reason about than other
> >> simpler interfaces. Is such complexity warranted?
> >>
> >> An alternate, much simpler interface would be to have a function, say
> >> get_worktrees(), return an array of 'worktree' structures to the
> >> caller, which the caller would iterate over (which is a common
> >> operation in C, thus easily reasoned about).
> >>
> >> The one benefit of a for-each-foo()-style interface is that it's
> >> possible to "exit early", thus avoiding the cost of interrogating
> >> meta-data for worktrees in which the caller is not interested,
> >> however, it seems unlikely that there will be so many worktrees linked
> >> to a repository for this early exit to translate into any real
> >> savings.
> >
> > The other benefit is that there is no need to worry about deallocating
> > the list.  But that might be too minor to worry about.
> 
> Probably. The burden of having to deallocate the returned array seems
> quite minor compared to the complexity of the callback function
> approach.
> 
> Also, unstated but implied with the suggestion of a get_worktrees()
> function was that there would be a corresponding free_worktrees()
> function to make cleanup easy.

That's fine with me.  Sorry for leading you down the wrong path,
Michael.
