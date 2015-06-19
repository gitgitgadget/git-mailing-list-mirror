From: Paul Tan <pyokagan@gmail.com>
Subject: Re: [PATCH/WIP v3 07/31] am: extract patch, message and authorship
 with git-mailinfo
Date: Sat, 20 Jun 2015 00:15:41 +0800
Message-ID: <CACRoPnQdR7qC6gH7j9_8gQUYKShLRQCr6GNtmn+XCpe9P4P-nA@mail.gmail.com>
References: <1434626743-8552-1-git-send-email-pyokagan@gmail.com>
	<1434626743-8552-8-git-send-email-pyokagan@gmail.com>
	<xmqqtwu4d8pg.fsf@gitster.dls.corp.google.com>
	<CACRoPnS9eyBF5NEM7sKvep+A8aKUNLJDaV-1c_oWDBwMcv26Bg@mail.gmail.com>
	<CAPc5daVbpB_T4cY1xvLrBKPUZw0JNMXqNAOsKE-R7NPO2nrnZA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Stefan Beller <sbeller@google.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jun 19 18:16:09 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z5yxc-0003ql-Ik
	for gcvg-git-2@plane.gmane.org; Fri, 19 Jun 2015 18:16:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754663AbbFSQPw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Jun 2015 12:15:52 -0400
Received: from mail-wi0-f172.google.com ([209.85.212.172]:36936 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754549AbbFSQPn (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Jun 2015 12:15:43 -0400
Received: by wicgi11 with SMTP id gi11so23211408wic.0
        for <git@vger.kernel.org>; Fri, 19 Jun 2015 09:15:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=d2zG42TJVDtmgSiC2xP8d2zGFQhcCoQVGFc6mH5EQzI=;
        b=Dje2g+MAhdI7owVGMVOsP9lxofUNIXBJAT1M1gYpHpkexa6YAU05NwrC+kWGSPL3E2
         6p2du5GhtPyqM3858jSBH74h5fsKWg7FJ13821+rAdDcj3no6xR6nLaNpnXjByBXhL8A
         IZtKmiQwOqNnG4bA+pORykqmzTcHTgYJow4yyAXzY8Khr+mtwwUsYS2OwF3qZYpM7AHX
         BTI6aLBJN5XGM897jpkFymshpYAMDspsLdQk5IfHDVYVPy6lMjaqeKrRmYuy+C+9oIow
         PHoHvrL5QU15WMNLnIDhQ4LNLSpB9tHdW8DDWuEjo4G3l9bIa9/bKjdLrcNO/lGqZIa2
         hRhw==
X-Received: by 10.180.95.101 with SMTP id dj5mr8158919wib.16.1434730541193;
 Fri, 19 Jun 2015 09:15:41 -0700 (PDT)
Received: by 10.194.85.113 with HTTP; Fri, 19 Jun 2015 09:15:41 -0700 (PDT)
In-Reply-To: <CAPc5daVbpB_T4cY1xvLrBKPUZw0JNMXqNAOsKE-R7NPO2nrnZA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272165>

On Fri, Jun 19, 2015 at 11:09 PM, Junio C Hamano <gitster@pobox.com> wrote:
> You do realize that strbuf internally does alloc/free so as a solution to
> fragmentation issue you are at the mercy of the same alloc/free, don't you?

Yes, of course, but it has the "alloc" variable to keep track of the
size of the allocated buffer, and provided that ALLOC_GROW() uses a
sensible factor to grow the buffer, it won't be calling malloc/free
that much to be a problem.

Of course, we could do the same and just add a "alloc" variable as
well and then use it with strbuf_attach()/strbuf_detach(), but at this
point why not just store it in an strbuf then and avoid the extra
"alloc" struct member?

> The primary thing I care about is to discourage callers of the API element
> am_state from touching these fields with strbuf functions. If it is char * then
> the would think twice before modifying (which would involve allocating the
> new buffer, forming the new value and assigning into it). With the fields left
> as strbuf after they are read or formed by the API (by reading by the API
> implementation from $GIT_DIR/rebase-apply/), it is too tempting to do
> strbuf_add(), strbuf_trim(), etc., without restoring the value to the original
> saying "I'm the last user of it anyway"--that is the sloppiness we can prevent
> by not leaving it as strbuf.

I don't think this is a good deterrent. If the code wanted to, it
could just use strbuf_attach()/strbuf_detach() as well, no?

I believe this kind of issue would be better solved with a big WARNING
comment and code review.

Also, there may be use cases where the user may wish to modify the
commit message/author fields. E.g., user may wish to modify the
message of the commit that results from am --continue to take into
account the conflicts that caused the am to fail.

Regards,
Paul
