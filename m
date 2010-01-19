From: Fredrik Kuivinen <frekui@gmail.com>
Subject: Re: [PATCH v3] Threaded grep
Date: Tue, 19 Jan 2010 01:12:40 +0100
Message-ID: <4c8ef71001181612l72ec73ecmae709fbb475752b0@mail.gmail.com>
References: <20100118103334.GA17361@fredrik-laptop>
	 <7vmy0bhxn1.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Git Mailing List <git@vger.kernel.org>,
	Johannes Sixt <j.sixt@viscovery.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jan 19 01:13:21 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NX1if-0004Ot-S3
	for gcvg-git-2@lo.gmane.org; Tue, 19 Jan 2010 01:13:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752327Ab0ASAMt convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 18 Jan 2010 19:12:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753229Ab0ASAMr
	(ORCPT <rfc822;git-outgoing>); Mon, 18 Jan 2010 19:12:47 -0500
Received: from mail-fx0-f225.google.com ([209.85.220.225]:55307 "EHLO
	mail-fx0-f225.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752248Ab0ASAMm convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 18 Jan 2010 19:12:42 -0500
Received: by fxm25 with SMTP id 25so81836fxm.21
        for <git@vger.kernel.org>; Mon, 18 Jan 2010 16:12:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=UNYoARo0BDpNz0lIES1AuMRp17xhIUdMLYJUUEwPg50=;
        b=D9l/85cbYmLtnyckJcFUFWpMy9AigQXOfxQ+I0GiI1yT3gb3cwuLbQrNFyWWP2HHj8
         BkjgXBfZgQIWEuQQY0s/YFtBBZNdvEpnqp4mUtMABOvrV3ON52nx2jg/T7gWSTGJ4tHs
         mIKr3/rGCqwYtlFLyeyu44evRyU8J+GawHaHY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=m7i4iE3cmZD9uTBoeLAykl9TkSgLOEn6tuFmkZ77KrR+mIxmT9FbxRl//V+PhtHWCA
         kcCxoFPG/Vf3o2y9ZgJe/j/V86aL+2qQaocuQlhNe3nQ0rvTU2IZMO/m47If8MdOrIaV
         DHnjPxre+QfjjLLMduTAm/nV/N/yXnFveoAIU=
Received: by 10.239.167.83 with SMTP id f19mr753489hbe.34.1263859960577; Mon, 
	18 Jan 2010 16:12:40 -0800 (PST)
In-Reply-To: <7vmy0bhxn1.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137413>

[I am adding git@vger to the Cc list as this may be interesting to
others as well.]

On Mon, Jan 18, 2010 at 23:10, Junio C Hamano <gitster@pobox.com> wrote=
:
> Fredrik Kuivinen <frekui@gmail.com> writes:
>
>> diff --git a/builtin-grep.c b/builtin-grep.c
>> index 24ae1ce..dc07e9e 100644
>> --- a/builtin-grep.c
>> +++ b/builtin-grep.c
>> @@ -15,11 +15,257 @@
>> =A0#include "grep.h"
>> =A0#include "quote.h"
>>
>> +#ifndef NO_PTHREADS
>> +#include "thread-utils.h"
>> +#include <pthread.h>
>> +#endif
>> +
>> =A0static char const * const grep_usage[] =3D {
>> =A0 =A0 =A0 "git grep [options] [-e] <pattern> [<rev>...] [[--] path=
=2E..]",
>> =A0 =A0 =A0 NULL
>> =A0};
>>
>> +static int use_threads =3D 1;
>> +
>> +#ifndef NO_PTHREADS
>> +#define THREADS 8
>> +static pthread_t threads[THREADS];
>
> I had to wonder why builtin-pack-objects.c doesn't have an array like
> this. =A0It uses an array of structure each of which bundles per-thre=
ad
> work item data and pthread_t. =A0Would an arrangement like that make =
it
> easier to read for this patch as well?

=46rom a cursory look at builtin-pack-objects.c I think it depends on
how you structure the work you are about to do.

In builtin-pack-objects.c the work seems to be divided evenly among
the threads at the start. When some thread don't have anything to do
it then steals work from some other thread.

In the current patch we instead add work to a FIFO from one thread and
then the consumer threads pick work from the FIFO. I think the current
structure suits the FIFO style quite well.

>> +static void* load_file(const char *filename, size_t *sz);
>
> Style: asterisks stick to identifiers, not types. =A0There are other
> places with the same issue in the patch, e.g.
>> +static struct work_item* get_work()
> that I'll omit from the rest of my comments.

Will fix. I looked carefully at the arguments, but forgot the return ty=
pes.

>> +enum work_type {WORK_BUF, WORK_FILE};
>> +
>> +/* We use one producer thread and number_of_threads consumer
>> + =A0 threads. The producer adds struct work_items to 'todo' and the
>> + =A0 consumers pick work items from the same array. */
>
> Style:
>
> =A0 =A0 =A0 =A0/*
> =A0 =A0 =A0 =A0 * We write multi line comments
> =A0 =A0 =A0 =A0 * like this.
> =A0 =A0 =A0 =A0 */

Will fix.

>> +#define TODO_SIZE 128
>
> How was this size tuned? =A0Can everybody (from teeny machines to bee=
fy
> ones) use the same setting?

I simply increased it until I didn't see any more significant
performance improvements on two the boxes I have access to. As I only
have access to two boxes, it can most certainly be better tuned for
boxes with significantly different characteristics. However, I think
that 128 is reasonable in the sense that it gives a nice improvement
for everyone with more than one core.

>> +static struct work_item todo[TODO_SIZE];
>> +static int todo_start =3D 0;
>
> We try not to explicitly initialize statics to 0 and let BSS segment
> take care of them.

Will fix.

>> +/* This lock protects all the variables above. */
>> +static pthread_mutex_t grep_lock =3D PTHREAD_MUTEX_INITIALIZER;
>
> J6t had comments on these initializers; do they also apply to
> builtin-pack-objects.c?

I believe so, but I do not know. Johannes?

>> +/* This function takes ownership of 'name' and 'buf'. They will be
>> + =A0 deallocated with free. */
>> +static int grep_buffer_async(struct grep_opt *opt, char *name, char=
 *buf,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0size_t size)
>> +{
>> + =A0 =A0 add_work(WORK_BUF, name, buf, size);
>> + =A0 =A0 return 0;
>> +}
>> +
>> +static int grep_file_async(struct grep_opt *opt, char *name,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0const char *filenam=
e)
>> +{
>> + =A0 =A0 add_work(WORK_FILE, name, (char*) filename, 0);
>> + =A0 =A0 return 0;
>> +}
>
> If I am reading the code correctly, it seems that you read quite many
> blobs in core and queue them in todo[] (up to the size limit of the
> array), and the worker bees in run() consumes them. =A0Shouldn't the
> rate of feeding blobs be limited in some way (other than just having =
a
> fixed TODO_SIZE, but somehow linked to the rate the worker bees finis=
h
> their work) to avoid wasting memory like this? =A0One approach might =
be
> to queue only the blob SHA-1 not the data in work item queue just lik=
e
> you queue only the filename not the contents, and have the worker bee
> to read the blob into memory.

Hm, yes that would be an improvement. One just have serialize the
calls to read_sha1_file (as I don't think read_sha1_file safely can be
called simultaneously from multiple threads).

>> ...
>> +static int grep_buffer_internal(struct grep_opt *opt, char *name, c=
har *buf,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 size_t siz=
e)
>> +{
>> +#ifndef NO_PTHREADS
>> + =A0 =A0 if (use_threads)
>> + =A0 =A0 =A0 =A0 =A0 =A0 return grep_buffer_async(opt, name, buf, s=
ize);
>> +#endif
>> + =A0 =A0 {
>> + =A0 =A0 =A0 =A0 =A0 =A0 int hit =3D grep_buffer(opt, name, buf, si=
ze);
>> + =A0 =A0 =A0 =A0 =A0 =A0 free(name);
>> + =A0 =A0 =A0 =A0 =A0 =A0 free(buf);
>> + =A0 =A0 =A0 =A0 =A0 =A0 return hit;
>> + =A0 =A0 }
>> +}
>> +
>> =A0static int grep_config(const char *var, const char *value, void *=
cb)
>> =A0{
>> =A0 =A0 =A0 struct grep_opt *opt =3D cb;
>> @@ -159,21 +405,21 @@ static int grep_sha1(struct grep_opt *opt, con=
st unsigned char *sha1, const char
>> =A0 =A0 =A0 if (opt->relative && opt->prefix_length) {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 quote_path_relative(name + tree_name_len=
, -1, &pathbuf, opt->prefix);
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 strbuf_insert(&pathbuf, 0, name, tree_na=
me_len);
>> - =A0 =A0 =A0 =A0 =A0 =A0 name =3D pathbuf.buf;
>> + =A0 =A0 } else {
>> + =A0 =A0 =A0 =A0 =A0 =A0 strbuf_addstr(&pathbuf, name);
>> =A0 =A0 =A0 }
>> - =A0 =A0 hit =3D grep_buffer(opt, name, data, size);
>> - =A0 =A0 strbuf_release(&pathbuf);
>> - =A0 =A0 free(data);
>> +
>> + =A0 =A0 hit =3D grep_buffer_internal(opt, strbuf_detach(&pathbuf, =
NULL),
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0dat=
a, size);
>> +
>> =A0 =A0 =A0 return hit;
>> =A0}
>
> This is quite a puzzling code. =A0Your grep_buffer_internal() returns
> the return value from grep_buffer_async() which always return 0 but
> then that 0 is returned to the caller as "we didn't see any hit".
> What happens if we start optimizing for a case where the end user is
> interested only in one bit of information "does it find anything, or
> is there absolutely no hits?" and wanted to add an early return
> codepath to grep_tree() and grep_cache() so that we say "Ah, we have
> seen a hit, so we don't have to look in others"?
>
> IOW, this patch makes the variable "hit" meaningless and confuses the
> readers. =A0This actually is the point that most worries me from long=
er
> term maintenance point of view.

The idea was to keep the current calling conventions as much as
possible, so that grep_cache and grep_tree could stay nearly
unchanged. So hit =3D 1 now means "we found something" and hit =3D 0 me=
ans
"we didn't find anything right now, but we may find something later
for this entry". The early return you sketched above will still
produce correct results, but it will not be an optimization for the
threaded code.

With the patch the return value from grep_file and grep_sha1 has to be
ORed with the return value from wait_all to determine if we found
something.

> How is the order of output controlled by the way? =A0I see you are
> keeping more than one threads from doing write_or_die() of the
> accumulated output at the same time with a mutex in work_done(), but
> if we have large files whose names come near the beginning and then a
> small file whose name come later in the input, we should defer the
> output of hits from the later smaller one before the earlier larger
> ones even if the worker bee assigned to the smaller one finishes whil=
e
> the other worker bees are still searching in the larger ones; it is
> not obvious to me where you are guaranteeing that ordering.

The output order is controlled by todo_done, todo_start, and work_item:=
:done.

The rule is that the range [todo_done, todo_start) (modulo
ARRAY_SIZE(todo)) in "todo"=A0contains work_items have been or are
processed by a consumer thread. If a particular work_item has been
processed, then .done =3D 1 and otherwise .done=A0=3D=A00. When a work_=
item is
marked as done in "work_done" we traverse a prefix of the range
[todo_done, todo_start): we stop as soon as .done =3D=A00. We then set
todo_done to the first work_item with .done =3D=A00.

In your example todo_done =3D=A00 and todo_start =3D 2. todo[0] represe=
nts a
large file and todo[1] represents a small file. If the small file gets
done first we set todo[1].done to 1 in work_done. As todo_done =3D 0 an=
d
todo[0].done =3D 0 we will not write any output now. When work_done is
called for todo[0], we set todo[0].done to 1. We will then write the
output for todo[0] (as todo_done =3D 0 and todo[0].done =3D 1) and afte=
r
that we write the output for todo[1].

In the current patch the mutex grep_lock is held when the output is
written. I'm guessing that this unnecessary serialization is the cause
of the waste of CPU time Linus is seeing. (Strangely enough I haven't
observed this phenomena on the boxes I have tested it on.)

> I am wondering if this can somehow be made into a change with alot
> smaller inpact, in spirit similar to "preloading". =A0The higher leve=
l
> loop may walk the input (be it cache, tree, or directory), issuing on=
e
> grep_file() or grep_sha1() at a time just like the existing code, but
> the thread-aware code adds "priming" phase that (1) populates a "work
> queue" with a very small memory footprint, and that (2) starts more
> than one underlying grep on different files and blobs (up to the
> number of threads you are allowed, like your "#define THREADS 8"), an=
d
> that (3) upon completion of one "work queue" item, the work queue ite=
m
> is marked with its result.
>
> Then grep_file() and grep_sha1() _may_ notice that the work queue ite=
m
> hasn't completed, and would wait in such a case, or just emits the
> output produced earlier (could be much earlier) by the worker bee.
>
> The low-memory-footprint work queue could be implemented as a lazy
> one, and may be very different depending on how the input is created.
> If we are grepping in the index, it could be a small array of <array
> index in active_cache[], done-bit, result-bit, result-strbuf> with a
> single integer that is a pointer into the index to indicate up to
> which index entry the work queue has been populated.

I will have to think about this a bit more. It's getting late here.

- Fredrik
