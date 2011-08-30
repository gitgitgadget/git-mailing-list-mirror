From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/3] traverse_trees(): allow pruning with pathspec
Date: Tue, 30 Aug 2011 10:44:45 -0700
Message-ID: <7v39gi3ib6.fsf@alter.siamese.dyndns.org>
References: <7vty9054qr.fsf@alter.siamese.dyndns.org>
 <1314653603-7533-1-git-send-email-gitster@pobox.com>
 <1314653603-7533-2-git-send-email-gitster@pobox.com>
 <CACsJy8CmZv7Fuhw+m6X2CVO4vWLYFQNmStu1jJmhVXSi4mPxJQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 30 19:44:54 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QySMn-0000bY-Nl
	for gcvg-git-2@lo.gmane.org; Tue, 30 Aug 2011 19:44:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755881Ab1H3Ros (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Aug 2011 13:44:48 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:55384 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755858Ab1H3Ror (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Aug 2011 13:44:47 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 326CF460F;
	Tue, 30 Aug 2011 13:44:47 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=r/+/84LT/i3ORlTYx+i616DEq9I=; b=fcxymw
	Z5aN5imfQ209Gj52exu4Wp92eU2CtCuSEbxVNFcdq3rkwBIsKmAu1tlPIUwjTh/g
	xhKWnqokKwfb/mns8EEAh2+FpXgUbB8Jz0u440i6RkM/f2TPIPD52ZDsQirFuO4G
	NZ9AR38MTF/k2Rxy2aDIjkNs33aXTChArDY0I=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=lnE5iImDiVKbpHIFnMbBd85er7vrMVx8
	4zlaMlxgJCMv5jJ476FLRuk67EDFMwKZBiZbSz4GVPAY3hkJ5Aro4HPZe5dz4tJq
	pnssOBM8cL1C0C+miVtbzRlwdA4Lu6T0XwLKGx9G4rKzTWMOzdxaBXmVW6/ZkVU8
	EDcP/cTv0ag=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2A924460E;
	Tue, 30 Aug 2011 13:44:47 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A066F460D; Tue, 30 Aug 2011
 13:44:46 -0400 (EDT)
In-Reply-To: <CACsJy8CmZv7Fuhw+m6X2CVO4vWLYFQNmStu1jJmhVXSi4mPxJQ@mail.gmail.com> (Nguyen
 Thai Ngoc Duy's message of "Tue, 30 Aug 2011 19:53:15 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: C07141A2-D32F-11E0-9D49-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180425>

Nguyen Thai Ngoc Duy <pclouds@gmail.com> writes:

>> @@ -376,16 +396,22 @@ int traverse_trees(int n, struct tree_desc *t, struct traverse_info *info)
>>                        mask |= 1ul << i;
>>                        if (S_ISDIR(entry[i].mode))
>>                                dirmask |= 1ul << i;
>> +                       e = &entry[i];
>>                }
>
> Why? "e" is not used in that loop or anywhere after that.

This is trying to find _a_ surviving entry to be fed to prune_traversal()
which in turn uses tree_entry_interesting(). At this point in the code, we
are stuffing the entries of the same name from the input trees (and if one
tree is missing an entry of the chosen name, it will have NULL there), so
any non-empty entry would do. It corresponds to "first" but that is just a
simple string and not a name_entry tree_entry_interesting() wants.


>>                if (!mask)
>>                        break;
>> -               ret = info->fn(n, mask, dirmask, entry, info);
>> -               if (ret < 0) {
>> -                       error = ret;
>> -                       if (!info->show_all_errors)
>> -                               break;
>> +               interesting = prune_traversal(e, info, &base, interesting);
>> +               if (interesting < 0)
>> +                       break;
>
> I don't really understand this function to comment. But I guess when
> interesting < 0, we only skip info->fn() and assume it returns "mask"
> (its user unpack_callback() only returns either "mask" or -1).

We consume the entries we have used in merging (which is actually
"everything in entry[] array" as info->fn() returns "mask" itself) by
saying "update_extended_entry()" and the purpose of doing so is to prepare
to process the next entry of the tree we are traversing.

When tree_entry_interesting() returns negative, it tells us "no, and no
subsequent entries will be either", meaning "we are done with this tree".
As we are done, there is nothing to prepare for the next round; we are not
walking the remaining entries in the trees we are looking at. Is there any
point in calling update_extended_entry() I am missing?
