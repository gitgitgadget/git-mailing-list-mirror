From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 03/18] revert: Simplify and inline add_message_to_msg
Date: Wed, 27 Jul 2011 22:56:04 +0530
Message-ID: <CALkWK0kFngXcyrKeB4HM5GdHebkuXOQ5jBETxWuxZCzYL94tqg@mail.gmail.com>
References: <1311736755-24205-1-git-send-email-artagnon@gmail.com>
 <1311736755-24205-4-git-send-email-artagnon@gmail.com> <20110727041809.GB18470@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Jeff King <peff@peff.net>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 27 19:26:32 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qm7sN-00068p-Tm
	for gcvg-git-2@lo.gmane.org; Wed, 27 Jul 2011 19:26:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752862Ab1G0R02 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 27 Jul 2011 13:26:28 -0400
Received: from mail-qw0-f46.google.com ([209.85.216.46]:41044 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752659Ab1G0R00 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 27 Jul 2011 13:26:26 -0400
Received: by qwk3 with SMTP id 3so931908qwk.19
        for <git@vger.kernel.org>; Wed, 27 Jul 2011 10:26:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=JNn5kbBNrYFp/mFow1vm13V8nBiKvJOfyxjsabzB8K8=;
        b=v9SkkKFc3EKgnNNXp5BVzfiXGt+QFjLMqjk/SBJhUD6gcTjTANXX7HLTCpWiGOwtVp
         HvnA4MnFsjRjaWZkQ56qp0QpPfvp317YhFCYX0JA30AOkCtxL6v0aon69KmnbYQIvdFb
         hJ3Zc7zfsHw9HTAVEiezg6iTdcv/gIDJBefHc=
Received: by 10.229.21.213 with SMTP id k21mr34259qcb.239.1311787585729; Wed,
 27 Jul 2011 10:26:25 -0700 (PDT)
Received: by 10.229.221.205 with HTTP; Wed, 27 Jul 2011 10:26:04 -0700 (PDT)
In-Reply-To: <20110727041809.GB18470@elie>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177984>

Hi,

Jonathan Nieder writes:
> Ramkumar Ramachandra wrote:
>> [Subject: [PATCH 03/18] revert: Simplify and inline add_message_to_m=
sg]
>
> Before, I wrote that it would be better to present this as a bugfix
> than as a code reorganization, since the former is more likely to
> affect people upgrading or to be relevant if this later turns out to
> have a regression and someone wonders why not to just revert it. =C2=A0=
Was
> I wrong?

I like the new commit message: I like to think that the old code was
misguided (intent: replace an empty commit message with the commit
object name), rather than buggy.  Since it's not possible to reproduce
the "bug" without constructing a commit object by hand, I don't know
if we should classify it a "bug".

> Testcase below. =C2=A0It makes a commit like this:
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0tree f0db5ba931b3f121d2050e23ac3cd47ac2233=
306
> =C2=A0 =C2=A0 =C2=A0 =C2=A0parent 43991719f0536a734e91e94f40361114477=
b3b5e
> =C2=A0 =C2=A0 =C2=A0 =C2=A0author A U Thor <author@example.com> 11129=
12113 -0700
> =C2=A0 =C2=A0 =C2=A0 =C2=A0committer C O Mitter <committer@example.co=
m> 1112912113 -0700
>
> with no blank line afterwards. =C2=A0I think this is relevant and not=
 a
> "what if cosmic rays corrupt that pointer" kind of thing because
> people use non-git programs or libraries to write to git object store=
s
> pretty often. =C2=A0If this object were invalid, it would still not b=
e a
> good behavior to segfault (better to die() or give some
> arbitrary-but-sane result). =C2=A0Not sure whether the object should =
be
> considered invalid (e.g., "git fsck" accepts it).

Thanks for writing the test.  However, there are probably several
other edge cases in other parts of Git which accept slightly malformed
tree/ blob objects.  Including this test is like telling developers:
"We have to be prepared for the worst kind of malformed objects in
every single Git application, not just objects created by us", and
there is probably no end to this.  In my opinion, it is alright to
SIGSEGV when a different but incorrect implementation of Git creates a
corrupt object store -- we should punish them for the mistake and set
an example.  Instead of attacking the problem at this level, I think
we should get the lower layers like git-fsck to throw out malformed
objects.

> Unfortunately it fails for me even after the patch. =C2=A0If the test=
 looks
> reasonable to you, it could be worth adding marked with
> "test_expect_failure".

Perhaps as part of a different series which addresses the issue of
malformed objects in general.  I don't think it is relevant for this
series.  The "other" series I'm thinking about should contain:
1. Documentation about the exact format of commit, tree, blob objects
the way the fast-import stream is documented.
2. Fixes to the lower layers like git fsck/repack/gc: it should throw
out objects that don't conform to the spec.
3. A dedicated list of tests that intentionally create malformed
objects to verify the spec/ restraining code.

(It should accommodate the major implementations and older versions of =
C Git)

Thanks.

-- Ram
