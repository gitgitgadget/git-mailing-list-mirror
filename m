From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Interesting git-format-patch bug
Date: Tue, 27 Nov 2012 09:29:21 -0800
Message-ID: <7vy5hnlzta.fsf@alter.siamese.dyndns.org>
References: <4B2793BF110AAB47AB0EE7B9089703854CA7BA61@fmsmsx110.amr.corp.intel.com>
 <7vobikotwd.fsf@alter.siamese.dyndns.org>
 <50b4304c.EwQy4JquPwsUyMfZ%perryh@pluto.rain.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, alan.r.olsen@intel.com
To: perryh@pluto.rain.com (Perry Hutchison)
X-From: git-owner@vger.kernel.org Tue Nov 27 18:29:49 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TdOyi-0007ND-Qu
	for gcvg-git-2@plane.gmane.org; Tue, 27 Nov 2012 18:29:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756629Ab2K0R3a (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Nov 2012 12:29:30 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:49882 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756578Ab2K0R3Z (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Nov 2012 12:29:25 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 49A619745;
	Tue, 27 Nov 2012 12:29:24 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=MiGAcTXEmjLfF9/Koh0X3UmiAyY=; b=uWdxYW
	nSxA2otpWJx28F+OvKnaGWWGpmxEDjFthG+eR86Vw+vAK26AulXfsKNhRVLCmImV
	00Ut+zQ3KGRjwcmgzpp0s2Sr7G4zdqoO2cOMs+numYF41fHUKOqTn2FG3D1N1VG/
	pzl/sxXxslcptWvbm4t+0tEqjT1VZ40Y3Eg50=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=RhXh3iRWUKLJJs8sAkXuakSC7KD1RoVM
	rY8ihCs6+OmjuEhiR3rw/mi5d9nhy6Cj+tl+qkvKeO82Vvn5ZaFlzepwRLH2asyU
	JAcGjiI6Q7Lxp7VeDPUIENgrvSrjLbUeeV1Tq+deBQLdngFMkp3nLvqDBHHP0Cqt
	NWnFab87Ppk=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0EEC39736;
	Tue, 27 Nov 2012 12:29:24 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 4BEA29733; Tue, 27 Nov 2012
 12:29:23 -0500 (EST)
In-Reply-To: <50b4304c.EwQy4JquPwsUyMfZ%perryh@pluto.rain.com> (Perry
 Hutchison's message of "Mon, 26 Nov 2012 20:15:24 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: FC099EB4-38B7-11E2-A670-C2612E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210569>

perryh@pluto.rain.com (Perry Hutchison) writes:

> Junio C Hamano <gitster@pobox.com> wrote:
>> "Olsen, Alan R" <alan.r.olsen@intel.com> writes:
>> > I found an interesting bug in git-format-patch.
>> >
>> > Say you have a branch A.  You create branch B and add a patch to
>> > it. You then merge that patch into branch A. After the merge,
>> > some other process (we will call it 'gerrit') uses annotate and
>> > changes the comment on the patch that exists on branch B.
>> >
>> > Now someone runs git-format-patch for the last n patches on
>> > branch A.  You should just get the original patch that was
>> > merged over to branch A.  What you get is the patch that was
>> > merged to branch A *and* the patch with the modified commit
>> > comment on branch B. (Double the patches, double the
>> > clean-up...)
>>
>> As you literally have patches that do essentially the same or
>> similar things on two branches that was merged, you cannot
>> expect to export each individual commit into a patch and not
>> have conflicts among them.  So I do not think there is no
>> answer than "don't do that".
>
> To me, this seems to miss Alan's point:  only one patch was merged
> to branch A,...

Are you sure about this part?

I thought Alan's description was that he originally had this

    x-----A
     \     \
      B-----M (a)

and then "some other process" made it like so:

    x-----A
    |\     \
    | B-----M
     \       \
      B'------M' (a)

and then you ask to linealize the last n patches starting from the
rewritten M'.

If that "some other process" instead created a history like this:

    x-----A---\
    |\     \   \ 
    | B-----M   \
     \           \
      B'----------M' (a)

then the redone-merge M' will not see the old B that was fixed later
to B' in the history, but then format-patch would not show B so we
wouldn't be having this discussion thread.

It is possible that "some other process" may (ab)use the parent
field to record the evolution of B, to create a topology like this:

    x-----A---\
    |\     \   \
    | B-----M   \
     \ \         \
      \-B'--------M' (a)

in which case M' has parent B' but B' has a (phoney) parent B.

So again, it all depends on what "some other process" does to the
history when it rewrites it, and if somebody wants to fiter cruft in
the resulting history when flattening it, the knowledge of what
"some other process" does need to help that process.

Which is what I already said, I guess ;-)

> so git-format-patch applied to branch A should find
> only one patch.  It can be argued either way whether that one-patch
> report should include the gerrit annotations, but surely the
> application of gerrit on branch B, _after the merge to branch A
> has already been performed_, should not cause an additional patch
> to magically appear on branch A.
