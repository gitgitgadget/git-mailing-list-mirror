From: Junio C Hamano <gitster@pobox.com>
Subject: [RFH] renaming strcmp/strncmp-icase
Date: Mon, 08 Sep 2014 11:52:47 -0700
Message-ID: <xmqqmwaalzb4.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 08 20:52:56 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XR43b-0006qa-2t
	for gcvg-git-2@plane.gmane.org; Mon, 08 Sep 2014 20:52:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754188AbaIHSwv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Sep 2014 14:52:51 -0400
Received: from smtp.pobox.com ([208.72.237.35]:52624 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753924AbaIHSwu (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Sep 2014 14:52:50 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id AA637370E7;
	Mon,  8 Sep 2014 14:52:49 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:mime-version:content-type; s=sasl; bh=t
	Qdkz9dekqaviYgXPNivpUxCTVs=; b=GAH+gEXdeSUlojLfpVBxSVm4L/aKeGd4V
	0MmtrwU4Urmzj34ChXBeF2DqpM+ZkHLiUGD+FzXiaXygglhyulegJhh2SK0UE+bl
	9xuL/MdiGyFATVJB9NKRoyfs4opkbRV7g2pP4sQVI56XY7HvRocnsr0z3JryTdDk
	iKhlwkt7Kg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:mime-version:content-type; q=dns; s=sasl; b=IXB
	uQGBjDcSY9wScI+/ArGe2oM6ka3cHKq/UDIq0CC/E9fnwEI63+u8ZDHq2BP9aagX
	pmm4wou5At0nwmlI13pbaD0K+lXnvcbC4eXJVcngVC+mOyjL0q5CeqCedUSjmEbQ
	98slxCqXXk6wXm0bMp8fOG/FfZUW/AyCAPEYkIe0=
Received: from pb-smtp0. (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 9FA98370E6;
	Mon,  8 Sep 2014 14:52:49 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 24C5B370E4;
	Mon,  8 Sep 2014 14:52:49 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 544178B4-3789-11E4-ADA7-BD2DC4D60FE0-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256668>

There are these two functions in dir.c that has only a handful of
callers outside:

    int strcmp_icase(const char *a, const char *b);
    int strncmp_icase(const char *a, const char *b, size_t count);

How many of you would think these are about comparing two strings in
a case-insensitive way?

If you raised your hand (like I did), you were wrong.  These do
comparison case-insensitively only on a case-insensitive filesystem,
and hence calling it makes sense only for pathnames you grabbed out
of the filesystem via readdir() (or the user gave us, intending to
name paths).

To avoid confusion, I think they should be renamed to stress the
fact that these are about comparing *PATHS*.  As I always say, I am
bad at naming things and good suggestions are appreciated.

FYI, there are names I thought about and haven't managed to convince
myself that they are good.

A good name for the non-n variant may be "compare_paths()", but that
is used in "combine-diff.c".  "compare_pathnames()" may be a
compromise.

However, either of these makes it hard to come up with a
corresponding name for the "n" (counted) variant.  The best I could
do was "compare_pathnames_counted()", but a nice similarity to
strcmp()/strncmp() pair is lost.

pathnamecmp()/pathnamencmp() perhaps?

I dunno.
