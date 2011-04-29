From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] lookup_object(): Speed up 'git gc' by 12%, by reducing
 hash chain length
Date: Thu, 28 Apr 2011 23:58:17 -0700
Message-ID: <7vtydh1r3q.fsf@alter.siamese.dyndns.org>
References: <20110427213502.GA13647@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>
To: Ingo Molnar <mingo@elte.hu>
X-From: git-owner@vger.kernel.org Fri Apr 29 08:58:36 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QFheu-00088d-0P
	for gcvg-git-2@lo.gmane.org; Fri, 29 Apr 2011 08:58:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755298Ab1D2G6b (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Apr 2011 02:58:31 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:53348 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755016Ab1D2G6a (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Apr 2011 02:58:30 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id ACA643151;
	Fri, 29 Apr 2011 03:00:29 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=xbCmT+0cbQHTtYjCvHwMV3eMy7Y=; b=Ai48zG
	yvpgV32/7zLoh2ge8wY0RSJziY1pMllqWX5voxGHkW41DAmkPIWfrA7VYGvPtClL
	UBOE7tfPUpRv4+a2sWPiykEAJLrE69VegWiCUMiXwUEUZp0KloMvmlvLH9k/S3pa
	qMqHc8684pZeykM8aDi4ifR3ceNAVeX3O/2Rc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=S1XDbE55Qe5QZiLM1UOsNt1iMiukD6wO
	ZLyu0Z9I6/dBPmzSnlxYarcmzdSZUQBqX0mR/I9HQ7CbVdhHH48owdkV1akt4cHa
	yY6jI+VXQ1DxoM947hsw7ZhYDjzfR+7XBhkYf4WZ4wzuHGg1MNfl+YMeaUPGIXvi
	sVJYzL/c8to=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 79F9F3150;
	Fri, 29 Apr 2011 03:00:25 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id C8367314F; Fri, 29 Apr 2011
 03:00:20 -0400 (EDT)
In-Reply-To: <20110427213502.GA13647@elte.hu> (Ingo Molnar's message of "Wed,
 27 Apr 2011 23:35:02 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 5BBB74E2-722E-11E0-811B-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172429>

Ingo Molnar <mingo@elte.hu> writes:

> diff --git a/object.c b/object.c
> index 7e1f2bb..b3fe485 100644
> --- a/object.c
> +++ b/object.c
> @@ -91,7 +91,7 @@ struct object *lookup_object(const unsigned char *sha1)
>  static void grow_object_hash(void)
>  {
>  	int i;
> -	int new_hash_size = obj_hash_size < 32 ? 32 : 2 * obj_hash_size;
> +	int new_hash_size = obj_hash_size < 32 ? 32 : 16 * obj_hash_size;
>  	struct object **new_hash;
>  
>  	new_hash = xcalloc(new_hash_size, sizeof(struct object *));
> @@ -116,7 +116,7 @@ void *create_object(const unsigned char *sha1, int type, void *o)
>  	obj->flags = 0;
>  	hashcpy(obj->sha1, sha1);
>  
> -	if (obj_hash_size - 1 <= nr_objs * 2)
> +	if (obj_hash_size - 1 <= nr_objs * 16)
>  		grow_object_hash();
>  
>  	insert_obj_hash(obj, obj_hash, obj_hash_size);

Shawn was telling me about this exact topic a few months ago, and I do
agree that object hash grows too slowly when you need to slurp in many
objects.

A few random thoughts, some are related and others are unrelated to what
your patch does:

 - We start out from a tiny table of 32 entries.  Would it make things
   noticeably worse if we start with a larger table for a workload that
   touch only a few dozen objects?  How about starting from a table with
   say 4 pages worth of pointers, or something?  Note that this is not
   about helping the case with near full-walk.

 - I agree x2 is growing the table too slowly, but at the same time, I do
   not think x16 is growing fast enough, if you will end up slurping
   millions of objects.  You would still need to rehash 5 times (maybe 4,
   I cannot count).

   Worse yet, the later rehash costs proportionally more (IOW having to
   rehash 5 times is not just 25% more expensive than having to rehash 4
   times).

 - If we grow the table too fast, wouldn't it make the largest table we
   could use smaller?  When we try to grow a large but crowded table by
   x2, we may be able to get enough core to rehash, but we may not be able
   to allocate x16 such an already large table.

I have this hunch that the workloads that truly require to hold huge
number of objects are limited, and we can enumerate them relatively
easily.  The callchain from gc to repack to pack-objects is one.  The
codepath in pack-objects that is called from "repack -a -d" should be able
to guess that it needs to slurp everything from the fact that there is no
negative ref given in the revision walking machinery.  It also should be
able to guess if the repository has large number of objects by looking at
the existing pack .idx files (they record the number of objects the
corresponding .pack files contain in a way that is cheap to read).

It might make sense to give an explicit hit to grow_object_hash() in such
a case (i.e. the caller e.g. pack-objects sets a flag for it to notice),
and have grow_object_hash() immediately jump to a huge hash size.
