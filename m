From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH 10/21] tree_entry_interesting(): fix depth limit with
 overlapping pathspecs
Date: Sat, 18 Dec 2010 10:37:28 +0700
Message-ID: <AANLkTik+DaUrh99qs4T-Pm_+3Oq499L_NtP6Xcht1wfH@mail.gmail.com>
References: <1292425376-14550-1-git-send-email-pclouds@gmail.com>
 <1292425376-14550-11-git-send-email-pclouds@gmail.com> <7vmxo5l2g4.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Dec 18 04:41:06 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PTnfK-0003Hj-Du
	for gcvg-git-2@lo.gmane.org; Sat, 18 Dec 2010 04:41:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755789Ab0LRDiA convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 17 Dec 2010 22:38:00 -0500
Received: from mail-wy0-f174.google.com ([74.125.82.174]:56081 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753561Ab0LRDh7 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 17 Dec 2010 22:37:59 -0500
Received: by wyb28 with SMTP id 28so1300635wyb.19
        for <git@vger.kernel.org>; Fri, 17 Dec 2010 19:37:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=GJxoxyRB2ro0KXANjBB7gR3E+1ViqATskyIlXI0oxiA=;
        b=gaC+5cr4yGeiKVagnZNXeQk4QYBzrJaoc/SVfddPGhJcxdtX8YLQq+gjdWO7lHxR7z
         RhKxoTTizoEhJNL/nLzKbp+7WHZOe5p4JYTlx3nPnblIq0yExtKibeRWXqlGyjpKvQpK
         JVVhMXnum/ZoL96tvyNGsTFP1zjdwNO5LwocE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=bNGbopy57xkLdJiigs/QediH5KrAgfgxOfDYZ3Zkq+0CCHTqKJDgpnRnsEHgSyE4fl
         CRhDcjL1iBOux4CfDpkGrfPuNlbTtNr8CXBjfAdb+mOEi26N7RcVXbYN+th2SyAxJCB/
         l+6zREgHftLly26Kgiuev9s5a228eMV2HD8qs=
Received: by 10.216.162.70 with SMTP id x48mr4801523wek.4.1292643478461; Fri,
 17 Dec 2010 19:37:58 -0800 (PST)
Received: by 10.216.158.83 with HTTP; Fri, 17 Dec 2010 19:37:28 -0800 (PST)
In-Reply-To: <7vmxo5l2g4.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163897>

2010/12/17 Junio C Hamano <gitster@pobox.com>:
> One possible definition of interaction between limit and wildcard may=
 be
> to count the number of slashes in the part of the path that matches t=
he
> wildcarded part of the pathspec, add the number of path components
> appended due to the leading directory match, and then subtract the nu=
mber
> of literal slashes in the wildcarded part of the pattern from the abo=
ve,
> and declare that a match is found if the difference is less than the
> limit.
>
> E.g. a pathspec element "a/*/x" would match "a/b/c/x", "a/b/c/d/e/x",
> "a/b/x/y" and "a/b/x/y/z" without limit, and with the limit of 1:
>
> =C2=A0 =C2=A0a/b/c/x =C2=A0 =C2=A0 =C2=A0 =C2=A0matches ('*' expands =
to "b/c")
> =C2=A0 =C2=A0a/b/c/d/e/x =C2=A0 =C2=A0no ('*' has to expand to "c/d/e=
" and needs 2 levels)
> =C2=A0 =C2=A0a/b/x/y =C2=A0 =C2=A0 =C2=A0 =C2=A0matches ('*' expands =
to "b" costing zero, "/y" needs 1)
> =C2=A0 =C2=A0a/b/x/y/z =C2=A0 =C2=A0 =C2=A0does not match
>
> Another definition could be to count _only_ the part that is appended=
 by
> recursion (i.e. we do not count how many slashes has to match '*' in =
the
> above examples), and as the option is called --depth, it might make m=
ore
> sense.

So with the above example, "a/" won't be counted. Depth limit of 0 or
1 will result in no matches. Depth limit of 2 will result in a/b/c/x
and a/b/x/y, correct?

I prefer this definition to the former. It sounds simpler to
understand and use, also less computation. But I can implement both
:-) We can mark what matching strategy we would use in struct
pathspec.  Hmm.. I'm not much help in figuring out which one makes
more sense.

Another thing, I don't know if anybody would need it. Should we
support depth limit per pathspec, so "a/*/x" can have depth limit of
2, but "*.c" has depth limit of 1..For one thing, his may help keeping
current's git-grep depth limit behavior if depth limit can also be
applied to wildcard pathspecs by setting depth limit for wildcard
pathspecs to -1. Exposing depth limit per pathspec to users is another
matter.

> In either case, I am not sure if "if it matches the longest pathspec,=
 we
> have the answer without looking at shorter ones" would be a good rule=
 to
> use.

As long as the rule of matching is "if any of these pathspecs is
matched, we have a match", then pathspec order should not matter
(without depth limit). Matching decision of one pathspec does not
affect the others. Depth limit is the first one breaking the last
sentence. And because pathspec order does not matter before depth
limit introduction, it should not cause any regression when depth
limit requires pathspecs in certain order. That's how I thought when I
decided to sort pathspecs.

Wildcard pathspecs are handled in a completely different path (even
with depth limit in either way you described). Overlapping is no issue
to wildcard pathspecs, we always need full pathspec to call fnmatch()
(unless you implied some early cut optmization that I don't see).
Therefore pathspec order is no issue.

Even when I introduce negative pathspec, it would be actually negative
prefix and go the same route as current depth limit impl (it also has
the same overlapping pathspec issue). Negative wildcard pathspecs
would blow my mind.
--=20
Duy
