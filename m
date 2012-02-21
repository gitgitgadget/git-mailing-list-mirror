From: =?UTF-8?B?WmJpZ25pZXcgSsSZZHJ6ZWpld3NraS1Tem1law==?= 
	<zbyszek@in.waw.pl>
Subject: Re: [PATCH 0/8 v6] diff --stat: use the full terminal width
Date: Tue, 21 Feb 2012 11:05:17 +0100
Message-ID: <4F436C5D.7070606@in.waw.pl>
References: <1329775034-21551-1-git-send-email-zbyszek@in.waw.pl> <7v4nuljcnk.fsf@alter.siamese.dyndns.org> <4F42E4C2.7070801@in.waw.pl> <7vr4xois3l.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Michael J Gruber <git@drmicha.warpmail.net>,
	pclouds@gmail.com, j.sixt@viscovery.net
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Feb 21 11:05:37 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RzmbH-00035X-2R
	for gcvg-git-2@plane.gmane.org; Tue, 21 Feb 2012 11:05:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753759Ab2BUKF3 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 21 Feb 2012 05:05:29 -0500
Received: from kawka.in.waw.pl ([178.63.212.103]:52885 "EHLO kawka.in.waw.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753442Ab2BUKF2 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Feb 2012 05:05:28 -0500
Received: from amanda.fuw.edu.pl ([193.0.82.254] helo=[192.168.121.139])
	by kawka.in.waw.pl with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.72)
	(envelope-from <zbyszek@in.waw.pl>)
	id 1Rzmb6-0005vx-Hw; Tue, 21 Feb 2012 11:05:24 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:8.0) Gecko/20120104 Icedove/8.0
In-Reply-To: <7vr4xois3l.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191149>

On 02/21/2012 08:05 AM, Junio C Hamano wrote:
> Zbigniew J=C4=99drzejewski-Szmek<zbyszek@in.waw.pl>  writes:
>
>> On 02/21/2012 12:41 AM, Junio C Hamano wrote:
>>> Zbigniew J=C4=99drzejewski-Szmek<zbyszek@in.waw.pl>   writes:
>>>
>>>> JC:
>>>>> Perhaps the maximum for garph_width should be raised to something=
 like
>>>>> "min(80, stat_width) - name_width"?
>>>> I think that a graph like
>>>> a | 1000 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++=
+++++++++++++
>>>> b |    1 -
>>>> is not very readable. I like the consistency forced by the 40-colu=
mn limit.
>>>> But I guess that this is very subjective.
>>>
>>> The above makes it very obvious that there is a huge amount of chan=
ge made
>>> to 'a' and a bit of deletion to 'b', compared to a mini-graph that =
is
>>> truncated to half the screen width.
>> Yes. But the same graph with 40 columns tells me exactly the same th=
ing.
>
> That is a bogus argument, isn't it?  You can say the same thing if yo=
u
> limited the length of the graph bars to 10-columns if you only compar=
e
> between 1000 and 1. You can even do with just 5-columns.  For that ma=
tter,
> without any graph bar at all, it tells us exactly the same thing beca=
use
> we have numbers.  Does that mean we do not need any bar?  Of course n=
ot.
> We use bars as visual aid.
Yes.

> Imagine what happens to the graph if you had paths with medium amount=
 of
> changes like 980, 800, 40, in addition to 1000 and 1.  By limiting th=
e
> length of the bars more than necessary, you are losing the resolution
> without a good reason, and that is why I find 40-column limit a poor
> design choice.
You're right.

>>> Besides, the above is what you would get without your patch on 80-c=
olumn
>>> terminal, no?
>>
>> Yes.
>
> I think this "use at most 40-places for the graph bar" was your respo=
nse
> to somebody's observation that "on 200-column terminal, we will still=
 see
> the commit log messages (and for many projects, also patch text) that=
 are
> designed to be comfortably viewable within the 80-column on the left,=
 and
> overlong graph bar stands out like an ugly sore thumb".
>
> While that "ugliness" observation might be a valid one to make, I do =
not
> think limiting the length of the graph bar without taking the length =
of
> the name part into account at all is the right solution to it.
>
> After all, that is exactly the same thinking that led to the bug in t=
he
> current code that you fixed with your series, isn't it?  Our safety c=
ode
> truncated the graph bar width too early without taking the width need=
ed to
> show the names into account, and then when the names turn out to be a=
ll
> short, we ended up wasting space on the right hand side, because we m=
ade
> the bars too short and the decision was made too early in the code.
>
> If the problem you are addressing is to make sure that the diffstat p=
art
> in the series of lines that are structured like this:
>
>     log message part ~80 column
>     diff stat part that can extend very very very very very very very=
 long
>     patch text part  ~80 column
>
> does not become overly long, wouldn't it be a more natural solution t=
o
> make sure that when the total (i.e. name and graph) length can fit to
> align with the message and patch (i.e. traditional ~80 col regardless=
 of
> the terminal width), not to give it too much width?  If the names are
> short, like "a" and "b", that may result in graph bar part to use ~70
> columns or so, and if the names are long, like in a Java project, you=
 may
> allocate 50 columns to the name and leave only 50 columns or so for t=
he
> graph part.
>
> A simple heuristic might be to see if name part (without truncation) =
and
> the graph part (without scaling) fits under 100-columns if the termin=
al is
> wider than that, and if so limit the whole thing to 100-columns befor=
e
> deciding the allocation of the total into two parts.  If the name par=
t
> alone is very wide, showing the name and the graph using the whole
> terminal width would give you a better result than using the bars tha=
t are
> artificially capped to a short limit, I would imagine.
This seem overly complex. A nice property to have would be
"if the window is wide enough so there's enough space for full=20
filenames, the graph part scales monotonically with the change count".
(If there's filename truncation, than there just isn't enough space for=
=20
everything and the graph may be compressed. But otherwise, if we have=20
two graphs which do not end at the edge of the screen, and the second=20
one is wider than the first one, then without looking at the change=20
counts we know that the second one has more changes).

=46or this property to be satisfied, the graph_width limit would have t=
o=20
be independent of the filename width. So maybe it should be
   71 =3D (available space if stat_width=3D=3D80 and the filename is "a=
" and
         the change count is in double digits).
Then if the filenames are longer, and the change counts are big enough,
the graph part starts gently extending above 80 columns.

What do you think about this approach?

Zbyszek
