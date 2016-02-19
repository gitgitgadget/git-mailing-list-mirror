From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH v2 14/25] shallow.c: implement a generic shallow boundary
 finder based on rev-list
Date: Fri, 19 Feb 2016 16:30:23 +0700
Message-ID: <20160219093023.GA12470@lanh>
References: <1454576641-29615-1-git-send-email-pclouds@gmail.com>
 <1454576641-29615-15-git-send-email-pclouds@gmail.com>
 <xmqqvb5y7vuj.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Feb 19 10:30:51 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aWhOk-0006UZ-1y
	for gcvg-git-2@plane.gmane.org; Fri, 19 Feb 2016 10:30:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030273AbcBSJaH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 19 Feb 2016 04:30:07 -0500
Received: from mail-pa0-f47.google.com ([209.85.220.47]:33044 "EHLO
	mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751351AbcBSJaA (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Feb 2016 04:30:00 -0500
Received: by mail-pa0-f47.google.com with SMTP id fl4so47589561pad.0
        for <git@vger.kernel.org>; Fri, 19 Feb 2016 01:29:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=fr3mlOucWHRrbebgenBQSVCEDYl+1BF2+K1Ek8eaCks=;
        b=b8yP6ZLUAuRsVv9x/jov0URpmuR3Jv1Odbpz5+HyOWqr+rr+lkglzikGWYSeNPUlJ+
         9FlPzXnGfzQSNWEbMinrZIKPX95l15RuhkTDyYAPM7HFyC7NkVm29lSoQViQcCHde1xu
         MWq4sbHX1BsxrQnqbhsnJ4sXq8qfZtGRza8dnxpzujJzUtIpHaVMJ1beBsZqjP5kxtB8
         a+MW0jKCsU6mDNFcuIPmnBoNAObNjB0Ylbeh+XqHyxtRGJ8zFdK1RLqrxNp9rydbt3qZ
         GCjtGP9v9ni6k6UPUhiLaK+/HOj+dZGUpWk+6RIZUUB0L6f/PAYvxYjHRg8ztAzLcN+f
         eV7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=fr3mlOucWHRrbebgenBQSVCEDYl+1BF2+K1Ek8eaCks=;
        b=TIPvyh+UB6MclUziyjd+3mJECy+WUnE2RSMfdClrSeEJJZUqnb9TIZGjGL3RoAZqAD
         V5BYIGLNuiEUw1FhyM2a/YbjhNpSgzjoOhpErUhmfnCco9h+TPtjXKawWoJkOOjl+zT3
         SOBqMBxVtuyJl0/kcs72VqhjSFsDB4/re0ocra9OqmKBRJ4N1XIxha3wh1FNptli34T5
         EUaOtXQxeuiht4Htm/uXOZjkJ8wv5xY6RX3wq/j2cDpseqSWsBJ0G5g2lHVtMdyUx6dZ
         1ZpSF3aWqQkBLWVtrf+e3xEZTp8Zs8dB1tGkvjgsq6CLVKZUIST3AbJjS/EK8ImdXP+S
         RgPQ==
X-Gm-Message-State: AG10YORIBdUNzJbPTknfMRa7FkjWWd4xdWFW61kWtgb2Vim4NNOnjAgufMV0HzNqVivJRA==
X-Received: by 10.66.252.100 with SMTP id zr4mr16330591pac.111.1455874199612;
        Fri, 19 Feb 2016 01:29:59 -0800 (PST)
Received: from lanh ([115.76.228.161])
        by smtp.gmail.com with ESMTPSA id dg12sm16178451pac.47.2016.02.19.01.29.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 19 Feb 2016 01:29:57 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Fri, 19 Feb 2016 16:30:23 +0700
Content-Disposition: inline
In-Reply-To: <xmqqvb5y7vuj.fsf@gitster.mtv.corp.google.com>
X-Clacks-Overhead: GNU Terry Pratchett
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286678>

On Mon, Feb 08, 2016 at 01:09:24PM -0800, Junio C Hamano wrote:
> Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes=
:
>=20
> > Instead of a custom commit walker like get_shallow_commits(), this =
new
> > function uses rev-list to mark NOT_SHALLOW to all reachable commits=
,
> > except borders. The definition of reachable is to be defined by the
> > protocol later. This makes it more flexible to define shallow bound=
ary.
> >
> > Note: if a commit has one NOT_SHALLOW parent and one SHALLOW parent=
,
> > then it's considered the boundary. Which means in the client side, =
this
> > commit has _no_ parents. This could lead to surprising cuts if we'r=
e not
> > careful.
> >
> > Another option is to include more commits and only mark commits who=
se
> > all parents are SHALLOW as boundary.
>=20
> The second and third are greek to me at this point ;-) but hopefully
> they will become clear as we read on.

Yeah. Everything looks clearer with illustration. This should be a
better. The question is should we do something about it now, or leave
it as is.

I'm tempted to go with "the first way" in future (so add some comments
about this in is_repository_shallow, instead of leaving it as commit
message in this patch).

-- 8< --
The way we find find border is paint all reachable commits NOT_SHALLOW.
Any of them that "touches" commits without NOT_SHALLOW flag are
considered shallow (e.g. zero parents via grafting mechanism). Shallow
commits and their true parents are all marked SHALLOW. Then NOT_SHALLOW
is removed from shallow commits at the end.

There is interesting observation, though somewhat off topic for this
patch. In the following graph, "x" is unreachable commits. "b" is the
parent of "a".

           x -- a -- o
	       /    /
         x -- b -- o

And as a result, "a" and "b" are both considered shallow commits. After
grafting occurs at the client side, what we see is

                a -- o
	            /
              b -- o

Notice that because of grafting, "a" has zero parents, so "b" is no
longer a parent of "a".

This is unfortunate and may be solved in two ways. The first is change
the way shallow grafting works and keeps "b -- a" connection if "b"
exists and is a shallow commit.

The second way is produce this graph (at client side) instead

           x -- a -- o
	       /    /
              b -- o

Which means we mark "x" as a shallow commit instead of "a".
-- 8< --
--
Duy
