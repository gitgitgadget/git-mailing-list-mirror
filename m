From: Mike Rappazzo <rappazzo@gmail.com>
Subject: Re: [PATCH v7 1/3] worktree: add top-level worktree.c
Date: Mon, 14 Sep 2015 08:20:02 -0400
Message-ID: <CANoM8SWP9YrZoUx5w9Do18uZf=5RrCV_ShvyaPQF4=9-vuFVbg@mail.gmail.com>
References: <1441402769-35897-1-git-send-email-rappazzo@gmail.com>
 <1441402769-35897-2-git-send-email-rappazzo@gmail.com> <CAPig+cQRx-uKZnnx2O0pG34HkcEdg1GbGNFd9PHdw+m0O3aJEA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	David Turner <dturner@twopensource.com>,
	Git List <git@vger.kernel.org>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Mon Sep 14 14:20:47 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZbSkL-0000Jy-Vj
	for gcvg-git-2@plane.gmane.org; Mon, 14 Sep 2015 14:20:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753672AbbINMUY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Sep 2015 08:20:24 -0400
Received: from mail-vk0-f44.google.com ([209.85.213.44]:33578 "EHLO
	mail-vk0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752912AbbINMUX (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Sep 2015 08:20:23 -0400
Received: by vkgd64 with SMTP id d64so57767159vkg.0
        for <git@vger.kernel.org>; Mon, 14 Sep 2015 05:20:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=M0EGZRzYwNKMG1M5+4aC9dIs01tLs2Jqu13BqQqAa48=;
        b=IJlQ34La5mYHpwnf4t/zcB9Yk8iBROXFUcUNuKf8YlLjZ8TCKivS9VBvBdfFczOGiV
         nMpU84YU1O2ZMo1niq7UNZZNe/aeKCsbyVwDIacedSy172L1QjjZ/gA3xkv3PIVACdGj
         lFL1XIy/soPu69wcvpMAKjG/uda1tVxtSa9+cAwbl7yMO4TVVgWTMGamhzFHUJ9cs8oG
         AIN4wRQ9IjipaQXA8T3QStdmtrLYQwRTT3kjNTfNAmeA/oRIg+1Miva2mOJbtX8MpWU5
         4chEQW57qndOr1DDLw4b9LOTLOccPtT4hARFK8zFiBogurw5jjE6QTqlHOxS1fjyarKy
         6LZA==
X-Received: by 10.31.47.210 with SMTP id v201mr12520026vkv.126.1442233222223;
 Mon, 14 Sep 2015 05:20:22 -0700 (PDT)
Received: by 10.103.80.201 with HTTP; Mon, 14 Sep 2015 05:20:02 -0700 (PDT)
In-Reply-To: <CAPig+cQRx-uKZnnx2O0pG34HkcEdg1GbGNFd9PHdw+m0O3aJEA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277817>

On Sat, Sep 12, 2015 at 10:39 PM, Eric Sunshine <sunshine@sunshineco.com> wrote:
> I realize that this is modeled closely after existing code in
> branch.c, but, with the exception of parsing the ref file and
> constructing a worktree structure, the main worktree case (id == NULL)
> is entirely disjoint from the linked worktree case (id != NULL). This
> suggests strongly that get_worktree() should be split into two
> functions, one for the main worktree and one for linked worktrees,
> which would make the code easier to understand. You might call the
> functions get_main_worktree() and get_linked_worktree(id) (or perhaps
> drop "linked" from the latter name).

I originally wrote it like that, but I felt that the code looked like
it was mostly duplicated in the functions.
I can give it a relook.

>> +
>> +struct worktree_list *get_worktree_list()
>
> Can we be more concise and call this get_worktrees()?
>

I prefer 'get_worktree_list' because I also added the 'get_worktree'
function, and I wanted to differentiate
the function names.

>> diff --git a/worktree.h b/worktree.h
>> new file mode 100644
>> index 0000000..2bc0ab8
>> --- /dev/null
>> +++ b/worktree.h
>> @@ -0,0 +1,48 @@
>> +#ifndef WORKTREE_H
>> +#define WORKTREE_H
>> +
>> +struct worktree {
>> +       char *path;
>> +       char *git_dir;
>> +       char *head_ref;
>> +       unsigned char head_sha1[20];
>> +       int is_detached;
>> +       int is_bare;
>> +};
>> +
>> +struct worktree_list {
>> +       struct worktree *worktree;
>> +       struct worktree_list *next;
>> +};
>
> I don't care too strongly, but an alternate approach (which I probably
> would have taken) would be to have get_worktrees() simply return an
> array of 'struct worktree' objects, hence no need for the additional
> 'struct worktree_list'. The slight complication with this approach,
> though, is that get_worktrees() either also needs to return the length
> of the array, or the array should end with some sort of end-of-array
> sentinel. An obvious sentinel would be path==NULL or git_dir==NULL or
> all of the above.
>
> Client iteration is just about the same with the array approach as
> with the linked-list approach.
>

I can't see what benefit this would provide.  I would sooner change
the returned list into
an array-backed list struct.  Alternatively, I think adding a
list_head pointer to this structure
could benefit client code.
