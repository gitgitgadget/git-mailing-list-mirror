From: greened@obbligato.org (David A. Greene)
Subject: Re: BUG: git subtree split gets confused on removed and readded directory
Date: Sun, 17 Jan 2016 17:23:07 -0600
Message-ID: <87twmbaizo.fsf@waller.obbligato.org>
References: <56991CFC.7060705@ruhr-uni-bochum.de>
	<xmqq4meeflws.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Dave Ware <davidw@realtimegenomics.com>, git@vger.kernel.org,
	Marcus Brinkmann <marcus.brinkmann@ruhr-uni-bochum.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jan 18 00:23:52 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aKwfn-0001jG-I8
	for gcvg-git-2@plane.gmane.org; Mon, 18 Jan 2016 00:23:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752905AbcAQXXQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 17 Jan 2016 18:23:16 -0500
Received: from li209-253.members.linode.com ([173.255.199.253]:32990 "EHLO
	johnson.obbligato.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752804AbcAQXXO (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Jan 2016 18:23:14 -0500
Received: from chippewa-nat.cray.com ([136.162.34.1] helo=waller.obbligato.org)
	by johnson.obbligato.org with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
	(Exim 4.85)
	(envelope-from <greened@obbligato.org>)
	id 1aKwgY-0003eo-GT; Sun, 17 Jan 2016 17:24:39 -0600
In-Reply-To: <xmqq4meeflws.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
	message of "Fri, 15 Jan 2016 15:44:19 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
X-Filter-Spam-Score: ()
X-Filter-Spam-Report: Spam detection software, running on the system "johnson.obbligato.org",
 has NOT identified this incoming email as spam.  The original
 message has been attached to this so you can view it or label
 similar future email.  If you have any questions, see
 @@CONTACT_ADDRESS@@ for details.
 Content preview:  Junio C Hamano <gitster@pobox.com> writes: > Marcus Brinkmann
    <marcus.brinkmann@ruhr-uni-bochum.de> writes: > >> I made a simple test repository
    showing the problem here: >> https://github.com/lambdafu/git-subtree-split-test>
    >> After creating the master branch, I created the split/bar branch like
   this: >> >> $ git subtree split -P bar -b split/bar >> >> The resulting history
    is confused by the directory "bar" which was >> added, removed and then re-added
    again. The recent history up to adding >> the directory the second time is
    fine. But  
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284272>

Junio C Hamano <gitster@pobox.com> writes:

> Marcus Brinkmann <marcus.brinkmann@ruhr-uni-bochum.de> writes:
>
>> I made a simple test repository showing the problem here:
>> https://github.com/lambdafu/git-subtree-split-test>
>> After creating the master branch, I created the split/bar branch like this:
>>
>> $ git subtree split -P bar -b split/bar
>>
>> The resulting history is confused by the directory "bar" which was
>> added, removed and then re-added again.  The recent history up to adding
>> the directory the second time is fine.  But then it seems to loose track
>> and add the parent of that commit up to the initial commit in the history.
>>
>> I'd expect that the parent of the readding commit is an empty tree
>> commit (which removed the last files in the directory), and that before
>> that are commits that reflect the initial creation of that directory
>> with its files, but rewritten as a subtree, of course.
>
> Thanks for a report.

Yes, thank you!

> David, does this ring a bell?

No, I have not run into this before.  I'm actually going to be working
in the split code starting sometime this month (work allowing, of
course).  So it's great to get a report like this.

One of the things I want to do is eventually move over subtree split to
using a proper filter-branch instead of the entirely custom code that's
currently there.  This does, however, appear to cause a semntic
difference in preliminary testing which I am still tracking down.  The
filter-based split is *incredibly* faster than the current code.  The
current code can take hours on moderately-sized histories.

This should shake out a lot of these kinds of problems since the
filter-branch code is heavily used and tested while the subtree split
code is not.

Assuming this goes ahead, I plan to introduce a new switch to control
filter-branch vs. original code and migrate the default to filter-branch
if all goes well.

I'll write up a failing test for this so that I remember to address it
when I get to the code.

Thanks again, Marcus!

                         -David
