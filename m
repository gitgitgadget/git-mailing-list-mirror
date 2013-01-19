From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 0/2] Hiding some refs in ls-remote
Date: Fri, 18 Jan 2013 16:37:04 -0800
Message-ID: <1358555826-11883-1-git-send-email-gitster@pobox.com>
Cc: spearce@spearce.org, mfick@codeaurora.org
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jan 19 01:37:43 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TwMRK-0002GN-DA
	for gcvg-git-2@plane.gmane.org; Sat, 19 Jan 2013 01:37:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753698Ab3ASAhL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Jan 2013 19:37:11 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:46449 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751835Ab3ASAhK (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Jan 2013 19:37:10 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0FC24A0AA;
	Fri, 18 Jan 2013 19:37:09 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id; s=sasl; bh=+h5BQ3y9m10JAHVxvh+7a0Rp1Jg
	=; b=RHyrfhrq+UestxTr3cNlKKGkUwBqIdO2araolchb+5LUTNwUdIzAqKva4N4
	gjt70v3fkzFxIgg49ihN6WJ4qauUtcfugc+bZqsFPtl0dT7yuTR4BiowLpWaKm4/
	0EtgiC15X+yj/MuBtKUkPeyknD7Rfu1i5PNPPaBzKkrI48HU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:message-id; q=dns; s=sasl; b=WNFMS7rfZibA0OJlu0RDW
	H4t5d3u+IlNxFhWdS3h6IMyytaj4izsUtKWQwGcLZ7fSehu2F19ccNqqKXB0XJDd
	8lM7DwhVGXsiuDV+7frD2MCfyCqDG0MV+aEu3TXyvARskNkQWCLZKtaIGk+voxa+
	wF6NK5owOtDzSFxYKDe4g8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0473CA0A9;
	Fri, 18 Jan 2013 19:37:09 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 60EC2A0A6; Fri, 18 Jan 2013
 19:37:08 -0500 (EST)
X-Mailer: git-send-email 1.8.1.1.454.g48d39c0
X-Pobox-Relay-ID: 5B19CED8-61D0-11E2-B09D-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213951>

This is an early preview of reducing the network cost while talking
with a repository with tons of refs, most of which are of use by
very narrow audiences (e.g. refs under Gerrit's refs/changes/ are
useful only for people who are interested in the changes under
review).  As long as these narrow audiences have a way to learn the
names of refs or objects pointed at by the refs out-of-band, it is
not necessary to advertise these refs.

On the server end, you tell upload-pack that some refs do not have
to be advertised with the uploadPack.hiderefs multi-valued
configuration variable:

	[uploadPack]
		hiderefs = refs/changes

The changes necessary on the client side to allow fetching objects
at the tip of a ref in hidden hierarchies are much more involved and
not part of this early preview, but the end user UI is expected to
be like these:

	$ git fetch $there refs/changes/72/41672/1
	$ git fetch $there 9598d59cdc098c5d9094d68024475e2430343182

That is, you ask for a refname as usual even though it is not part
of ls-remote response, or you ask for the commit object that is at
the tip of whatever hidden ref you are interested in.

Junio C Hamano (2):
  upload-pack: share more code
  upload-pack: allow hiding ref hiearchies

 t/t5512-ls-remote.sh |  9 ++++++
 upload-pack.c        | 86 ++++++++++++++++++++++++++++++++++++++++++----------
 2 files changed, 79 insertions(+), 16 deletions(-)

-- 
1.8.1.1.454.g48d39c0
