From: =?UTF-8?Q?Vicent_Mart=C3=AD?= <tanoku@gmail.com>
Subject: Re: [PATCH 10/16] pack-objects: use bitmaps when packing objects
Date: Wed, 26 Jun 2013 01:14:37 +0200
Message-ID: <CAFFjANQ2VD_Eir9-8u4xDD6NherudJa4xp3HN6FaTUsspnzt8g@mail.gmail.com>
References: <1372116193-32762-1-git-send-email-tanoku@gmail.com>
 <1372116193-32762-11-git-send-email-tanoku@gmail.com> <7v7ghhzt73.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jun 26 01:15:25 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UrcSJ-00085z-Sb
	for gcvg-git-2@plane.gmane.org; Wed, 26 Jun 2013 01:15:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752066Ab3FYXPS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Jun 2013 19:15:18 -0400
Received: from mail-ve0-f181.google.com ([209.85.128.181]:47104 "EHLO
	mail-ve0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751816Ab3FYXO6 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Jun 2013 19:14:58 -0400
Received: by mail-ve0-f181.google.com with SMTP id db10so10590771veb.26
        for <git@vger.kernel.org>; Tue, 25 Jun 2013 16:14:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=6dI8RK6NipWGwUaexkR7Blwu8smF21QMOsDeNtirWI8=;
        b=a9x8DkioeJhou+3R5WH5NX/r5JLn0m5Jl4SSfZO+WLxmUkcYTaSIpJ23lXMaM+StnD
         C9YKzW5KiVZScENgJIUQPUbdAYiFXaZxF39t6kjyCBMKsKumuP3zGJJMtVvJDmoQEve5
         tUCPXM153euHYR0xxMnm87uJQVrPnzE0AbPXKjLMpWFuzT/eq5lNIt3AtllR6APlp0zm
         O9ivGWv8dPhyxWCRkaIqOrxH6Am0ytc79daI+JfyUg9doGDDe4Qlghpn+l0/tpTCNNqB
         9+x1zUR8hoirL4wTis3Zphy9+WOHXCdxsOV3z62b0qifay+1xRBr3UX/MQdkGBAISLgS
         pryQ==
X-Received: by 10.220.144.13 with SMTP id x13mr772083vcu.21.1372202097179;
 Tue, 25 Jun 2013 16:14:57 -0700 (PDT)
Received: by 10.221.45.131 with HTTP; Tue, 25 Jun 2013 16:14:37 -0700 (PDT)
In-Reply-To: <7v7ghhzt73.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229016>

On Wed, Jun 26, 2013 at 1:06 AM, Junio C Hamano <gitster@pobox.com> wrote:
>> @@ -83,6 +84,9 @@ static struct progress *progress_state;
>>  static int pack_compression_level = Z_DEFAULT_COMPRESSION;
>>  static int pack_compression_seen;
>>
>> +static int bitmap_support;
>> +static int use_bitmap_index;
>
> OK.
>
>> @@ -2131,6 +2135,10 @@ static int git_pack_config(const char *k, const char *v, void *cb)
>>               cache_max_small_delta_size = git_config_int(k, v);
>>               return 0;
>>       }
>> +     if (!strcmp(k, "pack.usebitmaps")) {
>> +             bitmap_support = git_config_bool(k, v);
>> +             return 0;
>> +     }
>
> Hmph, so bitmap_support, not use_bitmap_index, keeps track of the
> user request?  Somewhat confusing.
>
>>       if (!strcmp(k, "pack.threads")) {
>>               delta_search_threads = git_config_int(k, v);
>>               if (delta_search_threads < 0)
>> @@ -2366,8 +2374,24 @@ static void get_object_list(int ac, const char **av)
>>                       die("bad revision '%s'", line);
>>       }
>>
>> +     if (use_bitmap_index) {
>> +             uint32_t size_hint;
>> +
>> +             if (!prepare_bitmap_walk(&revs, &size_hint)) {
>> +                     khint_t new_hash_size = (size_hint * (1.0 / __ac_HASH_UPPER)) + 0.5;
>
> What is __ac_HASH_UPPER?  That is a very unusual name for a variable
> or a constant.  Also it is mildly annoying to see unnecessary use of
> float like this.

See the updated patch at:

https://github.com/vmg/git/blob/vmg/bitmaps-master/builtin/pack-objects.c#L2422

>
>> +                     kh_resize_sha1(packed_objects, new_hash_size);
>> +
>> +                     nr_alloc = (size_hint + 63) & ~63;
>> +                     objects = xrealloc(objects, nr_alloc * sizeof(struct object_entry *));
>> +
>> +                     traverse_bitmap_commit_list(&add_object_entry_1);
>> +                     return;
>> +             }
>> +     }
>> +
>>       if (prepare_revision_walk(&revs))
>>               die("revision walk setup failed");
>> +
>>       mark_edges_uninteresting(revs.commits, &revs, show_edge);
>>       traverse_commit_list(&revs, show_commit, show_object, NULL);
>>
>> @@ -2495,6 +2519,8 @@ int cmd_pack_objects(int argc, const char **argv, const char *prefix)
>>                           N_("pack compression level")),
>>               OPT_SET_INT(0, "keep-true-parents", &grafts_replace_parents,
>>                           N_("do not hide commits by grafts"), 0),
>> +             OPT_BOOL(0, "bitmaps", &bitmap_support,
>> +                      N_("enable support for bitmap optimizations")),
>
> Please match this with the name of configuration variable, i.e. --use-bitmaps
>
>>               OPT_END(),
>>       };
>>
>> @@ -2561,6 +2587,11 @@ int cmd_pack_objects(int argc, const char **argv, const char *prefix)
>>       if (keep_unreachable && unpack_unreachable)
>>               die("--keep-unreachable and --unpack-unreachable are incompatible.");
>>
>> +     if (bitmap_support) {
>> +             if (use_internal_rev_list && pack_to_stdout)
>> +                     use_bitmap_index = 1;
>
> OK, so only when some internal condition is met, the user request to
> use bitmap is honored and the deision is kept in use_bitmap_index.
>
> It may be easier to read if you get rid of bitmap_support, set
> user_bitmap_index directly from the command line and config, and did
> this here instead:
>
>         if (!(use_internal_rev_list && pack_to_stdout))
>                 use_bitmap_index = 0;

Yeah, I'm not particularly happy with the way these flags are
implemented. I'll update this.
