From: Fredrik Kuivinen <frekui@gmail.com>
Subject: Re: [PATCH] Make xmalloc and xrealloc thread-safe
Date: Sat, 27 Mar 2010 14:26:20 +0100
Message-ID: <4c8ef71003270626y45685e69j28ccb8a8738b9083@mail.gmail.com>
References: <20100323161713.3183.57927.stgit@fredrik-laptop>
	 <20100323184309.GA31668@spearce.org>
	 <4c8ef71003231421u789c4332h461c066add0ec7b1@mail.gmail.com>
	 <alpine.LFD.2.00.1003231945480.31128@xanadu.home>
	 <4c8ef71003240823o7cd733bn5f19699305c94cba@mail.gmail.com>
	 <alpine.LFD.2.00.1003241133430.694@xanadu.home>
	 <ec874dac1003241122s3d592f26n1b23d23144939218@mail.gmail.com>
	 <alpine.LFD.2.00.1003241435300.694@xanadu.home>
	 <ec874dac1003241257r3cad86c9q1af84d3732e23ca8@mail.gmail.com>
	 <alpine.LFD.2.00.1003241613020.694@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Shawn Pearce <spearce@spearce.org>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Johannes Sixt <j6t@kdbg.org>
To: Nicolas Pitre <nico@fluxnic.net>
X-From: git-owner@vger.kernel.org Sat Mar 27 14:26:39 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NvW2A-000522-Pn
	for gcvg-git-2@lo.gmane.org; Sat, 27 Mar 2010 14:26:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753066Ab0C0N0X convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 27 Mar 2010 09:26:23 -0400
Received: from mail-fx0-f223.google.com ([209.85.220.223]:63339 "EHLO
	mail-fx0-f223.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752931Ab0C0N0W convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 27 Mar 2010 09:26:22 -0400
Received: by fxm23 with SMTP id 23so2804715fxm.21
        for <git@vger.kernel.org>; Sat, 27 Mar 2010 06:26:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:received:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=uCNS/1tsMH3gpvzxgAAIaqkCnAS6sWBdlSRx2pRTz10=;
        b=IOg+fbpz6tQcbWPdlOfBL3oDVGI7t0PNLAKb3UvRDeV0NrkGV2mEzE0nk4ZN98ksdr
         js8JiwvB+ceZTZ83kI0CXxAvYkDKO6aPZOqJOkM2vSGeLqyqZNqwz/FuBNdgJFR6atRQ
         SKBV4PWIFyMdsKl8R+7tlxuaBqywaY6+YVPRs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=RV/h9w1s+tcCc1wwu9vyVZipV0WQGgAQ/Z00154QYzzl7dDbeh/JWqpmnym6WGgvN4
         6aOMMoh8Ki292b5kAgG5jFHooRHwL6yZzPV0KRRZ3d9y/Y+0O+o9VKiteYjc7kNN8BS0
         wB9rwYEcY5An2haxhozxLCDatePIoMZVe7OIA=
Received: by 10.239.140.138 with HTTP; Sat, 27 Mar 2010 06:26:20 -0700 (PDT)
In-Reply-To: <alpine.LFD.2.00.1003241613020.694@xanadu.home>
Received: by 10.239.187.131 with SMTP id l3mr217347hbh.104.1269696380935; Sat, 
	27 Mar 2010 06:26:20 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143329>

On Wed, Mar 24, 2010 at 21:22, Nicolas Pitre <nico@fluxnic.net> wrote:
> By providing a hook for the routine responsible for trying to free so=
me
> memory on malloc failure, we can ensure that the =A0called routine is
> protected by the appropriate locks when threads are in play.
>
> The obvious offender here was pack-objects which was calling xmalloc(=
)
> within threads while release_pack_memory() is not thread safe.
>
> Signed-off-by: Nicolas Pitre <nico@fluxnic.net>
> ---
>
> On Wed, 24 Mar 2010, Shawn Pearce wrote:
>
>> On Wed, Mar 24, 2010 at 11:54 AM, Nicolas Pitre <nico@fluxnic.net> w=
rote:
>> > Another solution could be for xmalloc() to use a function pointer =
for
>> > the method to use on malloc error path, which would default to a
>> > function calling release_pack_memory(size, -1). =A0Then pack-objec=
ts.c
>> > would override the default with its own to acquire the read_mutex =
around
>> > the call to release_pack_memory(). =A0That is probably the easiest
>> > solution for now.
>>
>> Yea, that sounds like the most reasonable solution right now.
>
> So here it is.
>
> Note: there was a dubious usage of fd when calling release_pack_memor=
y()
> in xmmap() which is now removed.
>
> diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
> index 9780258..65f797f 100644
> --- a/builtin/pack-objects.c
> +++ b/builtin/pack-objects.c
> @@ -1522,6 +1522,13 @@ static void find_deltas(struct object_entry **=
list, unsigned *list_size,
>
> =A0#ifndef NO_PTHREADS
>
> +static void try_to_free_from_threads(size_t size)
> +{
> + =A0 =A0 =A0 read_lock();
> + =A0 =A0 =A0 release_pack_memory(size, -1);
> + =A0 =A0 =A0 read_unlock();
> +}
> +

Will this really work in all cases? In the find_deltas -> try_delta ->
read_sha1_file -> ... -> xmalloc call path, the mutex is already
locked when we get to xmalloc. As the mutex is of the default type
(NULL is passed as the mutex attribute argument to
pthread_mutex_init), it is undefined behaviour to lock the mutex again
(see http://www.opengroup.org/onlinepubs/007908799/xsh/pthread_mutexatt=
r_gettype.html
)

I just realised that builtin/grep.c also needs a fix for its use of xma=
lloc.

- Fredrik
