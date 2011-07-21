From: ZAK Magnus <zakmagnus@google.com>
Subject: Re: git fetch --all --depth
Date: Thu, 21 Jul 2011 13:40:54 -0700
Message-ID: <CAAuSN90Ai7KD68fwRtRUkP4tm61=CcEc_9-kH0Dh5mdAT4hOpg@mail.gmail.com>
References: <20110720223902.GA6675@camk.edu.pl>
	<7v1uxj4ml4.fsf@alter.siamese.dyndns.org>
	<20110721200455.GC11520@camk.edu.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Kacper Kornet <kornet@camk.edu.pl>
X-From: git-owner@vger.kernel.org Thu Jul 21 22:41:08 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qk03Q-0007vN-3g
	for gcvg-git-2@lo.gmane.org; Thu, 21 Jul 2011 22:41:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752895Ab1GUUlC convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 21 Jul 2011 16:41:02 -0400
Received: from smtp-out.google.com ([74.125.121.67]:57690 "EHLO
	smtp-out.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750769Ab1GUUk6 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 21 Jul 2011 16:40:58 -0400
Received: from wpaz1.hot.corp.google.com (wpaz1.hot.corp.google.com [172.24.198.65])
	by smtp-out.google.com with ESMTP id p6LKeuC5011118
	for <git@vger.kernel.org>; Thu, 21 Jul 2011 13:40:56 -0700
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=google.com; s=beta;
	t=1311280857; bh=XZ8dtff+aBUy663NU69K56nGYT8=;
	h=MIME-Version:In-Reply-To:References:Date:Message-ID:Subject:From:
	 To:Cc:Content-Type:Content-Transfer-Encoding;
	b=v1jMx3HOMTjkY1Txfxo/pC8g7cXphn+O6Boa8A2drp//C/2xAe0h3SfIMK/zGz2Rh
	 bytzCdG8kII6MhoFEEScA==
DomainKey-Signature: a=rsa-sha1; s=beta; d=google.com; c=nofws; q=dns;
	h=dkim-signature:mime-version:in-reply-to:references:date:
	message-id:subject:from:to:cc:content-type:
	content-transfer-encoding:x-system-of-record;
	b=oVbPuDpr1i/O4F4UHL395uPE20RNcJ3+4O+y2Z6o70yTRDQiJQPm21JV7pXz2BiBS
	q9azwEJtoJ4YcV/Pava0Q==
Received: from gwb15 (gwb15.prod.google.com [10.200.2.15])
	by wpaz1.hot.corp.google.com with ESMTP id p6LKeloB018758
	(version=TLSv1/SSLv3 cipher=RC4-SHA bits=128 verify=NOT)
	for <git@vger.kernel.org>; Thu, 21 Jul 2011 13:40:55 -0700
Received: by gwb15 with SMTP id 15so1430438gwb.13
        for <git@vger.kernel.org>; Thu, 21 Jul 2011 13:40:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=beta;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=CPXlif6wsgXqzNDU5BLGfWtp5KAoyMKTBtS7M2Bjjw4=;
        b=DVSUAzCmB1mnEkcKXDI5GOBFMPkTplcycUiioJ7e5N6sZhsTXL+F1mrbQGD0hb13qc
         x8aXJCyJ1XhS152kiqVg==
Received: by 10.151.45.10 with SMTP id x10mr1164444ybj.170.1311280854929; Thu,
 21 Jul 2011 13:40:54 -0700 (PDT)
Received: by 10.150.181.19 with HTTP; Thu, 21 Jul 2011 13:40:54 -0700 (PDT)
In-Reply-To: <20110721200455.GC11520@camk.edu.pl>
X-System-Of-Record: true
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177623>

Looks like a bug. I believe the culprit is add_options_to_argv(),
which is used by fetch_multiple() to copy command line arguments to a
child process, but does not copy the --depth argument. Thus --all (and
everything else that relies on fetch_multiple() or
add_options_to_argv()) ignores --depth.

On Thu, Jul 21, 2011 at 1:04 PM, Kacper Kornet <kornet@camk.edu.pl> wro=
te:
> On Thu, Jul 21, 2011 at 09:36:55AM -0700, Junio C Hamano wrote:
>> Kacper Kornet <kornet@camk.edu.pl> writes:
>
>> > I have just discovered that when I use:
>
>> > git fetch --all --depth=3D<n>
>
>> > the history is not deepened. Is the any specific reason for it or =
is it
>> > a bug?
>
>> The above is not specific enough to judge if you found a bug or if i=
t is a
>> user error.
>
> To be more specific, the steps to reproduce:
>
> $ git clone --depth=3D1 git://git.kernel.org/pub/scm/git/git.git
> $ cd git
> $ git fetch --depth 2 --all
>
> and the last command does nothing, while
>
> $ git fetch --depth 2
>
> deepens the clone by 2 repos, as expected.
>
>> IIRC, --depth=3D<n> is not "deepen by <n>", but "make sure I have at=
 least
>> <n> from the updated tip(s)". =A0The shallow-clone hack gives you qu=
ite
>> useless (even though it may be internally consistent) semantics if y=
ou
>> shallow-cloned way in the past and fetched with --depth after the ot=
her
>> side added many more commits than <n>, as you cannot guess what the =
right
>> value of <n> should be without actually fetching without --depth.
>
> That is true. Also, from esthetic point of view, sometimes I miss the
> functionality to deepen the full repository. For example git fetch
> --depth 0 could do it. Now I have to do git fetch --depth
> <very_large_number>
>
> --
> =A0Kacper Kornet
>
