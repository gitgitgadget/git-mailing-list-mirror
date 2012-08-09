From: Drew Northup <n1xim.email@gmail.com>
Subject: Re: Sync production with Git
Date: Wed, 8 Aug 2012 23:46:04 -0400
Message-ID: <CAM9Z-nkj0q9qb0pFU50HZc6Ka6ScUVD+wyROnq9NVf2fS03kww@mail.gmail.com>
References: <1344431484059-7564617.post@n2.nabble.com>
	<vpqlihpbh4f.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, David Aguilar <davvid@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: kiranpyati <kiran.pyati@infobeans.com>
X-From: git-owner@vger.kernel.org Thu Aug 09 05:46:26 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SzJhT-0004iD-2w
	for gcvg-git-2@plane.gmane.org; Thu, 09 Aug 2012 05:46:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754636Ab2HIDqO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Aug 2012 23:46:14 -0400
Received: from mail-bk0-f46.google.com ([209.85.214.46]:62002 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754630Ab2HIDqG (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Aug 2012 23:46:06 -0400
Received: by bkwj10 with SMTP id j10so2721bkw.19
        for <git@vger.kernel.org>; Wed, 08 Aug 2012 20:46:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=pSjSDi+L4TFIGAJzqX0yAxaebXq1KtUwxZAXj98z0nc=;
        b=wj/Osv/d6w7s8k5JbxshSZLKdT8kIg+eZ7zjhb7N41IQc+mgAVdSRq7jG9uQ9DhpqO
         etojquhQukZHa+c8WJSTuKj+DJOaiyNVT5UuxYQ1n1QX5ENkmXBTrxZLVx5YMcs0VfRu
         4n+6EIYtfvCYIMgNRQfGg9fNlpEwKXgq0aBxNpb8yJbMm8Ro9czdj8yNiqWSUZf5szWq
         JotBxHN1TzTS4N7a5/KAoaWvlYRL1nHhwRTZSo3ca4k3OGZ92mNFHkrh0kIk0YCxUNBI
         JN1k3AfUhBqErRa1hOA4nvKEL2MYWp0dEyFWqJDOJnyOhLRk9/5BUrnEiZjrPk52SVqq
         S2oQ==
Received: by 10.204.10.70 with SMTP id o6mr8453894bko.31.1344483964795; Wed,
 08 Aug 2012 20:46:04 -0700 (PDT)
Received: by 10.204.27.24 with HTTP; Wed, 8 Aug 2012 20:46:04 -0700 (PDT)
In-Reply-To: <vpqlihpbh4f.fsf@bauges.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203146>

On Wed, Aug 8, 2012 at 10:20 AM, Matthieu Moy
<Matthieu.Moy@grenoble-inp.fr> wrote:
> kiranpyati <kiran.pyati@infobeans.com> writes:
>
>> We want a way to seamlessly sync production and Git.
>
> You should be aware that Git was not designed for this scenario. The
> usual flow with Git (and actually with most revision control systems),
> is to do the development with Git, then use your build system to
> generate a package that can be used in production (e.g. generate a
> .tar.gz, or a .jar, or whatever your platform needs), and then install
> this package on your production server.

As I mentioned several days too late on a previous thread, the
assumption of formal packaging does not fit more than a few scenarios.
Certainly generating a tarfile sounds like a more reasonable solution
in many cases, but that requires discipline and plausible
deniability--you won't have a way of detecting if somebody didn't
follow the "official" deployment path. It is a sad fact that revision
control is probably the most sane way to detect this and deal with it
appropriately (without loosing work).

> It can be tempting, however, to use your revision control system as a
> deployment tool, so that an update on the production server be as simple
> as "git pull". But in real-life applications, it usually has to be more
> complicated: do you need to generate some files after you fetch the
> latest version of the source? Do you need to update your database?

If you are dealing with something updatable by just dropping a tar
file on it and walking away then a simple "git pull" will do just fine
(provided permissions and ACLs are set appropriately). If any of those
other concerns apply then you aren't talking about a simple file
update--you are talking about an application upgrade.

(Note: If you are using extended ACLs on a LINUX filesystem such as
ext2, ext3, or ext4, you won't have to worry about the git pull
flattening those--if you set them correctly--as that data is not part
of the content and container information that GIT tracks.)

> Isn't
> the .git/ directory harmfull here (e.g. do I want the full history
> source of my project to be visible worldwide if this is a
> webapplication?) ...

If you have configured your webserver correctly this is not an issue.

> If you insist in using Git for deployment, then you should absolutely
> stick to it. Whether for deployment or for anything else, trying to send
> changes using both Git and other mechanism (e.g. uploading files
> directly to a working tree as you did) puts you in trouble 99.9% of the
> cases.
>
> In your case, the damage is already done. If I were you, I'd do
> something like
>
> <do some backup>
> <make sure the backup is OK>
> <think twice "will I be able to restore the backup if it goes wrong?">
> $ git fetch origin
> $ git reset --hard origin/master
>
> (actually, if I were you, I'd try reproducing the situation on a
> non-production server first)

Before doing this, do a "git diff -b -w" (ignoring whitespace changes)
to see how big the damage is and extract patches.

If you've planned things out well you won't be using the same branch
in production that you use for general development and therefore will
have the ability to use GIT to help get the changes made directly on
the production system into a temporary branch on another system for
proper merging, testing, and QA.

> "git fetch" will download the revisions from the remote server, which
> should be the repository where the version you want to run is located.
> "git reset --hard" will discard any local change (committed or not) you
> may have, and set your local working tree to the latest version in the
> master branch of the remote repository. You may need a "git clean" to
> remove untracked files too.

Then you can safely hard reset to the commit just prior the divergence
and pull the changes onto the production system--re-applying those
changes you discovered in the "git diff -b -w" step on a developer's
system first, in a temporary branch, before doing the reset, merging
back to development, etc.

So, in conclusion, this is a situation that can be dealt with if one
keeps his wits about him.

-- 
-Drew Northup
--------------------------------------------------------------
"As opposed to vegetable or mineral error?"
-John Pescatore, SANS NewsBites Vol. 12 Num. 59
