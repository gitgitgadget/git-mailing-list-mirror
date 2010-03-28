From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: `git check-attr' problems & questions
Date: Sat, 27 Mar 2010 20:42:08 -0500
Message-ID: <20100328014208.GA23015@progeny.tock>
References: <m3iq8jn3ar.fsf@winooski.ccs.neu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Eli Barzilay <eli@barzilay.org>
X-From: git-owner@vger.kernel.org Sun Mar 28 03:42:36 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NvhWL-0004Ek-A9
	for gcvg-git-2@lo.gmane.org; Sun, 28 Mar 2010 03:42:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750756Ab0C1BmQ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 27 Mar 2010 21:42:16 -0400
Received: from mail-yw0-f172.google.com ([209.85.211.172]:33322 "EHLO
	mail-yw0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750742Ab0C1BmP (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Mar 2010 21:42:15 -0400
Received: by ywh2 with SMTP id 2so4270822ywh.33
        for <git@vger.kernel.org>; Sat, 27 Mar 2010 18:42:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=mX7is+bMbG1tpb1+t6cuc0nouoqz8PGmTXtXNITUS5g=;
        b=vsv3GvOkFWKZlMKxAdfaeUdxuGW+f2NdZWrmA+9EaMhDIWgcC7z70LelNhY8rFI7Al
         qh3DkFoJLWQZbrqd1diHItlsY00XsTiiG3D8MfephhkVw72DmF1+IrXT33eS8MPmCycA
         xkTFX33YAqBA6IhsGBWhIxvqYwnXD7IQqCYQs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=fI2ptoxnRmKniFoWX9+FULTPcxehW80N8LhufIYhn0d8c100HFCPl0HiQVrwgmscyG
         q/T78fXbSLopd57uvS6pNfgtPwG6eU58pjNnd4WRz3yWeTFakvXpm2C6qaALYN59TptK
         6NVvZF2kcLqLf0s60pCeaWUe4caE4AQOm0akQ=
Received: by 10.101.144.25 with SMTP id w25mr5675830ann.137.1269740533501;
        Sat, 27 Mar 2010 18:42:13 -0700 (PDT)
Received: from progeny.tock (wireless-207-194.uchicago.edu [128.135.207.194])
        by mx.google.com with ESMTPS id 21sm2378634iwn.11.2010.03.27.18.42.12
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 27 Mar 2010 18:42:12 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <m3iq8jn3ar.fsf@winooski.ccs.neu.edu>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143370>

Hi,

[quoted text reordered for convenience]

Eli Barzilay wrote:

> I'm trying to use .gitattributes to use some custom properties that w=
e
> have in an svn repository which is migrating to git,
[...]
> So my first question is -- am I missing something obvious?  It almost
> looks like `check-attr' is intended only for low-level use...

Yep.  It=E2=80=99s listed under =E2=80=9Cpurehelpers=E2=80=9D (Internal=
 helper commands) in
command-list.txt and hence git(1).  I suspect a good place to put
a user-visible equivalent would be a future =E2=80=98git ls=E2=80=99 co=
mmand [1].

Therefore...

> Fixing the first problem seems like it would be easy with a quick
> shell script (maybe even with just an alias),

If it proves pleasant to use, it would be very nice if you could send
a copy of such a shell script after a while.  Experiments like this
are the foundation of a good UI.

> 2. I'm also trying to use an attribute on a hook script on the server
>    (with the idea that email notifications are sent according to the
>    set of modified files) -- but it looks like `git check-attr'
>    doesn't work on a bare repository.

Current =E2=80=98git check-attr=E2=80=99 reads its attributes from actu=
al .gitattribute
files in the work tree first and then examines the versions registered
in the index.  So the secret is to read the .gitattribute files you car=
e
about into a temporary index file --- e.g., something like this.

 : "Usage: $0 commit check-attr-args" &&

 GIT_INDEX=3Dtmp-index git read-tree --reset -i "$1" &&
 shift &&
 GIT_INDEX=3Dtmp-index git check-attr "$@" &&
 rm tmp-index

Ideally, check-attr should learn an option to set a different policy
(e.g., index-only) with git_attr_set_direction(), but that is a
different story.

>    instead of showing an error, it actually succeeds after
>    showing that the attribute is "unspecified".

Probably it should learn to error out when it expects to use a work
tree but there is none.  git_attr_set_direction() does this.

> And the last question -- is there anything that does something like
> this customized email notifications that I'm trying to do?  (That is:
> an attribute that determines recipients, then a `post-receive' hook
> that builds a list of modified files, grabs all the corresponding
> values of this attributes, and that's makes up the recipient list to
> notify.)

Not that I know of.

HTH,
Jonathan

[1] I read the name from here:
http://thread.gmane.org/gmane.comp.version-control.git/136360
That series went in a different direction, though.
http://thread.gmane.org/gmane.comp.version-control.git/141678
