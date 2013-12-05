From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 0/3] Teaching "git push" to map pushed refs
Date: Wed,  4 Dec 2013 17:27:26 -0800
Message-ID: <1386206849-6503-1-git-send-email-gitster@pobox.com>
References: <1386117594-22062-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 05 02:27:40 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VoNj7-000401-Oi
	for gcvg-git-2@plane.gmane.org; Thu, 05 Dec 2013 02:27:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756253Ab3LEB1d (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Dec 2013 20:27:33 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:39128 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753515Ab3LEB1c (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Dec 2013 20:27:32 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6860B58739
	for <git@vger.kernel.org>; Wed,  4 Dec 2013 20:27:32 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=2NZg
	0WjEXFJJY7KRakhJNQIy6Qw=; b=Suv3dTdIKknri9U4I+2iXzeJpUfmZz+qoUjG
	A+tSAJJVYyDyDYFLMWUjt1Ig/MIYw0XULs2179/VLLAtJr1wcBGSQmE+X5tfaEyo
	VOmwmHu+DJbFXaAVM5u58XeCPjHaYaiyX1Iq6F3TsAWu2p5DxrbXax2zTdz86D3W
	ZMnO92M=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=auwK3h
	My6qq3DOyjoNH6nCUZLOqAUu4WlN+A62oQFHCmsJ3yQwDrfemhORTuJvxupfx6RZ
	RP6zFnkFOTRwb2p48bo+bnBE00i/PR8FXlxPK/K2xVuIO/oX6O1YIQI11GY0LJug
	LUopEibsOdBgrNrZBqlQb/gTooEqBiMaVNccU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5780858738
	for <git@vger.kernel.org>; Wed,  4 Dec 2013 20:27:32 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 9CF3558736
	for <git@vger.kernel.org>; Wed,  4 Dec 2013 20:27:31 -0500 (EST)
X-Mailer: git-send-email 1.8.5.1-402-gdd8f092
In-Reply-To: <1386117594-22062-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 69488D3C-5D4C-11E3-87F2-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238832>

The 'master' refspec in "git fetch origin master" used to mean "We
grab their 'master' branch, but we do not store it in any of our
remote-tracking branches." but in modern Git, the remote-tracking
branch that would receive updates from 'master' with a corresponding
"git fetch origin" (without any specific refs on the command line)
is updated.  Updating the same refs/remotes/origin/master with

	git fetch origin
	git fetch origin master

avoids surprises.

However, we did not have a similar refspec mapping on the push side.
This three-patch series does just that.  It would help triangular
workflow by making these two:

	git checkout master && git push origin
	git push origin master

update the same ref at the 'origin'.  It also would help those who
need to emulate a fetch run on mothership from satellite with a push
run on satellite into mothership (due to e.g. network connectivity
issues).

The second round avoids instantiating the remote and the list of
local heads until the very last minute when they are actually
needed (the change is in the second patch).

Junio C Hamano (3):
  builtin/push.c: use strbuf instead of manual allocation
  push: use remote.$name.push as a refmap
  push: also use "upstream" mapping when pushing a single ref

 Documentation/git-push.txt |  9 +++--
 builtin/push.c             | 84 ++++++++++++++++++++++++++++++++++------------
 remote.c                   |  8 ++---
 remote.h                   |  2 ++
 t/t5516-fetch-push.sh      | 75 +++++++++++++++++++++++++++++++++++++++++
 5 files changed, 150 insertions(+), 28 deletions(-)

-- 
1.8.5.1-402-gdd8f092
