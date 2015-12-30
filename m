From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: Segfault in git reflog
Date: Wed, 30 Dec 2015 18:26:33 +0700
Message-ID: <CACsJy8CoRs8dNPWag-E947oVTt4R8XbKBLvaQvBPGm4jqZBKNw@mail.gmail.com>
References: <20151230092400.GA9319@spirit> <1451474248.9251.7.camel@kaarsemaker.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Dennis Kaarsemaker <dennis@kaarsemaker.net>
X-From: git-owner@vger.kernel.org Wed Dec 30 12:27:12 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aEEuL-00007N-Rl
	for gcvg-git-2@plane.gmane.org; Wed, 30 Dec 2015 12:27:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754653AbbL3L1F (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Dec 2015 06:27:05 -0500
Received: from mail-lf0-f54.google.com ([209.85.215.54]:35903 "EHLO
	mail-lf0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754640AbbL3L1E (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Dec 2015 06:27:04 -0500
Received: by mail-lf0-f54.google.com with SMTP id z124so220001741lfa.3
        for <git@vger.kernel.org>; Wed, 30 Dec 2015 03:27:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=Mq4iOWq8I2iszPbFl9KoU8xpfVVIobhb6ZrpG+neUIw=;
        b=Vm7mKgEV6TbFdiiB5tw0fDCGn5kfRPowRqg63xTDEUHfjh4YKBVwn2EqEO1PkDSgQ5
         2WLhTSCdwrsMHRePsl7weprD1qdKs1XScH9FHMDUx4jsLmpqhwFsXmVD98BahX/g4X8r
         FCj5oEk54uAUvXFD+FIdS+fmT7jiJwkDvC1n7Kw9oK7MK3LAl54/jGcQGesw8c7gPEPz
         fwIEJo0OLibz0JWq/Qogo01t1owIA0XbZ+8vWELi2U1yUO/MFVRBie93DZ+JmOccEhb7
         j2HEi9kIr1wFPf5hTC3vOHm5ctzd5cdQi05mGWf6VjnOBXnVwuC/fr3JlvoS4xN6X22k
         R70A==
X-Received: by 10.25.17.229 with SMTP id 98mr749426lfr.3.1451474822898; Wed,
 30 Dec 2015 03:27:02 -0800 (PST)
Received: by 10.112.97.72 with HTTP; Wed, 30 Dec 2015 03:26:33 -0800 (PST)
In-Reply-To: <1451474248.9251.7.camel@kaarsemaker.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283176>

On Wed, Dec 30, 2015 at 6:17 PM, Dennis Kaarsemaker
<dennis@kaarsemaker.net> wrote:
> On wo, 2015-12-30 at 10:24 +0100, Dennis Kaarsemaker wrote:
>> spirit:~/code/git (master)$ cat .git/logs/HEAD
>> 2635c2b8bfc9aec07b7f023d8e3b3d02df715344 54bc41416c5d3ecb978acb0df80d57aa3e54494c Dennis Kaarsemaker <dennis@kaarsemaker.net> 1446765642 +0100
>> 74c855f87d25a5b5c12d0485ec77c785a1c734c5 54bc41416c5d3ecb978acb0df80d57aa3e54494c Dennis Kaarsemaker <dennis@kaarsemaker.net> 1446765951 +0100  checkout: moving from 3c3d3f629a6176b401ebec455c5dd59ed1b5f910 to master
>
> 74c855f87d25a5b5c12d0485ec77c785a1c734c5 is actually a tag, pointing to
> 3c3d3f629a6176b401ebec455c5dd59ed1b5f910. I'm not sure if that is
> relevant.

It is. save_parents() expects "commit" to be a commit because it needs
commit->index, which is not available from struct tag. So when
saved_parents_at() tries to read commit->index, it gets random value
(from the tag). Hell breaks loose from there because this index field
points to some memory in the slab mem allocator. The question is, how
come a tag is passed in here. Maybe we can sprinkle some
assert(object->type == OBJ_COMMIT) in revision.c and see..
-- 
Duy
