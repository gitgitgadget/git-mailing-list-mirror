From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v3 00/15] ref-filter: use parsing functions
Date: Wed, 6 Jan 2016 16:14:41 -0500
Message-ID: <CAPig+cRjXHmBnnmHbbibeV-gcvwMFQc7-5ce4s2OHu+wQwMy4Q@mail.gmail.com>
References: <1451980994-26865-1-git-send-email-Karthik.188@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Karthik Nayak <karthik.188@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jan 06 22:14:50 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aGvPq-0001Mt-QS
	for gcvg-git-2@plane.gmane.org; Wed, 06 Jan 2016 22:14:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752003AbcAFVOn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Jan 2016 16:14:43 -0500
Received: from mail-vk0-f66.google.com ([209.85.213.66]:32794 "EHLO
	mail-vk0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751906AbcAFVOm (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Jan 2016 16:14:42 -0500
Received: by mail-vk0-f66.google.com with SMTP id n1so697842vkb.0
        for <git@vger.kernel.org>; Wed, 06 Jan 2016 13:14:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=Fliti4KkZKM52ofx0JgoOuRZVbWPOVFNnMx/qN5kJag=;
        b=xdyYTBoQ6X+GLkfp2ZmCl4OUvfTSM7mo6EA3QEAgzZdFQkai30OM1IbT2YQ7PrxvEN
         Cig7HmJ49s7sVfMTc7gOrZnxkueIGRQViGhqIZvOetNGDLI75C+d3KVF07fhwK+AVMR5
         /0ML0SNm2rpMPMAov7gDHAxWWFVCHRecBqEaNVmoxV/1dRGHgXa1BZWloudQWFi3g6Z3
         TvfxlFiBtPjBiCKNUTMfj3X5iiROINN082yu02A8ciSRU/TNBQeCKvqaUz34RV6SA+xI
         p5hDD/jX4bXl7IrZENcw+S6mNfgTsLY1uox0suGlOcKLuOjq3YmrN0GjJmhhtRmjM3K+
         GnzA==
X-Received: by 10.31.164.78 with SMTP id n75mr38633510vke.14.1452114881475;
 Wed, 06 Jan 2016 13:14:41 -0800 (PST)
Received: by 10.31.62.203 with HTTP; Wed, 6 Jan 2016 13:14:41 -0800 (PST)
In-Reply-To: <1451980994-26865-1-git-send-email-Karthik.188@gmail.com>
X-Google-Sender-Auth: GfgSOz53b-ELkZli5AhyFMWg3dw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283454>

On Tue, Jan 5, 2016 at 3:02 AM, Karthik Nayak <karthik.188@gmail.com> wrote:
> Eric suggested that I make match_atom_name() not return a value [0]. I
> haven't done that as we use match_atom_name() in [14/15] for matching
> 'subject' and 'body' in contents_atom_parser() and although Eric
> suggested I use strcmp() instead, this would not work as we need to
> check for derefernced 'subject' and 'body' atoms.
> [0]: http://article.gmane.org/gmane.comp.version-control.git/282701

I don't understand the difficulty. It should be easy to manually skip
the 'deref' for this one particular case:

    const char *name = atom->name;
    if (*name == '*')
        name++;

Which would allow this unnecessarily complicated code from patch 14/15:

    if (match_atom_name(atom->name, "subject", &buf) && !buf) {
        ...
        return;
    } else if (match_atom_name(atom->name, "body", &buf) && !buf) {
        ...
        return;
    } if (!match_atom_name(atom->name, "contents", &buf))
        die("BUG: parsing non-'contents'");

to be simplified to the more easily understood form suggested during
review[1] of v2:

    if (!strcmp(name, "subject")) {
        ...
        return;
    } else if (!strcmp(name, "body")) {
        ...
        return;
    } else if (!match_atom_name(name,"contents", &buf))
        die("BUG: expected 'contents' or 'contents:'");

You could also just use (!strcmp("body") || !strcmp("*body")) rather
than skipping "*" manually, but the repetition makes that a bit
noisier and uglier.

[1]: http://article.gmane.org/gmane.comp.version-control.git/282645
