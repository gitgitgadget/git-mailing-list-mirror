From: Phillip Susi <psusi@ubuntu.com>
Subject: Re: Clone from shallow bundle bug
Date: Tue, 31 Mar 2015 22:56:36 -0400
Message-ID: <551B5E64.9070906@ubuntu.com>
References: <551B0D37.5070407@ubuntu.com> <xmqqbnj8q0bm.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Apr 01 05:00:06 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yd8ss-0001EE-Pe
	for gcvg-git-2@plane.gmane.org; Wed, 01 Apr 2015 05:00:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753413AbbDAC74 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 31 Mar 2015 22:59:56 -0400
Received: from cdptpa-outbound-snat.email.rr.com ([107.14.166.226]:24303 "EHLO
	cdptpa-oedge-vip.email.rr.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752125AbbDAC7w (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 31 Mar 2015 22:59:52 -0400
Received: from [72.238.77.169] ([72.238.77.169:37851] helo=[192.168.1.142])
	by cdptpa-oedge02 (envelope-from <psusi@ubuntu.com>)
	(ecelerity 3.5.0.35861 r(Momo-dev:tip)) with ESMTP
	id 31/35-24812-46E5B155; Wed, 01 Apr 2015 02:56:37 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.5.0
In-Reply-To: <xmqqbnj8q0bm.fsf@gitster.dls.corp.google.com>
X-RR-Connecting-IP: 107.14.168.130:25
X-Cloudmark-Score: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266590>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA512

On 03/31/2015 06:17 PM, Junio C Hamano wrote:
> Phillip Susi <psusi@ubuntu.com> writes:
> 
>> I made a shallow clone of my repo, then used git bundle create to
>> pack it all into a bundle file, then cloned from that bundle.
> 
> I think the introdution of shallow clone feature broke git bundle
> create by not teaching it that its shallow boundaries are
> prerequisite commits to unbundle its contents.  IOW, the bundle
> created from the shallow clone is broken, I would think.

It seems to me that it isn't exactly broken; it just needs to put
something in the bundle noting that it was built from a shallow clone,
and then when cloning from the shallow bundle, the new clone needs its
.git/shallow file.

In other words, the bundle contains all of the objects in the shallow
clone, so a new shallow clone can be correctly constructed from the
bundle, it's just that the new clone doesn't *know* it too is shallow
and things like git log and gitk need to stop following the history
chain when they reach the shallow point rather than complain that the
rest of the history is missing ( which is intentional ).

For that matter, if you do create a depth limited bundle from a non
shallow repository, then try to clone from it, the cloned repo should
automatically become shallow rather than complain about missing history.

In other words, any time you clone from a bundle, the clone process
should check if the full history is in the bundle, and if not,
automatically make the new repo shallow so as to avoid the error
messages about the missing history.



-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQEcBAEBCgAGBQJVG15kAAoJENRVrw2cjl5RnvgH/iMyN/1U2zg+ju/teVEQIMRL
prvC60S9/yLxSp6RmiXpN2xuGHMkn7i2y6XpM9RQdE6ETeGaIw7UaDan3r7BPTSD
+Q9DrAM0g17IGNxvmGPiJZP7j0t2e43oTA9KM8alf6icMU/mWJgQsbtc9QFVfVkd
jsYevK1GR6ysrAHBAV6GxKfNw5yw3N+kTf9s2rKXWIFaArD0rcKJZVxiygMlhVSa
hT4j3+n5f3n0WMDVxFzhwOaW+yrPiXF3gs1pKFX8GT5g1BtvOAEnyskSgA5nZsNB
G53ncyyefinaaBqCvPSbcTLXmWLV8QuLBExc13BWXiVUD2rRNQr7u1ihbxWKyvU=
=D90B
-----END PGP SIGNATURE-----
