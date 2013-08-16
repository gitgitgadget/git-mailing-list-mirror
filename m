From: Erik Bernoth <erik.bernoth@gmail.com>
Subject: Re: Understanding Git Under The Hood: Trees
Date: Fri, 16 Aug 2013 15:13:06 +0200
Message-ID: <CAB46HOkJhRdrkVdFv0g2Foj+K_9mXP-muAy_K8kY=3FPqwHSnw@mail.gmail.com>
References: <CAB46HOnsOdYyt3sEe=iv3AJu_BDpTqCLKUpTBFQSnVGMZc8r8A@mail.gmail.com>
	<520CCC53.4090308@op5.se>
	<7vwqnmrhbw.fsf@alter.siamese.dyndns.org>
	<CAB46HOmVpMFsu9dWwB+TZW+DQmE-5XOZqJf62Ufz7ak0eGxP5g@mail.gmail.com>
	<520DECF0.9080501@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Andreas Ericsson <ae@op5.se>
X-From: git-owner@vger.kernel.org Fri Aug 16 15:13:23 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VAJqF-0000KH-8T
	for gcvg-git-2@plane.gmane.org; Fri, 16 Aug 2013 15:13:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752769Ab3HPNNL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 Aug 2013 09:13:11 -0400
Received: from mail-ea0-f169.google.com ([209.85.215.169]:44314 "EHLO
	mail-ea0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752560Ab3HPNNI (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Aug 2013 09:13:08 -0400
Received: by mail-ea0-f169.google.com with SMTP id z7so1005325eaf.0
        for <git@vger.kernel.org>; Fri, 16 Aug 2013 06:13:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=nnzyaoAERyT7y1+DWfXTTyEtKTRhX5eC1kQVPwv0p9I=;
        b=mN7gciGfWlR6Fn4jOtyNd1q0i+YTEAXKnyYUD3GE/6bHnetDkSo4a2cj7i+eNv6W0U
         pBkOF3Uh3e87MgJcWZP+gfEFImVYxAcB5xrS8j9oJWdsexFp28tf8s5+BaL5LFhzIhc3
         e6eGkCEuXU+qGVURauGHgdZlbzt+3njoZGNrqmmW5moPok03zvLxd47PN3dClVRKYkwg
         Kmk93Vf85jsCNd0egPbE+umm7k0I0mzcg6YlSm5fCuqT0MOXZGgmn6Fp+uBFEDnBKDp1
         +92K4f3kpHN8YPWjW9/4ntlbfRS3PdGegQWmc9T6ZkU71JgSTpkBK+htgsxWYJcuQaWk
         K0gQ==
X-Received: by 10.14.29.67 with SMTP id h43mr2092567eea.7.1376658786936; Fri,
 16 Aug 2013 06:13:06 -0700 (PDT)
Received: by 10.223.4.70 with HTTP; Fri, 16 Aug 2013 06:13:06 -0700 (PDT)
In-Reply-To: <520DECF0.9080501@op5.se>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232424>

Hi Andreas,

you gave me a lot of new insight and keywords I can google (Junio as
well!). Thanks a lot!

On Fri, Aug 16, 2013 at 11:12 AM, Andreas Ericsson <ae@op5.se> wrote:
> More or less, yes, but please don't confuse "directory tree" with "git
> tree". They're not the same. A directory tree can contain multiple
> levels of directories, whereas a git tree can only contain a list
> of objects. The index (aka "staging area") represents a directory tree, but
> when it gets stored on-disk a directory tree gets broken down into
> as many git trees as is necessary.

I was confusing it in a way, that I didn't even realize that it was
confusion. I thought from the Git-Book chapter 9 that the index itself
would store a git-tree reference, like a commit does. Therefore in my
own git add implementation I always started with reading and writing
git-trees without any cache in the middle. With a simple, flat index
in the middle of course the whole problem becomes much simpler!

Also after working through the man files of the plumbing commands you
showed I can use that much better in my daily git usage. Can't thank
you guys enough!

I think I start my python-git from scratch again, now that I
understand everything much better. For now I assume the following
algorithms:

 a) git add path/to/file

   1. read the index into a memory object (probably a dictionary like
"index = { 'path/to/file' : (mode, sha1), ... }")
   2. write a blob of path/to/file to the object store
   3. update index["path/to/file"] with the new sha1
   4. write updated index to filesystem

b) git commit -m <msg>

   1. read index to memory
   2. recursively create memory git-tree objects top-down
   3. write git-tree objects to object store recursively bottom-up,
tracking the sha1 of child trees for parent trees
   4. add root-sha1 and commit-msg to memory commit object (author,
committer and so on can be added later)
   5. write commit object to object store
   6. update HEAD (branches will be added later)
   7. clean index ("index = {}")
   8. write empty index to filesystem

Cheers
Erik
