From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v6 0/10] port tag.c to use ref-filter APIs
Date: Wed, 29 Jul 2015 13:29:34 -0700
Message-ID: <xmqqbneu907l.fsf@gitster.dls.corp.google.com>
References: <CAOLa=ZR6_2NBB4v0Ynq391=8Jk2RZON6R0YG=HKUNwKx249b7Q@mail.gmail.com>
	<CAPig+cQv4BWFwgx7mDHh=gNpxbEeR7auw4os-tOpf3cGah=zpw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Karthik Nayak <karthik.188@gmail.com>, Git <git@vger.kernel.org>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Christian Couder <christian.couder@gmail.com>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Wed Jul 29 22:29:43 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZKXyw-0003vP-Lx
	for gcvg-git-2@plane.gmane.org; Wed, 29 Jul 2015 22:29:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753213AbbG2U3i convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 29 Jul 2015 16:29:38 -0400
Received: from mail-pa0-f53.google.com ([209.85.220.53]:34529 "EHLO
	mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752025AbbG2U3i (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Jul 2015 16:29:38 -0400
Received: by pacan13 with SMTP id an13so11180705pac.1
        for <git@vger.kernel.org>; Wed, 29 Jul 2015 13:29:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type:content-transfer-encoding;
        bh=IOO3UJuATE0i6Rl0hCWldRhqbplf0N55mu2fagslqP4=;
        b=iaBuvo8HfqjxYzUgWNwx7r3qqE1C364USfgpMBN/aI0ZD77xLMR+mrJTtc/L655t0g
         fph6SmPfnLYXqgcvs23E5EULbfc/JK4XdpqDpQvvqzaJRC97Uors6ZHiQRJtJMOAQOIT
         DFzeEvd7PDfnGwz1xLN/KgpCYjtNihwN25uTUawS3YAObmtn0aPfM/8Lv+t9qBGeoU7+
         8qLbeTGCiiJCCqNn4f1qTtwMIDWFEpf1DA58cFM0u6C4dV5yq8lKrfGrdhJX6l0tAcin
         iuZz3EA/H++TDQAO7DE15tw3y1FYbGid2svveSRS7LnrSJZ3bJ7+4Aj6EkyRrQUK85F3
         dUOw==
X-Received: by 10.66.253.40 with SMTP id zx8mr96386629pac.56.1438201777677;
        Wed, 29 Jul 2015 13:29:37 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:4c0b:2701:e242:17dc])
        by smtp.gmail.com with ESMTPSA id de2sm42331715pdb.15.2015.07.29.13.29.34
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 29 Jul 2015 13:29:35 -0700 (PDT)
In-Reply-To: <CAPig+cQv4BWFwgx7mDHh=gNpxbEeR7auw4os-tOpf3cGah=zpw@mail.gmail.com>
	(Eric Sunshine's message of "Wed, 29 Jul 2015 15:27:21 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274950>

Eric Sunshine <sunshine@sunshineco.com> writes:

>> Side Note: --format=3D"%(padright:X)" applies to the next available =
atom
>> and not to the next span. I find this more accurate as I don't see w=
hy
>> we'd want to pad something of known length. But its up for discussio=
n
>
> This isn't supported by the current %(padright:) syntax, but an
> example would be if someone wants to pad a string composed of atoms
> and literal strings. For instance, the user might want to right-pad
> the composed string "%(refattribute1) glorked %(refattribute2)=E2=80=9D=
=2E

It is an excellent example that shows why "something of known
length" argument needs to be rethought.

"Currently we do not need it to reimplement the canned 'tag -l'
format" is an OK and sensible justification to stick to the current
implementation of %(padright:N), but we'd need to think if we would
want to keep this limited and strange form that applies to a single
atom that comes next (ignoring any literal spans) as a private
implementation detail between ref-filter and "git tag".  Opening it
up to end-users would not mean we cannot add a correctly operating
variant of "pad this string to the right" later, but it does mean we
have to maintain %(padright) in this limited form forever.

My knee-jerk reaction is that we probably should not want to expose
this to the end users, and to discourage its use, perhaps name it
somewhat strangely (e.g. "%(x-padright:N)" or something).
