From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v2 01/10] sequencer.c: remove broken support for rfc2822
 continuation in footer
Date: Tue, 22 Jan 2013 02:12:08 -0800
Message-ID: <20130122101208.GC8908@elie.Belkin>
References: <1358757627-16682-1-git-send-email-drafnel@gmail.com>
 <1358757627-16682-2-git-send-email-drafnel@gmail.com>
 <20130122075413.GB6085@elie.Belkin>
 <CA+sFfMfERgGbf58LjOfAhhO_-YLu+yo+L-vYMuAuOUaP90yvgA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: gitster@pobox.com, pclouds@gmail.com, git@vger.kernel.org,
	Brandon Casey <bcasey@nvidia.com>
To: Brandon Casey <drafnel@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jan 22 11:12:41 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TxaqO-0006Kh-Q1
	for gcvg-git-2@plane.gmane.org; Tue, 22 Jan 2013 11:12:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753251Ab3AVKMQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Jan 2013 05:12:16 -0500
Received: from mail-pb0-f54.google.com ([209.85.160.54]:52230 "EHLO
	mail-pb0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752851Ab3AVKMO (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Jan 2013 05:12:14 -0500
Received: by mail-pb0-f54.google.com with SMTP id rr4so2035301pbb.13
        for <git@vger.kernel.org>; Tue, 22 Jan 2013 02:12:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=4r1mKENWaE+xU459HOCMM1ZSWUBr+r7WXyzJjZ3S3h0=;
        b=cOWvhrVvRUXIB6ymTSjP15oFj0N53yGiwNZxVGrmswFUbnsUY2HRoAWgwo+r/oh4kZ
         lGx91r70xmA51YRaKGbcybRQa4xVO1ec7S0KnDkEyF4FgE4/Edyncv4IyV9BpEVotQ4Z
         p5rk9tXut/JqYGNaQ5at2sx2GcABtrAXKoc4nAH57Uk2LYiMb9KqK2mSoMRFjVzAFsd/
         IVtFq3bAhGQAVFClAIxvmx2Av/IxMM0VSjNPkTiHASUOrzqMVU4QMMUKi8RZpMwu4nZi
         G9qabRedpuxcT8xxQVNkGJBKZUCExgq3uSMcnmiNsYovBngqOWXloFuhzgJCxwcaz5vc
         zGGw==
X-Received: by 10.68.130.170 with SMTP id of10mr37867224pbb.131.1358849533931;
        Tue, 22 Jan 2013 02:12:13 -0800 (PST)
Received: from elie.Belkin (c-107-3-135-164.hsd1.ca.comcast.net. [107.3.135.164])
        by mx.google.com with ESMTPS id pl10sm10477480pbc.60.2013.01.22.02.12.11
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 22 Jan 2013 02:12:12 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <CA+sFfMfERgGbf58LjOfAhhO_-YLu+yo+L-vYMuAuOUaP90yvgA@mail.gmail.com>
User-Agent: Mutt/1.5.21+51 (9e756d1adb76) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214229>

Brandon Casey wrote:
> On Mon, Jan 21, 2013 at 11:54 PM, Jonathan Nieder <jrnieder@gmail.com> wrote:

>>> -             if ((buf[k] == ' ' || buf[k] == '\t') && !first)
>>> -                     continue;
>>
>> This is always the first line examined, so this "continue" never
>> triggers.
>
> This is just totally broken and always has been.  The index variable
> should be 'i' not 'k'.

Yes, now I see.

This test trips when the *next* line starts with ' ' or '\t'.

	commit, cherry-pick -s: remove broken support for multiline rfc2822 fields

	Starting with c1e01b0c (commit: More generous accepting of RFC-2822
	footer lines, 2009-10-28), "git commit -s" carefully parses the last
	paragraph of each commit message to check if it consists only of
	RFC2822-style headers, in which case the signoff will be added as a
	new line in the same list:

		Reported-by: Reporter <reporter@example.com>
		Signed-off-by: Author <author@example.com>
		Acked-by: Lieutenant <lt@example.com>

	It even included support for accepting indented continuation lines for
	multiline fields.  Unfortunately the multiline field support is broken
	because it checks whether buf[k] (the first character of the *next*
	line) instead of buf[i] is a whitespace character.  So for example, it
	confuses the following for a well-formed RFC2822 footer:

		Reported-by: Reporter <reporter@example.com>
		LINE NOISE
		 continuation
		 continuation

	A typical well-formed footer with multiline fields is not accepted:

		Reported-by: Re Porter
		 <reporter@example.com>
		Signed-off-by: Author <author@example.com>

	That this has remained broken for so long is a good sign that nobody
	actually needed continuation lines.  Rip out the broken continuation
	support.
