From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH v4 4/4] cache-tree: Write updated cache-tree after commit
Date: Tue, 8 Jul 2014 17:32:20 +0700
Message-ID: <CACsJy8C20oFdATHKTLK=9U3_kHu1QsuS4i74RPgQn0aTwVCC8w@mail.gmail.com>
References: <1404619619-4774-1-git-send-email-dturner@twitter.com>
 <1404619619-4774-4-git-send-email-dturner@twitter.com> <xmqq61j9c4xb.fsf@gitster.dls.corp.google.com>
 <xmqq7g3obsqm.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: David Turner <dturner@twopensource.com>,
	Git Mailing List <git@vger.kernel.org>,
	David Turner <dturner@twitter.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jul 08 12:32:56 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X4Shk-0001I6-7o
	for gcvg-git-2@plane.gmane.org; Tue, 08 Jul 2014 12:32:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753534AbaGHKcw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Jul 2014 06:32:52 -0400
Received: from mail-qc0-f171.google.com ([209.85.216.171]:38962 "EHLO
	mail-qc0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753141AbaGHKcv (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Jul 2014 06:32:51 -0400
Received: by mail-qc0-f171.google.com with SMTP id w7so4959339qcr.2
        for <git@vger.kernel.org>; Tue, 08 Jul 2014 03:32:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=ocgACW/GQZHJWm/zAXF5sYzckcg9uJ4l/3yeYknveo4=;
        b=Q+UTX33Cc28O5wHwW+8RO489AcOeYDe7nsJhSVJlPUbm1yYp8pCQ6GtDeeT0qBAJ0Y
         nJ9WafSs7IWPWfrW1aZ7oqdy15QwXx9J2rRinu5afmDUx1/hVsF76xmW5ryJmKEou2TV
         4fx0M/G6hd099WCdlQJXb0UdCQ0/VYFaLPPX9KjAgU4qLqxv7RTb3ywxz8j0yj5k6w+6
         ORHz9NFw9dmqPDCorQEtf+Vt4Nm7yitCoVgje+CAJtFF2ODqrND2d6aDrO08UjFsqzVR
         2TTxwt4L3iTipsaBrwYqil6mbwSbpL+I4jqu/F9aEp2pq8ea4qJhIWzc5K3zFHgwiaTg
         +sGQ==
X-Received: by 10.140.98.195 with SMTP id o61mr43938839qge.41.1404815570928;
 Tue, 08 Jul 2014 03:32:50 -0700 (PDT)
Received: by 10.96.66.129 with HTTP; Tue, 8 Jul 2014 03:32:20 -0700 (PDT)
In-Reply-To: <xmqq7g3obsqm.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253010>

On Tue, Jul 8, 2014 at 7:26 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Junio C Hamano <gitster@pobox.com> writes:
>
>>> diff --git a/builtin/commit.c b/builtin/commit.c
>>> index 9cfef6c..5981755 100644
>>> --- a/builtin/commit.c
>>> +++ b/builtin/commit.c
>>> @@ -342,6 +342,8 @@ static char *prepare_index(int argc, const char **argv, const char *prefix,
>>>
>>>              discard_cache();
>>>              read_cache_from(index_lock.filename);
>>> +            if (update_main_cache_tree(WRITE_TREE_SILENT) >= 0)
>>> +                    write_cache(fd, active_cache, active_nr);
>>>
>>>              commit_style = COMMIT_NORMAL;
>>>              return index_lock.filename;

I wonder if we need to update_main_cache_tree() so many times in this
function. If I read the code correctly, all roads must lead to
update_main_cache_tree(0) in prepare_to_commit(). If we find out that
we have incomplete cache-tree before that call, we could write the
index one more time after that call, instead of spreading
update_main_cache_tree() all over prepare_index(). I know the
"index_file" in prepare_to_commit() is probably "index.lock" or
something, but that does not stop us from locking again
("index.lock.lock") if we want to update it.

Writing cache tree early in prepare_index() does help hooks, but I
would say hooks are uncommon case and we could add an option to
update-index to explicitly rebuild cache-tree, then hooks that do diff
a lot (or other operations that use cache-tree) could rebuild
cache-tree by themselves. When the index file is large, every write
pays high penalty so I think trying to write less often is good.
-- 
Duy
