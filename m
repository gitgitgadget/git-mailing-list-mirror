From: Ray Chen <rchen@cs.umd.edu>
Subject: Re: [PATCH/RFC] git-svn: New flag to add a file in empty directories
Date: Wed, 18 May 2011 06:46:25 -0400
Message-ID: <BANLkTi=of41DdZAqxAZkgjuuqo3bVpjexA@mail.gmail.com>
References: <1305669635-10861-1-git-send-email-rchen@cs.umd.edu> <4DD373CD.6010607@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Eric Wong <normalperson@yhbt.net>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Wed May 18 12:46:53 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QMeHE-0008WS-ON
	for gcvg-git-2@lo.gmane.org; Wed, 18 May 2011 12:46:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756974Ab1ERKqq convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 18 May 2011 06:46:46 -0400
Received: from mail-yi0-f46.google.com ([209.85.218.46]:64587 "EHLO
	mail-yi0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756943Ab1ERKqp convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 18 May 2011 06:46:45 -0400
Received: by yia27 with SMTP id 27so481124yia.19
        for <git@vger.kernel.org>; Wed, 18 May 2011 03:46:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:sender:in-reply-to:references:from
         :date:x-google-sender-auth:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=Z8MpbSTcvkj1kMcMhhAg/RheHZGdoEsi5xeClMjxSc0=;
        b=eg0ZUlGz2Wx2skhCuCEK9h4oKFY2BptB7w3wAa775myhD669PRFucGeGBIi3a9URgB
         vP4Ktufk9CKZKWALzgQAM5uwrNAiazi5DliYOJu/5qmvJbeKWWAAf1MFALYdmHT6Z2sr
         MZ3ULknZDCXzQYvMYgKMPvAvknNZqvWEq9YSg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:from:date
         :x-google-sender-auth:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        b=Dz5jFweM+xQhBgFzUmxc9z2PhgMzCa600Cc/zRcBbdo5xINr9cUmnBNqtUlqIEFkBb
         h34p9/FgR0EMx2rAEvq5pPmAPwcT0DKTJbMXic+Dw6KUZQcOY42Aj/+KM+iFXFgF/DqQ
         fvwS0lZ/dhBCSHgZJnA8ryR5jAZULnfikb/ME=
Received: by 10.236.154.42 with SMTP id g30mr1832326yhk.72.1305715605082; Wed,
 18 May 2011 03:46:45 -0700 (PDT)
Received: by 10.236.111.44 with HTTP; Wed, 18 May 2011 03:46:25 -0700 (PDT)
In-Reply-To: <4DD373CD.6010607@alum.mit.edu>
X-Google-Sender-Auth: LuB72vfAV9gM-YynVRkLg6qcjpM
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173870>

On Wed, May 18, 2011 at 3:22 AM, Michael Haggerty <mhagger@alum.mit.edu=
> wrote:
>
> I'm not familiar enough with the code to critique your code, but I ha=
ve
> some questions/comments about the feature's intended behavior:
>
> 1. What happens if a previously empty directory is deleted from
> Subversion? =A0It seems to me that consistency would demand that the
> placeholder file be deleted so that git also forgets about the
> directory. =A0On the other hand, if the user has edited the placehold=
er
> file since it was created, it might be advisable to emit a warning or=
 error.
>
When directories are deleted from a Subversion repository (empty or
not), the corresponding Git directory and all its constituent files
are removed one by one.  This takes care of any placeholder files that
may have been added.

This happens inside SVN::Git::Fetcher::delete_entry around line 4210.

> 2. What happens if, in Subversion, content is added to a previously
> empty directory? =A0Is the placeholder left around?
>
True, the placeholder sticks around in this case.  It wouldn't be hard
to track when a placeholder file is generated and remove it when it's
no longer needed.

Tracking the placeholder files would also be useful for namespace
collisions.  For example, if a Subversion repository adds a .gitignore
file to a previously committed empty directory.  The Subversion add
would need to be translated into a Git modification.  I'm not sure how
to store this information in the long-term tracking case, though.

> 3. I believe that this feature would be useful to people who are
> tracking a Subversion repository over time (not just for full
> migrations). =A0What happens if the user sometimes uses the new optio=
ns
> and sometimes not? =A0Are the missing directories that have "accumula=
ted"
> since the last invocation with --preserve-empty-dirs all added in the
> first commit resulting from a later use of --preserve-empty-directori=
es,
> or are they skipped forever? =A0I'm talking about this scenario:
>
> Subversion =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 git
> ---------- =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ---
> Add empty directory "a"
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 git svn fetch=
 --preserve-empty-dirs
> Add empty directory "b"
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 git svn fetch
> Add empty directory "c"
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 git svn fetch=
 --preserve-empty-dirs
>
> After the third "git svn fetch", does the git repository contain
> directory "b"?
>
In this case, the git repository would not contain the "b" directory,
but it would exist in the user's working copy without a placeholder
file.  I can only think of two situations when this is inappropriate.
=46irst, if the user checks out earlier revisions, the empty directorie=
s
would persist.  Second, if anybody clones the Git repository, they'd
be missing the empty directories.

How problematic are these two cases?  I think re-fetching everything
from the Subversion repository is the only way to fix this.

If support for long-term tracking is deemed desirable, then maybe this
feature should be on by default.  Otherwise, you increase the chance
that repository data will be irrevocably damaged.

- Ray
