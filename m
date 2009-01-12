From: Lars Hjemli <hjemli@gmail.com>
Subject: Re: [RFC/PATCH 1/3] tree.c: add support for traversal of submodules
Date: Mon, 12 Jan 2009 11:59:32 +0100
Message-ID: <8c5c35580901120259scee7c82k8917a2909bbb73de@mail.gmail.com>
References: <1231717555-10559-1-git-send-email-hjemli@gmail.com>
	 <1231717555-10559-2-git-send-email-hjemli@gmail.com>
	 <7vr639kyf0.fsf@gitster.siamese.dyndns.org>
	 <8c5c35580901120104u418d8d73mad4ab7d71fe8c3f8@mail.gmail.com>
	 <7vab9wj0rs.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jan 12 12:01:07 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LMKXa-0006QZ-6Z
	for gcvg-git-2@gmane.org; Mon, 12 Jan 2009 12:01:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752101AbZALK7f (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Jan 2009 05:59:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752091AbZALK7e
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Jan 2009 05:59:34 -0500
Received: from wa-out-1112.google.com ([209.85.146.181]:15901 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752079AbZALK7d (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Jan 2009 05:59:33 -0500
Received: by wa-out-1112.google.com with SMTP id v27so5557901wah.21
        for <git@vger.kernel.org>; Mon, 12 Jan 2009 02:59:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=NwD8KZ4kkPpid7R6r17Zv1hCmMlXDdw/u4HhbSX1YnI=;
        b=OgzTVT8Hn0jhBxQNpLwt5XJb6eloOnn7CSIf50cRaHX+aAWK9roh1lF2ClLdVRZa+a
         F08veLg97zuVYYhwEbCvdbWhz8aFvCbpdMjhGd+pClTBMzvdRrGcyA+QfowYEGr3Cwsi
         Zo7DCFgvWxgpnPqaVWGfV4JMvYxVB92kP1+cM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=bCtfgsopRqFCMmNItaQQiMAJf7l3NkzRc9IDFs151xAbT/iee60yO/VKYEE6lz4x4z
         gzb6CuGXBA9IxSE2fu99yUvtm0vfEsPC/3o9GLciwKM2sWWK5Pck9Q76ccI4LQCYlPmA
         5HriLOgSegityXQXCvQq+io+kBuFWJp2++hv4=
Received: by 10.114.208.20 with SMTP id f20mr18964827wag.225.1231757972742; 
	Mon, 12 Jan 2009 02:59:32 -0800 (PST)
In-Reply-To: <7vab9wj0rs.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105324>

On Mon, Jan 12, 2009 at 11:07, Junio C Hamano <gitster@pobox.com> wrote:
> Lars Hjemli <hjemli@gmail.com> writes:
>
>> On Mon, Jan 12, 2009 at 04:15, Junio C Hamano <gitster@pobox.com> wrote:
>> ...
>>> When the user explicitly asks you to traverse into submodules and the
>>> necessary commit is not available in a submodule, the code goes on without
>>> complaining.  I am not saying it is bad, but I wonder if we would want to
>>> distinguish these three cases:
>>>
>>>  (1) the submodule is initialized and the necessary commit is there.
>>>
>>>  (2) the submodule is initialized, but the necessary commit is missing.
>>>
>>>  (3) the submodule is not even initialized (aka "the user is not
>>>     interested in it"); there is only an empty directory.
>>>
>>> I think it is perfectly fine not to say anything for (3) but I am unsure
>>> about the second case.
>>
>> Do we want to impose the porcelainish rules of git-submodule
>> (.gitmodules, .git/config) in read_tree_recursive()?
>>
>> If so, I guess a new submodule.h might provide something like this
>> (disclaimer: coded in gmail):
>
> I do not see why you would need anything more than we already have to tell
> (3) from (1) and (2).  And I do not see why you need to have the Porcelain
> policy in the picture for telling these three cases apart, either.
>
> For example, there is this code in read-cache.c::ce_compare_gitlink():
>
>        static int ce_compare_gitlink(struct cache_entry *ce)
>        {
>                unsigned char sha1[20];
>
>                /*
>                 * We don't actually require that the .git directory
>                 * under GITLINK directory be a valid git directory. It
>                 * might even be missing (in case nobody populated that
>                 * sub-project).
>                 *
>                 * If so, we consider it always to match.
>                 */
>                if (resolve_gitlink_ref(ce->name, "HEAD", sha1) < 0)
>                        return 0;
>                return hashcmp(sha1, ce->sha1);
>        }
>
> It asks resolve_gitlink_ref() to see if the directory (where the submodule
> checkout _might_ be present if the user is interested in it) has .git/HEAD
> that resolves.  If so, the user has a checkout and is interested in it.
> Otherwise, there is no checkout, in other words, we have case (3) above.

Ah, yes, this makes sense. Thanks.


> Whether you force the user to link the submodule object store to the
> primary one as alternates, or do that for the user temporarily inside the
> process [*1*],

If resolve_gitlink_ref() returns 0, I think we should automatically
insert the objectdir of the submodule as a tempory alternate.


> you would then be able to tell (1) and (2) apart by asking
> has_sha1_file() if you can see the commit.

Yes (I've also got a use-case for this with bare repositories [*1*],
but in that setting I guess it's ok to force the user to link the
alternates manually).


> One thing that is unclear is to me is for whom the commit is missing (or
> present).  I think the outline I gave above follows the design of your
> patch to assume that the commit may (or may not) be available to the
> superproject and traverse into the commit when that is the case.  It does
> not mean the commit is available to the submodule itself (the commit may
> have found in the primary project itself, not via the alternates), but
> such an arrangement makes it somewhat useless.

I think we can ignore this issue; if someone has added the
superproject as an alternate for the submodule and then done a
checkout of a superproject commit in the submodule followed by
committing this gitlink in the superproject, we can only hope the user
really knew what he was doing...


> What's the typical direction of using alternates in a setting with
> superproject with a submodule?  Do people have alternates in the submodule
> repository that borrows from the superproject repository?  Or the other
> way around?  What's the rationale for having such alternates for normal
> use case?  I am suspecting that there is no reason (other than this
> "recursive tree traversal") to have an alternates file in either
> direction,

Likewise.


> but I also strongly suspect that I am missing some unwritten
> assumption you are making.

I'm only assuming that we want to support traversal into the
submodules from core git.


*1* This will be (ab)used by cgit to support downloading of 'complete'
tarballs, as outlined in
http://thread.gmane.org/gmane.comp.version-control.git/102827.

--
larsh
