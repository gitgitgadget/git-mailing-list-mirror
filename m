From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [RFC PATCH 13/13] revert: Introduce --continue to continue the
 operation
Date: Tue, 21 Jun 2011 12:19:34 -0500
Message-ID: <20110621171933.GP15461@elie>
References: <1308661489-20080-1-git-send-email-artagnon@gmail.com>
 <1308661489-20080-14-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Daniel Barkalow <barkalow@iabervon.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 21 19:19:51 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QZ4c4-0001Di-HL
	for gcvg-git-2@lo.gmane.org; Tue, 21 Jun 2011 19:19:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757054Ab1FURTj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Jun 2011 13:19:39 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:63805 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756802Ab1FURTj (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Jun 2011 13:19:39 -0400
Received: by iyb12 with SMTP id 12so3022042iyb.19
        for <git@vger.kernel.org>; Tue, 21 Jun 2011 10:19:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=VU6Tz04VWfXW7O67n+m2I6KZCCYmgDNHC/N1j6Tw3bQ=;
        b=HijOGclyUeKObAlemc2LfyQWGaE3xnkE9w7Umtcfl2qFRDYpRywCLqCs08zZNKVhrl
         V+E8sAdlYOeDMH94sIsr1/B5VzbXI4VfIOTgCRzIXLw+cVnThOVvby/U0dtyYa9kib3V
         tR30xFQjZdp5C0qF0ibVxyPJRBf4xTeZmEOSk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=XLfrOzJp3+HZK3cfiJxUS2pXJke/7HaH7sI4C9PrU/aLSGXyEjqw1V72JEmNZYSfQd
         FHI2I7WBOihYv7ZGBA0bx0Kj6RucrMeXeGqcwvGj7Rz4ZH7pqSuUgpbMJYoRCoqz8kti
         PslMJQhY2e42FpkgHdVbt++TzX9ksDboq9wqo=
Received: by 10.42.142.3 with SMTP id q3mr7827406icu.243.1308676778332;
        Tue, 21 Jun 2011 10:19:38 -0700 (PDT)
Received: from elie (adsl-69-209-79-158.dsl.chcgil.ameritech.net [69.209.79.158])
        by mx.google.com with ESMTPS id a9sm1630232icy.18.2011.06.21.10.19.36
        (version=SSLv3 cipher=OTHER);
        Tue, 21 Jun 2011 10:19:37 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1308661489-20080-14-git-send-email-artagnon@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176176>

Ramkumar Ramachandra wrote:

> After resolving a conflict, the user has the option to continue the
> operation.

When reading this, I wonder: "does the user have that option or will
she gain that option after this patch?  And if the latter, what does
the UI look like?  And what is the purpose --- if I just cherry-picked
a commit and ran into a conflict, won't 'git commit' be good enough?"

> Mixing operations (cherry-pick and revert in the same
> todo_list) and command-line options are unsupported at this stage.

It's not obvious what this means.

> --- a/builtin/revert.c
> +++ b/builtin/revert.c
[...]
> @@ -614,6 +652,78 @@ static void format_todo(struct strbuf *buf, struct commit_list *todo_list,
>  	}
>  }
>  
> +static void read_populate_todo(struct commit_list **todo_list,
> +			struct replay_opts *opts)
> +{
> +	struct strbuf buf = STRBUF_INIT;
> +	enum replay_action action;
> +	struct commit *commit;
> +	struct commit_list *new_item;
> +	struct commit_list *cur = NULL;
> +	unsigned char commit_sha1[20];
> +	char sha1_abbrev[40];
> +	char *p;
> +	int insn_len = 0;
> +	char *insn;
> +	int fd;

The naive reader is not sure what this function is about and is
intimidated by its size.  (I know you have plans regarding that
already; just mentioning it so it doesn't get forgotten.)

> +		/* Verify that the action matches up with the one in
> +		   opts; we don't support arbitrary instructions */

I haven't reviewed the function in full, but this GNU-style comment
jumped out on the way down while scrolling.  I believe you already
know what comments should look like to be consistent with the rest
of the git codebase.

Ok, I've reached the end.  Probably some of these comments apply to
code that might be changed anyway, but still, hope that helps a
little.  And thanks for working on this.
