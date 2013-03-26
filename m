From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Rename conflicts in the index
Date: Tue, 26 Mar 2013 12:24:47 -0700
Message-ID: <7vboa6t14w.fsf@alter.siamese.dyndns.org>
References: <A54CE3E330039942B33B670D971F857403995D93@TK5EX14MBXC252.redmond.corp.microsoft.com> <7va9q72n1u.fsf@alter.siamese.dyndns.org> <A54CE3E330039942B33B670D971F857403A0AA7A@TK5EX14MBXC253.redmond.corp.microsoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "git\@vger.kernel.org" <git@vger.kernel.org>
To: Edward Thomson <ethomson@microsoft.com>
X-From: git-owner@vger.kernel.org Tue Mar 26 20:25:24 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UKZUl-00067c-CY
	for gcvg-git-2@plane.gmane.org; Tue, 26 Mar 2013 20:25:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753963Ab3CZTYv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Mar 2013 15:24:51 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:65220 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751753Ab3CZTYu (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Mar 2013 15:24:50 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id EBD34A480;
	Tue, 26 Mar 2013 15:24:49 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=xVwEvPt4C3L1p4FJtNpJAxVKNgs=; b=h7T3Oa
	glgaA5GnTr8eQpeZrLk8/GMyidSG5ZGwDLWDqK0INYqr1vhe8KRBi1JV8ge/ZGpi
	25En90/lL7ZErf+dGqH8lh2uLQiYyd9qZHZwqmk9eNjoexxVITx3y8g4bE4Ww2cm
	UBUEGk8ZS1VSr/GsHzgEFnej5/ctTpFdVq/04=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=CKRbc/RDSX0gDr4tw+DEiuwYvybSm6Ua
	EiiINu9qIwRrCG4Qli8HS84g7dXXU5PqdV+/o8Z8B27nYVM/f2aeUSnerMx0ghDG
	d+WGAx+lVY8CyV3xwv1EQAFvCXSP0RKvscf78ApRjZPA5LX+QQfmymv43eyOEDpx
	ubF8zwV66GM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DA362A47F;
	Tue, 26 Mar 2013 15:24:49 -0400 (EDT)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 1F82DA47D; Tue, 26 Mar 2013
 15:24:49 -0400 (EDT)
In-Reply-To: <A54CE3E330039942B33B670D971F857403A0AA7A@TK5EX14MBXC253.redmond.corp.microsoft.com> (Edward Thomson's message of "Tue, 26 Mar 2013 18:30:29 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: D34D9E62-964A-11E2-9D4E-EA7A2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219190>

Edward Thomson <ethomson@microsoft.com> writes:

> I would propose a new extension, 'CONF', to handle conflict data, differing
> from the stage >0 entries in the index in that this extension tracks the
> conflicting file across names if the underlying merge engine has support
> for renames.
>
> I made an attempt to keep the entry data similar to other entries in the
> index.  I would propose that entries in the conflict are as follows:
>
> Flags
>   Four octets that describe the conflict.  Data includes:
>
>   0x01  HAS_ANCESTOR
>     There is a file in the common ancestor branch that contributes
>     to this conflict.  Its data will follow.
>   0x02  HAS_OURS
>     There is a file in "our" branch that contributes to this conflict.
>     Its data will follow.
>   0x04  HAS_THEIRS
>     There is a file in "their" branch that contributes to this conflict.
>     Its data will follow.
>
>   0x08  NAME_CONFLICT_OURS
>     This item has a path in "our" branch that overlaps a different
>     item in "their" branch.  (Eg, this conflict represents the "our"
>     side of a rename/add conflict.)
>   0x10  NAME_CONFLICT_THEIRS
>     This item has a path in "their" branch that overlaps a different
>     item in "our" branch.  (Eg, this conflict represents the "theirs"
>     side of a rename/add conflict.)
>
>   0x20  DF_CONFLICT_FILE
>     This is the file involved in a directory/file conflict.
>   0x40  DF_CONFLICT_CHILD
>     This is a child of a directory involved in a directory/file conflict.
>
>   Other bits are reserved.
>
> Conflict Sides
>   The data about one side of a conflict will contain:
>   mode (ASCII string representation of octal, null-terminated)
>   path (null terminated)
>   sha1 (raw bytes)
>
> The conflict sides will be written in this order:
>   Ancestor (if HAS_ANCESTOR is set)
>   Ours (if HAS_OURS is set)
>   Theirs (if HAS_THEIRS is set)

Puzzled.  Most of the above, except NAME_CONFLICT_{OURS,THEIRS}
bits, look totally pointless duplication.

When you are working with Git, you have to be prepared to read from
the datafile like the index that other people (and your previous
version) created, and you also have to make sure you do not make
what you write out unusable by other people without a good reason.

So your tool needs code to see higher stage entries in the main
index to find <mode,sha1> for the conflicted paths even without the
index extension anyway, and if your tool does also perform merges,
you would need to strive for writing the main index with conflicted
entries and implementations that do not yet understand your
extension can keep operating.  For some types of extensions, the
latter may be hard (and that is why I stopped at "you would need to
strive for", and not "you must"), but for the one under discussion,
I do not think it is the case (by the way "CONF" sounds as if it is
some sort of configuration data).

If you are starting a brand new system from scratch, keeping only
the resolved entries in the main index and having a separate section
for conflicts might be also a valid design choice, but you do not
live in that world if you are discussing the design on this mailing
list.

> I would propose that this not simply track rename conflicts, but all
> conflicts.

That is a no starter.
