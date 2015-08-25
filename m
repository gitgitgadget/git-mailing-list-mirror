From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 2/6] builtin/am: make sure state files are text
Date: Tue, 25 Aug 2015 09:19:13 -0700
Message-ID: <xmqqtwrn1gu6.fsf@gitster.dls.corp.google.com>
References: <xmqqzj1g31e5.fsf@gitster.dls.corp.google.com>
	<1440449890-29490-1-git-send-email-gitster@pobox.com>
	<1440449890-29490-3-git-send-email-gitster@pobox.com>
	<20150824235547.GB13261@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Aug 25 18:19:23 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZUGwT-0007Bd-Fq
	for gcvg-git-2@plane.gmane.org; Tue, 25 Aug 2015 18:19:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755512AbbHYQTR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Aug 2015 12:19:17 -0400
Received: from mail-pa0-f50.google.com ([209.85.220.50]:36062 "EHLO
	mail-pa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755058AbbHYQTP (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Aug 2015 12:19:15 -0400
Received: by padfo6 with SMTP id fo6so12155950pad.3
        for <git@vger.kernel.org>; Tue, 25 Aug 2015 09:19:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=5pa9oltLgl7+9I0a9HewyEDeHutZabVLim0A2Kv4kwE=;
        b=hWQPspqqLrLrDoMJiiNNOHjjgfrCVzYd7BYod+hiDBjAFKWXKQ6DGznqszKeThZUg+
         EmhXPUFV5cwjv9cAp2iZxobXJEhfU+mHu6nqYOZHHL3l8HSEarRXxGFgbCbJueLxLV5e
         tQksSW967cP/bG/v+DmBn/bS7sZl8x3SSK22SU3C8B3ZppRDqJ/sOk9yktcj1gW+949S
         deGB0O5/kb7bZu0JMDMelJ/e0wlGpAhpVi72MtYvQzIgtWmM+9iHg7mm3kzb5CNOLSTd
         +1PUFgDzRyATGw7wL9gpwOGI3KW/LclQdUcACVslwe42qSzYgs4qXAxBlKnjidlo62ai
         hDAA==
X-Received: by 10.68.169.69 with SMTP id ac5mr58491276pbc.14.1440519554636;
        Tue, 25 Aug 2015 09:19:14 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:cdc0:fd6d:4069:6223])
        by smtp.gmail.com with ESMTPSA id nt6sm21583240pdb.73.2015.08.25.09.19.13
        (version=TLS1_2 cipher=AES128-SHA256 bits=128/128);
        Tue, 25 Aug 2015 09:19:13 -0700 (PDT)
In-Reply-To: <20150824235547.GB13261@sigill.intra.peff.net> (Jeff King's
	message of "Mon, 24 Aug 2015 19:55:47 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276534>

Jeff King <peff@peff.net> writes:

> On Mon, Aug 24, 2015 at 01:58:06PM -0700, Junio C Hamano wrote:
>
>> We forgot to terminate the payload given to write_file() with LF,
>> resulting in files that end with an incomplete line.  Teach the
>> wrappers builtin/am uses to make sure it adds LF at the end as
>> necessary.
>
> Is it even worth doing this step? It's completely reverted later in the
> series. I understand that we do not want to hold the fix to git-am
> hostage to write_file refactoring, but I don't see any reason these
> cannot all graduate as part of the same topic.
>
> Ignore me if you really are planning on doing the first two to "maint"
> and holding the others back for "master".

Not really.  The primary reason why this step exists and 1-2/6 make
a sufficient fix by themselves is because I wasn't even sure if
3-6/6 were worth doing.

As to "flags exposed to callers" vs "with and without gently", when
we change the system to allow new modes of operations (e.g. somebody
wants to write a binary file, or allocate more flag bits for their
special case), I'd expect that we'd add a more general and verbose
"write_file_with_options(path, flags, fmt, ...)"), gain experience
with that function, and then possibly introduce canned thin wrappers
(e.g. write_binary_file() that is a synonym to passing BINARY but
not GENTLY) if the new thing proves widely useful, just like I left
write_file() and write_file_gently() in as fairly common things to
do.
