From: Uri Moszkowicz <uri@4refs.com>
Subject: Re: Long clone time after "done."
Date: Thu, 8 Nov 2012 11:20:29 -0600
Message-ID: <CAMJd5AQ24u11BH6rMAHvR95N4ys6KHfEQKD1uLzr+=TDgN_69Q@mail.gmail.com>
References: <CAMJd5AQBbnFqT5xrFuPOEsJevwDE=jUgBVFZ5KqTZk5zv5+NOw@mail.gmail.com>
 <CAMJd5ASL1UPfzUmfXqACuYuGhXQjJLqbsjq7dfpRpF4K-hZFtA@mail.gmail.com> <20121108155607.GD15560@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Nov 08 18:21:05 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TWVmq-0004gL-Ff
	for gcvg-git-2@plane.gmane.org; Thu, 08 Nov 2012 18:21:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756366Ab2KHRUv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Nov 2012 12:20:51 -0500
Received: from mx71.nozonenet.com ([204.14.89.24]:43587 "EHLO
	mail3.nozonenet.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756024Ab2KHRUu (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Nov 2012 12:20:50 -0500
Received: (qmail 26076 invoked by uid 399); 8 Nov 2012 12:20:49 -0500
Received: from mail-ie0-f174.google.com (smtp@4refs.com@209.85.223.174)
  (de-)crypted with TLSv1: RC4-SHA [128/128] DN=unknown
  by mail3.nozonenet.com with ESMTPSAM; 8 Nov 2012 12:20:49 -0500
X-Originating-IP: 209.85.223.174
X-Sender: smtp@4refs.com
Received: by mail-ie0-f174.google.com with SMTP id k13so4540155iea.19
        for <git@vger.kernel.org>; Thu, 08 Nov 2012 09:20:49 -0800 (PST)
Received: by 10.50.237.70 with SMTP id va6mr20494589igc.8.1352395249308; Thu,
 08 Nov 2012 09:20:49 -0800 (PST)
Received: by 10.64.28.231 with HTTP; Thu, 8 Nov 2012 09:20:29 -0800 (PST)
In-Reply-To: <20121108155607.GD15560@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209175>

I tried the patch but it doesn't appear to have helped :( Clone time
with it was ~32m.

Do you all by any chance have a tool to obfuscate a repository?
Probably I still wouldn't be permitted to distribute it but might make
the option slightly more palatable. Anything else that I can do to
help debug this problem?

On Thu, Nov 8, 2012 at 9:56 AM, Jeff King <peff@peff.net> wrote:
> On Wed, Nov 07, 2012 at 11:32:37AM -0600, Uri Moszkowicz wrote:
>
>>   #4  parse_object (sha1=0xb0ee98
>> "\017C\205Wj\001`\254\356\307Z\332\367\353\233.\375P}D") at
>> object.c:212
>>   #5  0x00000000004ae9ec in handle_one_ref (path=0xb0eec0
>> "refs/tags/<removed>", sha1=0xb0ee98
>> "\017C\205Wj\001`\254\356\307Z\332\367\353\233.\375P}D", flags=2,
>> cb_data=<optimized out>) at pack-refs.
>>
>> [...]
>>
>> It looks like handle_one_ref() is called for each ref and most result
>> in a call to read_sha1_file().
>
> Right. When generating the packed-refs file, we include the "peeled"
> reference for a tag (i.e., the commit that a tag object points to). So
> we have to actually read any tag objects to get the value.
>
> The upload-pack program generates a similar list, and I recently added
> some optimizations. This code path could benefit from some of them by
> using "peel_ref" instead of hand-rolling the tag dereferencing. The main
> optimization, though, is reusing peeled values that are already in
> packed-refs; we would probably need some additional magic to reuse the
> values from the source repository.
>
> However:
>
>> It only takes a second or so for each call but when you have thousands
>> of them (one for each ref) it adds up.
>
> I am more concerned that it takes a second to read each tag. Even in my
> pathological tests for optimizing upload-pack, peeling 50,000 refs took
> only half a second.
>
>> Adding --single-branch --branch <branch> doesn't appear to help as
>> it is implemented afterwards. I would like to debug this problem
>> further but am not familiar enough with the implementation to know
>> what the next step is. Can anyone offer some suggestions? I don't see
>> why a clone should be dependent on an O(#refs) operations.
>
> Does this patch help? In a sample repo with 5000 annotated tags, it
> drops my local clone time from 0.20s to 0.11s. Which is a big percentage
> speedup, but this code isn't taking a long time in the first place for
> me.
>
> ---
> diff --git a/pack-refs.c b/pack-refs.c
> index f09a054..3344749 100644
> --- a/pack-refs.c
> +++ b/pack-refs.c
> @@ -40,13 +40,9 @@ static int handle_one_ref(const char *path, const unsigned char *sha1,
>
>         fprintf(cb->refs_file, "%s %s\n", sha1_to_hex(sha1), path);
>         if (is_tag_ref) {
> -               struct object *o = parse_object(sha1);
> -               if (o->type == OBJ_TAG) {
> -                       o = deref_tag(o, path, 0);
> -                       if (o)
> -                               fprintf(cb->refs_file, "^%s\n",
> -                                       sha1_to_hex(o->sha1));
> -               }
> +               unsigned char peeled[20];
> +               if (!peel_ref(path, peeled))
> +                       fprintf(cb->refs_file, "^%s\n", sha1_to_hex(peeled));
>         }
>
>         if ((cb->flags & PACK_REFS_PRUNE) && !do_not_prune(flags)) {
