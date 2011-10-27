From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [PATCH 2/2] pack-objects: optimize "recency order"
Date: Thu, 27 Oct 2011 23:49:14 +0200
Message-ID: <CACBZZX6ZWOF=j-k8o-4NHmjS2HpyS+PmKjJh_QKevWurBf9pbA@mail.gmail.com>
References: <1310084657-16790-1-git-send-email-gitster@pobox.com>
 <1310084657-16790-3-git-send-email-gitster@pobox.com> <CACBZZX6Ss4jLtdrDhLUNKCUjEHjHHKzfv-LMkOyTPDhRUXm4sQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Oct 27 23:49:41 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RJXpU-0003EC-QK
	for gcvg-git-2@lo.gmane.org; Thu, 27 Oct 2011 23:49:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753415Ab1J0Vtg convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 27 Oct 2011 17:49:36 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:63863 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753296Ab1J0Vtf convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 27 Oct 2011 17:49:35 -0400
Received: by bkbzt19 with SMTP id zt19so2385608bkb.19
        for <git@vger.kernel.org>; Thu, 27 Oct 2011 14:49:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=we4Y9drkto20JBA1gDnfERF1oztg2JVthBr05T1Cc2U=;
        b=okOjjeC/qJN0q/zxeH1rCynJN/GAgvsgAGeAnc4qvSQjXfk6IQUjKDjDcE3MJ5oIze
         ZlNYByRsUueTDPRb3pirGp16+6QU+BUzzcax6l5wRT4CKVcilGFvGh8h97cPYbHrIhKp
         2gDbvrS8O4myQFqPn5nbU8CEJqeiJHZE25jF4=
Received: by 10.204.10.81 with SMTP id o17mr866656bko.78.1319752174205; Thu,
 27 Oct 2011 14:49:34 -0700 (PDT)
Received: by 10.204.112.79 with HTTP; Thu, 27 Oct 2011 14:49:14 -0700 (PDT)
In-Reply-To: <CACBZZX6Ss4jLtdrDhLUNKCUjEHjHHKzfv-LMkOyTPDhRUXm4sQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184320>

On Thu, Oct 27, 2011 at 23:01, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <=
avarab@gmail.com> wrote:

> I haven't dug into why this is but I'm pretty sure it's because this
> patch makes Git behave pathologically on repositories with a large
> amount of tags. git.git itself has ~27k revs / and ~450 tags, or a ta=
g
> every ~60 revisions.
>
> Try it on e.g. a repository with a couple of hundred thousand revs an=
d
> a tag every 10-20 revisions.

Actually it just seems slow in general, not just on repositories with
a lot of tags, on linux-2.6.git with this patch:

    $ time ~/g/git/git-pack-objects --keep-true-parents
--honor-pack-keep --non-empty --all --reflog
--delta-base-offs</dev/null
/home/avar/g/linux-2.6/.git/objects/pack/.tmp-pack
    Counting objects: 2184059, done.
    Delta compression using up to 8 threads.
    Compressing objects: 100% (338780/338780), done.
    130605d5b82492a38452b9bc7bddfb4a6ef0e942
    Writing objects: 100% (2184059/2184059), done.
    Total 2184059 (delta 1825129), reused 2184059 (delta 1825129)

    real    1m28.426s
    user    1m19.661s
    sys     0m3.008s

With it reverted:

    $ time ~/g/git/git-pack-objects --keep-true-parents
--honor-pack-keep --non-empty --all --reflog --delta-base-offset
</dev/null /home/avar/g/linux-2.6/.git/objects/pack/.tmp-pack
    Counting objects: 2184059, done.
    Delta compression using up to 8 threads.
    Compressing objects: 100% (338780/338780), done.
    130605d5b82492a38452b9bc7bddfb4a6ef0e942
    Writing objects: 100% (2184059/2184059), done.
    Total 2184059 (delta 1825129), reused 2184059 (delta 1825129)

    real    0m50.152s
    user    0m45.367s
    sys     0m2.920s

And if you create a lot of tags:

    git log --pretty=3D%h | perl -lne 'chomp(my $sha =3D <>); print $sh=
a
if $i++ % 10 =3D=3D 0' | parallel "git tag test-tag-{} {}"

Resulting in:

    $ git rev-list HEAD | wc -l
    269514
    $ git tag -l | wc -l
    13733

This'll be the time with this patch reverted, i.e. almost exactly the
same as with just ~250 tags:

    real    0m52.860s
    user    0m44.907s
    sys     0m3.172s

And with it applied, i.e. almost exactly the same as with just ~250
tags:

    real    1m29.080s
    user    1m21.825s
    sys     0m3.096s
