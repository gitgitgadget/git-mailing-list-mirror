From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: Segfault in git reflog
Date: Wed, 30 Dec 2015 18:28:19 +0700
Message-ID: <CACsJy8Cm6a2FiyZwXsTpzbp7ZkZUGWf=HmjsMtQvJMjzVLkTzA@mail.gmail.com>
References: <20151230092400.GA9319@spirit> <1451474248.9251.7.camel@kaarsemaker.net>
 <CACsJy8CoRs8dNPWag-E947oVTt4R8XbKBLvaQvBPGm4jqZBKNw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Dennis Kaarsemaker <dennis@kaarsemaker.net>
X-From: git-owner@vger.kernel.org Wed Dec 30 12:28:55 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aEEw3-0001Tw-67
	for gcvg-git-2@plane.gmane.org; Wed, 30 Dec 2015 12:28:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754611AbbL3L2w (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Dec 2015 06:28:52 -0500
Received: from mail-lb0-f171.google.com ([209.85.217.171]:35665 "EHLO
	mail-lb0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754397AbbL3L2u (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Dec 2015 06:28:50 -0500
Received: by mail-lb0-f171.google.com with SMTP id bc4so114309353lbc.2
        for <git@vger.kernel.org>; Wed, 30 Dec 2015 03:28:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=WECG2MVzKcoVkpNgOdo9LMqRwNIPdyiO35yVz4L5S0k=;
        b=eiOthqcEwJuZogha1d4SQiWkclhP7GjaPWx8J+HEGZyuN/z3RnQNcPiB5QjVcwgaIh
         pPXs8vUj08m3oG96O3zaPsJG6S9W/8X1S3z3Sw2QmpE/fONGwJoJ+MEULOF+5yNwsBdl
         7umQwaJPkH1NvzW43ZkjspRfMSUo1788AqbKtnJKbsU0cXzUcq4RnEzZHMLmcxNgRcbf
         QhuSDepOUpiHDFKLka33esSPWN01Od+b67YFU250i34ITeuLNsvLqI3l8ySsW/z1OGn3
         +HdcCxszYTW5knmGc3en0HX5XksnnuwKh5ZDipHfMxsd9pxxHQmIO9YE3C8zgAkWQddC
         Aizw==
X-Received: by 10.112.172.8 with SMTP id ay8mr2236771lbc.145.1451474929283;
 Wed, 30 Dec 2015 03:28:49 -0800 (PST)
Received: by 10.112.97.72 with HTTP; Wed, 30 Dec 2015 03:28:19 -0800 (PST)
In-Reply-To: <CACsJy8CoRs8dNPWag-E947oVTt4R8XbKBLvaQvBPGm4jqZBKNw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283177>

On Wed, Dec 30, 2015 at 6:26 PM, Duy Nguyen <pclouds@gmail.com> wrote:
> On Wed, Dec 30, 2015 at 6:17 PM, Dennis Kaarsemaker
> <dennis@kaarsemaker.net> wrote:
>> On wo, 2015-12-30 at 10:24 +0100, Dennis Kaarsemaker wrote:
>>> spirit:~/code/git (master)$ cat .git/logs/HEAD
>>> 2635c2b8bfc9aec07b7f023d8e3b3d02df715344 54bc41416c5d3ecb978acb0df80d57aa3e54494c Dennis Kaarsemaker <dennis@kaarsemaker.net> 1446765642 +0100
>>> 74c855f87d25a5b5c12d0485ec77c785a1c734c5 54bc41416c5d3ecb978acb0df80d57aa3e54494c Dennis Kaarsemaker <dennis@kaarsemaker.net> 1446765951 +0100  checkout: moving from 3c3d3f629a6176b401ebec455c5dd59ed1b5f910 to master

Ah... I came from a different angle and did not realize the tag sha1
is from your reflog. So yeah maybe reflog parsing code should check
object type first, don't assume it's a commit!

>>
>> 74c855f87d25a5b5c12d0485ec77c785a1c734c5 is actually a tag, pointing to
>> 3c3d3f629a6176b401ebec455c5dd59ed1b5f910. I'm not sure if that is
>> relevant.
>
> It is. save_parents() expects "commit" to be a commit because it needs
> commit->index, which is not available from struct tag. So when
> saved_parents_at() tries to read commit->index, it gets random value
> (from the tag). Hell breaks loose from there because this index field
> points to some memory in the slab mem allocator. The question is, how
> come a tag is passed in here. Maybe we can sprinkle some
> assert(object->type == OBJ_COMMIT) in revision.c and see..
> --
> Duy



-- 
Duy
