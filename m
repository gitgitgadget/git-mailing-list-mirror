From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Use case I don't know how to address
Date: Sun, 06 Sep 2009 01:03:12 -0700
Message-ID: <7vk50ccxfj.fsf@alter.siamese.dyndns.org>
References: <4AA20CEC.8060408@chandlerfamily.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Alan Chandler <alan@chandlerfamily.org.uk>
X-From: git-owner@vger.kernel.org Sun Sep 06 10:05:30 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MkCkb-000397-VW
	for gcvg-git-2@lo.gmane.org; Sun, 06 Sep 2009 10:05:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754685AbZIFIDW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Sep 2009 04:03:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754680AbZIFIDW
	(ORCPT <rfc822;git-outgoing>); Sun, 6 Sep 2009 04:03:22 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:41318 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752227AbZIFIDS (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Sep 2009 04:03:18 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 9B934280B0;
	Sun,  6 Sep 2009 04:03:19 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=sAMDoRpR7YEAbHiOwtHl2q2rhC0=; b=hgJ+uiWHuNEJFek7it51gIQ
	g7KrpY1p/MiDdOOqNulji8vyJn99mLFWDNybpdoWusscH7nIMcdciqoXmz6ZiDdf
	jGfnKYf0ScbMn2q3MdRx2W7zJK+7q5Y3zdAWObXkzopwCIDBJ+DRvi4V67QCcAmc
	JY9aVQsK+tqT63O9HfiU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=iCpbc7hYkQaPOBLnzDs30R4PCLYiY+lPUgwyf6LQAeTj9FmW8
	EO2Zv2sVOSQmTAv3lkc3rWlsQmU9SssiXBO8IJpJPBYzgbQo8dzfznN2MFqht/V8
	69wPe9+jhR7T3qSjXVfucsNJg4slBiZChGegN7DZ2dtlJShudYx8VAIAlY=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 602E7280AF;
	Sun,  6 Sep 2009 04:03:17 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C0E6A280AE; Sun,  6 Sep
 2009 04:03:13 -0400 (EDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: BC234FFE-9ABB-11DE-AA20-A13518FFA523-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127845>

Alan Chandler <alan@chandlerfamily.org.uk> writes:

>        2' - 2a - 3' - 4' ----------------- 6' SITE
>       /         /    /                    /
> 1 -  2  ------ 3  - 4  ------------6'''- 6a TEST
>                      \            /
>                        5  ------ 6  MASTER
>                         \         \
>                           5''- 5a- 6'' DEMO
>
>
> What will happen is the changes made in 4->5 will get applied to the
> (now) Test branch as part of the 6->6'' merge, and I will be left
> having to add a new commit, 6a, to undo them all again.  Given this is
> likely to be quite a substantial change I want to try and avoid it if
> possible.

I presume 6'''-6a has the revert of 4-5?  If so, the next merge should
work just fine.

You have arranged TEST->SITE transition correctly to limiting the SITE
customization to 2a and never merging SITE back to TEST, so we can ignore
SITE branch altogether from now on.  Similarly we can ignore DEMO branch,
since its customization is limited to 5a and it never gets merged back to
MASTER.

    1 -  2  ------ 3  - 4  ------------6'''- 6a-----7a??? TEST
                         \            /            /    
                           5  ------ 6------------7 MASTER

Now, 6-7 is a new feature built on MASTER.  What would happen when it is
merged to TEST to produce 7a?

The merge base for this merge is 6, and since that commit to the tip of
the TEST branch 6a, there is a "skin from vanilla to FanClub" change and
nothing else.  On the other hand, since the merge base to the tip of the
MASTER branch 7, there is a "feature enhancement" but no skin related
changes.

So bog-standard three-way merge should say:

 - One branch, MASTER, added these features, but TEST branch did not do
   anything with these feature changes since the merge base.  We'll use
   the feature change done on MASTER.

 - The other branch, TEST, changed the skin from the merge base, but
   MASTER branch did not change any skinning.  We'll keep the skin change
   done on TEST.

And everything should be fine.
