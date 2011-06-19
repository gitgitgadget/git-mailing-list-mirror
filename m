From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v2 16/20] transport-helper: update ref status after push
 with export
Date: Sun, 19 Jun 2011 18:25:25 -0500
Message-ID: <20110619232525.GH23893@elie>
References: <1308496725-22329-1-git-send-email-srabbelier@gmail.com>
 <1308496725-22329-17-git-send-email-srabbelier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Git List <git@vger.kernel.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Ramkumar Ramachandra <artagnon@gmail.com>
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 20 01:25:41 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QYRN3-00081Z-RU
	for gcvg-git-2@lo.gmane.org; Mon, 20 Jun 2011 01:25:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754866Ab1FSXZc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 19 Jun 2011 19:25:32 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:36773 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754790Ab1FSXZb (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 19 Jun 2011 19:25:31 -0400
Received: by iwn6 with SMTP id 6so744916iwn.19
        for <git@vger.kernel.org>; Sun, 19 Jun 2011 16:25:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=xAh3sy1hJSydLPeFCa2Rn1twOMGJC3Ya4ENTAwKtgoU=;
        b=r31q/nj21Nwddw29jDC0qLW0szVWoxoOe754isa5kKdWQjM1+Pyzq/4taUeRTnrxD+
         fmq5uQwALzSYWoM1LNexHpJFAhcIQF9o83ZKxzXgQBodXGZslgO8Migj+Rh3jmd5QBzt
         xH5rLqBNsu4B0ythhwnY9h8GgG90pzH+YkaZ8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=FL2/8gy9sfFxWta/3rA7OqV3xUxj1ziuHrjwK8OJ/lWQKdonbS/qv5Y/RPf62UYGBF
         3vUG79lbjz6XEbATCV3rIu9FI2UVnPsv+JyhZPyUqGzrj2XGkDMDVDEmdVt2R+InH7S1
         k16mrf54n5LeKhS9oKhPbulCDhxkj3C7/UGHE=
Received: by 10.43.59.142 with SMTP id wo14mr5679221icb.373.1308525931071;
        Sun, 19 Jun 2011 16:25:31 -0700 (PDT)
Received: from elie (adsl-69-209-50-158.dsl.chcgil.sbcglobal.net [69.209.50.158])
        by mx.google.com with ESMTPS id hw7sm4940709icc.15.2011.06.19.16.25.28
        (version=SSLv3 cipher=OTHER);
        Sun, 19 Jun 2011 16:25:29 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1308496725-22329-17-git-send-email-srabbelier@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176040>

Sverre Rabbelier wrote:

>
> Signed-off-by: Sverre Rabbelier <srabbelier@gmail.com>
> ---
>
>   This time a proper implementation of this patch.

Nice. :)

I assume this still does not return "error <dst> <reason>" responses,
instead disconnecting the helper on error, which is fine but probably
worth mentioning.

> --- a/git-remote-testgit.py
> +++ b/git-remote-testgit.py
> @@ -148,11 +148,15 @@ def do_export(repo, args):
>      sys.stdout.flush()
>  
>      update_local_repo(repo)
> -    repo.importer.do_import(repo.gitdir)
> +    changed = repo.importer.do_import(repo.gitdir)
>  
>      if not repo.local:
>          repo.non_local.push(repo.gitdir)
>  
> +    for ref in changed:
> +        print "ok %s" % ref
> +    print
> +

The remote-helpers(1) manual says, concerning "push":

	When the push is complete, outputs one or more ok <dst> or
	error <dst> <why>?  lines to indicate success or failure of
	each pushed ref. The status report output is terminated by a
	blank line. The option field <why> may be quoted in a C style
	string if it contains an LF.

Ideally we would want "export" to also print all refs intended for
export, even if they did not actually change, but there's no obvious
way to get that information.  In the "not repo.local" case, seeing
which refs changed in .git/info/fast-import/<repo>.git like you do
here seems like a reasonable enough heuristic.

What happens if no ref changed (the "already up to date" case)?
