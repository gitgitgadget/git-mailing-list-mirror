From: Shawn Pearce <spearce@spearce.org>
Subject: Re: [RFC/WIP] Pluggable reference backends
Date: Mon, 10 Mar 2014 07:30:45 -0700
Message-ID: <CAJo=hJtiPgByhk9M4ZKD98DARzgeU6z2mmw7fcLTEbBza-_h6A@mail.gmail.com>
References: <531D9B50.5030404@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git discussion list <git@vger.kernel.org>,
	Jeff King <peff@peff.net>, Vicent Marti <tanoku@gmail.com>,
	Brad King <brad.king@kitware.com>,
	Johan Herland <johan@herland.net>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Mon Mar 10 15:31:15 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WN1EY-0005IW-JP
	for gcvg-git-2@plane.gmane.org; Mon, 10 Mar 2014 15:31:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753212AbaCJObJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Mar 2014 10:31:09 -0400
Received: from mail-we0-f181.google.com ([74.125.82.181]:44747 "EHLO
	mail-we0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752628AbaCJObH (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Mar 2014 10:31:07 -0400
Received: by mail-we0-f181.google.com with SMTP id q58so8712680wes.12
        for <git@vger.kernel.org>; Mon, 10 Mar 2014 07:31:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=spearce.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=Y/g9lhr3DPyLVd3UZyH6ylZnoSsP910Dg8WWHN3Gi7Q=;
        b=fywNde/cOnMYVO5utFSYWpmfl0zSCZ4HUEXDbhNe/crZ65PxTW8Shiuy9yUxsKYCqN
         cfyMULHzZvYpEEv7Ndj1CYuAmFnHmRLUAipAj0Um+Qk/HgiI32gYnS65RLIcn8yP+iQv
         JDj/OUBpo+qqCDNRjlt89HVCPur+X4NBaimwk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=Y/g9lhr3DPyLVd3UZyH6ylZnoSsP910Dg8WWHN3Gi7Q=;
        b=fYL3M6ONJfHXkLs3XV7hyvrcNBcebyQXnkw3csdH1IHtYDOByFU2013QucL6r0V57C
         XimNf5gwXJ3Wt9bTgPcDNj7jZjzepdUZwrPk50iOFPyqbxH1SfNWofyuKjrX4JY1E/fX
         Ch7Lf9qplujHkeRaH3RZ1aiOSfYCBeoThlzB/wkN/02ONt3qozC2NHhH9v0ey0bK1Bx/
         ZyTObmEdUGRplXJN4nkJOvVl4vWNk01NHg8EoKxgdVt9W8hoVmHWA9p3MeQ47EuUBl9J
         066kTcWJD9/VXK/8GToRJELM4vpN3VEF6bjoQl6I37Qepiyf7jeHUa64Wbf2V6XUKt2K
         ALgQ==
X-Gm-Message-State: ALoCoQkBDIc7/6wUhjy+4J3RIiT0RRMvMRg2Wky3TP+gHrFz3+NxXi5zyrX7oNor0OSTUElyUjqv
X-Received: by 10.180.109.77 with SMTP id hq13mr9387493wib.0.1394461865263;
 Mon, 10 Mar 2014 07:31:05 -0700 (PDT)
Received: by 10.227.7.133 with HTTP; Mon, 10 Mar 2014 07:30:45 -0700 (PDT)
In-Reply-To: <531D9B50.5030404@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243762>

On Mon, Mar 10, 2014 at 4:00 AM, Michael Haggerty <mhagger@alum.mit.edu> wrote:
> I have started working on pluggable ref backends.  In this email I
> would like to share my plans and solicit feedback.

Yay!

JGit already has pluggable ref backends, so it is good to see this
starting in git-core.

FWIW the Gerrit Code Review community is interested in this project.

> * Store references in a SQLite database, to get correct transaction
>   handling.

No to SQLLite in git-core. Using it from JGit requires building
SQLLite and a JNI wrapper, which makes JGit significantly less
portable. I know SQLLite is pretty amazing, but implementing
compatibility with it from JGit will be a big nightmare for us.

> * Reference transactions that can be used across multiple Git
>   commands.  Imagine,
>
>       export GIT_TRANSACTION=$(git transaction begin)
>       trap 'git transaction rollback' ERR
>       git foo ...
>       git bar ...
>       git baz ...
>       if ! git transaction commit
>       then
>           # Transaction failed; all references rolled back
>       else
>           # Transaction succeeded; all references updated atomically
>       fi
>       trap '' ERR
>       unset GIT_TRANSACTION
>
>   The "GIT_TRANSACTION" environment variable would tell git to read
>   from the usual references, overridden with any reference changes
>   that have occurred during the transaction, but write any changes
>   (including both old and new values) to the transaction.  The command
>   "git transaction commit" would verify that the old values listed in
>   the transaction still agree with the current values, and then make
>   all of the changes atomically.

Yay!

Gerrit Code Review really wants to get transactions implemented. So I
am very much in favor of trying to improve the situation in git-core.

We want not only a transaction over 2+ references in the same
repository, but we also want to perform transactions across
repositories. Consider a git submodule child and parent being updated
at the same time. We really want to update refs/heads/master in both
repositories atomically at the central server.

>   Such transactions could also be broadcast to mirrors when they are
>   committed to keep multiple Git repositories in sync.

Ooh, this would be very interesting.

> Git hosters [1] will be likely to take advantage of alternate
> reference backends pretty easily, because they know which tools touch
> their repositories and need only update those tools.  It is expected
> that alternate reference backends will be useful for hosters even if
> they don't become practical for end-users.

Alternate reference backends are absolutely useful to large hosters.
The loose reference format isn't very scalable. The packed-refs helps,
but you can do better. IIRC our android.googlesource.com reference
backend uses only 79 bytes per reference on average, including both
the name string and the value. This super compact format is easy to
hold in RAM for hundreds of busy repositories.

> For end-users it is important that their repository be readable by all
> of the tools that they use.  So if we want to make a new format a
> viable option for normal Git users (let alone make it the new default
> format), some coordination will be needed between all of the
> commonly-used Git implementations (git-core, libgit2, JGit, and maybe
> Dulwich, Grit, ...).  Whether or not this happens in real life depends
> on how advantageous the hypothetical new format is to Git users and is
> beyond the scope of this proposal.

It is sad we have this many implementations, but as one of the authors
(JGit) I am happy to at least see you are worrying about compatibility
with them.
