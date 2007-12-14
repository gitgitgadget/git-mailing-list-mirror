From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Fix config lockfile handling.
Date: Fri, 14 Dec 2007 13:57:59 -0800
Message-ID: <7vfxy5os60.fsf@gitster.siamese.dyndns.org>
References: <1197665998-32386-1-git-send-email-krh@redhat.com>
	<1197665998-32386-2-git-send-email-krh@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Kristian =?utf-8?Q?H=C3=B8gsberg?= <krh@redhat.com>
X-From: git-owner@vger.kernel.org Fri Dec 14 22:58:52 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J3IYT-0000El-HS
	for gcvg-git-2@gmane.org; Fri, 14 Dec 2007 22:58:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757056AbXLNV6Y convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 14 Dec 2007 16:58:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761837AbXLNV6U
	(ORCPT <rfc822;git-outgoing>); Fri, 14 Dec 2007 16:58:20 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:63742 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759897AbXLNV6S convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 14 Dec 2007 16:58:18 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 1D0229C8A;
	Fri, 14 Dec 2007 16:58:08 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id ADC569C89;
	Fri, 14 Dec 2007 16:58:03 -0500 (EST)
In-Reply-To: <1197665998-32386-2-git-send-email-krh@redhat.com> (Kristian
	=?utf-8?Q?H=C3=B8gsberg's?= message of "Fri, 14 Dec 2007 15:59:57 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68352>

Kristian H=C3=B8gsberg <krh@redhat.com> writes:

> When we commit or roll back the lock file the fd is automatically clo=
sed,
> so don't do that again.

With your change, we do not check the return status from close(2)
anymore, which means that we may have run out of diskspace without
noticing and renamed the incomplete file into the real place.  Oops?

At least the original code wouldn't have had that problem.

The right fix in the longer term would be to check the return value fro=
m
the close(2) in commit_lock_file(), but it currently does not check on
purpose, because the callers may have already closed the fd.
