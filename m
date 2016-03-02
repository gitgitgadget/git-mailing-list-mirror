From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 0/4] "split bundle" preview
Date: Wed,  2 Mar 2016 12:32:37 -0800
Message-ID: <1456950761-19759-1-git-send-email-gitster@pobox.com>
References: <xmqqfuw84uhb.fsf@gitster.mtv.corp.google.com>
Cc: Jeff King <peff@peff.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 02 21:32:53 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1abDRx-0006vC-KH
	for gcvg-git-2@plane.gmane.org; Wed, 02 Mar 2016 21:32:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755773AbcCBUcp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Mar 2016 15:32:45 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:58930 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754190AbcCBUco (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Mar 2016 15:32:44 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id E29BA4806D;
	Wed,  2 Mar 2016 15:32:42 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=QPXY
	LEnQegE57Zw3hoxsZq/P5OI=; b=t80DnL+nvDbMp1MMB6/T3NFICptgyveOfGIT
	N4/O1tzwlb5SkPj3E7qqq7dSkYQtlMcppUoNQzeUqKdg+WX/DH/OL7xGHIbMMXd6
	Lcr47m5CKk6mj17PIWpkkfKm3cFWioajYlh6iz0VYS2o0MDYhoSXGMXNUEL3NRLO
	2AwfPd4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; q=dns; s=sasl; b=
	LAlqbCxkS0ZWllQ2V+mnWzIBq9k34IUu6c9jr12TjaGRN9No8QoqAoDMPkUluKZ3
	cag9JMvDJ7unFmoWCkIwUMZoEteUpZttvxdyNQTu8nVI309okY4MolB0aS5odl+y
	vPEwQGnzIkO2MRVIujxruR80yFW3ERKEPRf0xozRnMw=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id DAD8A4806C;
	Wed,  2 Mar 2016 15:32:42 -0500 (EST)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 5C9184806B;
	Wed,  2 Mar 2016 15:32:42 -0500 (EST)
X-Mailer: git-send-email 2.8.0-rc0-114-g0b3e5e5
In-Reply-To: <xmqqfuw84uhb.fsf@gitster.mtv.corp.google.com>
X-Pobox-Relay-ID: E9FB5CD6-E0B5-11E5-ABA6-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288150>

Here is a preview of the "split bundle" stuff that may serve as one
of the enabling technology to offload "git clone" traffic off of the
server core network to CDN.

Changes:

 - The "checksum" bit about the in-bundle packdata, which was
   incorrect, was dropped from the proposed log message of 1/4.

 - "init_bundle_header()" helper has been added to 3/4; the name of
   the new field in bundle_header structure is now "filename", not
   "bundle_file".  It is silly to name a field with "bundle" in it
   when the structure is about a bundle already.

 - 4/4 is new, and implements the unbundling part, i.e. running
   either "git clone" or "git bundle unbundle" on the two files
   after a split bundle is made available locally.

Junio C Hamano (4):
  bundle doc: 'verify' is not about verifying the bundle
  bundle: plug resource leak
  bundle: keep a copy of bundle file name in the in-core bundle header
  bundle v3: the beginning

 Documentation/git-bundle.txt |   9 ++-
 builtin/bundle.c             |   6 +-
 bundle.c                     | 142 +++++++++++++++++++++++++++++++++++++------
 bundle.h                     |   8 ++-
 t/t5704-bundle.sh            |  64 +++++++++++++++++++
 transport.c                  |   4 +-
 6 files changed, 204 insertions(+), 29 deletions(-)

-- 
2.8.0-rc0-114-g0b3e5e5
