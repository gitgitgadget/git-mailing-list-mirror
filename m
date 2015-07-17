From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2 06/20] checkout: check_linked_checkout: improve
 "already checked out" aesthetic
Date: Thu, 16 Jul 2015 20:32:38 -0400
Message-ID: <CAPig+cRtCon=jaqbjZyHTvJ3cydiyAz+5OC=3x30VfAJniYYMQ@mail.gmail.com>
References: <1437034825-32054-1-git-send-email-sunshine@sunshineco.com>
	<1437034825-32054-7-git-send-email-sunshine@sunshineco.com>
	<xmqqy4ig3s3q.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Duy Nguyen <pclouds@gmail.com>,
	Michael J Gruber <git@drmicha.warpmail.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jul 17 02:32:44 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZFta0-0002xI-9Q
	for gcvg-git-2@plane.gmane.org; Fri, 17 Jul 2015 02:32:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756549AbbGQAcj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Jul 2015 20:32:39 -0400
Received: from mail-yk0-f182.google.com ([209.85.160.182]:34346 "EHLO
	mail-yk0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756539AbbGQAci (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Jul 2015 20:32:38 -0400
Received: by ykax123 with SMTP id x123so78073339yka.1
        for <git@vger.kernel.org>; Thu, 16 Jul 2015 17:32:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=eK5+keXHeOAfPaSjKYMLhxO32ymknNTI2mLS5lcwy6Q=;
        b=JiOKv099zfNfn9wrjzs2D3OHPQP70ofl2wz/ks/eFl3dZStPsiFxLunZokZupDE6JI
         d6xYIGHEMW13u3zlFbVVYc8DYTl02YwXA15bzR6NmlUixYJCd0dbSHfayG03oBCcTmAF
         pOf/8708EG7N79Pt163Dntgblx3kuxp0DbDqITNh5dIQTBOMYW7Xly00fShWp+9v6TOm
         wgRsPpsHRkaSsRYOrELFjOm3CyStHNPPmM8JBNg5xHYGAqNsP39sZYfmqwIN7WYpvNPH
         GIpVmGGKbJqOOd7d3TvGweSnO+VSb/1/g2mOfis92H8JvJmED8EO8oPrkFp0Q7a+OOQG
         Q5bQ==
X-Received: by 10.170.138.134 with SMTP id f128mr12919042ykc.90.1437093158103;
 Thu, 16 Jul 2015 17:32:38 -0700 (PDT)
Received: by 10.37.12.129 with HTTP; Thu, 16 Jul 2015 17:32:38 -0700 (PDT)
In-Reply-To: <xmqqy4ig3s3q.fsf@gitster.dls.corp.google.com>
X-Google-Sender-Auth: e3SgKZm9mLpxChE6xTJr9GxED5Q
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274054>

On Thu, Jul 16, 2015 at 1:55 PM, Junio C Hamano <gitster@pobox.com> wrote:
> How does this work with manually configured GIT_DIR environment, by
> the way?  I think GIT_DIR=/collection/of/repos/foo.git would be OK,
> as strbuf_strip_suffix() would hopefully leave it intact, but I am
> more interested in the general working of linked checkout feature,
> not just this error message.

I may be misunderstanding your question, but my answer is that
strbuf_strip_suffix() is not applied to $GIT_DIR, but rather to the
content of file $GIT_COMMON_DIR/worktrees/<tag>/gitdir, which is the
path to the .git file in the linked worktree. That is, given:

    git worktree add ../foo HEAD

then the content of 'gitdir' is the absolute path of "../foo/.git",
and strbuf_strip_suffix() operates on that value.

> In the new world order with GIT_DIR and GIT_COMMON_DIR, does
> "$GIT_DIR" always have to be the same as "$GIT_WORK_TREE/.git"?  Do
> we need some sanity check if that is the case?  Perhaps: if you have
> $GIT_DIR set to $somewhere/.git/worktrees/$name, then
>
>  - $GIT_COMMON_DIR must match $somewhere/.git,
>
>  - $somewhere/.git/worktrees/$name/commondir must point at
>    $GIT_COMMON_DIR,
>
>  - $GIT_WORK_TREE/.git must match $GIT_DIR
>
> or something like that?

Duy is probably better suited to answer this, as he would likely have
taken these issues into consideration when implementing the feature.
(I've been poking through documentation and code for quite a while
trying to answer this email but don't yet have a sufficient grasp to
do it justice. I'm not even sure where such a sanity check would be
placed.)

>>       } else
>>               strbuf_addstr(&gitdir, get_git_common_dir());
>>       skip_prefix(branch, "refs/heads/", &branch);
>> +     strbuf_strip_suffix(&gitdir, "/.git");
>
> Sick people have '/.git' and run "git add etc/passwd"; do we want to
> consider such a use case?

I originally implemented this as stripping only ".git" since it felt
natural for the result to have a trailing slash, however, when I
looked back at your report[1], I saw that you suggested stripping
"/.git", so I changed it to strip the slash as well. Given the above
"sick" use-case, we may indeed want to strip only ".git".

[1]: http://article.gmane.org/gmane.comp.version-control.git/274001

>>       die(_("'%s' is already checked out at '%s'"), branch, gitdir.buf);
>>  done:
>>       strbuf_release(&path);
