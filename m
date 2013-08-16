From: Andreas Ericsson <ae@op5.se>
Subject: Re: Understanding Git Under The Hood: Trees
Date: Fri, 16 Aug 2013 11:12:16 +0200
Message-ID: <520DECF0.9080501@op5.se>
References: <CAB46HOnsOdYyt3sEe=iv3AJu_BDpTqCLKUpTBFQSnVGMZc8r8A@mail.gmail.com> <520CCC53.4090308@op5.se> <7vwqnmrhbw.fsf@alter.siamese.dyndns.org> <CAB46HOmVpMFsu9dWwB+TZW+DQmE-5XOZqJf62Ufz7ak0eGxP5g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Erik Bernoth <erik.bernoth@gmail.com>
X-From: git-owner@vger.kernel.org Fri Aug 16 11:12:29 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VAG55-0006QG-VD
	for gcvg-git-2@plane.gmane.org; Fri, 16 Aug 2013 11:12:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751845Ab3HPJMW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 Aug 2013 05:12:22 -0400
Received: from mail-lb0-f180.google.com ([209.85.217.180]:56534 "EHLO
	mail-lb0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751149Ab3HPJMV (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Aug 2013 05:12:21 -0400
Received: by mail-lb0-f180.google.com with SMTP id a16so1302714lbj.39
        for <git@vger.kernel.org>; Fri, 16 Aug 2013 02:12:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=x-gm-message-state:message-id:date:from:user-agent:mime-version:to
         :cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=WpQUswdX5pquzUFjcRu1+YlL/mK8u4g8uioQf1NQo/g=;
        b=EmSWbG2UYG8+aCvRhoyWPgpcJr2TJ/UittsUuiu1JZRM+2xiulIJE7JZgteNgVseaB
         9OB4FQC3IFXU/Ft3051kLKH7e4dZcPBiRK/LT5zVVWT7RJROAKAW+YHuBCqHUUT2ayiS
         OQdbhpsJFWfIbT6x8vNttNOZOC8qNPUF+/0sLZof/uHNPgy7dvizK91k49eLTwr3JMhp
         qNOLUiVqsHzSPMAsN2eULkdPxE+Y3rg5Vt69vrnh757Ka+Yhe7wBvDbC51kzccl9EHBN
         tMNekoJErtPvtRiepwuobh7mtCq2KAu5+dbkVGgVtH+fnsxZ77hZClfiKGRM8wH59zs/
         AWkw==
X-Gm-Message-State: ALoCoQmryFbjeOpvQ9hcH99R9AtOx/qfCo0x3B9fpWyzHYpZ7Cp7lrJW5qQcEECYT5g5CrcavtS4
X-Received: by 10.112.172.137 with SMTP id bc9mr1537695lbc.21.1376644339504;
        Fri, 16 Aug 2013 02:12:19 -0700 (PDT)
Received: from lenix.dev.op5.com. (sth-vpn1.op5.com. [193.201.96.49])
        by mx.google.com with ESMTPSA id i9sm316993laa.3.1969.12.31.16.00.00
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 16 Aug 2013 02:12:18 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130803 Thunderbird/17.0.8
In-Reply-To: <CAB46HOmVpMFsu9dWwB+TZW+DQmE-5XOZqJf62Ufz7ak0eGxP5g@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232404>

On 2013-08-15 21:32, Erik Bernoth wrote:
> On Thu, Aug 15, 2013 at 7:31 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> While the last statement applies to other parts of the system, it is
>> not true for the in-core index design.  We always had a flat index,
>> and it is not cheating at all.  The original "tree" was also a flat
>> representation of everything under the sun, and hierarchical tree
>> objects came much later.
>
> To some degree that revalidates my interpretation of Andreas'
> statements. If I understand it correctly eacht time a shell command is
> executed, which requires tree interaction, the corresponding tree is
> read from filesystem to memory completely before anything is done?


More or less, yes, but please don't confuse "directory tree" with "git
tree". They're not the same. A directory tree can contain multiple
levels of directories, whereas a git tree can only contain a list
of objects. The index (aka "staging area") represents a directory tree, 
but when it gets stored on-disk a directory tree gets broken down into
as many git trees as is necessary.

The index is just a cache though. Until changes have been staged to it
in preparation for the next commit, it can be recreated exactly from
the currently checked out commit. As Junio pointed out, the index has 
been flat from the very beginning. Don't confuse the index with the
git tree objects found in the object storage though, or the working tree
with git trees. They're really not the same.

To illustrate the differences, here's a few commands and what they do
and operate on, with regards to the three different kinds of trees that
have come up in this discussion.


Ignore everything git-related and only print the worktree:
   find .

Ignores everything index- and worktree-related and only print the root
git tree of the currently checked out commit. You won't see any
relative paths or directories in there; Just a list of trees and blobs:
   git cat-file -p $(git cat-file -p HEAD | sed -n 's/^tree //p;q')


List staged files only, regardless of what you have in the worktree or
what the latest commit looks like. This will look pretty much like the
last command, but with files located in subdirectories as well, and an
additional field where the "index-state" is stored:
   git ls-files -s


 > So
 > if I git-add a file, the whole index is read first, then the memory
 > object is changed and then the resulting change is written to disk
 > bottom-up from the point of view of the tree?
 >

When you git-add a file, we read in the index, update it with the new
contents of the file you pointed to, or add the new file to it if the
file isn't known to us since before. We also add the blob to the
object store and write out the new tree(s) to the object store as well.
Then we write out the new index, and then we're done. We do all that
bottom up, as you say, or the object store will be inconsistent after
we started writing root objects but before we're done writing leaf
objects.

For a simple "git-add", that's it, and you'll now see "git status" list
files as added to the index without being committed. They're what we
call "staged" at this point.

If you also do "git commit" after having done "git-add", we write out a
commit object, pointing to its parent commit and the root tree we
created in the "git-add" stage. "git cat-file -p HEAD" will give you an
idea of how that looks.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231

Considering the successes of the wars on alcohol, poverty, drugs and
terror, I think we should give some serious thought to declaring war
on peace.
