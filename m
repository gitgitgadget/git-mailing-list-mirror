From: Thomas Rast <trast@inf.ethz.ch>
Subject: Re: [PATCH] pack-objects: no crc check when the cached version is used
Date: Fri, 13 Sep 2013 23:26:21 +0200
Message-ID: <87k3ikct1e.fsf@inf.ethz.ch>
References: <1379070180-15947-1-git-send-email-pclouds@gmail.com>
	<xmqq7gekk24q.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	<git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Sep 13 23:26:31 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VKasn-00074c-VF
	for gcvg-git-2@plane.gmane.org; Fri, 13 Sep 2013 23:26:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755211Ab3IMV00 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 13 Sep 2013 17:26:26 -0400
Received: from edge20.ethz.ch ([82.130.99.26]:51921 "EHLO edge20.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754308Ab3IMV0Z convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 13 Sep 2013 17:26:25 -0400
Received: from CAS21.d.ethz.ch (172.31.51.111) by edge20.ethz.ch
 (82.130.99.26) with Microsoft SMTP Server (TLS) id 14.2.298.4; Fri, 13 Sep
 2013 23:26:20 +0200
Received: from hexa.ethz.ch (46.126.8.85) by CAS21.d.ethz.ch (172.31.51.111)
 with Microsoft SMTP Server (TLS) id 14.2.298.4; Fri, 13 Sep 2013 23:26:22
 +0200
In-Reply-To: <xmqq7gekk24q.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Fri, 13 Sep 2013 11:28:05 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2 (gnu/linux)
X-Originating-IP: [46.126.8.85]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234774>

Junio C Hamano <gitster@pobox.com> writes:

> Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.com> writes:
>
>> Current code makes pack-objects always do check_pack_crc() in
>> unpack_entry() even if right after that we find out there's a cached
>> version and pack access is not needed. Swap two code blocks, search
>> for cached version first, then check crc.
[...]
>
> Interesting.
>
> This is only triggered inside pack-objects, which would read a lot
> of data from existing packs, and the overhead for looking up the
> entry from the revindex, faulting in the actual packdata, and
> computing and comparing the crc would not be trivial, especially as
> the cost is incurred over many objects we need to untangle in the
> delta chain.  If you have interesting numbers to show how much this
> improves the performance, I am curious to see it.

I can't see anything wrong with the patch, but then I haven't stared to=
o
hard.  (It seems that my conversion around abe601b (sha1_file: remove
recursion in unpack_entry, 2013-03-27) was faithful on this point, the
problem has existed for longer than that.)

I tried the perf script below, but at least for the git repo the only
thing I can see is noise.

--- 8< --- t/perf/p5300-pack-object.sh --- 8< ---
#!/bin/sh

test_description=3D"Tests object packing performance"

=2E ./perf-lib.sh

test_perf_default_repo

test_perf 'pack-objects on commits in HEAD' '
	git rev-list HEAD |
	git pack-objects --stdout >/dev/null
'

test_perf 'pack-objects on all of HEAD' '
	git rev-list --objects HEAD |
	git pack-objects --stdout >/dev/null
'

test_done
