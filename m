From: Fredrik Kuivinen <frekui@gmail.com>
Subject: Re: [PATCH 7/6] Enable threaded async procedures whenever pthreads is 
	available
Date: Tue, 23 Mar 2010 09:15:45 +0100
Message-ID: <4c8ef71003230115y64d36094y178fcfe6576e9c66@mail.gmail.com>
References: <cover.1267889072.git.j6t@kdbg.org>
	 <201003092100.36616.j6t@kdbg.org>
	 <7v7hpjq0aw.fsf@alter.siamese.dyndns.org>
	 <201003172228.18939.j6t@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	"Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Tue Mar 23 09:15:56 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NtzHI-0007am-58
	for gcvg-git-2@lo.gmane.org; Tue, 23 Mar 2010 09:15:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754695Ab0CWIPu convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 23 Mar 2010 04:15:50 -0400
Received: from mail-fx0-f213.google.com ([209.85.220.213]:65203 "EHLO
	mail-fx0-f213.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753822Ab0CWIPr convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 23 Mar 2010 04:15:47 -0400
Received: by fxm5 with SMTP id 5so2478332fxm.29
        for <git@vger.kernel.org>; Tue, 23 Mar 2010 01:15:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=jfSPQAIvBGgFXCCxQsCo21Q0hZSVi9zNSOyn5zZ3cW4=;
        b=k4a801rHjgaWDn10Rvu41mUy0gQvTdSxbMB2YdA9LsWMLmKvXF+P7YesnfdVe+U38J
         FCJH93DMwTt/sw5iqw50lPQfOM0qQMs1j4jz8TbT+Aq0FlVFfDnCthvKqX5A7mrnMxV9
         taa/T538Z7ELre8FC4Eo29GPp3LAUmzZNwcHA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=NzZLe5CNTQ2n8hN792dftA3C6HqOyce8LjFZWAkRou2SBw7ndAJfGbRP8c1JB+Nd7Q
         cwOFSNB0rMUOnK4ejwA1tT1E78t+zh7ZwLQTfl24PV4I6gu/d6LNVVvfqyucfgVtj9VL
         wdyHHTazw7T3VIocQfW0hKpR6lKlmyk6v110Y=
Received: by 10.239.177.197 with SMTP id w5mr528242hbf.79.1269332145802; Tue, 
	23 Mar 2010 01:15:45 -0700 (PDT)
In-Reply-To: <201003172228.18939.j6t@kdbg.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142996>

On Wed, Mar 17, 2010 at 22:28, Johannes Sixt <j6t@kdbg.org> wrote:
> On Mittwoch, 10. M=E4rz 2010, Junio C Hamano wrote:
>> Johannes Sixt <j6t@kdbg.org> writes:
>> > On Samstag, 6. M=E4rz 2010, Shawn O. Pearce wrote:
>> >> I'm in favor of that. =A0If we have threaded delta search enabled=
,
>> >> we probably can also run these async procedures in a POSIX thread
>> >> rather than forking off a child.
>> >
>> > OK. The patch could look like this.
>>
>> Will queue in 'pu', but as Shawn said, we should probably give anoth=
er
>> closer look at the callees that are started with this interface befo=
re
>> moving forward.
>
> So here is my analysis.
>
> There are currently these users of the async infrastructure:
>
> builtin-fetch-pack.c
> builtin-receive-pack.c
> builtin-send-pack.c
> convert.c
> remote-curl.c
> upload_pack.c
>
> The list below shows all functions that read or write potentially glo=
bal state
> that are called from the async procedure (except for upload_pack.c, s=
ee
> below). I ignored all functions that do not depend on global state, l=
ike
> strcmp, memcpy, sprintf, strerror, etc.
>

> ----------
> convert.c:filter_buffer()
> =A0pipe
> =A0close
> =A0getenv
> =A0fork
> =A0read
> =A0write
> =A0fprintf
> =A0waitpid
>
> if GIT_TRACE is set:
> =A0xrealloc
> =A0die
> =A0free
>
> This one is less trivial. It calls start_command+finish_command from =
the async
> procedure. The parent calls
> =A0read()
> =A0xrealloc() (via strbuf_read())
> =A0error()
> (and nothing else) between start_async() and finish_async().
>
> As long as GIT_TRACE is not set, we are safe, because the async proce=
dure
> carefully releases all global resources that it allocated, and the pa=
rent is
> looking in the other direction while it does os. Even if GIT_TRACE is=
 set,
> xrealloc() in the parent and the async procedure cannot be called
> simultanously because the procedure calls it only before it begins wr=
iting
> output, and the parent only after it received this output.

Maybe I'm missing something but, isn't it possible that xrealloc is
called simultaneously from the two threads if GIT_TRACE is set?

Immediately after start_async the parent calls strbuf_read. We then
get the call chain
strbuf_read -> strbuf_grow -> ALLOG_GROW -> xrealloc, so xrealloc is
called before we read any data in the parent.

In the child we have start_command -> trace_argv_printf -> strbuf_grow =
-> ...

That xmalloc and xrealloc aren't thread-safe feels a bit fragile.
Maybe we should try to fix that.

> ----------
> upload_pack:create_pack_file(): This user is different because it cal=
ls into
> the revision walker in the async procedure, which definitely affects =
global
> state. Therefore, here is the list of functions called by the parent =
until it
> exits:
> =A0pipe
> =A0close
> =A0getenv
> =A0fork
> =A0read
> =A0write
> =A0fprintf
> =A0waitpid
> =A0alarm
> =A0die
> =A0die_errno
> =A0pthread_join / waitpid

sha1_to_hex is also called by the parent and the current
implementation of that function is not thread-safe. sha1_to_hex is
also called by some paths in the revision machinery, but I don't know
if it will ever be called in this particular case.

Maybe it would be a good idea to create wrappers for getenv, setenv,
unsetenv, and putenv to make them thread-safe as well. Then won't have
to worry about them in the future.

- Fredrik
