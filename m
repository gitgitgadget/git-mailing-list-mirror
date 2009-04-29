From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Weird growth in packfile during initial push
Date: Wed, 29 Apr 2009 16:57:37 -0700
Message-ID: <7vy6tj109a.fsf@gitster.siamese.dyndns.org>
References: <20090415182754.GF23644@curie-int>
 <alpine.LFD.2.00.0904151443030.6741@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Robin H. Johnson" <robbat2@gentoo.org>, git@vger.kernel.org
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Thu Apr 30 01:57:54 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LzJf0-0005K1-05
	for gcvg-git-2@gmane.org; Thu, 30 Apr 2009 01:57:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753849AbZD2X5p (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Apr 2009 19:57:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753198AbZD2X5p
	(ORCPT <rfc822;git-outgoing>); Wed, 29 Apr 2009 19:57:45 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:41267 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751465AbZD2X5o (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Apr 2009 19:57:44 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 4D9A413B12;
	Wed, 29 Apr 2009 19:57:43 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 7195B13B0F; Wed,
 29 Apr 2009 19:57:39 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 8798B290-3519-11DE-BA52-D766E3C8547C-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117981>

Nicolas Pitre <nico@cam.org> writes:

>> $ git push origin master:master
>> Initialized empty Git repository in /var/gitroot/exp/gentoo-x86.git/
>> Counting objects: 4969800, done.
>> Delta compression using up to 8 threads.
>> Compressing objects: 100% (1217809/1217809), done.
>> Writing objects: 100% (4969800/4969800), 810.56 MiB | 21608 KiB/s, done.
>> Total 4969800 (delta 3735812), reused 4969800 (delta 3735812)
>
> Here we know for sure that all objects were directly reused, so no 
> attempt at recompressing them was done.  The only thing that 
> pack-objects might do in this case in addition to directly streaming the 
> existing pack is to convert delta object headers from OFS_DELTA to 
> REF_DELTA.
>
>> $ ls -la /var/gitroot/exp/gentoo-x86.git/objects/pack
>> total 966876
>> drwxr-xr-x 2 git git      4096 Apr 14 08:43 .
>> drwxr-xr-x 4 git git      4096 Apr 14 08:35 ..
>> -r--r--r-- 1 git git 139155472 Apr 14 08:43 pack-f805bb448f864becfeac9c7f8a8ac2ef90c26787.idx
>> -r--r--r-- 1 git git 849936308 Apr 14 08:43 pack-f805bb448f864becfeac9c7f8a8ac2ef90c26787.pack
>
> Let's see if my theory stands:
>
> 	849936308 - 786336481 = 63599827
> 	63599827 / 3735812 = 17.02
>
> Hence an average difference of 17 bytes per delta.  Given that REF_DELTA 
> objects have a 20-byte SHA1 base reference which is replaced with a 
> variable length encoding of a pack offset in the OFS_DELTA case, we're 
> talking about 2.98 bytes for that offset encoding which feels about 
> right.
>
> [...]
>
> And the code matches this theory as well.  Can you try this patch if you 
> have a chance?

Is there any progress on this?

I think you did a veryclear analysis.  8% size reduction is not only
unignorable but use of delta offset should also help runtime efficiency,
right?
