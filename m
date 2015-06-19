From: Charles Bailey <charles@hashpling.org>
Subject: Improvements to parse-options and a new filter-objects command
Date: Fri, 19 Jun 2015 10:10:56 +0100
Message-ID: <1434705059-2793-1-git-send-email-charles@hashpling.org>
To: Junio Hamano <gitster@pobox.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 19 11:37:44 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z5sjs-0004sp-4u
	for gcvg-git-2@plane.gmane.org; Fri, 19 Jun 2015 11:37:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753964AbbFSJh0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Jun 2015 05:37:26 -0400
Received: from host02.zombieandprude.com ([80.82.119.138]:51086 "EHLO
	host02.zombieandprude.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753642AbbFSJhX (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Jun 2015 05:37:23 -0400
Received: from hashpling.plus.com ([212.159.69.125]:41965)
	by host02.zombieandprude.com with esmtpsa (TLS1.2:RSA_AES_128_CBC_SHA256:128)
	(Exim 4.80)
	(envelope-from <charles@hashpling.org>)
	id 1Z5sKQ-0006de-4D; Fri, 19 Jun 2015 10:11:14 +0100
X-Mailer: git-send-email 2.4.0.53.g8440f74
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272115>

In my team we've been looking for a fast way to check a large number of
repositories for large files, which are typically unintentionally checked in
binaries, so that we can warn repository owners and help them tidy up as
desired.

There seem to be two main approaches to scripting this. The first is to do
something revision-walk based such as `log --numstat` and the second is to scan
pack files using `verify-pack -v` and either to ensure that everything is packed
or scan loose objects separately.

The revision walking tends to be slow and parsing verify-pack -v is awkward
not only because of the need to take account of multiple packs and loose
objects, but also because it is porcelainish. For example, at some point it
gained a delta chain summary which needs to be snipped before the list of
packed objects can be sorted and used.

The third patch in this series adds a new built in which makes this simple and
fast. While implementing it, I found a couple of other improvements which I
think stand alone.

[PATCH 1/3] Correct test-parse-options to handle negative ints

I noticed that a printf in test-parse-options was using %u instead of %d for an
int with the consequence that it wouldn't ever print a negative value correctly.
I don't know that we do ever parse a negative integer as an option, but there's
no reason that it shouldn't work so I fixed it and added a trivial test.

[PATCH 2/3] Move unsigned long option parsing out of pack-objects.c

I wanted to be able to parse options like --min-size=500k in my new command so I
started to add OPT_ULONG, only to realise that it already existed but was
private to pack-objects. I added OPT_ULONG support to parse-options based on the
existing OPT_INTEGER code, added new tests and changed pack-objects to use this
instead.
