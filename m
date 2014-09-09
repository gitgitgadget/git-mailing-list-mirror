From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] fsck: exit with non-zero status upon error from fsck_obj()
Date: Tue, 09 Sep 2014 15:21:42 -0700
Message-ID: <xmqqvbowigeh.fsf@gitster.dls.corp.google.com>
References: <1409177412.15185.3.camel@leckie>
	<20140829185325.GC29456@peff.net>
	<xmqqha0v5cgn.fsf@gitster.dls.corp.google.com>
	<1409343480.19256.2.camel@leckie> <20140829203145.GA510@peff.net>
	<xmqq4mwgjvt6.fsf_-_@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: David Turner <dturner@twopensource.com>,
	git mailing list <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Sep 10 00:21:53 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XRTnM-00062y-CB
	for gcvg-git-2@plane.gmane.org; Wed, 10 Sep 2014 00:21:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752804AbaIIWVr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Sep 2014 18:21:47 -0400
Received: from smtp.pobox.com ([208.72.237.35]:56591 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752506AbaIIWVp (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Sep 2014 18:21:45 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id DCC883929C;
	Tue,  9 Sep 2014 18:21:44 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=c2fB8hDXbE0L8ye9/sAHBw3IO7Y=; b=IZza2s
	Y2vuJDW3Di8Hf9axdkQa3orpHeCmr6PYRHlrEUqiA8mKthahrow9JDQyppfng0Yq
	MjAWCvMSIsNJsGsHD5ChErhztHxfpEefz3Pu2cXaIbBQrKokvux8DT/eFSm7Rqqz
	n89pn4fkSTFVRnU6EDWY48avB4pFqs+4KlWNU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Vc0wl+uLsgCMmCFTP+HdhafCV3LEftXA
	s/WtI6iLQGzZ6IYIhwxNvVIxHttQfRY5aJKLh+vv9GWhH+H6qYOXsoTuL1upP1wD
	3n9WLCe3hL/Tld0bdvUht8QVynfgfm8PayQ3qqyKinfu02bpnNFwhl+coEAPkYFb
	medbc395qX0=
Received: from pb-smtp0. (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id D43433929B;
	Tue,  9 Sep 2014 18:21:44 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 5581C3929A;
	Tue,  9 Sep 2014 18:21:44 -0400 (EDT)
In-Reply-To: <xmqq4mwgjvt6.fsf_-_@gitster.dls.corp.google.com> (Junio
	C. Hamano's message of "Tue, 09 Sep 2014 15:03:33 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: AE3B9520-386F-11E4-B3C4-BD2DC4D60FE0-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256717>

Junio C Hamano <gitster@pobox.com> writes:

> From: Jeff King <peff@peff.net>
> Date: Fri, 29 Aug 2014 16:31:46 -0400
>
> Upon finding a corrupt loose object, we forgot to note the error to
> signal it with the exit status of the entire process.
>
> [jc: adjusted t1450 and added another test]

Spoke too soon.  If found another instance where we expected fsck to
notice a corruption.  We'd need to squash this in.

By the way, Jonathan, with dbedf8bf (t1450 (fsck): remove dangling
objects, 2010-09-06) you added a 'test_might_fail git fsck' to the
1450 test that catches an object corruption.  Do you remember if
there was some flakiness in this test that necessitated it, or is it
merely "I think this should fail, but it does not, and we may fix it
some day but I am not doing that in this patch?"  Assuming that it
is the latter, I am including an update to 1450 as well.

There is another test_might_fail that runs "git rev-list" in the
same test, but that is not part of the said patch and unrelated to
the current topic, so I didn't dig further; we may want to audit the
hits from "git grep test_might_fail t/" as a separate topic (hint,
hint).


 t/t1450-fsck.sh        | 2 +-
 t/t4212-log-corrupt.sh | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/t1450-fsck.sh b/t/t1450-fsck.sh
index c8dff9c..0de755c 100755
--- a/t/t1450-fsck.sh
+++ b/t/t1450-fsck.sh
@@ -69,7 +69,7 @@ test_expect_success 'object with bad sha1' '
 	git update-ref refs/heads/bogus $cmt &&
 	test_when_finished "git update-ref -d refs/heads/bogus" &&
 
-	test_might_fail git fsck 2>out &&
+	test_must_fail git fsck 2>out &&
 	cat out &&
 	grep "$sha.*corrupt" out
 '
diff --git a/t/t4212-log-corrupt.sh b/t/t4212-log-corrupt.sh
index 58b792b..67bd8ec 100755
--- a/t/t4212-log-corrupt.sh
+++ b/t/t4212-log-corrupt.sh
@@ -14,7 +14,7 @@ test_expect_success 'setup' '
 '
 
 test_expect_success 'fsck notices broken commit' '
-	git fsck 2>actual &&
+	test_must_fail git fsck 2>actual &&
 	test_i18ngrep invalid.author actual
 '
 
