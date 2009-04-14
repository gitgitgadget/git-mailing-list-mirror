From: Junio C Hamano <gitster@pobox.com>
Subject: Re: On Tracking Binary Files
Date: Tue, 14 Apr 2009 13:05:30 -0700
Message-ID: <7vws9n2e7p.fsf@gitster.siamese.dyndns.org>
References: <7efce40a0904140741w28da9b54ucfe4b54bf48b0844@mail.gmail.com>
 <7efce40a0904140742i48aad41ds66de5dfe368f3b16@mail.gmail.com>
 <alpine.DEB.1.00.0904141853040.10279@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Patrick Berkeley <patrickberkeley@gmail.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Apr 14 22:07:35 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ltoua-000461-KV
	for gcvg-git-2@gmane.org; Tue, 14 Apr 2009 22:07:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751790AbZDNUFm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Apr 2009 16:05:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751686AbZDNUFm
	(ORCPT <rfc822;git-outgoing>); Tue, 14 Apr 2009 16:05:42 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:43695 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751540AbZDNUFl (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Apr 2009 16:05:41 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 2CD38AA5C8;
	Tue, 14 Apr 2009 16:05:38 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 95308AA5C5; Tue,
 14 Apr 2009 16:05:32 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 9F5D594E-292F-11DE-9BCC-C121C5FC92D5-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116562>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> On Tue, 14 Apr 2009, Patrick Berkeley wrote:
>
>> Does Git track the deltas on binary files?
>> 
>> Someone in #git mentioned that if the binaries change too much Git no
>> longer just stores the changes. If this is the case, what is the
>> breaking point where Git goes from storing the deltas to the entire
>> new file?
>
> Git does not store the deltas as you think it does.  The deltification of 
> the objects is almost independent from the commmit history, i.e. we 
> _always_ store snapshots for most practical matters.

Always store snapshots sounds as if you are not storing delta at all.  I
think I know what you meant to say, but the way you phrased it is
misleading.

Documentation/technical/pack-heuristics.txt talks about this in some
detail.  A short version is:

 - It does not make a difference if you are dealing with binary or text;

 - The delta is not necessarily against the same path in the previous
   revision, so even a new file added to the history can be stored in a
   delitified form;

 - When an object stored in the deltified representation is used, it would
   incur more cost than using the same object in the compressed base
   representation.  The deltification mechanism makes a trade-off taking
   this cost into account, as well as the space efficiency.

The last point may probably be not covered by pack-heuristics IRC talk
Linus had in the documentation.  Basically:

 - A deltified object is stored as an (compressed) xdelta against some
   base object.  If the best deltified representation we come up with is
   larger than the result of just compressing the object without
   deltification, it is not worth storing it from the space comsumption
   point of view.  Thus, we originally said something like "if an
   attempted delta is larger than half of the object size (assuming
   average 50% of compression ratio), do not use the deltified
   representation, it is not worth it".  We attempt to delta against many
   base objects to pick the best possible delta; the number of attempt is
   called the delta window.

 - The base object of a deltified object could also be deltified, and you
   may need to repeatedly apply delta on top of some object that is not a
   delta to get to the final object.  The length of this chain is called
   delta depth, and obviously you would want to keep the delta depth short
   to gain a reasonable runtime performance.  Thus, when delitifying one
   object A, we make a weighted comparison between the size of the delta
   to build it out of an object of depth N and the size of the delta to
   build it out of an object of depth M.  A slightly larger delta that is
   based on an object with a shallower delta depth is favored over a
   smaller delta based on an object with a much deeper delta depth.
