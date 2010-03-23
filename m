From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH 7/6] Enable threaded async procedures whenever pthreads is  available
Date: Tue, 23 Mar 2010 21:19:18 +0100
Message-ID: <201003232119.19430.j6t@kdbg.org>
References: <cover.1267889072.git.j6t@kdbg.org> <201003172228.18939.j6t@kdbg.org> <4c8ef71003230115y64d36094y178fcfe6576e9c66@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	"Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Fredrik Kuivinen <frekui@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 23 21:21:32 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NuAbT-000786-4w
	for gcvg-git-2@lo.gmane.org; Tue, 23 Mar 2010 21:21:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751776Ab0CWUV0 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 23 Mar 2010 16:21:26 -0400
Received: from bsmtp4.bon.at ([195.3.86.186]:35025 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751492Ab0CWUVZ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Mar 2010 16:21:25 -0400
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id 4CAFD10017;
	Tue, 23 Mar 2010 21:21:20 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by dx.sixt.local (Postfix) with ESMTP id AE41119F6B8;
	Tue, 23 Mar 2010 21:19:19 +0100 (CET)
User-Agent: KMail/1.9.10
In-Reply-To: <4c8ef71003230115y64d36094y178fcfe6576e9c66@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143046>

On Dienstag, 23. M=E4rz 2010, Fredrik Kuivinen wrote:
> On Wed, Mar 17, 2010 at 22:28, Johannes Sixt <j6t@kdbg.org> wrote:
> > ----------
> > convert.c:filter_buffer()
> ...
> Maybe I'm missing something but, isn't it possible that xrealloc is
> called simultaneously from the two threads if GIT_TRACE is set?
>
> Immediately after start_async the parent calls strbuf_read. We then
> get the call chain
> strbuf_read -> strbuf_grow -> ALLOG_GROW -> xrealloc, so xrealloc is
> called before we read any data in the parent.
>
> In the child we have start_command -> trace_argv_printf -> strbuf_gro=
w ->
> ...

Outch! You are right. It seems I missed the call of strbuf_grow before =
the=20
loop in strbuf_read.

OK, this means that convert.c is not safe if (and only if) GIT_TRACE is=
=20
set. :-(

> That xmalloc and xrealloc aren't thread-safe feels a bit fragile.
> Maybe we should try to fix that.

The point of this assessment was to find out whether this is necessary =
(and=20
whether something else that is not thread-safe is used).

> > ----------
> > upload_pack:create_pack_file():=20
> ...
> sha1_to_hex is also called by the parent and the current
> implementation of that function is not thread-safe. sha1_to_hex is
> also called by some paths in the revision machinery, but I don't know
> if it will ever be called in this particular case.

sha1_to_hex is only called by the parent when the async procedure is no=
t used.

-- Hannes
