From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] builtin-fast-export.c: add default case to avoid crash
 on  corrupt repo
Date: Sun, 22 Mar 2009 14:58:53 -0700
Message-ID: <7vwsahcj8i.fsf@gitster.siamese.dyndns.org>
References: <1237675051-6688-1-git-send-email-kusmabite@gmail.com>
 <7vd4cabffl.fsf@gitster.siamese.dyndns.org>
 <40aa078e0903220522g66cf2172l9f1a43ed562cc4d3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Erik Faye-Lund <kusmabite@gmail.com>, git@vger.kernel.org,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: Erik Faye-Lund <kusmabite@googlemail.com>
X-From: git-owner@vger.kernel.org Sun Mar 22 23:00:42 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LlVig-0002AY-Ha
	for gcvg-git-2@gmane.org; Sun, 22 Mar 2009 23:00:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756045AbZCVV7H (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 22 Mar 2009 17:59:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756041AbZCVV7G
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Mar 2009 17:59:06 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:39823 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755983AbZCVV7D (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Mar 2009 17:59:03 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 078F0A462D;
	Sun, 22 Mar 2009 17:59:02 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id DD881A462A; Sun,
 22 Mar 2009 17:58:54 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: A745EEEC-172C-11DE-AFF2-32B0EBB1AA3C-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114181>

Erik Faye-Lund <kusmabite@googlemail.com> writes:

> Anyway, I guess this makes the most sense as a four-patch series:
> 1) Add test-cases for tags of tag objects, tag objects of tag objects,
> tags of trees and tag objects of trees.
> 2) Turn the existing error into a warning
> 3) Add the missing warning and remove the crash
> 4) Fix fast-export to export tags pointing to tags.
>
> Makes sense?

Yes.

I suspect we will hear an argument that say the dying is deliberate
because pretending to have produced a faithful export while some
information is lacking is bad and warnings are easy to miss, and I would
certainly understand that argument.

We have similar issue with signed tags and filter-branch, which strips the
signature when it rewrites the history.  I recall the code originally died
for the same reasoning, but asking "it died; what can the user do now?"
made us realize that it is the best we can do to make best-effort
reproduction with a warning when losing information.

This falls into the same category.  I think "we die by default if we
cannot give a faithful reproduction, and the user needs to give an
explicit permission (e.g. --force option) to lose information", is a very
sensible thing to do, but "we die if we cannot export some things, and we
refuse to produce an approximation." without an escape hatch is not.
