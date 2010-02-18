From: Junio C Hamano <gitster@pobox.com>
Subject: Re: How to create patches for a merge?
Date: Thu, 18 Feb 2010 10:10:13 -0800
Message-ID: <7veikifm9m.fsf@alter.siamese.dyndns.org>
References: <83d7aaa41002180340p2f9b7241h9c220b84ec5dd1d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Geoffrey Lee <geoffreyj.lee@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 18 19:10:32 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NiApZ-0005Wf-NF
	for gcvg-git-2@lo.gmane.org; Thu, 18 Feb 2010 19:10:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753482Ab0BRSKY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Feb 2010 13:10:24 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:46872 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752733Ab0BRSKX (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Feb 2010 13:10:23 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 8B8809BCE5;
	Thu, 18 Feb 2010 13:10:20 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=1VlPC1mq9x1wOhUCnYHu2tcwqxI=; b=kosqPK
	TnvVZPSmzWZ4cOMTs7dEMLWlI5DaNbJht6V+hcut6ICxHVEkl1b3rh2RECw5Vnwz
	/crjk+oKXWbjqxqZOUxAHXLCAaclI8/4XJ8XLxjHQk8utohmSPzRllZHSsEgP8xC
	Iloq9dN/I0RruaeOPmrHCK9KCcIn0YzMH8inI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=BDmAeYP/Uwsek2YUlImNFuENIxprARnJ
	tAQ2WGeem7iMjgwUhQkqKYfl+FKptfBualden9akOcER68M1JDZLz+JjYkkzydZa
	cX9OmF0qRsi4/A2Sf7K+QJR/S441f7Z9pibl7YBvE2I5I36ufrEeFuUNvcYpnU/7
	lC3UtBIvhQk=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 620AF9BCE4;
	Thu, 18 Feb 2010 13:10:18 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 738349BCE3; Thu, 18 Feb
 2010 13:10:15 -0500 (EST)
In-Reply-To: <83d7aaa41002180340p2f9b7241h9c220b84ec5dd1d@mail.gmail.com>
 (Geoffrey Lee's message of "Thu\, 18 Feb 2010 03\:40\:07 -0800")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: DEE7F02E-1CB8-11DF-80A3-D83AEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140353>

Geoffrey Lee <geoffreyj.lee@gmail.com> writes:

> This produces a merge conflict. In this scenario, "git format-patch
> master..bar" only produces 3 patches, omitting "Commit M". How do I
> deal with this?

There is no provision for communicating how a conflict is resolved over
patches.  The answer to your "How do I deal with *this*" question would be
"It is up to you.", if your "*this*" is "I want to communicate this as a
patch".  The steps to deal with "*this*" may go like this:

 - Think what shape of patch you want to see in order to convey what
   "Commit M" did to the recipient of your patch series.  First, try to
   construct it, by hand if necessary, as a design of such a feature.

 - How would a recipient "apply" such a patch?  As commonly used "patch"
   implementations, including "git apply", may not be able to read the
   above format, and they would certainly not create a merge commit, so
   you need to design the recieving side as well.

 - Then implement them ;-)

The best I think of offhand to reproduce

     B---M---D
    /   /
   A---C

might go like this:

 (1) Emit diff between (A,B) as usual;

 (2) Emit diff between (A,C) as usual, but with additional information
     usually not found in regular patches to help recipient that this
     should be applied to the same commit as (1) is applied to;

 (3) Emit diff between (B,M) and (C,M), but make sure that they won't be
     seen as a patch to be applied by ordinary "patch" programs to avoid
     mistakes at the recipient side.  Include some way to tell the
     recipient that these two "patches" need to be applied to the results
     of applying (1) and (2), and that the result needs to be recorded as
     a merge between them.

 (4) Emit D as usual;

Then the recipient would start from something that resembles A (call it X)
and do the following:

 (5) Apply (1); call that result B'

       B'
      /
     X

 (6) Apply (2), following that additional insn to apply the patch to the
     base of (5); call that result C'

       B'
      /
     X---C'

 (7) Apply (B,M) half of (3) to B' and call it M'


       B'..M'
      /
     X---C'

 (8) Apply (C,M) half of (3) to C' and call it M"

       B'--M' M"
      /      .
     X------C'

 (9) If M' and M" do not match (which can happen when A and X are majorly
     different), merge them using X as their common ancestor, and resolve
     conflicts as necessary, and call the result M'".

     If M' and M" do match, be happy and call either of them M'".

         B'..M'..M'"                B'..M'"
        /       .       or         /   . 
       /       M"                 X---C'
      /       .
     X-------C'

 (10) Record M'" as children of B' and C'.

       B'--M'"
      /   /
     X---C'

 (11) Apply (4); call that result D'

        B'--M'"-D'
      /   /
     X---C'

and you are done.
