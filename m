From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Heads up: major rebase -i -p rework coming up
Date: Sat, 24 Jan 2009 15:01:12 -0800
Message-ID: <7vzlhgl35z.fsf@gitster.siamese.dyndns.org>
References: <alpine.DEB.1.00.0901242056070.14855@racer>
 <7vpricmoda.fsf@gitster.siamese.dyndns.org>
 <alpine.DEB.1.00.0901242156320.14855@racer>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Stephan Beyer <s-beyer@gmx.net>, git@vger.kernel.org,
	Stephen Haberman <stephen@exigencecorp.com>,
	spearce@spearce.org, Thomas Rast <trast@student.ethz.ch>,
	=?utf-8?Q?Bj=C3=B6rn?= Steinbrink <B.Steinbrink@gmx.de>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sun Jan 25 00:03:04 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LQrWp-0004Z5-Pb
	for gcvg-git-2@gmane.org; Sun, 25 Jan 2009 00:03:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752065AbZAXXBa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 24 Jan 2009 18:01:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751560AbZAXXB3
	(ORCPT <rfc822;git-outgoing>); Sat, 24 Jan 2009 18:01:29 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:49241 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751209AbZAXXB2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 24 Jan 2009 18:01:28 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id A629E1D343;
	Sat, 24 Jan 2009 18:01:27 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 3C3A31D0E0; Sat,
 24 Jan 2009 18:01:19 -0500 (EST)
In-Reply-To: <alpine.DEB.1.00.0901242156320.14855@racer> (Johannes
 Schindelin's message of "Sat, 24 Jan 2009 22:04:53 +0100 (CET)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: EE509FCE-EA6A-11DD-A5DD-BE78113D384A-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107015>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> - What's with the apostrophe?  I seem to remember that you argued it 
>>   would be enough to make "A" stand for the original when it is used for 
>>   the first time and the second and later use can stand for the result 
>>   of the last use (e.g. the "goto A'" above can be simply spelled as 
>>   "goto A"), when I suggested to use "mark" in a way similar to how 
>>   fast-import language uses it during the sequencer discussion?
>> 
>>   I am not complaining; I am just being curious why the sudden change of 
>>   heart.
>
> Very easy explanation.  I got convinced by your arguments.  Even if I 
> could imagine that I never use the thing without apostrophe, it is good to 
> have an obvious indicator that this is not necessarily the original 
> commit.

Now that does not make much sense to me.

The reason I suggested that 'mark' would give a cleaner semantics was
because in your earlier design "A" could either stand for the original or
it could stand for the result of an operation that used "A", and there
could be more than one operation that uses "A".  Explicitly naming each
result with a mark would give us an unambiguous way to distinguish them.

I however do not think you would ever use A twice in the context of
"rebase -i/-p".  Cherry-picking the same commit twice to create two copies
of them will not happen in that context.

While trying to recreate something like this on top of a commit "o", you
would have to talk about "A" multiple times,...

          B---M
         /   / \
 ---o---A---C   \
     \   \       \
      D---N-------O

... but even in such a picture, after one "pick A", you would always want
to refer to the result of the pick, and never the original A.

    pick A
    goto A'^
    pick D
    merge A' was N
    goto A'
    pick B
    goto A'
    pick C
    merge B' was M
    merge N' was O

So I am inclined to think that "first use refers to the original, second
and thereafter will refer to the result of the first use" would be a good
enough semantics for "rebase -i/-p", and you do not need "A" vs "A'" for
this.

By the way, I think this example shows that your "goto" might need a way
to refer to the "onto" commit in some way (I just used "A'^" there).

On the other hand, if you are aiming to allow users to create (by editing
the insn file) an arbitrarily different structure like this, starting from
the same topology:

  ---o---B---C---A
      \           \
       A---D-------O

that is, rebasing the upper line of development into one linear sequence
with different patch order, while rebasing the lower line into another
linear sequence by rebasing D on top of A, you would need to be able to
refer to the two different results of "using A", and your "A'" notation
would not help.

    pick B
    pick C
    pick A
    goto B'^
    pick A
    pick D
    merge A' was O

The last "merge A' was O" is done while on the result of applying D on top
of the result of applying A on the lower line, and wants to call the tip
of the upper line by referring it as "the result of applying A". 

But there are two results from applying A, and I do not think you can
avoid 'mark', even though you for some reason seem to hate it.

If this kind of transformation is outside the scope of your redesign
(which I think is a sensible design decision), I do not see why you would
need "A vs A'".

You either need the full power of 'mark', or "A is original until it is
used, and then the one and only one result once it is used,"; nothing in
between like "A vs A'" would make much sense.
