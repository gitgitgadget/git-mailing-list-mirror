From: "Felipe Contreras" <felipe.contreras@gmail.com>
Subject: Re: [PATCH 1/1] fast-import: show a warning for non-existent files.
Date: Tue, 2 Sep 2008 01:01:52 +0300
Message-ID: <94a0d4530809011501n651c42c8xebb5cc39a93aac4c@mail.gmail.com>
References: <1220275214-6178-1-git-send-email-felipe.contreras@gmail.com>
	 <20080901192506.GE7482@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Tue Sep 02 00:03:37 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KaHUm-0000rJ-FR
	for gcvg-git-2@gmane.org; Tue, 02 Sep 2008 00:03:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758566AbYIAWB5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Sep 2008 18:01:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758467AbYIAWB4
	(ORCPT <rfc822;git-outgoing>); Mon, 1 Sep 2008 18:01:56 -0400
Received: from rv-out-0506.google.com ([209.85.198.228]:64821 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756040AbYIAWBx (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Sep 2008 18:01:53 -0400
Received: by rv-out-0506.google.com with SMTP id k40so1976095rvb.1
        for <git@vger.kernel.org>; Mon, 01 Sep 2008 15:01:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=SyeFdb0HDAj9m2sksIwkj568W4GfrFFa/+MeG7hwI+I=;
        b=KWjKENTIAUXOgT041X7Ja+cQsyJQRU37Cp6U2kXVHGhwkZf5AOZNUy9cvLQW7mxW6u
         x45aA69mmBvsgo/0m/nohp64NZrBrBkfR1vz0w3N6E1SqOy8xbJyh3lkLqeUQKpvHw09
         37iMhXxp2Ps34ffe+QI2nOUNiC0ucUCj18znI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=D7r5krAl57Xdte3C3kuXie/t2dh4KMN0alUQ+Y/IzP7DZJvYqAvzf27FzpabE5cRvd
         Oj5IrKzUdvRcDK2DJ9oDg2Zh9GvhBKRT6uieCK9JbH1wPFmaZHSYPWTqqbsUSHmd2DpN
         lOXhB6XdHgs+6sR4zNIuxeljUKuavsX8wYmIQ=
Received: by 10.141.195.5 with SMTP id x5mr3697188rvp.263.1220306512765;
        Mon, 01 Sep 2008 15:01:52 -0700 (PDT)
Received: by 10.140.166.19 with HTTP; Mon, 1 Sep 2008 15:01:52 -0700 (PDT)
In-Reply-To: <20080901192506.GE7482@spearce.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94617>

On Mon, Sep 1, 2008 at 10:25 PM, Shawn O. Pearce <spearce@spearce.org> wrote:
> Felipe Contreras <felipe.contreras@gmail.com> wrote:
>> This is useful in certain SCMs like monotone, where each 'merge revision' has
>> the changes of all the micro-branches merged. So it appears as duplicated commands.
>>
>> The delete command was ignoring the issue completely. The rename/copy commands
>> where throwing a fatal exception.
>
> Signed-off-by line?  See Documentation/SubmittingPatches.

All right, read.

>> diff --git a/fast-import.c b/fast-import.c
>> index 7089e6f..3dd2ab6 100644
>> --- a/fast-import.c
>> +++ b/fast-import.c
>> @@ -1952,7 +1953,13 @@ static void file_change_d(struct branch *b)
>>                       die("Garbage after path in: %s", command_buf.buf);
>>               p = uq.buf;
>>       }
>> -     tree_content_remove(&b->branch_tree, p, NULL);
>> +     memset(&leaf, 0, sizeof(leaf));
>> +     tree_content_remove(&b->branch_tree, p, &leaf);
>> +     if (!leaf.versions[1].mode)
>> +     {
>> +             warning("Path %s not in branch", p);
>> +             return;
>> +     }
>>  }
>>
>>  static void file_change_cr(struct branch *b, int rename)
>
> This is going to leak memory unless you add this before the
> if (..mode) condition:
>
>        if (leaf->tree)
>                release_tree_content_recursive(e->tree);

Hmm, ok.

> We didn't worry about deleting a path that doesn't exist because
> the importer clearly wants it gone.  If it wants it gone and it is
> already gone then it should be fine to ignore the delete command.
>
> But as I point out below some import front-ends should be accurate
> enough that they should not send a 'D' command unless the path is
> already in the tree.  Thus this can be an error condition for some
> types of frontends, but can be ignored for others.

I'm sending the patch again with this behavior as an option.

>> @@ -1994,7 +2001,10 @@ static void file_change_cr(struct branch *b, int rename)
>>       else
>>               tree_content_get(&b->branch_tree, s, &leaf);
>>       if (!leaf.versions[1].mode)
>> -             die("Path %s not in branch", s);
>> +     {
>> +             warning("Path %s not in branch", s);
>> +             return;
>> +     }
>>       tree_content_set(&b->branch_tree, d,
>>               leaf.versions[1].sha1,
>>               leaf.versions[1].mode,
>
> Normally we consider invalid paths to be an error.  I wonder if this
> should still be an error, unless the front-end passes an option on
> the command line.  Then monotone based importers can make these
> warnings, but other importers that don't have this problem can
> still treat them what they are, which is a fatal error.
>
> Did you run the test suite (t/t9300-fast-import.sh) after your patch?
> I would have thought a few of the bad path errors should be caught
> there.

I didn't initially, now I just did and it doesn't seem to be checking
for such things.

Best regards.

-- 
Felipe Contreras
