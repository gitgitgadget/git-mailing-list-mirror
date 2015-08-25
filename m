From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 2/6] builtin/am: make sure state files are text
Date: Tue, 25 Aug 2015 11:41:35 -0700
Message-ID: <xmqq8u8zyzvk.fsf@gitster.dls.corp.google.com>
References: <xmqqzj1g31e5.fsf@gitster.dls.corp.google.com>
	<1440449890-29490-1-git-send-email-gitster@pobox.com>
	<1440449890-29490-3-git-send-email-gitster@pobox.com>
	<20150824235547.GB13261@sigill.intra.peff.net>
	<xmqqtwrn1gu6.fsf@gitster.dls.corp.google.com>
	<20150825164701.GA10060@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Aug 25 20:41:43 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZUJAE-0002oO-8f
	for gcvg-git-2@plane.gmane.org; Tue, 25 Aug 2015 20:41:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755458AbbHYSli (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Aug 2015 14:41:38 -0400
Received: from mail-pa0-f54.google.com ([209.85.220.54]:34301 "EHLO
	mail-pa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751865AbbHYSlh (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Aug 2015 14:41:37 -0400
Received: by pabzx8 with SMTP id zx8so41551379pab.1
        for <git@vger.kernel.org>; Tue, 25 Aug 2015 11:41:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=YUqLbN6X08TFZF85uf1NVxm92SbjfmFaELyH9YCqerQ=;
        b=uJYQQSlsSYq11hYAq8cpGzolACfVfiDFk5nZEvsGHYRJP1iXHTUK56GSjVd96I2vY9
         DMN1wzn8wog5cILj+CaPFiluccP6lSnfQLt8llV4veGSXMy8X/EwGB0s+AVlyJLNDS+Q
         dOx2O1r6l9ErgIRObyPhyKzeWkU4mJBx2/j/J/R5xM+C4pkutOoephdq/EJtdnqplxqO
         sM1vda6ErVz4J84xsJIVZqkY9TOQfTFlcmuce/RHD0eN4d3QXcQZouxpF3aZXfJqpKts
         KybvTLT3/i+JPxAtB32iPN88MscOQH0gVER/zbd2h0vrHomYmLNcaOVkkBoxQv/yhrSC
         r1xA==
X-Received: by 10.68.227.8 with SMTP id rw8mr59835009pbc.74.1440528097195;
        Tue, 25 Aug 2015 11:41:37 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:cdc0:fd6d:4069:6223])
        by smtp.gmail.com with ESMTPSA id fw15sm21901748pdb.26.2015.08.25.11.41.36
        (version=TLS1_2 cipher=AES128-SHA256 bits=128/128);
        Tue, 25 Aug 2015 11:41:36 -0700 (PDT)
In-Reply-To: <20150825164701.GA10060@sigill.intra.peff.net> (Jeff King's
	message of "Tue, 25 Aug 2015 12:47:01 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276557>

Jeff King <peff@peff.net> writes:

> On Tue, Aug 25, 2015 at 09:19:13AM -0700, Junio C Hamano wrote:
>
>> As to "flags exposed to callers" vs "with and without gently", when
>> we change the system to allow new modes of operations (e.g. somebody
>> wants to write a binary file, or allocate more flag bits for their
>> special case), I'd expect that we'd add a more general and verbose
>> "write_file_with_options(path, flags, fmt, ...)"), gain experience
>> with that function, and then possibly introduce canned thin wrappers
>> (e.g. write_binary_file() that is a synonym to passing BINARY but
>> not GENTLY) if the new thing proves widely useful, just like I left
>> write_file() and write_file_gently() in as fairly common things to
>> do.
>
> Yeah, that works. It is a bit of a gamble to me. If we never add a lot
> more options, the end result is much nicer (callers do not deal with the
> flag option at all). But if we do, we end up with the mess that
> get_sha1_with_* and add_pending_object() got into.

Yeah.  I do not know.  Perhaps a good intermim solution for now
would be to make

  - write_file_l(path, flags, fmt, ...);

the low-level helper, with a single convenience wrapper:

  - write_file(path, fmt, ...)

for everybody other than two "gently" ones to use.  Two "gently"
ones can call write_file_l(path, WRITE_FILE_GENTLY, fmt,...).

You are right about binary stuff.  You could do fmt="...%c..."  and
pass '\0' to corresponding place if your NUL is in the fixed part of
the data you are generating, but otherwise write_file() interface is
a very useful way to handle binary.
