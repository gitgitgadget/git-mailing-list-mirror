From: Lars Hjemli <hjemli@gmail.com>
Subject: Re: [PATCH 2/3] Teach read_tree_recursive() how to traverse into 
	submodules
Date: Sun, 18 Jan 2009 18:45:40 +0100
Message-ID: <8c5c35580901180945u17a69140vff2736765ee6073@mail.gmail.com>
References: <1232275999-14852-1-git-send-email-hjemli@gmail.com>
	 <1232275999-14852-2-git-send-email-hjemli@gmail.com>
	 <1232275999-14852-3-git-send-email-hjemli@gmail.com>
	 <alpine.DEB.1.00.0901181635290.3586@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sun Jan 18 18:47:10 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LObjm-0007oO-9B
	for gcvg-git-2@gmane.org; Sun, 18 Jan 2009 18:47:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933824AbZARRpn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 18 Jan 2009 12:45:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933781AbZARRpm
	(ORCPT <rfc822;git-outgoing>); Sun, 18 Jan 2009 12:45:42 -0500
Received: from wa-out-1112.google.com ([209.85.146.176]:15259 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933670AbZARRpl (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Jan 2009 12:45:41 -0500
Received: by wa-out-1112.google.com with SMTP id v27so1303107wah.21
        for <git@vger.kernel.org>; Sun, 18 Jan 2009 09:45:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=OsXvuBw3j8t/zC2yiRaaTs+o64NSAZFXalJaomEdI3c=;
        b=kxhOPyBrO22CfrG/aNauEUVaZJ31Jx+3JC9zQ0BZREgKdh0B1WtRPUIKpeIBecoA46
         ZVQlHC5lx6xVMDm4C18VqSriLcsrjJWI0jmBvYiGU/lGsP7keEND+Ho17+01wJfOJNjl
         swIaxib17cMSqdReWdxkdisVAItAzNM3Kdc2o=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=StJgEEOgex/gwDI3ViLqeNu0w8pqsw/g4Jc/k6NKlkDnN9gk2ldUrrb5B5KkcF7/7F
         GdNl4gDt06dL4bvf4HcOR3MlsUQP1somNGH+LYdwBMKnBJw5Yqx3CtMmR6p7WS/8bivb
         NTEEUHAelQGbGopg+fQFDJH6E5/AtFdFtjAeY=
Received: by 10.114.190.18 with SMTP id n18mr3424807waf.101.1232300740817; 
	Sun, 18 Jan 2009 09:45:40 -0800 (PST)
In-Reply-To: <alpine.DEB.1.00.0901181635290.3586@pacific.mpi-cbg.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106253>

On Sun, Jan 18, 2009 at 16:48, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> Hi,
>
> On Sun, 18 Jan 2009, Lars Hjemli wrote:
>
>> diff --git a/environment.c b/environment.c
>> @@ -159,3 +161,13 @@ int set_git_dir(const char *path)
>>       setup_git_env();
>>       return 0;
>>  }
>> +
>> +int get_traverse_gitlinks()
>> +{
>> +     return traverse_gitlinks;
>> +}
>> +
>> +void set_traverse_gitlinks(int traverse)
>> +{
>> +     traverse_gitlinks = traverse;
>> +}
>
> If you have full accessors anyway, it is much easier and cleaner to make
> this a global variable to begin with.
>
> However, environment.c is reserved for things that come from the config
> and can be overridden by the user.  That is certainly not the case for
> traverse_gitlinks.
>
> But let's think about it again: should traverse_gitlinks be a global
> varible at all?  I think not.  It should be a per-call decision.

Yes, it might be a cleaner solution to add an extra parameter to
read_tree_recursive(), and since it currently has only 7 callsites the
patch wouldn't be too big either. Junio, what do you think?


>> +/* Try to add the objectdb of a submodule */
>> +int add_gitlink_odb(char *relpath)
>
> This wants to be static.

Thanks

>
>> +{
>> +     const char *odbpath;
>> +     struct stat st;
>> +
>> +     odbpath = read_gitfile_gently(mkpath("%s/.git", relpath));
>> +     if (!odbpath)
>> +             odbpath = mkpath("%s/.git/objects", relpath);
>> +
>> +     if (stat(odbpath, &st))
>> +             return 1;
>> +
>> +     return add_alt_odb(odbpath);
>> +}
>> +
>> +/* Check if we should recurse into the specified submodule */
>> +int traverse_gitlink(char *path, const unsigned char *commit_sha1,
>
> This, too.

Thanks again ;-)

>
>> +                  struct tree **subtree)
>> +{
>> +     unsigned char sha1[20];
>> +     int linked_odb = 0;
>> +     struct commit *commit;
>> +     void *buffer;
>> +     enum object_type type;
>> +     unsigned long size;
>> +
>> +     hashcpy(sha1, commit_sha1);
>> +     if (!add_gitlink_odb(path)) {
>> +             linked_odb = 1;
>> +             if (resolve_gitlink_ref(path, "HEAD", sha1))
>> +                     die("Unable to lookup HEAD in %s", path);
>> +     }
>
> Why would you want to continue if add_gitlink_odb() did not find a checked
> out submodule?
>
> Seems you want to fall back to look in the superproject's object database.
> But I think that is wrong, as I have a superproject with many platform
> dependent submodules, only one of which is checked out, and for
> convenience, the submodules all live in the superproject's repository.

Actually, I want this to work for bare repositories by specifying the
submodule odbs in the alternates file. So if the current submodule odb
wasn't found my plan was to check if the commit object was accessible
anyways but don't die() if it wasn't.


>> +     commit = lookup_commit(sha1);
>> +     if (!commit)
>> +             die("traverse_gitlink(): internal error");
>
> s/internal error/could not access commit '%s' of submodule '%s'",
>                        sha1_to_hex(sha1), path);/

Ok (I belive this codepath is virtually impossible to hit, hence the
"internal error", but I could of course be mistaken).


>> @@ -132,6 +188,30 @@ int read_tree_recursive(struct tree *tree,
>>                               return -1;
>>                       continue;
>>               }
>> +             if (S_ISGITLINK(entry.mode) && get_traverse_gitlinks()) {
>
> Like I said, traverse_gitlinks should be a flag to read_tree_recursive.
> So preferably, you should add a parameter 'flags' and make that option an
> enum.
>
>> +                     int retval;
>> +                     char *newbase;
>> +                     struct tree *subtree;
>> +                     unsigned int pathlen = tree_entry_len(entry.path, entry.sha1);
>
> Nit: Long line.

Will fix

>
>> +
>> +                     newbase = xmalloc(baselen + 1 + pathlen);
>> +                     memcpy(newbase, base, baselen);
>> +                     memcpy(newbase + baselen, entry.path, pathlen);
>> +                     newbase[baselen + pathlen] = 0;
>
> We have strbufs for that.
>
>> +                     if (!traverse_gitlink(newbase, entry.sha1, &subtree)) {
>> +                             free(newbase);
>> +                             continue;
>> +                     }
>> +                     newbase[baselen + pathlen] = '/';
>
> ... to avoid this off-by-one.

Actually, I don't think this is off-by-one, since (baselen + pathlen +
1) is passed along to read_tree_recursive() as the new baselen. But
using strbufs might be cleaner anyways.

Thanks for the review.

--
larsh
