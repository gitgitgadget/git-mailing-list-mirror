From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 4/4] restore_env(): free the saved environment variable once we are done
Date: Tue, 02 Feb 2016 15:50:02 -0800
Message-ID: <xmqqio26pt91.fsf_-_@gitster.mtv.corp.google.com>
References: <56A72235.9080602@drmicha.warpmail.net>
	<1453814801-1925-1-git-send-email-pclouds@gmail.com>
	<xmqq60ygcd9a.fsf@gitster.mtv.corp.google.com>
	<xmqqbn87a54v.fsf@gitster.mtv.corp.google.com>
	<CACsJy8DzHYpw3TT3i17W-8eiR9J9DOQUO6mkxffUEnGqT1u96Q@mail.gmail.com>
	<xmqqtwlz8c4w.fsf@gitster.mtv.corp.google.com>
	<xmqqy4ba627n.fsf_-_@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Git Mailing List <git@vger.kernel.org>,
	Michael J Gruber <git@drmicha.warpmail.net>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 03 00:50:14 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aQki4-0003XX-L0
	for gcvg-git-2@plane.gmane.org; Wed, 03 Feb 2016 00:50:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754852AbcBBXuH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Feb 2016 18:50:07 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:62901 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754771AbcBBXuF (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Feb 2016 18:50:05 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 7435041A28;
	Tue,  2 Feb 2016 18:50:04 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=gv4H4+nschmtsr3vyXC9fpj39FM=; b=FKs/76
	sqN8lLivE2vn6Bd+UKu0ro0hYaCMVcSAPS6RzGTA4E+PJgX56tTDLm++X9DD7TRq
	NdRCvkzzLISwMjLmWMpDCignMluRK58JOuWGKobLprOW+JVCthGAnJwA3wM3w77/
	Z55JiruoorGBA2gk78FXerS4U1gvT10alEnVs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=QhaFASzaZlkzzqwW3aOh+3qc5w8soCII
	8cp3+qPlb6NY9/949m3mq1TspPfJH/UPP1Wyb6KYhh6Gw2m/7BRI1WSovJvMFgPW
	iFTzUui3MNSzXdc9XysFvCT6oytVeJdryuHPI+Nni9eoZyI+HfT9Q2Doem9IFW6w
	RBZvwRLkHIo=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 6BF5541A27;
	Tue,  2 Feb 2016 18:50:04 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id DE3DE41A26;
	Tue,  2 Feb 2016 18:50:03 -0500 (EST)
In-Reply-To: <xmqqy4ba627n.fsf_-_@gitster.mtv.corp.google.com> (Junio
	C. Hamano's message of "Wed, 27 Jan 2016 15:18:36 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: AE1B3886-CA07-11E5-80CF-04C16BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285319>

Just like we free orig_cwd, which is the value of the original
working directory saved in save_env_before_alias(), once we are
done with it, the contents of orig_env[] array, saved in the
save_env_before_alias() function should be freed; otherwise,
the second and subsequent calls to save/restore pair will leak
the memory allocated in save_env_before_alias().

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 * This is new.

 git.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/git.c b/git.c
index 1cbe267..93f569d 100644
--- a/git.c
+++ b/git.c
@@ -54,10 +54,12 @@ static void restore_env(int external_alias)
 		if (external_alias &&
 		    !strcmp(env_names[i], GIT_PREFIX_ENVIRONMENT))
 			continue;
-		if (orig_env[i])
+		if (orig_env[i]) {
 			setenv(env_names[i], orig_env[i], 1);
-		else
+			free(orig_env[i]);
+		} else {
 			unsetenv(env_names[i]);
+		}
 	}
 }
 
-- 
2.7.0-391-gcd29568
