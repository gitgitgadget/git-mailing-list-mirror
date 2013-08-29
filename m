From: Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH v2 1/5] replace: forbid replacing an object with one of
 a different type
Date: Thu, 29 Aug 2013 08:29:36 +0200 (CEST)
Message-ID: <20130829.082936.1893875995125817253.chriscool@tuxfamily.org>
References: <xmqqk3j6c1x0.fsf@gitster.dls.corp.google.com>
	<878uzmclva.fsf@linux-k42r.v.cablecom.net>
	<xmqqa9k1a9wq.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: trast@inf.ethz.ch, git@vger.kernel.org, philipoakley@iee.org,
	j6t@kdbg.org
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Thu Aug 29 08:30:06 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VEvk5-0008JI-J9
	for gcvg-git-2@plane.gmane.org; Thu, 29 Aug 2013 08:30:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752825Ab3H2GaA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Aug 2013 02:30:00 -0400
Received: from [194.158.98.15] ([194.158.98.15]:59978 "EHLO mail-2y.bbox.fr"
	rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751895Ab3H2G37 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Aug 2013 02:29:59 -0400
Received: from localhost (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr [128.78.31.246])
	by mail-2y.bbox.fr (Postfix) with ESMTP id 3A7995A;
	Thu, 29 Aug 2013 08:29:36 +0200 (CEST)
In-Reply-To: <xmqqa9k1a9wq.fsf@gitster.dls.corp.google.com>
X-Mailer: Mew version 6.3 on Emacs 23.3 / Mule 6.0 (HANACHIRUSATO)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233235>

From: Junio C Hamano <gitster@pobox.com>
>
> Thomas Rast <trast@inf.ethz.ch> writes:
> 
>> Hrm, you're right, that's a flaw in my logic.  You could do the same in
>> all other cases too, e.g. replace a tree so that an entry is of a
>> different type and at the same time change the type of the object
>> itself.  You however have to carefully go through all objects that refer
>> to the one that was replaced, and fix the type in all of them.
>>
>> It still seems an extremely unsafe thing to do with trees...
>>  ...
>> Should we add a --force flag of some sort to allow the user to do this,
>> while keeping the normal safety checks?
> 
> As long as we do not forbid such an unusual replacement on the
> reading side, we won't break people who are more inventive than we
> are (I am not convinced that we know people's workflow well enough
> to definitively say that no sane workflow, which benefits from being
> able to replace an object with another from a different type,
> exists).
> 
> Preventing "git replace" wrapper from creating such a replacement by
> default will make it harder to do and may reduce mistakes, without
> breaking them too much, I think.

I agree. It is always possible to create replacement refs using "git
update-ref" if one really wants to.

What about using the following in the commit message or in the
documentation:

------------------------------------------

DISCUSSION

If one object is replaced with one of a different type, the only way
to keep the history valid is to also replace all the other objects
that point to the replaced object. That's because:

* Annotated tags contain the type of the tagged object.

* The tree/parent lines in commits must be a tree and commits, resp.

* The object types referred to by trees are specified in the 'mode'
  field:
    100644 and 100755    blob
    160000               commit
    040000               tree
  (these are the only valid modes)

* Blobs don't point at anything.

But if all the objects that point to an object, called O, are to be
replaced, then in most cases object O probably doesn't need to be
replaced. It's probably sufficient to create the new object, called
O2, that would replace object O and to replace all the objects
pointing to object O with objects pointing to O2.

The only case where someone might really want to replace object 0,
with an object O2 of a different type, and all the objects pointing to
it, is if it's really important, perhaps for external reasons, to have
object O's SHA1 point to O2.

And anyway, if one really wants to do that, it can still be done using
"git update-ref".

------------------------------------------

Thanks,
Christian.
