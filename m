From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 16/16] ls-files: add --overlay option
Date: Mon, 15 Sep 2008 12:35:08 -0700
Message-ID: <7vljxtb3tf.fsf@gitster.siamese.dyndns.org>
References: <1221397685-27715-1-git-send-email-pclouds@gmail.com>
 <1221397685-27715-2-git-send-email-pclouds@gmail.com>
 <1221397685-27715-3-git-send-email-pclouds@gmail.com>
 <1221397685-27715-4-git-send-email-pclouds@gmail.com>
 <1221397685-27715-5-git-send-email-pclouds@gmail.com>
 <1221397685-27715-6-git-send-email-pclouds@gmail.com>
 <1221397685-27715-7-git-send-email-pclouds@gmail.com>
 <1221397685-27715-8-git-send-email-pclouds@gmail.com>
 <1221397685-27715-9-git-send-email-pclouds@gmail.com>
 <1221397685-27715-10-git-send-email-pclouds@gmail.com>
 <1221397685-27715-11-git-send-email-pclouds@gmail.com>
 <1221397685-27715-12-git-send-email-pclouds@gmail.com>
 <1221397685-27715-13-git-send-email-pclouds@gmail.com>
 <1221397685-27715-14-git-send-email-pclouds@gmail.com>
 <1221397685-27715-15-git-send-email-pclouds@gmail.com>
 <1221397685-27715-16-git-send-email-pclouds@gmail.com>
 <1221397685-27715-17-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Sep 15 21:36:44 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KfJs8-0006UE-15
	for gcvg-git-2@gmane.org; Mon, 15 Sep 2008 21:36:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753474AbYIOTfU convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 15 Sep 2008 15:35:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753352AbYIOTfU
	(ORCPT <rfc822;git-outgoing>); Mon, 15 Sep 2008 15:35:20 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:48986 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753346AbYIOTfS convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 15 Sep 2008 15:35:18 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 41D98611CD;
	Mon, 15 Sep 2008 15:35:16 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 5F25D611CB; Mon, 15 Sep 2008 15:35:10 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 6C43D86C-835D-11DD-92C8-D0CFFE4BC1C1-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95933>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> The same situation happens for "assume unchanged" bit, but I would
> expect narrow checkout to be more user-friendly and should notify use=
rs
> these cases so users will not be confused. On this first step, users
> may check by themselves with "git ls-files --overlay",...

Could you explain how the earlier --narrow-checkout option introduced i=
n
[05/16] interacts with this one?

The user has X inside narrow area and Y outside.  ls-files reports both=
 X
and Y.  'ls-files --narrow-checkout' reports only X.  Y is tracked but =
not
really, so 'ls-files --narrow-checkout -o' shouldn't say Y is untracked=
;
there is no cue to tell between X and Y.

But with a half of your patch to 'ls-files -t', you already can show th=
ese
potentially stale (leftover from an ancient checkout un-updated because=
 of
narrowness) files.  Could a simpler alternative be to do this processin=
g
not inside "if (show_deleted/modified)" part of show_files(), but insid=
e
"if (show_cached/stage)" part of it?  Instead of saying tag_cached
unconditionally, if the entry is marked no_checkout, then you would
lstat(2) it there and report that the path is "marked not to be checked
out but somehow something exists there".

By the way, I do not see an easy way to review what paths are marked wi=
th
no-checkout easily from your command set.  It might be worthwhile to ad=
d a
new option that iterates over the index, finds a set of common prefixes=
 to
no-checkout entries and reports that set.
