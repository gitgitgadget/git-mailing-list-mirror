From: Johan Herland <johan@herland.net>
Subject: Re: [PATCH 07/18] builtin/notes.c: Split notes ref DWIMmery into a separate function
Date: Thu, 7 Oct 2010 15:56:13 +0200
Message-ID: <201010071556.14555.johan@herland.net>
References: <1285719811-10871-1-git-send-email-johan@herland.net> <1285719811-10871-8-git-send-email-johan@herland.net> <20101005155053.GH12797@burratino>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, bebarino@gmail.com, gitster@pobox.com
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu Oct 07 15:56:21 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P3qxF-0005va-3F
	for gcvg-git-2@lo.gmane.org; Thu, 07 Oct 2010 15:56:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760634Ab0JGN4I (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Oct 2010 09:56:08 -0400
Received: from mail.mailgateway.no ([82.117.37.108]:54822 "EHLO
	mail.mailgateway.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754548Ab0JGN4G (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Oct 2010 09:56:06 -0400
Received: from dslb-088-073-123-190.pools.arcor-ip.net ([88.73.123.190] helo=epsilon.localnet)
	by mail.mailgateway.no with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.60 (FreeBSD))
	(envelope-from <johan@herland.net>)
	id 1P3qx1-000CWa-Fa; Thu, 07 Oct 2010 15:56:03 +0200
User-Agent: KMail/1.13.2 (Linux/2.6.32-24-generic; KDE/4.4.2; i686; ; )
In-Reply-To: <20101005155053.GH12797@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158400>

On Tuesday 5. October 2010 17.50.53 Jonathan Nieder wrote:
> Johan Herland wrote:
> > +static void expand_notes_ref(struct strbuf *sb)
> > +{
> > +	if (!prefixcmp(sb->buf, "refs/notes/"))
> > +		return; /* we're happy */
> > +	else if (!prefixcmp(sb->buf, "notes/"))
> > +		strbuf_insert(sb, 0, "refs/", 5);
> > +	else
> > +		strbuf_insert(sb, 0, "refs/notes/", 11);
> > +}
> 
> Aside: I'm not sure this is the most convenient rule to use after all.

FTR, that rule is not introduced by this patch, the patch merely moves it into 
a separate function.

> Example:
> 
>  $ git log --notes-ref=charon/notes/full
>  fatal: unrecognized argument: --notes-ref=charon/notes/full
>  $ git log --show-notes=charon/notes/full
>  warning: notes ref refs/notes/charon/notes/full is invalid
> ...
>  $ git log --show-notes=remotes/charon/notes/full
>  warning: notes ref refs/notes/remotes/charon/notes/full is invalid
> ...
>  $ git log --show-notes=refs/remotes/charon/notes/full -1
>  commit 16461e8e5fc5b2dbe9176b9a8313c395e1e07304
>  Merge: c3e5a06 79bd09f
>  Author: Junio C Hamano <gitster@pobox.com>
>  Date:   Thu Sep 30 16:02:27 2010 -0700
> 
>      Merge branch 'il/remote-fd-ext' into pu
> 
>      * il/remote-fd-ext:
>        fixup! git-remote-fd
> 
>  Notes (remotes/charon/notes/full):
>      Pu-Overview:
>          What's cooking in git.git (Sep 2010, #07; Wed, 29)
>  $

Indeed, if you keep notes refs outside refs/notes, the current behaviour is 
not very user-friendly. So far, we've required all notes refs to be within 
refs/notes. (See for example init_notes_check() in builtin/notes.c, which 
refuses to work with notes refs outside 'refs/notes/', hence was probably the 
reason for adding the above code in the first place.)

I guess this moves us towards the discussion of how to handle remote notes 
refs and how to synchronize them on fetch/push. In short, if we want to keep 
notes refs outside of refs/notes (e.g. in refs/remotes/foo/notes), we need to 
change this part of the code.

> And now that I think of it, the revision args parser uses its own code
> for this...

I assuming you're talking about the revision args parser's DWIMing of "foo" 
into the first existing ref in the following list:

1. $GIT_DIR/foo
2. refs/foo
3. refs/tags/foo
4. refs/heads/foo
5. refs/remotes/foo
6. refs/remotes/foo/HEAD

If we want to reuse this DWIMery, we obviously want a different list of "auto-
completions". Maybe something like:

1. refs/notes/foo
2. refs/remote-notes/foo (depends on how we organize remote notes refs)
3. ?

> Regardless, this patch is a step in the right direction imho.

Thanks, I expect future patches to change this code in order to deal with 
remote notes refs. For the purposes of the current patch series, I will assume 
that all notes refs live under refs/notes.


...Johan

-- 
Johan Herland, <johan@herland.net>
www.herland.net
