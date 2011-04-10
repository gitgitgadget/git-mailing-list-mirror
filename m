From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [RFC PATCH 00/11] Sequencer Foundations
Date: Sun, 10 Apr 2011 14:47:39 -0500
Message-ID: <20110410194739.GC28163@elie>
References: <1302448317-32387-1-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>,
	Christian Couder <chriscool@tuxfamily.org>,
	Daniel Barkalow <barkalow@iabervon.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Sun Apr 10 21:47:56 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q90by-0001fL-27
	for gcvg-git-2@lo.gmane.org; Sun, 10 Apr 2011 21:47:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755180Ab1DJTrq convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 10 Apr 2011 15:47:46 -0400
Received: from mail-yi0-f46.google.com ([209.85.218.46]:38618 "EHLO
	mail-yi0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754256Ab1DJTro convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 10 Apr 2011 15:47:44 -0400
Received: by yia27 with SMTP id 27so1943946yia.19
        for <git@vger.kernel.org>; Sun, 10 Apr 2011 12:47:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=uSzD+d7ZZYkTwnXiODj3taasrfIAaRVA36EssRIR9KE=;
        b=M6RE/8G864VyQklbNQID3AOWBtROGg6eACjOTTpsYkWZKCQJFUMpTjpTa+t+bxpuJa
         c6iznHgiFeozPTR6lm+te+Rp4FCYH+4oIkPUthPAdUt2p9XSLXIUEDPPfKus6ts1o6eS
         Cw9snQCCYoybPl3ORCw+YU4PKwxN8t7bxu+M8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=GhO6SLQHJ+eoUjmvF0C6F3QG/0orQ1lBSecIzhn9qRbaJfHj268IsaT2/osc1qHJmE
         l0gmDm6Ynfa+WbYXUofS7s07KjX6/Py3/YCckBpd9fIqQ+t85sbWQwX/5aaOjhNSSwAa
         1qWUxzkP9B/qFqyDYV0DO+uIpPVRFXW8L6fZU=
Received: by 10.91.8.3 with SMTP id l3mr3937393agi.2.1302464863978;
        Sun, 10 Apr 2011 12:47:43 -0700 (PDT)
Received: from elie (adsl-69-209-51-92.dsl.chcgil.sbcglobal.net [69.209.51.92])
        by mx.google.com with ESMTPS id d14sm5281463ana.0.2011.04.10.12.47.42
        (version=SSLv3 cipher=OTHER);
        Sun, 10 Apr 2011 12:47:42 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1302448317-32387-1-git-send-email-artagnon@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171283>

Hi again,

Ramkumar Ramachandra wrote:

> I've started working on building a sequencer for Git.

Happy to see.

> 0. Is the general flow alright?

Not sure --- I don't have the big picture.  Could you give a quick
summary of the flow in the cover letter ("patch 1 does such-and-such,
so patch 2 can do such-and-such, leading to...") to the next revision,
and quick explanations of the purpose (i.e., why we should want each
change) in the individual change descriptions?

> 1. Is it okay to use this kind of adaptive error handling (calling
> 'die' in some places and returning error in other places), or should
> it be more uniform?

'die' gets used in two ways (well, one way really):

 - to say "there is no sane way to recover from this failure".  For
   example, xmalloc dies if even after trying to free up memory,
   malloc still could not satisfy the request.

 - to say "so far we've been too lazy to implement recovery from
   this failure".  Or "while we *could* recover from this failure, no
   one has needed it, so let's not --- that code would just bitrot."

Therefore a mixture of 'die' and 'return error' seems inevitable.  The
dangerous mixtures to avoid are those likely to trip up callers (e.g.,
if all code paths 'return error' except one edge case).

> 2. In 11/11, I've used cmd_revert and cmd_rerere.  This is highly
> inelegant, mainly because of the command-line argument parsing
> overhead.  Re-implementing it using more low-level functions doesn't
> seem to be the way to go either: for example, 'reset --hard' has some
> additional logic of writing HEAD and ORIG_HEAD, which I don't want to
> duplicate.  Should I work on reworking parts of 'rerere.c' and
> 'revert.c', or is there some other way?

See "git log --grep=3Dlibify" for examples.  Isn't rerere already
libified?  Ah, you need "rerere clear" --- I think a rerere_clear
function alongside rerere_forget et al would make sense.

More generally, it should be feasible to expose a nice, simple API for
any functionality you need (with params struct if necessary, etc).
That's how many of the current APIs (revision walking, diffcore, ...)
came about.

> 3. From the format of the TODO and DONE files, one more thing should
> be clear- I'm trying to stick to a slight variation of the 'rebase -i=
'
> format.  This part will go into the sequencer.  Then I'll use a
> cherry-pick specific file to keep the command-line options.  Yes, I'm
> trying to work on Daniel's idea [3] from the very start.  Is this a
> good idea?

This is still bouncing in my head.  I think I like it --- is the idea
that some day you could put commands like

	am topic.mbox

in your insn sheet, or do nested rebases with a --force-nested option?
That does sound useful.  How would one request "skip to the next
operation in the outer rebase" on the command line?  This is starting
to feel like a debugger.

> 4. I have a feeling that I've broken translation strings.  Is there a
> README, plus a bunch of tests I can run to make sure that I've not
> broken anything?

If you put "GETTEXT_POISON =3D YesPlease" in your config.mak, the
translations will be translated to gibberish when the GIT_GETTEXT_POISO=
N
envvar is set, so you can use the test suite as a sanity check.
"make pot" can be used to get the translation template that
translators will see.

As for a readme explaining how to use _, N_, and Q_, yes, I think that
would be useful.  I think =C3=86var's series has something like that (b=
ut
targetted at translators) later on; it might make sense to prod him or
me for a simpler explanation can be merged immediately.  Until then,
there is "git log gettext.h".

Regards,
Jonathan
