From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC PATCH 0/9] Narrow/Sparse checkout round 3: "easy mode"
Date: Sat, 16 Aug 2008 22:50:24 -0700
Message-ID: <7vbpzs9om7.fsf@gitster.siamese.dyndns.org>
References: <20080815142439.GA10609@laptop>
 <7v1w0pdze0.fsf@gitster.siamese.dyndns.org>
 <fcaeb9bf0808162212y756465a5ib7ce3a8849765033@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Nguyen Thai Ngoc Duy" <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sun Aug 17 07:56:30 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KUbFa-0005UN-5S
	for gcvg-git-2@gmane.org; Sun, 17 Aug 2008 07:56:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751243AbYHQFuc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 17 Aug 2008 01:50:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751234AbYHQFub
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Aug 2008 01:50:31 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:54045 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751225AbYHQFub (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Aug 2008 01:50:31 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 8DA0864D56;
	Sun, 17 Aug 2008 01:50:29 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id C286C64D55; Sun, 17 Aug 2008 01:50:26 -0400 (EDT)
In-Reply-To: <fcaeb9bf0808162212y756465a5ib7ce3a8849765033@mail.gmail.com>
 (Nguyen Thai Ngoc Duy's message of "Sun, 17 Aug 2008 12:12:50 +0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 65EBA1A6-6C20-11DD-A9FF-B29498D589B0-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92579>

"Nguyen Thai Ngoc Duy" <pclouds@gmail.com> writes:

> On 8/16/08, Junio C Hamano <gitster@pobox.com> wrote:
>> Nguyen Thai Ngoc Duy <pclouds@gmail.com> writes:
>>  > Another difference from the last round is "narrow rules" will not be preserved
>>  > when switching branches. When you switch branch with no option, you will get
>>  > full checkout. You may want to use --path|--add-path|--remove-path when
>>  > switching branches to have narrow checkout again.
>>
>>
>> You could save the "narrow rules" in the extension section of the index.
>>  If the final form of this series needs to use a separate CE_NO_CHECKOUT
>>  bit (which would make the resulting index incompatible with the current
>>  git), the narrow rules section can be marked as "your git must understand
>>  this" class of extension to make sure that people do not mistakenly access
>>  an index written by this new version of git with the current or older git.
>
> The problem is "narrow rules" may change over time in a way that git
> may handle it wrong. Assume that you have a directory with two files:
> a and b. You first narrow checkout a (which would save the rule
> "checkout a"). Then you do "git checkout b". When you update HEAD,
> what should happen?

I'd expect that this sequence:

	git checkout --set-no-checkout arch include
        git checkout arch/x86 include/asm-x86

to set up narrowing rules to (1) exclude everything in arch/ and include/
area by default, but (2) allow checking out everything in arch/x86/ and
include/asm-x86/ that currently exist _and_ will exist in different commits
when we switch to.

On the other hand, if I did this after the above two-command sequence:

	git checkout include/Kbuild

then I'd expect only that file to be added to the checkout set.  I think
you can record list of pathspecs (with positive and negative) to implement
that semantics, no?

>>  > Now back to technical POV. I did not reuse CE_VALID (assume unchanged) bit
>>  > because it has been used for core.ignorestat.
>>
>> I am not sure what's the relation between these two.
>
> Because the usage is different? When you "git update-index foo" with
> core.ignorestat=1, it will mark it CE_VALID. And if the same bit is
> used for narrow checkout, the file is considered not existing in
> workdir. I'd expect foo is still in my narrow area after "git
> update-index foo".

Ok.  We would need to use an extra bit for this.

The bit 0x4000 is the last one available, so we would want to use it as
"this index entry uses more bits than the traditional format" bit, and
define a backward incompatible on-disk index entry format to actually
record CE_NO_CHECKOUT and other flags we will invent in the future.

Perhaps ondisk_cache_entry structure will have an extra "unsigned int
flags2" after "flags" when that bit is on, and we can have 31 more bits in
flags2, with the highest bit of flags2 signalling the presense of flags3
word in the future, or something like that.

By the way, "uint" and "ushort" in struct ondisk_cache_entry are 4-byte
and 2-byte network byte order integers; should we write them as uint32_t
and uint16_t instead in the longer run?
