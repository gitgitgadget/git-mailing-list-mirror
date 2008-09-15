From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 05/16] ls-files: add --narrow-checkout option to "will
 checkout" entries
Date: Mon, 15 Sep 2008 13:20:16 -0700
Message-ID: <7v3ak1b1q7.fsf@gitster.siamese.dyndns.org>
References: <1221397685-27715-1-git-send-email-pclouds@gmail.com>
 <1221397685-27715-2-git-send-email-pclouds@gmail.com>
 <1221397685-27715-3-git-send-email-pclouds@gmail.com>
 <1221397685-27715-4-git-send-email-pclouds@gmail.com>
 <1221397685-27715-5-git-send-email-pclouds@gmail.com>
 <1221397685-27715-6-git-send-email-pclouds@gmail.com>
 <m34p4io8vt.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Mon Sep 15 22:21:47 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KfKZn-0002mr-5a
	for gcvg-git-2@gmane.org; Mon, 15 Sep 2008 22:21:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754425AbYIOUUa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Sep 2008 16:20:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754444AbYIOUUa
	(ORCPT <rfc822;git-outgoing>); Mon, 15 Sep 2008 16:20:30 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:64520 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754366AbYIOUUa (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Sep 2008 16:20:30 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 5B87161B3F;
	Mon, 15 Sep 2008 16:20:27 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id ECF1361B3D; Mon, 15 Sep 2008 16:20:22 -0400 (EDT)
In-Reply-To: <m34p4io8vt.fsf@localhost.localdomain> (Jakub Narebski's message
 of "Sun, 14 Sep 2008 11:55:06 -0700 (PDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: BC31FDBC-8363-11DD-9D5D-D0CFFE4BC1C1-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95937>

Jakub Narebski <jnareb@gmail.com> writes:

>> @@ -72,6 +73,11 @@ OPTIONS
>>  	to file/directory conflicts for checkout-index to
>>  	succeed.
>>  
>> +--narrow-checkout::
>> +	When narrow checkout is being used, this option together with other
>> +	index-based selection options like --cached or --stage, only narrowed
>> +	portion will be printed out.
>> +
>
> I would rather say, that if git-ls-files is requested to show index
> content (by using selection options like --cached or --stage), then
> by default it shows all entries, also those marked "no checkout".
> With this option git-ls-files would show only files that would get
> checked out.

ls-files is a very low-level interrogator, and I have this queasy feeling
in the stomach if it suddenly stopped showing half of the index without
explicitly asked to with an option like this.  If somebody iterates over
ls-files output (with or without pathspecs), most often it would be to do
something interesting on the work tree files that correspond to these
paths, and for that use case it would make sense to have a mode that shows
only the paths marked for checkout.  But unless you can prove that "most
often" above is "100%", you risk breaking somebody's script.  Maybe you
are doing something similar [*1*] to the index-filter feature of
filter-branch, starting from the current index that has no-checkout marks
in its entries, and it wants to know all the paths in the index.  Who
knows?


[Footnote]

*1* filter-branch happens to start with an empty index and does not know
about the new 'narrow checkout' feature, so it is Ok, but it is plausible
as an optimization for it to prime the initial index from the current
"real" index, which may have the no-checkout marks.
