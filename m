From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [BUG] "git --literal-pathspecs blame" broken in master
Date: Fri, 25 Oct 2013 11:16:08 +0700
Message-ID: <CACsJy8Aw9KyeWqgC5KQmqPrzD7J4Gga1ibDTvfNQFaVN303U9g@mail.gmail.com>
References: <20131025034947.GA4959@sigill.intra.peff.net> <20131025040436.GA11810@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Oct 25 06:16:45 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VZYpG-0005GP-Tz
	for gcvg-git-2@plane.gmane.org; Fri, 25 Oct 2013 06:16:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751157Ab3JYEQj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Oct 2013 00:16:39 -0400
Received: from mail-qe0-f53.google.com ([209.85.128.53]:64151 "EHLO
	mail-qe0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750878Ab3JYEQi (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Oct 2013 00:16:38 -0400
Received: by mail-qe0-f53.google.com with SMTP id cy11so2030918qeb.40
        for <git@vger.kernel.org>; Thu, 24 Oct 2013 21:16:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=e/PSnuSgs2AM50548z+bde2E7A1dNn1lI4r9Is74Wx0=;
        b=J/a5Qa+FAPtzKNupq1pCGxSKHQcj9bgZEEw7ISmXfOlBfE5rfh3dxNpBf7inNZLWoF
         Tz1QSSkbiqnVfhJkE7XmmvMfKBwG6Y98ztlyrg+PbOhEnV4HrLf9BtY9mDkiSw+20HJE
         IU0iy57ZSAXdlh7fxmy8jvHc2YYr1gbdoQuMfQ0NCoY0Wld3ucCnSaQ1xJjmJGgl4Qy9
         rcIVjWlIZaYoIrpaK9MVivgZbXOLGpB+pT2kiUf0evgkJqm3fwAhB5gS6W95wwHlG0VK
         osuzwVsIW/En5tEtWAD0H7zX5PSQ0vOklf/GrQ3rMlPgt3/LnIA+lV9lREorFHbulTre
         Or0w==
X-Received: by 10.224.7.194 with SMTP id e2mr8775192qae.46.1382674598176; Thu,
 24 Oct 2013 21:16:38 -0700 (PDT)
Received: by 10.96.27.202 with HTTP; Thu, 24 Oct 2013 21:16:08 -0700 (PDT)
In-Reply-To: <20131025040436.GA11810@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236654>

On Fri, Oct 25, 2013 at 11:04 AM, Jeff King <peff@peff.net> wrote:
> On Thu, Oct 24, 2013 at 11:49:47PM -0400, Jeff King wrote:
>
>> We get another change with a16bf9d (pathspec: make --literal-pathspecs
>> disable pathspec magic, 2013-07-14), which I would think would fix
>> things, but doesn't.
>>
>>   $ git blame ':(foo)bar'
>>   fatal: Invalid pathspec magic 'foo' in ':(foo)bar'
>>   $ git --literal-pathspecs blame ':(foo)bar'
>>   fatal: :(foo)bar: pathspec magic not supported by this command: 'literal'
>>
>> The first one remains good, but the second one is still broken. I
>> haven't dug further yet, but I thought it might be a bit more obvious to
>> you.
>
> Hmm. Is the fix as simple as:
>
> diff --git a/builtin/blame.c b/builtin/blame.c
> index 56e3d6b..1c2b303 100644
> --- a/builtin/blame.c
> +++ b/builtin/blame.c
> @@ -408,7 +408,7 @@ static struct origin *find_origin(struct scoreboard *sb,
>         paths[0] = origin->path;
>         paths[1] = NULL;
>
> -       parse_pathspec(&diff_opts.pathspec, PATHSPEC_ALL_MAGIC, 0, "", paths);
> +       parse_pathspec(&diff_opts.pathspec, PATHSPEC_ALL_MAGIC & ~PATHSPEC_LITERAL, 0, "", paths);
>         diff_setup_done(&diff_opts);
>
>         if (is_null_sha1(origin->commit->object.sha1))
>
> All of the GUARD_PATHSPEC calls indicate that everybody understands
> PATHSPEC_LITERAL. It is not technically true that git-blame understands
> the literal pathspec magic:
>
>   $ git blame -- ':(literal)revision.c'
>   fatal: no such path ':(literal)revision.c' in HEAD
>
> but that is a separate bug (that blame considers the argument as a path
> first before feeding it to the pathspec machinery). The patch above does
> not fix that, but AFAICT it does not make anything worse.

I did consider this change but dropped it because there are more
parse_pathspec() calls with PATHSPEC_ALL_MAGIC as mask. Thanks for
bringing up ":(literal)".  I guess we need to change prefix_pathspec()
to set PATHSPEC_LITERAL only when :(literal) is present, not when
--literal-pathspecs is used.
-- 
Duy
