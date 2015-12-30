From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH/RFC v2 0/2] add regex match flags to git describe
Date: Wed, 30 Dec 2015 16:52:15 +0700
Message-ID: <CACsJy8ADrHW=Tr2Tx04NoAKP3MfP__Ndjut_G_7HitLPHKn46w@mail.gmail.com>
References: <cover.1451298323.git.mostynb@opera.com> <xmqqy4cejoz4.fsf@gitster.mtv.corp.google.com>
 <5681D02C.1040609@opera.com> <xmqqk2nxi002.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Mostyn Bramley-Moore <mostynb@opera.com>,
	Git Mailing List <git@vger.kernel.org>,
	"brian m . carlson" <sandals@crustytoothpaste.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Dec 30 10:53:18 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aEDRV-0002fl-Ux
	for gcvg-git-2@plane.gmane.org; Wed, 30 Dec 2015 10:53:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754176AbbL3Jwt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Dec 2015 04:52:49 -0500
Received: from mail-lb0-f175.google.com ([209.85.217.175]:33099 "EHLO
	mail-lb0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751871AbbL3Jwr (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Dec 2015 04:52:47 -0500
Received: by mail-lb0-f175.google.com with SMTP id sv6so106528067lbb.0
        for <git@vger.kernel.org>; Wed, 30 Dec 2015 01:52:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=y4a5iHSf+iQYPyKTLZ+sDq0EEBdBSSekzrJxTdRlxDo=;
        b=dAT8z15aDCevt3+9teaTZmqi895GAKoQBeHup0/qf2r+QK+rTAm/o76lO4e2PRq1zg
         /hp2faAIlZ7G9W89mnPH/FXFjvSU1+OxsP5hTRXLTosmpPRP3sWVkOgGNV82g2b8N4mK
         QPQy7NC/yKDTusYIvGYIOipJP3QVC3ccbWfCi+mu+eY70XAChCLVb0SQFpkyp+B50dCx
         iUtd1VSOt6bCae74vmBm9HUoHrqojR5Vq0jzizLyRw9a723IgLr23pZNcWOD3LsViMY+
         aAmxGVQvB4gg6mOfTEHsRLUkKH3EPLiHFZneQbSwKLrFPXO3w2l40aVVL+GJDMUeehQW
         eohg==
X-Received: by 10.112.168.70 with SMTP id zu6mr22289682lbb.26.1451469165510;
 Wed, 30 Dec 2015 01:52:45 -0800 (PST)
Received: by 10.112.97.72 with HTTP; Wed, 30 Dec 2015 01:52:15 -0800 (PST)
In-Reply-To: <xmqqk2nxi002.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283170>

On Wed, Dec 30, 2015 at 1:27 AM, Junio C Hamano <gitster@pobox.com> wrote:
> It is more important to envision what we would do in the future when
> a command that takes a pattern (or a set of patterns) to match the
> refnames with _and_ another pattern (or a set of patterns) to match
> something else, and take that into account when designing this
> "allowing matching logic for refnames to be customized from glob to
> something else" feature, so that we do not paint outselves into a
> corner we cannot later get out of.  Imagine a hypothetical command
> 'git mgrep' that can look for a pattern in tips of multiple branches
> that can be used this way:
>
>     $ git mgrep -e 'froo*tz' --refs 'refs/heads/release/*'
>
> which may look for strings that match "froo*tz" in the trees of
> all branches whose name match the pattern 'release/*'.  In this
> example, the pattern to match strings is a BRE (same default as
> "git grep"), and the pattern to match refnames is a glob.
>
> Consistency & similarity with "git grep" would most likely lead us
> to add -E/-F/-G/-P options to this command and to make it affect how
> the pattern to match strings works.  For example:
>
>     $ git mgrep -E -e 'fro+tz' --match-refs 'refs/heads/release/*'
>
> may look for the same strings that would match the first example,
> but the pattern is expressed in ERE.  "-P", "-G", and "-F" options
> would also work the same way.
>
> Now, the question is what this "-E" (or -P/-G/-F) should do with the
> matching the command does with the refnames.  The easiest (and
> laziest) way out from the implementors' point of view might be to
> declare that they affect both at the same time.
> ...

What about not using command line options? We could go with something
like pathspec magic. I think as long as we provide three options:
literal, some pattern matching and backquote, then the user has enough
flexibility to specify any set of refs. For pattern matching I'd
prefer wildmatch. regex can be used via backquote, e.g. `for-each-ref
| grep ...` (or teach for-each-ref about regex to avoid grep).
-- 
Duy
