From: John Keeping <john@keeping.me.uk>
Subject: Re: [PATCH v3] Add git-grep threads param
Date: Tue, 27 Oct 2015 14:11:00 +0000
Message-ID: <20151027141100.GR19802@serenity.lan>
References: <1445862733-838-1-git-send-email-vleschuk@accesssoftek.com>
 <20151026193241.GO19802@serenity.lan>
 <6AE1604EE3EC5F4296C096518C6B77EE5D0FDAB9FC@mail.accesssoftek.com>
 <20151027115256.GQ19802@serenity.lan>
 <6AE1604EE3EC5F4296C096518C6B77EE5D0FDAB9FF@mail.accesssoftek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Victor Leschuk <vleschuk@gmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Victor Leschuk <vleschuk@accesssoftek.com>
X-From: git-owner@vger.kernel.org Tue Oct 27 15:11:24 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zr4yB-0001te-Hk
	for gcvg-git-2@plane.gmane.org; Tue, 27 Oct 2015 15:11:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932344AbbJ0OLT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Oct 2015 10:11:19 -0400
Received: from jackal.aluminati.org ([72.9.247.210]:55339 "EHLO
	jackal.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932320AbbJ0OLT (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Oct 2015 10:11:19 -0400
Received: from localhost (localhost [127.0.0.1])
	by jackal.aluminati.org (Postfix) with ESMTP id C1916CDA64B;
	Tue, 27 Oct 2015 14:11:17 +0000 (GMT)
X-Quarantine-ID: <cm+XDVtsQs4q>
X-Virus-Scanned: Debian amavisd-new at serval.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -1.001
X-Spam-Level: 
X-Spam-Status: No, score=-1.001 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, BAYES_20=-0.001] autolearn=no
Received: from jackal.aluminati.org ([127.0.0.1])
	by localhost (jackal.aluminati.org [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id cm+XDVtsQs4q; Tue, 27 Oct 2015 14:11:12 +0000 (GMT)
Received: from serenity.lan (chimera.aluminati.org [10.0.16.60])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by jackal.aluminati.org (Postfix) with ESMTPSA id DC2F7CDA648;
	Tue, 27 Oct 2015 14:11:02 +0000 (GMT)
Content-Disposition: inline
In-Reply-To: <6AE1604EE3EC5F4296C096518C6B77EE5D0FDAB9FF@mail.accesssoftek.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280264>

On Tue, Oct 27, 2015 at 06:54:16AM -0700, Victor Leschuk wrote:
> Hello John,
> 
> >> This thought also crossed my mind, however we already pass grep_opt to
> >> start_threads() function, so I think passing it to wait_all() is not
> >> that ugly, and kind of symmetric. And I do not like the idea of
> >> duplicating same information in different places. What do you think?
> 
> > The grep_opt in start_threads() is being passed through to run(), so it
> > seems slightly different to me.  If the threads were being setup in
> > grep.c (as opposed to builtin/grep.c) then I'd agree that it belongs in
> > grep_opt, but since this is local to this particular user of the grep
> > infrastructure adding num_threads to the grep_opt structure at all feels
> > wrong to me.
> 
> > Note that I wasn't suggesting passing num_threads as a parameter to
> > wait_all(), but rather having it as global state that is accessed by
> > wait_all() in the same way as the `threads` array.
> 
> > If we rename use_threads to num_threads and just use that, then we only
> > have the information in one place don't we?
> 
> Yeah, I understood your idea. So we parse config_value directly to 
> 
> static int num_threads; /* old use_threads */

Presumably this is:

	static int num_threads = -1;

so that the default behaviour continues to work correctly.

> And use it internally in builtin/grep.c. I think you are right.
> 
> Looks like grep_cmd_config() is the right place to parse it. Something like:
> 
> --- a/builtin/grep.c
> +++ b/builtin/grep.c
> @@ -267,6 +267,8 @@ static int wait_all(struct grep_opt *opt)
>  static int grep_cmd_config(const char *var, const char *value, void *cb)
>  {
>         int st = grep_config(var, value, cb);
> +       if (thread_config(var, value, cb) < 0)
> +               st = -1;
>         if (git_color_default_config(var, value, cb) < 0)
>                 st = -1;
>         return st;
> 
> What do you think?

I'd be tempted to open code the "grep.threads" case in this function
rather than introducing a helper for a single variable, but I don't
think it matters either way.  This looks good.
