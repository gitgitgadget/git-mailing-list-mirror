From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: Transparently encrypt repository contents with GPG
Date: Sat, 14 Mar 2009 12:16:26 +0100
Message-ID: <49BB920A.20301@drmicha.warpmail.net>
References: <978bdee00903121419o61cd7a87rb55809796bd257d7@mail.gmail.com> <fabb9a1e0903121434u4a3d71bdi6277071f54557a7e@mail.gmail.com> <49BA39A1.9090203@drmicha.warpmail.net> <200903131215.49336.trast@student.ethz.ch> <fabb9a1e0903130417x36121bd5ya8b323e0a80bbd8f@mail.gmail.com> <49BA6606.1070403@fastmail.fm> <7vy6v9f9zn.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Sverre Rabbelier <srabbelier@gmail.com>,
	Thomas Rast <trast@student.ethz.ch>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Matthias Nothhaft <matthias.nothhaft@googlemail.com>,
	git@vger.kernel.org, Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Mar 14 12:18:44 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LiRt5-00024R-03
	for gcvg-git-2@gmane.org; Sat, 14 Mar 2009 12:18:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752990AbZCNLQl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 14 Mar 2009 07:16:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752909AbZCNLQk
	(ORCPT <rfc822;git-outgoing>); Sat, 14 Mar 2009 07:16:40 -0400
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:49770 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752480AbZCNLQi (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 14 Mar 2009 07:16:38 -0400
Received: from compute2.internal (compute2.internal [10.202.2.42])
	by out1.messagingengine.com (Postfix) with ESMTP id 6658B2EF710;
	Sat, 14 Mar 2009 07:16:36 -0400 (EDT)
Received: from heartbeat1.messagingengine.com ([10.202.2.160])
  by compute2.internal (MEProxy); Sat, 14 Mar 2009 07:16:36 -0400
X-Sasl-enc: dp2XRyMDKnFAgyG/9I0D1hV7Rf+I6yBpCDb6vDyrTC4S 1237029395
Received: from localhost.localdomain (p4FC60DCD.dip0.t-ipconnect.de [79.198.13.205])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 80B5AC627;
	Sat, 14 Mar 2009 07:16:34 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1b4pre) Gecko/20090314 Lightning/1.0pre Shredder/3.0b3pre
In-Reply-To: <7vy6v9f9zn.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113244>

Junio C Hamano venit, vidit, dixit 13.03.2009 21:23:
> Michael J Gruber <michaeljgruber+gmane@fastmail.fm> writes:
> 
>> In .gitattributes (or.git/info/a..) use
>>
>> * filter=gpg diff=gpg
>>
>> In your config:
>>
>> [filter "gpg"]
>>         smudge = gpg -d -q --batch --no-tty
>>         clean = gpg -ea -q --batch --no-tty -r C920A124
>> [diff "gpg"]
>>         textconv = decrypt
>>
>> This gives you textual diffs even in log! You want use gpg-agent here.
> 
> Don't do this.
> 
> Think why the smudge/clean pair exists.
> 
> The version controlled data, the contents, may not be suitable for
> consumption in the work tree in its verbatim form.  For example, a cross
> platform project would want to consistently use LF line termination inside
> a repository, but on a platform whose tools expect CRLF line endings, the
> contents cannot be used verbatim.  We "smudge" the contents running
> unix2dos when checking things out on such platforms, and "clean" the
> platform specific CRLF line endings by running dos2unix when checking
> things in.  By doing so, you can see what really got changed between
> versions without getting distracted, and more importantly, "you" in this
> sentence is not limited to the human end users alone.
> 
> git internally runs diff and xdelta to see what was changed, so that:
> 
>  * it can reduce storage requirement when it runs pack-objects;
> 
>  * it can check what path in the preimage was similar to what other path
>    in the postimage, to deduce a rename;
> 
>  * it can check what blocks of lines in the postimage came from what other
>    blocks of lines in the preimage, to pass blames across file boundaries.
> 
> If your "clean" encrypts and "smudge" decrypts, it means you are refusing
> all the benifit git offers.  You are making a pair of similar "smudged"
> contents totally dissimilar in their "clean" counterparts.  That is simply
> backwards.
> 
> As the sole raison d'etre of diff.textconv is to allow potentially lossy
> conversion (e.g. msword-to-text) applied to the preimage and postimage
> pair of contents (that are supposed to be "clean") before giving a textual
> diff to human consumption, the above config may appear to work, but if you
> really want an encrypted repository, you should be using an encrypting
> filesystem.  That would give an added benefit that the work tree
> associated with your repository would also be encrypted.

Exactly. This is why I suggested using cryptfs/luks in my first response
already.

But I don't know the OP's requirements, which is why I also told him how
to do what he wanted, even though it has the drawbacks you and Jeff (and
maybe I) mentioned. Maybe it's an attempt at hosting a semi-private repo
on a public (free) server?

Besides the non-text nature of encrypted content, the problem here is
that d(e(x))=x for all x but e(d(x)) differs from x most probably, and
hopefully randomly, unless you use the right version of debian's openssl
of course ;)

That being said:
git diff calls textconv filters with smudged as well as cleaned files
(when diffing work tree files to blobs), and this does not seem right. I
hope this is not happening with the internal diff, nor with crlf!

Since both the cleaned and the smudged version are supposed to be
"authoritative" (as opposed to the textconv'ed one) one may argue either
way what's the right approach. For internal use comparing the cleaned
versions may make more sense, for displaying diff's the checked-out
form, i.e. smudged versions make more sense.

But that is another topic which would need to be substantiated with
tests. It's not completely unlikely I may come up with some, but don't
count on it...

Cheers,
Michael
