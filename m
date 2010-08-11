From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [RFC/PATCH] WIP: Report intra-test progress with TAP subtests
Date: Tue, 10 Aug 2010 20:04:12 -0500
Message-ID: <20100811010412.GA2994@burratino>
References: <1281473829-2102-1-git-send-email-avarab@gmail.com>
 <20100811004425.GI2099@burratino>
 <AANLkTi=ygXFpRLR_Z7iEXX3THh+GT7P7X9o+NnaLajqs@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 11 03:06:05 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OizlY-0007VP-0t
	for gcvg-git-2@lo.gmane.org; Wed, 11 Aug 2010 03:06:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758167Ab0HKBFz convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 10 Aug 2010 21:05:55 -0400
Received: from mail-qw0-f46.google.com ([209.85.216.46]:36312 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758161Ab0HKBFy (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Aug 2010 21:05:54 -0400
Received: by qwh6 with SMTP id 6so8824053qwh.19
        for <git@vger.kernel.org>; Tue, 10 Aug 2010 18:05:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=upQqKryjfJpAGNcnEg20xEDVN770mxPMK8FXmFG7tw0=;
        b=gBFH43yaZsZVa3rroK8t0/TZPMDUv8pzc8qv1LRXNNMUAEFASY9LkJ0spSVe00O3z7
         l2ExRDoy7FLdYV4pf0PKlPkt5OPprXRld7c7cYV2tgYBZIuSeFU7U85El2H3EEuW7U5F
         3oYgjSXg6mmW9ccsFHdaQ/fMV/kgN9ni6TRT0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=ni8iIWkNxZTSJy85QS2ER+odLO5L6pVXthTevOTpEXYXICjk1vcF93PVtBACJcQsP/
         cCBENrjpI8UmBY7XEFv9N1OqH3CdAegl1eZuqSvyM+ntAaD7AY/1n60WN6tUQuWeswo5
         u0uLix0iflpcbvEr71+21tsCZ85HfW0O1uMro=
Received: by 10.220.62.72 with SMTP id w8mr10908430vch.32.1281488753257;
        Tue, 10 Aug 2010 18:05:53 -0700 (PDT)
Received: from burratino (dhcp-11-17.cs.uchicago.edu [128.135.11.176])
        by mx.google.com with ESMTPS id w1sm3760217vbl.8.2010.08.10.18.05.52
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 10 Aug 2010 18:05:52 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <AANLkTi=ygXFpRLR_Z7iEXX3THh+GT7P7X9o+NnaLajqs@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153180>

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
> On Wed, Aug 11, 2010 at 00:44, Jonathan Nieder <jrnieder@gmail.com> w=
rote:

>> Maybe the test harness could automate that a little, by using
>> set -x at the beginning and set +x at the end of each test.
>
> The main use case for this for me is the smoke tester output, where
> you won't get access to the original machine (without asking). Having
> a few intra-test checkpoints helps you to see where things might have
> gone wrong.

I meant something like this:
-- 8< --
diff --git a/t/test-lib.sh b/t/test-lib.sh
index e5523dd..a4bc358 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -368,9 +368,11 @@ test_debug () {
=20
 test_run_ () {
 	test_cleanup=3D:
+	set -x
 	eval >&3 2>&4 "$1"
 	eval_ret=3D$?
 	eval >&3 2>&4 "$test_cleanup"
+	set +x
 	if test "$verbose" =3D "t" && test -n "$HARNESS_ACTIVE"; then
 		echo ""
 	fi
-- >8 --

but made optional and with output munged into parsable format by
changing PS4 (or "set -T" with a DEBUG trap, if that=E2=80=99s portable
enough).
