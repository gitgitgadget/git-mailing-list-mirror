From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v2 4/4] fast-export: make sure refs are updated properly
Date: Tue, 30 Oct 2012 19:47:42 +0100
Message-ID: <CAMP44s3MHrG_XeZEodnxemrW-V18+NHnFvi7koyx9mH8XuHc6w@mail.gmail.com>
References: <1351617089-13036-1-git-send-email-felipe.contreras@gmail.com>
	<1351617089-13036-5-git-send-email-felipe.contreras@gmail.com>
	<CAGdFq_j1RROOwxDi1FfJZJ6wiP9y9FWzSpc7MXVSvRmgk0sF9A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: ">" <git@vger.kernel.org>, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Elijah Newren <newren@gmail.com>
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Tue Oct 30 19:48:00 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TTGqz-0004aj-1S
	for gcvg-git-2@plane.gmane.org; Tue, 30 Oct 2012 19:47:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965538Ab2J3Srq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Oct 2012 14:47:46 -0400
Received: from mail-oa0-f46.google.com ([209.85.219.46]:50205 "EHLO
	mail-oa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965528Ab2J3Srn (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Oct 2012 14:47:43 -0400
Received: by mail-oa0-f46.google.com with SMTP id h16so598233oag.19
        for <git@vger.kernel.org>; Tue, 30 Oct 2012 11:47:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=PbxC6PhMgZlj+CJfg17hmLlTCBLVFqwc7d6/lWrLeq0=;
        b=SVk7CfmUwqXVtJwvfWsY2Jkq3IMDBmIQElNy8Zt5Lb/0D1CgVNXQeZV38HgnAXDCB/
         khF4V14gXStuqI+B+LIYPDugjYRQwgG0h7053Codmi9z+QX0E4zQByNdyPJidVLHn8qn
         Hac4gPkuWdm3mKBjtdxAH5WTsp7w0dfEMrUU9uZhSbG9ce7LFbvD2uO+zbA69xxxxE69
         cC5ZJ+xl6tsWWABbOqYW0drlOJlLAd0qSgDhZc3/FVjFEC1Vpul+0It6sQO+sfqW3bp/
         4fcRDqRRFubrBsupkWs2HKEH0LpHx/4rQIwdyXBTqNNK9qNn6Ko/OeX4Vjl1JS5jVdCJ
         50zg==
Received: by 10.60.12.233 with SMTP id b9mr30200079oec.95.1351622862323; Tue,
 30 Oct 2012 11:47:42 -0700 (PDT)
Received: by 10.60.4.74 with HTTP; Tue, 30 Oct 2012 11:47:42 -0700 (PDT)
In-Reply-To: <CAGdFq_j1RROOwxDi1FfJZJ6wiP9y9FWzSpc7MXVSvRmgk0sF9A@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208722>

On Tue, Oct 30, 2012 at 7:12 PM, Sverre Rabbelier <srabbelier@gmail.com> wrote:
> On Tue, Oct 30, 2012 at 10:11 AM, Felipe Contreras
> <felipe.contreras@gmail.com> wrote:
>> When an object has already been exported (and thus is in the marks) it
>> is flagged as SHOWN, so it will not be exported again, even if this time
>> it's exported through a different ref.
>>
>> We don't need the object to be exported again, but we want the ref
>> updated, which doesn't happen.
>>
>> Since we can't know if a ref was exported or not, let's just assume that
>> if the commit was marked (flags & SHOWN), the user still wants the ref
>> updated.
>>
>> So:
>>
>>  % git branch test master
>>  % git fast-export $mark_flags master
>>  % git fast-export $mark_flags test
>>
>> Would export 'test' properly.
>>
>> Additionally, this fixes issues with remote helpers; now they can push
>> refs wich objects have already been exported.
>
> Won't this also export child (or maybe parent) branches that weren't
> mentioned? For example:
>
> $ git branch one
> $ echo foo > content
> $ git commit -m two
> $ git fast-export one
> $ git fast-export two
>
> I suspect that one of those will export both one and two. If not, this
> seems like a great solution to the fast-export problem.

Why would it? We are not changing the way objects are exported, the
only difference is what happens at the end
(handle_tags_and_duplicates()).

And if you are talking about the ref for the reset at the end, it has
to be both in the list of refs selected by the user (initially in
&revs.pending), either marked or the object already referenced by
another ref in the list selected by the user (e.g. fast-export one
two, where one^{commit} == two^{commit}, and not marked as
UNINTERESTING (e.g. ^two).

Cheers.

-- 
Felipe Contreras
