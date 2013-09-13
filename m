From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 2/2] version-gen: avoid messing the version
Date: Fri, 13 Sep 2013 11:16:11 -0700
Message-ID: <xmqqbo3wk2ok.fsf@gitster.dls.corp.google.com>
References: <1379035046-6688-1-git-send-email-felipe.contreras@gmail.com>
	<1379035046-6688-3-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Fri Sep 13 20:16:20 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VKXul-0006WG-9J
	for gcvg-git-2@plane.gmane.org; Fri, 13 Sep 2013 20:16:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752610Ab3IMSQP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Sep 2013 14:16:15 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:41843 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751624Ab3IMSQO (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Sep 2013 14:16:14 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 926A340CA6;
	Fri, 13 Sep 2013 18:16:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=yRMxWupgCHSoWn4xT1v5nXmIko4=; b=EWv7I4OAfvReviQTW6gC
	xrQ12Wvb8kxz1LrpuqJ88FDdzJIl0R/3HF3atIWDfmPLpnWILuA7hLGtDS6OV2/B
	YUg/QLBbYy6F9NV/cUiAISrEek+zz4WxaQysDwMGzc9UdmIC+510p+40a81qTSzb
	v9mIwB5BviL4CGXmMAZk1Do=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=cscpjqgAaTpb1KZv0xY5t65qnUOtewrfIaZ/cAoQHYDrYQ
	uZqa8v6XQkQH9wP4pCM1dfAxLYbpwLtNCTTBFzdgD8PxcXAWLcm356bCAv6ldJwS
	kkUE6YAqqigcESNi7zSorLOPGr/z21HDQZfHWOVbuVVTszfQkqyGfZR3p62k4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 87B3640CA3;
	Fri, 13 Sep 2013 18:16:13 +0000 (UTC)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id F29AD40CA0;
	Fri, 13 Sep 2013 18:16:12 +0000 (UTC)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 9288B8B2-1CA0-11E3-8B9A-CA9B8506CD1E-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234759>

Felipe Contreras <felipe.contreras@gmail.com> writes:

> If the version is 'v1.8.4-rc1' that is the version, and there's no need
> to change it to anything else, like 'v1.8.4.rc1'.
>
> If RedHat, or somebody else, needs a specific version, they can use the
> 'version' file, like everybody else.
>
> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
> ---

I already explained to you why this is a bad change.

When we say "we try to avoid regressions", we really mean it.
Before coming up with a change to pay Paul by robbing Peter, we must
make an honest effort to see if there is a way to pay Paul without
robbing anybody.

This change forces existing users who depend on how dashes are
mangled into dots to change their tooling.  

We do occasionally make deliberate regressions that force existing
users to change the way they work, but only when there is no other
way, and when the benefit of the change far outweighs the cost of
such an adjustment, and with careful planning to ease the pain of
transition.  The updates to "git add" and "git push" planned for 2.0
fall into that category.

There has to be a benefit that far outweighs the inconvenience this
patch imposes on existing users, but I do not see there is any.  "If
somebody needs a specific version, they can use the 'version' file"
does not justify it at all; it equally applies to those who want to
use a version name with a dash.

Besides, the patch does not even do what it claims to do; if the
version is "v1.8.4-rc1", what you get out of the updated code is
"1.8.4-rc1", still losing the leading "v".

I'd be more receptive if the patch were like this instead, though.


diff --git a/GIT-VERSION-GEN b/GIT-VERSION-GEN
index b444c18..c6d78ec 100755
--- a/GIT-VERSION-GEN
+++ b/GIT-VERSION-GEN
@@ -3,12 +3,16 @@
 GVF=GIT-VERSION-FILE
 DEF_VER=v1.8.4.GIT
 
+READ_RAW_VERSION=
 LF='
 '
 
 # First see if there is a version file (included in release tarballs),
 # then try git-describe, then default.
-if test -f version
+if test -f raw-version && VN=$(cat raw-version)
+then
+	READ_RAW_VERSION=yes
+elif test -f version
 then
 	VN=$(cat version) || VN="$DEF_VER"
 elif test -d ${GIT_DIR:-.git} -o -f .git &&
@@ -26,7 +30,10 @@ else
 	VN="$DEF_VER"
 fi
 
-VN=$(expr "$VN" : v*'\(.*\)')
+if test -z "$READ_RAW_VERSION"
+then
+	VN=$(expr "$VN" : v*'\(.*\)')
+fi
 
 if test -r $GVF
 then
