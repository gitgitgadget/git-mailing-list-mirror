From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v2 2/3] fast-export: improve speed by skipping blobs
Date: Mon, 6 May 2013 14:02:13 -0500
Message-ID: <CAMP44s2rvu2PaazHEx-OXaZbuBAX7sZb04Oh38ifyAEG6kcxkw@mail.gmail.com>
References: <1367793534-8401-1-git-send-email-felipe.contreras@gmail.com>
	<1367793534-8401-3-git-send-email-felipe.contreras@gmail.com>
	<20130506123111.GB3809@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Antoine Pelisse <apelisse@gmail.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon May 06 21:02:24 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UZQg4-00036U-5s
	for gcvg-git-2@plane.gmane.org; Mon, 06 May 2013 21:02:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755690Ab3EFTCR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 May 2013 15:02:17 -0400
Received: from mail-la0-f50.google.com ([209.85.215.50]:62320 "EHLO
	mail-la0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755658Ab3EFTCP (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 May 2013 15:02:15 -0400
Received: by mail-la0-f50.google.com with SMTP id fl20so3563350lab.23
        for <git@vger.kernel.org>; Mon, 06 May 2013 12:02:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=pjHQK0c/vOioi+L9hzPh2vZgqtEAEcI3OIW77TfAydo=;
        b=JAir+PNlYHg8dYRUM2F4DP6tJYE1YZny1SZDiPiXeS9feh0Gwr0gH9VlPdTlr61SwX
         ikloiovxCxnMrVZJuB32sbUG6VhcFMqJT438TotjfwxmWYqP9IMMMcZdlkinbbrt5exZ
         jKtRJb7BtCKFSAyFTgyulOQKhECep0Nva8miCSRyZ4lRcHr6ePV5VhkQpsgg39MuaziH
         ATrYmvXM4Tz/nKuX21e8zeihJ9GkUlAVdeOoqgjLSEZZRGFGiNUtH8o5EgUL5xNyHXio
         aEltRW46930aOXTytXya1VSc4fqKawnYWvs4Z0mpHEcV8S5SuQRkZAY1btM2ZEx87sen
         h4YQ==
X-Received: by 10.112.145.72 with SMTP id ss8mr7889949lbb.12.1367866933950;
 Mon, 06 May 2013 12:02:13 -0700 (PDT)
Received: by 10.114.184.3 with HTTP; Mon, 6 May 2013 12:02:13 -0700 (PDT)
In-Reply-To: <20130506123111.GB3809@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223483>

On Mon, May 6, 2013 at 7:31 AM, Jeff King <peff@peff.net> wrote:
> On Sun, May 05, 2013 at 05:38:53PM -0500, Felipe Contreras wrote:
>
>> We don't care about blobs, or any object other than commits, but in
>> order to find the type of object, we are parsing the whole thing, which
>> is slow, specially in big repositories with lots of big files.
>
> I did a double-take on reading this subject line and first paragraph,
> thinking "surely fast-export needs to actually output blobs?".

If you think that, then you are not familiar with the code.

--export-marks=<file>::
	Dumps the internal marks table to <file> when complete.
	Marks are written one per line as `:markid SHA-1`. Only marks
	for revisions are dumped; marks for blobs are ignored.

		if (deco->base && deco->base->type == 1) {
			mark = ptr_to_mark(deco->decoration);
			if (fprintf(f, ":%"PRIu32" %s\n", mark,
				sha1_to_hex(deco->base->sha1)) < 0) {
			    e = 1;
			    break;
			}
		}

> Reading the patch, I see that this is only about not bothering to load
> blob marks from --import-marks. It might be nice to mention that in the
> commit message, which is otherwise quite confusing.

The commit message says it exactly like it is: we don't care about blobs.

If an object is not a commit, we *already* skip it. But as the commit
message already says, we do so by parsing the whole thing.

> I'm also not sure why your claim "we don't care about blobs" is true,
> because naively we would want future runs of fast-export to avoid having
> to write out the whole blob content when mentioning the blob again.

Because it's pointless to have hundreds and thousands of blob marks
that are *never* going to be used, only for an extremely tiny minority
that would.

> Does that match your reasoning?

It doesn't matter, it has been that way since --export-marks was introduced.

>> Before this, loading the objects of a fresh emacs import, with 260598
>> blobs took 14 minutes, after this patch, it takes 3 seconds.
>
> Presumably most of that speed improvement comes from not parsing the
> blob objects. I wonder if you could get similar speedups by applying the
> "do not bother parsing" rule from your patch 3. You would still incur
> some cost to create a "struct blob", but it may or may not be
> measurable.  That would mean we get the "case not worth worrying about"
> from above for free. I doubt it would make that big a difference,
> though, given the rarity of it. So I am OK with it either way.

How would I know if it's a blob or a commit, if not by the code this
patch introduces?

-- 
Felipe Contreras
