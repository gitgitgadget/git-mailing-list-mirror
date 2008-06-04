From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Avoid errors from git-rev-parse in gitweb blame
Date: Tue, 03 Jun 2008 22:58:07 -0700
Message-ID: <7v3ant213k.fsf@gitster.siamese.dyndns.org>
References: <940824.46903.qm@web31808.mail.mud.yahoo.com>
 <200806032331.44514.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Luben Tuikov <ltuikov@yahoo.com>,
	Rafael Garcia-Suarez <rgarciasuarez@gmail.com>,
	git@vger.kernel.org, Lea Wiemann <lewiemann@gmail.com>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 04 07:59:19 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K3m1m-00052b-TS
	for gcvg-git-2@gmane.org; Wed, 04 Jun 2008 07:59:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751960AbYFDF6Z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Jun 2008 01:58:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751952AbYFDF6Z
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Jun 2008 01:58:25 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:51518 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751860AbYFDF6Y (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Jun 2008 01:58:24 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 6A0CF2DE9;
	Wed,  4 Jun 2008 01:58:23 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 89A322DE6; Wed,  4 Jun 2008 01:58:15 -0400 (EDT)
In-Reply-To: <200806032331.44514.jnareb@gmail.com> (Jakub Narebski's message
 of "Tue, 3 Jun 2008 23:31:43 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 3DCA855C-31FB-11DD-A5EE-F9737025C2AA-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83744>

Jakub Narebski <jnareb@gmail.com> writes:

>> The intention was that it shouldn't necessarily be the (strict) parent
>> of the change (changed segment), since it may or may not have changed
>> in the strict parent commit.  The intention was that it
>> "starts"/"opens" the parent commit so that "git" would start from
>> there and find the actual change/commit where that line/segment has
>> changed.  And it has worked pretty fine for me when data-mining
>> (something I do quite often) code evolution.

Yes, but the current scheme breaks down in another way.  When $full_rev
added many lines to the file, and you are adding the link to for a line
near the end of the file and such a line may not exist.  This cannot be
cheaply done even inside blame itself.

Another breakage is even though $full_rev^ _may_ exist (iow, $full_rev
might not be the root commit), the file being blamed may not exist there
(iow $full_rev might have introduced the file).  Instead of running
"rev-parse $full_rev^", you would at least need to ask "rev-list -1
$full_rev^ -- $path" or something from the Porcelain layer, but
unfortunately this is rather expensive.

Because blame already almost knows if the commit the final blame lies on
has a parent, it would be reasonably cheap to add that "parent or nothing"
information to its --porcelain (and its --incremental) format if we wanted
to.
