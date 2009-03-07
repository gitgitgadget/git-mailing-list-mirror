From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/3] builtin-merge: add support for default merge options
Date: Fri, 06 Mar 2009 16:58:04 -0800
Message-ID: <7v63imqhcz.fsf@gitster.siamese.dyndns.org>
References: <cover.1236377358.git.jaysoffian@gmail.com>
 <12addb53ef5c0e62ee22847591c8e7b884dc0bd2.1236377358.git.jaysoffian@gmail.com> <13f0016028b195541b8b5d9149292150cbb13ab7.1236377358.git.jaysoffian@gmail.com> <9f755b5bae0b02c5cb3e01680acf71fe7153be04.1236377358.git.jaysoffian@gmail.com> <7vr61aqngu.fsf@gitster.siamese.dyndns.org> <76718490903061516l62869424q4bd4cfa64fe2195e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, jean-luc malet <jeanluc.malet@gmail.com>
To: Jay Soffian <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Sat Mar 07 01:59:46 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LfktC-0003B6-Tl
	for gcvg-git-2@gmane.org; Sat, 07 Mar 2009 01:59:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753043AbZCGA6P convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 6 Mar 2009 19:58:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752151AbZCGA6P
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Mar 2009 19:58:15 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:49441 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750753AbZCGA6O convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 6 Mar 2009 19:58:14 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id A1C199FEE0;
	Fri,  6 Mar 2009 19:58:11 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 2106E9FEDE; Fri,
  6 Mar 2009 19:58:06 -0500 (EST)
In-Reply-To: <76718490903061516l62869424q4bd4cfa64fe2195e@mail.gmail.com>
 (Jay Soffian's message of "Fri, 6 Mar 2009 18:16:08 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 07F1A0D2-0AB3-11DE-84BF-CFA5EBB1AA3C-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112500>

Jay Soffian <jaysoffian@gmail.com> writes:

> On Fri, Mar 6, 2009 at 5:46 PM, Junio C Hamano <gitster@pobox.com> wr=
ote:
>
>> When you are on branch "frotz", your config have both merge.options =
and
>> branch.frotz.mergeoptions, and you give some other options from the
>> command line, how should they interact? =C2=A0I'd expect the branch.=
*.options
>> to take effect, ignoring merge.options entirely.
>
> Really? I didn't think that would be consistent with the fact that th=
e
> the command line options override branch.*.options, but don't replace
> them.

I think cumulative option in configuration is bad in practice, but I'll
explain why after talking about something else.

I think it would be much better if you did not introduce a new
configuration merge.options which is not consistent with everything els=
e
to begin with.

Instead, if your addition was literally to allow saying things like thi=
s,
it would be much easier to understand.

	[branch "*"]
        	mergeoptions =3D ...
                remote =3D origin
                rebase =3D true
	[branch "frotz"]
        	mergeoptions =3D ; nothing
                rebase =3D false
	[branch "nitfol"]
        	remote =3D xyzzy

When on branch 'nitfol', because there is an overriding "remote" define=
d,
we would not look at branch.*.remote and fetch from xyzzy instead of
fetching from the default origin.  Because there is no "rebase" defined
for that branch, we would use branch.*.rebase=3Dtrue from the fall-back
default.

When on branch 'frotz', because you have an explicit mergeoptions that
says "I do not want any", it would override whatever is defined for the
corresponding fall-back default branch.*.mergeoptions.

Having explained that I think branch.*.mergeoptions is syntactically ni=
cer
and more extensible as the UI to the end user, let's discuss the
"cumulative" aspect.  In the following, I'll keep using branch.*.$optio=
n,
but you can read it as if I said merge.options and the discussion is th=
e
same.

There are two reasons why you as an end user specify a concrete value
(e.g. "empty") for a concrete branch name (e.g. branch.frotz.mergeoptio=
ns).
One is because you know the current value set to the fall-back default
(e.g. branch.*.mergeoptions) is not suitable for this particular branch=
=2E
Another is because you know you may want to change the fall-back defaul=
t
sometime in the future, and you do not want that to affect your setting
you are making for this particular branch today.

=46or the purpose of the first reason above, if you allowed cumulative
option, the end user needs to inspect branch.*.$option and come up with=
 a
countermanding set of options to set to branch.frotz.$option.  If there=
 is
no cumulative option, the end user does not have to worry about what
branch.*.$option says.  Non-cumulative is simply easier to understand.

=46or the purpose of the second reason above, when the user has to upda=
te
branch.frotz.$option because some external situation changed (e.g. the
user used to be an e-mail contributor, but now gained "push privilege";
the user became the primary maintainer; etc.), the same argument on
maintenance burden as above holds.  To update branch.*.$option, you nee=
d
to inspect every branch.$specific.$option (or lack thereof) as well in
either way.

So overall, cumulative configuration tend to be more cumbersome for the
end user to manage.

You cannot draw a direct analogy with the command line options, which i=
s
used as a single-shot override by nature.  The user knows what usually
happens when he says "git pull" while on branch 'frotz' without options=
,
and countermanding specific aspects (but not necessarily others) of the
operation for this single invocation.  Because the configuration values
are set so that the user can set-and-forget the exact syntax to invoke
each feature, cumulativeness between configured default and command lin=
e
override makes more sense.
